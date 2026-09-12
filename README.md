# dotfiles

Personal macOS dotfiles, managed with [GNU Stow](https://www.gnu.org/software/stow/).
Each directory under `packages/` is a stow package that mirrors `$HOME`.

```
packages/
├── git/        .gitconfig
├── kitty/      .config/kitty/
├── nvim/       .config/nvim/
├── starship/   .config/starship.toml
└── zsh/        .zshrc, .zprofile, .hushlogin
```

## Requirements

- [GNU Stow](https://www.gnu.org/software/stow/)
- [zsh](https://www.zsh.org/)

## Setup

```zsh
git clone git@github.com:chetan-satpute/dotfiles.git
cd dotfiles
./scripts/install.zsh
```

The scripts are location-agnostic — clone anywhere, under any name.

## Usage

Install everything, or just the packages you name:

```zsh
./scripts/install.zsh
./scripts/install.zsh nvim zsh
```

Uninstall the same way:

```zsh
./scripts/uninstall.zsh
./scripts/uninstall.zsh nvim zsh
```

Uninstalling a package that isn't currently installed is a no-op, not an
error, and neither script ever touches a symlink it doesn't own.

## Safety

If a real file already exists where a package wants to place a symlink,
`install.zsh` backs it up to `~/.dotfiles-backup/<timestamp>/` before
adopting it into the repo. Nothing is ever overwritten silently.
