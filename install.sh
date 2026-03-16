#!/usr/bin/env bash

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

NVIM_RUNTIME="$HOME/.nvim_runtime"
NVIM_CONFIG="$HOME/.config/nvim"
IDEAVIMRC="$HOME/.ideavimrc"

info() { echo -e "${BLUE}==>${NC} $*"; }
warn() { echo -e "${YELLOW}[WARN]${NC} $*"; }
ok()   { echo -e "${GREEN}[OK]${NC} $*"; }
err()  { echo -e "${RED}[ERROR]${NC} $*"; }

usage() {
    cat <<EOF
Usage: $(basename "$0") <profile...>

Profiles:
  nvim      Standalone Neovim (full setup)
  vscode    VSCode-Neovim (same as nvim — init.lua handles it automatically)
  idea      IdeaVim (.ideavimrc)
  all       All of the above

Options:
  -h, --help    Show this help message

Examples:
  $(basename "$0") nvim
  $(basename "$0") nvim idea
  $(basename "$0") all
EOF
}

# Try to create a symlink at $1 pointing to $2.
# If a correct symlink already exists, print upgrade hint and return.
# If something else exists at $1, back it up first.
ensure_link() {
    local link_path="$1"
    local target="$2"
    local label="$3"

    # Already correctly linked — upgrade path
    if [ -L "$link_path" ] && [ "$(readlink "$link_path")" = "$target" ]; then
        ok "$label already installed. To upgrade: cd $NVIM_RUNTIME && git pull"
        return
    fi

    # Something else exists — back up
    if [ -e "$link_path" ] || [ -L "$link_path" ]; then
        local backup="${link_path}.bak.$(date +%Y%m%d%H%M%S)"
        warn "Existing $(basename "$link_path") backed up → $backup"
        mv "$link_path" "$backup"
    fi

    ln -s "$target" "$link_path"
    ok "$label installed: $link_path → $target"
}

install_nvim() {
    info "Installing Neovim configuration..."
    mkdir -p "$HOME/.config"
    ensure_link "$NVIM_CONFIG" "$NVIM_RUNTIME" "Neovim"
}

install_idea() {
    info "Installing IdeaVim configuration..."
    local src="$NVIM_RUNTIME/.ideavimrc"
    if [ ! -f "$src" ]; then
        err "$src not found"
        return 1
    fi
    ensure_link "$IDEAVIMRC" "$src" "IdeaVim"
}

# --- Main ---

if [ $# -eq 0 ]; then
    usage
    exit 1
fi

# Parse arguments
do_nvim=false
do_idea=false

for arg in "$@"; do
    case "$arg" in
        -h|--help)     usage; exit 0 ;;
        nvim|basic)    do_nvim=true ;;
        vscode)        do_nvim=true ;;
        idea)          do_idea=true ;;
        all)           do_nvim=true; do_idea=true ;;
        *)             err "Unknown profile: $arg"; usage; exit 1 ;;
    esac
done

# Preflight check
if [ ! -d "$NVIM_RUNTIME" ]; then
    err "$NVIM_RUNTIME not found. Clone the repo first:"
    echo "  git clone https://github.com/lionoggo/akit-nvim.git $NVIM_RUNTIME"
    exit 1
fi

$do_nvim && install_nvim
$do_idea && install_idea

echo ""
ok "All done! Enjoy :-)"
