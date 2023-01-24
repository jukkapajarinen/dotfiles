# Jukka's dotfiles 💎

My dotfiles and scripts for MacOS and Linux. Dotfiles are symlinked to appropriate directories by handy installation scripts.

## Installation

- ⚠️ Please read installation scripts before usage. You may accidentally override things you don't want to! ⚠️
- Clone this repository to any location in your filesystem.  (E.g. **~/Projects**)
- Change directory to the previously **cloned** `dotfiles` directory
- Launch the `./installers/install_macos.sh` or `./installers/install_linux.sh` script in **bash**!
  - *Supported options are `-f` or `--force` to force installation.*
  - *Don't use **sudo!** (installer will ask for sudo password, if needed.)*
  - *Installer will ask your permission `[y/N]` to start the installation.*

## TL;DR;

```
git clone git@github.com:jukkapajarinen/dotfiles.git && cd dotfiles && bash ./installers/install_linux.sh;
```

## Author

- [Jukka Pajarinen](https://www.jukkapajarinen.com)

## [License](LICENSE.md)

Copyright (c) 2022 Jukka Pajarinen

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.