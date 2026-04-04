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

() { echo -e "${BLUE}==>${NC} $*"; }
warn() { echo -e "${YELLOW}[WARN]${NC} $*"; }
ok()   { echo -e "${GREEN}[OK]${NC} $*"; }
err()  { echo -e "${RED}[ERROR]${NC} $*"; }

detect_os() {
    case "$(uname -s)" in
        Darwin) echo "macos" ;;
        Linux)
            if [ -f /etc/debian_version ]; then echo "debian"
            elif [ -f /etc/arch-release ]; then echo "arch"
            elif [ -f /etc/fedora-release ]; then echo "fedora"
            else echo "linux"
            fi ;;
        *) echo "unknown" ;;
    esac
}

OS=$(detect_os)

pkg_hint() {
    local tool="$1"
    local brew_cmd="$2"
    local apt_cmd="$3"
    local pacman_cmd="$4"
    local fallback="$5"

    case "$OS" in
        macos)  echo "$tool → $brew_cmd" ;;
        debian) echo "$tool → $apt_cmd" ;;
        arch)   echo "$tool → $pacman_cmd" ;;
        *)      echo "$tool → $fallback" ;;
    esac
}

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

check_system_deps() {
    info "Checking system dependencies ($OS)..."
    local missing=()

    # Common tools (all platforms)
    command -v nvim &>/dev/null || \
        missing+=("$(pkg_hint "neovim" "brew install neovim" "apt install neovim (或从 GitHub Releases 下载 AppImage)" "pacman -S neovim" "从 https://github.com/neovim/neovim/releases 下载")")
    command -v rg &>/dev/null || \
        missing+=("$(pkg_hint "ripgrep" "brew install ripgrep" "apt install ripgrep" "pacman -S ripgrep" "cargo install ripgrep")")
    command -v fzf &>/dev/null || \
        missing+=("$(pkg_hint "fzf" "brew install fzf" "apt install fzf" "pacman -S fzf" "从 https://github.com/junegunn/fzf/releases 下载")")
    command -v node &>/dev/null || \
        missing+=("$(pkg_hint "node (markdown-preview)" "brew install node" "apt install nodejs npm" "pacman -S nodejs npm" "https://nodejs.org/")")
    command -v lazygit &>/dev/null || \
        missing+=("$(pkg_hint "lazygit (可选, Git TUI)" "brew install lazygit" "见 https://github.com/jesseduffield/lazygit/releases" "pacman -S lazygit" "见 https://github.com/jesseduffield/lazygit/releases")")

    # Platform-specific tools
    case "$OS" in
        macos)
            command -v im-select &>/dev/null || \
                missing+=("im-select (输入法切换) → brew install im-select")
            ;;
        debian|arch|fedora|linux)
            # Input method
            if ! command -v fcitx5-remote &>/dev/null && ! command -v ibus &>/dev/null; then
                missing+=("$(pkg_hint "fcitx5-remote 或 ibus (输入法切换)" "" "apt install fcitx5" "pacman -S fcitx5" "安装 fcitx5 或 ibus")")
            fi
            # Clipboard
            if ! command -v xclip &>/dev/null && ! command -v xsel &>/dev/null && ! command -v wl-copy &>/dev/null; then
                missing+=("$(pkg_hint "xclip/wl-clipboard (剪贴板)" "" "apt install xclip (X11) 或 apt install wl-clipboard (Wayland)" "pacman -S xclip 或 pacman -S wl-clipboard" "安装 xclip 或 wl-clipboard")")
            fi
            # LaTeX PDF viewer (optional)
            if command -v latexmk &>/dev/null && ! command -v zathura &>/dev/null; then
                missing+=("$(pkg_hint "zathura (可选, LaTeX PDF 预览)" "" "apt install zathura zathura-pdf-poppler" "pacman -S zathura zathura-pdf-poppler" "安装 zathura")")
            fi
            ;;
    esac

    if [ ${#missing[@]} -gt 0 ]; then
        echo ""
        warn "以下系统依赖未安装："
        for item in "${missing[@]}"; do
            echo -e "  ${YELLOW}•${NC} $item"
        done
        echo ""
    else
        ok "所有系统依赖已就绪"
    fi
}

check_formatters() {
    local missing=()

    command -v prettierd &>/dev/null || command -v prettier &>/dev/null || \
        missing+=("prettierd  (JSON/YAML/JS/TS)  →  :MasonInstall prettierd  或  npm install -g @fsouza/prettierd")
    command -v stylua &>/dev/null || \
        missing+=("$(pkg_hint "stylua (Lua)" ":MasonInstall stylua  或  brew install stylua" ":MasonInstall stylua  或  cargo install stylua" ":MasonInstall stylua  或  pacman -S stylua" ":MasonInstall stylua  或  cargo install stylua")")
    command -v black &>/dev/null || \
        missing+=("black      (Python)          →  :MasonInstall black      或  pip install black")
    command -v rustfmt &>/dev/null || \
        missing+=("rustfmt    (Rust)            →  随 Rust 工具链自带，运行 rustup component add rustfmt")

    if [ ${#missing[@]} -gt 0 ]; then
        echo ""
        warn "以下格式化器未安装，,fm 格式化功能将不可用："
        for item in "${missing[@]}"; do
            echo -e "  ${YELLOW}•${NC} $item"
        done
        echo -e "  ${BLUE}提示：${NC}进入 Neovim 后也可通过 :Mason 统一安装"
    fi
}

install_nvim() {
    info "Installing Neovim configuration..."
    mkdir -p "$HOME/.config"
    ensure_link "$NVIM_CONFIG" "$NVIM_RUNTIME" "Neovim"
    check_system_deps
    check_formatters
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
