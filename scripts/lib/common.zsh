# Shared helpers for scripts/install.zsh and scripts/uninstall.zsh.
# This file is meant to be sourced, not executed directly.

[[ -n "$__DOTFILES_COMMON_LOADED" ]] && return
__DOTFILES_COMMON_LOADED=1

# Colors
RED="\033[0;31m"
GREEN="\033[0;32m"
YELLOW="\033[1;33m"
BLUE="\033[0;34m"
BOLD="\033[1m"
RESET="\033[0m"

log_info() { echo "${BLUE}[INFO]${RESET} $1"; }
log_ok() { echo "${GREEN}[OK]${RESET} $1"; }
log_warn() { echo "${YELLOW}[WARN]${RESET} $1"; }
log_error() { echo "${RED}[ERROR]${RESET} $1" >&2; }

# Verify GNU stow is available on PATH.
check_stow_installed() {
  if ! command -v stow >/dev/null 2>&1; then
    log_error "GNU stow is not installed. Please install it and try again."
    exit 1
  fi
}

# Resolve the repo root, packages dir, and target dir into globals:
#   dotfiles_dir, packages_dir, target_dir
resolve_dotfiles_dir() {
  dotfiles_dir=$(git rev-parse --show-toplevel 2>/dev/null) || {
    log_error "Failed to get dotfiles directory. Are you inside a Git repo?"
    exit 1
  }
  packages_dir="${dotfiles_dir}/packages"
  target_dir="${HOME}"
}

# Ensure packages_dir exists and contains at least one package.
validate_packages_dir() {
  if [[ ! -d "$packages_dir" ]]; then
    log_error "Directory '${packages_dir}' does not exist."
    exit 1
  fi

  local count=0
  for pkg_path in "$packages_dir"/*(N/); do
    count=$((count + 1))
  done

  if [[ "$count" -eq 0 ]]; then
    log_error "No packages found in '${packages_dir}'."
    exit 1
  fi
}

# Echo the basenames of all package directories under packages_dir.
discover_all_packages() {
  local pkg_path
  for pkg_path in "$packages_dir"/*(N/); do
    basename "$pkg_path"
  done
}

# Given optional package-name args, validate each names a real package
# under packages_dir. No args is always valid (means "all packages"). Must
# be called directly (not inside a command substitution) since it exits the
# whole script on failure — `exit` inside `$(...)` would only kill that
# subshell and let the script carry on with a corrupted/empty result.
validate_target_packages() {
  [[ $# -eq 0 ]] && return

  local -a invalid=()
  local pkg

  for pkg in "$@"; do
    [[ -d "${packages_dir}/${pkg}" ]] || invalid+=("$pkg")
  done

  if [[ ${#invalid[@]} -gt 0 ]]; then
    log_error "Unknown package(s): ${invalid[*]}"
    log_error "Available packages: $(discover_all_packages | tr '\n' ' ')"
    exit 1
  fi
}

# Echo the deduped list of packages to operate on. No args -> all packages.
# Assumes validate_target_packages "$@" was already called successfully.
resolve_target_packages() {
  if [[ $# -eq 0 ]]; then
    discover_all_packages
    return
  fi

  local -A seen=()
  local pkg
  for pkg in "$@"; do
    [[ -n "${seen[$pkg]}" ]] && continue
    seen[$pkg]=1
    echo "$pkg"
  done
}

# Resolve a symlink's target to an absolute, normalized path, without
# requiring the target to actually exist (works for dangling symlinks too).
resolve_symlink_target() {
  local link_path="$1" link_target
  link_target=$(readlink "$link_path")
  [[ "$link_target" != /* ]] && link_target="${link_path:h}/${link_target}"
  print -r -- "${link_target:A}"
}

# Recursively walk a package's tree honoring GNU Stow's directory folding:
# a real directory that exists on both sides is descended into (stow folds
# into it), but anything already symlinked — correctly or not — stops the
# walk right there, since everything below it is reached *through* that
# symlink rather than being a separate managed path. Getting this wrong
# means treating a package's own files (visible through an already-correct
# whole-directory symlink) as foreign conflicts to be adopted/backed up.
#
# Echoes, relative to $HOME, every real (non-symlink) path that
# `stow --adopt` would still need to absorb. Warns (to stderr) about
# symlinks that exist at a managed path but point somewhere other than into
# this package — those are left untouched for stow itself to report.
scan_adopt_conflicts() {
  local pkg="$1" rel="$2"
  local src_dir="${packages_dir}/${pkg}${rel:+/$rel}"
  local entry name child_rel src_child tgt_child

  for entry in "$src_dir"/*(DN); do
    name="${entry:t}"
    child_rel="${rel:+$rel/}$name"
    src_child="${packages_dir}/${pkg}/${child_rel}"
    tgt_child="${target_dir}/${child_rel}"

    if [[ -L "$tgt_child" ]]; then
      if [[ "$(resolve_symlink_target "$tgt_child")" != "${src_child:A}" ]]; then
        log_warn "Symlink at '${tgt_child}' points elsewhere ($(readlink "$tgt_child")); leaving it for stow to report." >&2
      fi
    elif [[ -d "$tgt_child" && -d "$src_child" ]]; then
      scan_adopt_conflicts "$pkg" "$child_rel"
    elif [[ -e "$tgt_child" ]]; then
      echo "$child_rel"
    fi
    # else: nothing exists at tgt_child yet -> stow will create it
  done
}

# Same directory-folding-aware walk as scan_adopt_conflicts, but for
# uninstall: sets the global flags `any_linked` (this package has at least
# one symlink correctly pointing into it) and `foreign_found` (a managed
# path is occupied by a symlink that points somewhere else, so `stow -D`
# will/should leave it alone). Real files and absent paths are irrelevant to
# uninstall and are not reported.
scan_unstow_state() {
  local pkg="$1" rel="$2"
  local src_dir="${packages_dir}/${pkg}${rel:+/$rel}"
  local entry name child_rel src_child tgt_child

  for entry in "$src_dir"/*(DN); do
    name="${entry:t}"
    child_rel="${rel:+$rel/}$name"
    src_child="${packages_dir}/${pkg}/${child_rel}"
    tgt_child="${target_dir}/${child_rel}"

    if [[ -L "$tgt_child" ]]; then
      if [[ "$(resolve_symlink_target "$tgt_child")" == "${src_child:A}" ]]; then
        any_linked=true
      else
        foreign_found=true
      fi
    elif [[ -d "$tgt_child" && -d "$src_child" ]]; then
      scan_unstow_state "$pkg" "$child_rel"
    fi
  done
}
