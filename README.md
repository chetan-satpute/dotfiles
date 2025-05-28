# 🧰 dotfiles

My personal dotfiles, managed with GNU Stow and a Go-based installer script.

## 🚀 Quick Start

Clone the repo:

```zsh
git clone https://github.com/yourusername/dotfiles.git ~/.dotfiles

cd ~/.dotfiles
```
Install dotfiles:

```zsh
go run scripts/install.go
# or
stow --dir=packages <package_name> --target=$HOME
stow --dir=packages nvim --target=$HOME
```

## 🧪 Requirements
- GNU Stow
- Go

