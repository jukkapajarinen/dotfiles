# ##############################################################################
# Windows installation script for Jukka's dotfiles
# ##############################################################################

param([switch]$Yes);

# Declare common variables
$scriptDir = $PSScriptRoot;
$homeDir = $env:USERPROFILE;
$os = "Windows";

# Print the directory paths
Write-Host "Welcome $env:USERNAME, to Jukka's dotfiles installation script.";
Write-Host "- Operating system: " -NoNewline; Write-Host $os -ForegroundColor Green;
Write-Host "- Source directory: " -NoNewline; Write-Host $scriptDir -ForegroundColor Blue;
Write-Host "- Target directory: " -NoNewline; Write-Host $homeDir -ForegroundColor Red;

# Read possible --yes from the cli args (answer Y to all and overwrite files)
if ($args -contains "--yes") { $Yes = $true; }

# Print a message with a green arrow
function Arrow($message) {
  Write-Host "==>" -ForegroundColor Green -NoNewline;
  Write-Host " $message";
}

# Ask a [Y/n] question, or answer Y automatically with --yes
function Ask($question) {
  if ($Yes) {
    Arrow "$question [Y/n] Y";
    return $true;
  }
  Write-Host "==>" -ForegroundColor Green -NoNewline;
  $yn = Read-Host " $question [Y/n]";
  return $yn -notmatch "^[nN]";
}

# Symlink source to target (ask before overwriting), copy if symlinks are not allowed
function Link($source, $target) {
  $existing = Get-Item -LiteralPath $target -Force -ErrorAction SilentlyContinue;
  if ($existing) {
    if ($existing.LinkType -eq "SymbolicLink" -and $existing.Target -eq $source) {
      Write-Host "'$target' -> '$source' (already linked)";
      return;
    }
    if (-not $Yes -and -not (Ask "Overwrite '$target'?")) { return; }
    Remove-Item -LiteralPath $target -Force;
  }
  try {
    New-Item -ItemType SymbolicLink -Path $target -Target $source -ErrorAction Stop | Out-Null;
    Write-Host "'$target' -> '$source'";
  } catch {
    Copy-Item -LiteralPath $source -Destination $target -Force;
    Write-Host "'$target' <- '$source' (copied, symlinks need Developer Mode or admin)" -ForegroundColor Yellow;
  }
}

if (-not (Ask "Are you sure to start installation?")) {
  Arrow "Installation was not started.";
  exit;
}

# Windows create directories
Arrow "Create possibly missing directories.";
$dirs = @(
  "$homeDir\.config",
  "$env:LOCALAPPDATA\nvim",
  "$env:APPDATA\Code\User"
);
foreach ($dir in $dirs) {
  if (-not (Test-Path -LiteralPath $dir)) {
    New-Item -ItemType Directory -Path $dir -Force | Out-Null;
    Write-Host "created directory '$dir'";
  }
}

# Windows create dotfile symlinks
Arrow "Install user configuration files.";
Link "$scriptDir\git-config" "$homeDir\.gitconfig";
Link "$scriptDir\git-excludes" "$homeDir\.gitexcludes";
Link "$scriptDir\starship.toml" "$homeDir\.config\starship.toml";
Link "$scriptDir\vimrc" "$homeDir\_vimrc";
Link "$scriptDir\vimrc" "$homeDir\.vimrc";
Link "$scriptDir\vimrc" "$env:LOCALAPPDATA\nvim\init.vim";
Link "$scriptDir\vscode-settings.json" "$env:APPDATA\Code\User\settings.json";
Link "$scriptDir\vscode-keybindings.json" "$env:APPDATA\Code\User\keybindings.json";
Link "$scriptDir\vscode-extensions.txt" "$env:APPDATA\Code\User\extensions.txt";

# Windows install VS Code extensions
if ((Get-Command code -ErrorAction SilentlyContinue) -and (Ask "Install VS Code extensions?")) {
  Arrow "Install VS Code extensions.";
  Get-Content "$scriptDir\vscode-extensions.txt" | Where-Object { $_.Trim() } | ForEach-Object {
    code --install-extension $_.Trim();
  }
}

# Print info that execution finished
Arrow "Installation finished.";
