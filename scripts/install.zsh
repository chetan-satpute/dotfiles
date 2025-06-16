#!/usr/bin/env zsh

# Check if 'stow' is installed
if ! command -v stow >/dev/null 2>&1; then
  echo "❌ GNU stow is not installed. Please install it and try again."
  exit 1
fi

# Get the Git repo root
dotfiles_dir=$(git rev-parse --show-toplevel 2>/dev/null) || {
  echo "❌ Failed to get dotfiles directory. Are you inside a Git repo?"
  exit 1
}

packages_dir="${dotfiles_dir}/packages"
target_dir="${HOME}"

# Ensure packages_dir exists
if [[ ! -d "$packages_dir" ]]; then
  echo "❌ Directory '${packages_dir}' does not exist."
  exit 1
fi

# Loop through all directories inside packages_dir
for pkg_path in "$packages_dir"/*; do
  if [[ -d "$pkg_path" ]]; then
    pkg=$(basename "$pkg_path")
    echo "📦 Stowing $pkg..."

    if ! stow --target="$target_dir" --dir="$packages_dir" "$pkg"; then
      echo "❌ Failed to stow $pkg"
    fi
  fi
done

echo "✅ All packages stowed to $target_dir"

