#!/usr/bin/env zsh
#
# Stow every package under packages/ (or just the ones named on the command
# line) into $HOME. Any real file already sitting at a target path is backed
# up before being adopted into the repo, so this is safe to run on a machine
# that already has its own dotfiles in place.
#
# Usage:
#   ./scripts/install.zsh              # install all packages
#   ./scripts/install.zsh nvim zsh     # install only the named packages

source "${0:A:h}/lib/common.zsh"

check_stow_installed
resolve_dotfiles_dir
validate_packages_dir

validate_target_packages "$@"
packages=("${(@f)$(resolve_target_packages "$@")}")

run_timestamp=$(date +%Y%m%d-%H%M%S)
backup_root="${HOME}/.dotfiles-backup/${run_timestamp}"
backed_up_any=false
failed_pkgs=()

for pkg in "${packages[@]}"; do
  printf "→ ${BOLD}Stowing${RESET} ${BLUE}%-20s${RESET}" "$pkg"

  pkg_failed=false
  for rel_path in "${(@f)$(scan_adopt_conflicts "$pkg" "")}"; do
    [[ -z "$rel_path" ]] && continue
    target_path="${target_dir}/${rel_path}"

    # A real file/dir sits at a path this package manages — `stow --adopt`
    # would swallow it into the repo. Move it aside first so nothing is
    # silently overwritten.
    dest="${backup_root}/${pkg}/${rel_path}"
    if mkdir -p "$(dirname "$dest")" && mv "$target_path" "$dest"; then
      backed_up_any=true
    else
      echo " ${RED}[FAILED]${RESET}"
      log_error "Could not back up '${target_path}' before adopting it."
      failed_pkgs+=("$pkg")
      pkg_failed=true
      break
    fi
  done

  if [[ "$pkg_failed" == true ]]; then
    continue
  fi

  if stow --adopt --target="$target_dir" --dir="$packages_dir" "$pkg"; then
    echo " ${GREEN}[OK]${RESET}"
  else
    echo " ${RED}[FAILED]${RESET}"
    failed_pkgs+=("$pkg")
  fi
done

if [[ "$backed_up_any" == true ]]; then
  echo "\n${YELLOW}Note:${RESET} pre-existing files were backed up to ${BOLD}${backup_root}${RESET}"
fi

if [[ ${#failed_pkgs[@]} -eq 0 ]]; then
  echo "\n${GREEN}✔ All packages stowed successfully to ${BOLD}$target_dir${RESET}"
else
  echo "\n${RED}✘ Failed packages:${RESET}"
  for pkg in "${failed_pkgs[@]}"; do
    echo "  - ${YELLOW}$pkg${RESET}"
  done
  exit 1
fi
