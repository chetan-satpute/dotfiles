#!/usr/bin/env zsh
#
# Un-stow every package under packages/ (or just the ones named on the
# command line) from $HOME. Packages that aren't currently installed are
# skipped, not treated as an error. Symlinks that don't belong to this repo
# are never touched.
#
# Usage:
#   ./scripts/uninstall.zsh              # uninstall all packages
#   ./scripts/uninstall.zsh nvim zsh     # uninstall only the named packages

source "${0:A:h}/lib/common.zsh"

check_stow_installed
resolve_dotfiles_dir
validate_packages_dir

validate_target_packages "$@"
packages=("${(@f)$(resolve_target_packages "$@")}")

failed_pkgs=()

for pkg in "${packages[@]}"; do
  printf "→ ${BOLD}Unstowing${RESET} ${BLUE}%-20s${RESET}" "$pkg"

  any_linked=false
  foreign_found=false
  scan_unstow_state "$pkg" ""

  if [[ "$any_linked" == false && "$foreign_found" == false ]]; then
    echo " ${YELLOW}[SKIP]${RESET} (not installed)"
    continue
  fi

  if stow --delete --target="$target_dir" --dir="$packages_dir" "$pkg"; then
    if [[ "$foreign_found" == true ]]; then
      echo " ${YELLOW}[PARTIAL]${RESET} (some paths left untouched — not owned by this repo)"
    else
      echo " ${GREEN}[OK]${RESET}"
    fi
  else
    echo " ${RED}[FAILED]${RESET}"
    failed_pkgs+=("$pkg")
  fi
done

if [[ ${#failed_pkgs[@]} -eq 0 ]]; then
  echo "\n${GREEN}✔ All packages unstowed successfully from ${BOLD}$target_dir${RESET}"
else
  echo "\n${RED}✘ Failed packages:${RESET}"
  for pkg in "${failed_pkgs[@]}"; do
    echo "  - ${YELLOW}$pkg${RESET}"
  done
  exit 1
fi
