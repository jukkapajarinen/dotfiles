# Ubuntu software packages
## install software from packages
```
apt install git curl exa bat docker.io docker-compose most vim neovim neofetch lolcat fonts-firacode gnome-tweaks geary steam kitty keepassxc vlc;
```

## install software via scripts
```
cd $HOME/Downloads && git clone https://github.com/pop-os/shell.git && cd shell && make local-install;
sudo cp org.gnome.shell.extensions.pop-shell.gschema.xml /usr/share/glib-2.0/schemas/;
sudo glib-compile-schemas /usr/share/glib-2.0/schemas/;
```
```
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim;
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim';
```
```
sh -c "$(curl -fsSL https://starship.rs/install.sh)";
```
```
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash;
```
