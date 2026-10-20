# Jukka's dotfiles 💎

My dotfiles and scripts for MacOS, Linux and Windows. Dotfiles are symlinked to appropriate directories by handy installation scripts.

Please check the installation scripts before usage. You may accidentally override things you don't want to!

Custom keyboard configurations readme is [here](./kbd/xd60_v3_QMK_README.md).

## Installation Linux

- Clone this repository to any location in your filesystem.  (E.g. **~/**)
- Change directory to the previously **cloned** `dotfiles` directory
- Launch the `./INSTALL.sh` script in **bash**!
  - *Supported option is `--yes` to answer `Y` to all questions and overwrite existing files.*
  - *Don't use **sudo!** (installer will ask for sudo password, if needed.)*
  - *Installer will ask your permission `[Y/n]` to start the installation.*

### Installation Windows

- Launch `INSTALL.ps1` in **PowerShell** instead: `powershell -ExecutionPolicy Bypass -File .\INSTALL.ps1`
  - *Supported option is `-Yes` (or `--yes`) to answer `Y` to all questions and overwrite existing files.*
  - *Installs only the Windows-applicable dotfiles: git, starship, vim/neovim and VS Code.*
  - *Files are symlinked when Developer Mode is on (or when run as admin), otherwise copied.*

## TL;DR;

```
git clone git@github.com:jukkapajarinen/dotfiles.git && 
cd dotfiles && 
bash ./INSTALL.sh;
```

## Author

- [Jukka Pajarinen](https://www.jukkapajarinen.com)

## [License](LICENSE.md)

Copyright (c) 2026 Jukka Pajarinen

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.