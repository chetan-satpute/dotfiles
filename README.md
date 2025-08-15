# 🧰 Dotfiles

My personal dotfiles, managed with [GNU Stow](https://www.gnu.org/software/stow/).

## 🚀 Quick Start

Clone the repo:

```zsh
git clone https://github.com/yourusername/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
```

Install dotfiles:

```zsh
./scripts/install.zsh

# or install a specific package:
stow --dir=packages --target=$HOME <package_name>

# example:
stow --dir=packages --target=$HOME nvim
```

## 🧪 Requirements

- [GNU Stow](https://www.gnu.org/software/stow/)
- [zsh](https://www.zsh.org/)
