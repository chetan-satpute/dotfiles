#!/usr/bin/env zsh

# Colors
RED="\033[0;31m"
GREEN="\033[0;32m"
YELLOW="\033[1;33m"
BLUE="\033[0;34m"
BOLD="\033[1m"
RESET="\033[0m"

# Check if 'stow' is installed
if ! command -v stow >/dev/null 2>&1; then
  echo "${RED}[ERROR]${RESET} GNU stow is not installed. Please install it and try again."
  exit 1
fi

# Get the Git repo root
dotfiles_dir=$(git rev-parse --show-toplevel 2>/dev/null) || {
  echo "${RED}[ERROR]${RESET} Failed to get dotfiles directory. Are you inside a Git repo?"
  exit 1
}

packages_dir="${dotfiles_dir}/packages"
target_dir="${HOME}"

# Ensure packages_dir exists
if [[ ! -d "$packages_dir" ]]; then
  echo "${RED}[ERROR]${RESET} Directory '${packages_dir}' does not exist."
  exit 1
fi

failed_pkgs=()

# Loop through all directories inside packages_dir
for pkg_path in "$packages_dir"/*; do
  if [[ -d "$pkg_path" ]]; then
    pkg=$(basename "$pkg_path")
    printf "→ ${BOLD}Stowing${RESET} ${BLUE}%-20s${RESET}" "$pkg"

    if stow --target="$target_dir" --dir="$packages_dir" "$pkg" >/dev/null 2>&1; then
      echo " ${GREEN}[OK]${RESET}"
    else
      echo " ${RED}[FAILED]${RESET}"
      failed_pkgs+=("$pkg")
    fi
  fi
done

# Summary
if [[ ${#failed_pkgs[@]} -eq 0 ]]; then
  echo "\n${GREEN}✔ All packages stowed successfully to ${BOLD}$target_dir${RESET}"
else
  echo "\n${RED}✘ Failed packages:${RESET}"
  for pkg in "${failed_pkgs[@]}"; do
    echo "  - ${YELLOW}$pkg${RESET}"
  done
  exit 1
fi

