# Neovim Configuration

基于 Lua 的现代 Neovim 配置，支持 **macOS** 和 **Linux**（Ubuntu/Debian、Arch 等），适配 **Neovim standalone**、**VSCode-Neovim**、**IdeaVim** 三种环境。

## 支持平台

| 平台 | 状态 |
|------|------|
| macOS (Apple Silicon / Intel) | 完整支持 |
| Ubuntu / Debian | 完整支持 |
| Arch Linux | 完整支持 |
| 其他 Linux 发行版 | 基本支持（需手动安装依赖） |

## 安装

### 前置依赖

#### 通用依赖（所有平台）

| 依赖 | 用途 | macOS | Ubuntu / Debian | Arch |
|------|------|-------|-----------------|------|
| **Neovim** >= 0.10 | 编辑器 | `brew install neovim` | [GitHub Releases](https://github.com/neovim/neovim/releases) AppImage | `pacman -S neovim` |
| **Git** | 插件管理 | `brew install git` | `apt install git` | `pacman -S git` |
| [**Nerd Font**](https://www.nerdfonts.com/) | 图标显示（推荐 Hack Nerd Font） | Homebrew Cask 或手动安装 | 手动安装 | `pacman -S ttf-hack-nerd` |
| **ripgrep** | 全局文本搜索 | `brew install ripgrep` | `apt install ripgrep` | `pacman -S ripgrep` |
| **fzf** | 模糊搜索引擎 | `brew install fzf` | `apt install fzf` | `pacman -S fzf` |
| **Node.js** | markdown-preview、prettierd | `brew install node` | `apt install nodejs npm` | `pacman -S nodejs npm` |

#### 平台特有依赖

<details>
<summary><b>macOS</b></summary>

| 依赖 | 用途 | 安装 |
|------|------|------|
| im-select | 中文输入法自动切换 | `brew install im-select` |
| lazygit | Git TUI（可选） | `brew install lazygit` |
| MacTeX / BasicTeX | LaTeX 编辑（可选） | `brew install --cask mactex` |
| Skim.app | LaTeX PDF 预览 + SyncTeX（可选） | `brew install --cask skim` |

</details>

<details>
<summary><b>Ubuntu / Debian</b></summary>

| 依赖 | 用途 | 安装 |
|------|------|------|
| fcitx5 或 ibus | 中文输入法自动切换 | `apt install fcitx5` |
| xclip（X11）或 wl-clipboard（Wayland） | 系统剪贴板集成 | `apt install xclip` 或 `apt install wl-clipboard` |
| lazygit | Git TUI（可选） | [GitHub Releases](https://github.com/jesseduffield/lazygit/releases) |
| TeX Live | LaTeX 编辑（可选） | `apt install texlive-full` |
| zathura | LaTeX PDF 预览 + SyncTeX（可选） | `apt install zathura zathura-pdf-poppler` |

</details>

<details>
<summary><b>Arch Linux</b></summary>

| 依赖 | 用途 | 安装 |
|------|------|------|
| fcitx5 或 ibus | 中文输入法自动切换 | `pacman -S fcitx5` |
| xclip 或 wl-clipboard | 系统剪贴板集成 | `pacman -S xclip` 或 `pacman -S wl-clipboard` |
| lazygit | Git TUI（可选） | `pacman -S lazygit` |
| TeX Live | LaTeX 编辑（可选） | `pacman -S texlive-most` |
| zathura | LaTeX PDF 预览 + SyncTeX（可选） | `pacman -S zathura zathura-pdf-poppler` |

</details>

### Neovim

```bash
# 1. 克隆配置到 ~/.nvim_runtime
git clone https://github.com/lionoggo/akit-nvim.git ~/.nvim_runtime

# 2. 运行安装脚本（自动创建 symlink + 检查系统依赖 + 检查格式化器）
cd ~/.nvim_runtime && bash install.sh nvim

# 3. 启动 Neovim（首次启动自动安装插件，等待完成后重启）
nvim
```

`install.sh` 会自动检测当前操作系统，检查所需依赖是否已安装，并给出对应平台的安装命令提示。

**支持的 profile**：

| 命令 | 说明 |
|------|------|
| `bash install.sh nvim` | Neovim standalone 配置 |
| `bash install.sh idea` | IdeaVim 配置（.ideavimrc） |
| `bash install.sh all` | 安装全部 |

进入 Neovim 后运行 `:Mason` 可管理 LSP 服务器、格式化器、Linter 的安装。

**格式化器**（需在 Mason 中手动安装，或通过系统包管理器安装）：

| 格式化器 | 文件类型 | Mason 安装 | macOS | Linux |
|----------|----------|------------|-------|-------|
| prettierd | JSON / YAML / JS / TS | `:MasonInstall prettierd` | `npm install -g @fsouza/prettierd` | 同左 |
| stylua | Lua | `:MasonInstall stylua` | `brew install stylua` | `cargo install stylua` |
| black | Python | `:MasonInstall black` | `pip install black` | 同左 |
| rustfmt | Rust | — | 随 Rust 工具链自带 | 同左 |

### VSCode

1. 安装 VSCode 扩展 [vscode-neovim](https://marketplace.visualstudio.com/items?itemName=asvetliakov.vscode-neovim)
2. 在 VSCode `settings.json` 中指定 Neovim 路径：
   ```json
   {
     "vscode-neovim.neovimExecutablePaths.darwin": "/opt/homebrew/bin/nvim",
     "vscode-neovim.neovimExecutablePaths.linux": "/usr/bin/nvim"
   }
   ```
3. 配置会自动加载 `~/.config/nvim/init.lua`，检测到 VSCode 环境后只启用键位映射，不加载插件。

### IdeaVim

```bash
bash install.sh idea
```

重启 JetBrains IDE 即可生效。

## 架构

```
~/.config/nvim/
├── init.lua                      # 入口：环境检测 + 加载分流
├── lua/
│   ├── core/                     # 核心层（全环境共享）
│   │   ├── options.lua           #   vim 选项设置
│   │   ├── keymaps.lua           #   通用键位映射
│   │   └── autocmds.lua          #   自动命令（仅 Neovim）
│   ├── vscode/                   # VSCode 层
│   │   └── keymaps.lua           #   VSCode 命令映射
│   ├── config/
│   │   └── lazy.lua              # lazy.nvim 引导安装
│   └── plugins/                  # 插件层（仅 Neovim standalone）
│       ├── colorscheme.lua       #   主题
│       ├── editor.lua            #   编辑增强
│       ├── ui.lua                #   界面
│       ├── navigation.lua        #   导航与搜索
│       ├── lsp.lua               #   LSP + 补全 + 格式化
│       ├── treesitter.lua        #   语法树
│       ├── git.lua               #   Git 集成
│       ├── im-select.lua         #   中文输入法自动切换
│       ├── markdown.lua          #   Markdown 编辑
│       └── latex.lua             #   LaTeX 编辑
└── .ideavimrc                    # IdeaVim 配置
```

### 三层分流

```
init.lua
  ├─ 所有环境 ─→ core/options.lua + core/keymaps.lua
  │
  ├─ VSCode ──→ vscode/keymaps.lua        （仅键位，调用 VSCode 原生命令）
  │
  └─ Neovim ──→ core/autocmds.lua         （自动命令）
               → config/lazy.lua           （引导 lazy.nvim）
               → plugins/*.lua             （全部插件）
```

- **core 层**：基础 vim 选项和通用键位，VSCode 和 Neovim 均加载
- **vscode 层**：将 Vim 键位映射到 VSCode 原生命令（如 `gd` → `editor.action.revealDefinition`）
- **plugins 层**：仅在 Neovim standalone 模式下加载，通过 lazy.nvim 管理，按需懒加载

### 插件一览

| 类别 | 插件 | 用途 | 平台 |
|------|------|------|------|
| 插件管理 | lazy.nvim | 插件管理器，支持懒加载、lockfile、profiler | 全平台 |
| 主题 | catppuccin (默认), tokyonight, gruvbox-material, molokai | 可切换的多主题 | 全平台 |
| 补全 | blink.cmp + friendly-snippets | 高性能补全引擎 + 代码片段 | 全平台 |
| LSP | nvim-lspconfig + mason.nvim + mason-lspconfig | 语言服务协议 + 自动安装 | 全平台 |
| 格式化 | conform.nvim | 异步代码格式化 | 全平台 |
| 语法树 | nvim-treesitter + textobjects + context | 语义高亮、文本对象、上下文显示 | 全平台 |
| 模糊搜索 | fzf-lua | 文件搜索、文本搜索、Buffer 切换等 | 全平台 |
| 文件树 | snacks.nvim explorer | 侧边文件浏览器 | 全平台 |
| 代码大纲 | aerial.nvim | Treesitter 驱动的符号大纲 | 全平台 |
| 状态栏 | lualine.nvim | 底部状态栏 | 全平台 |
| Buffer 栏 | bufferline.nvim | 顶部 Buffer 标签栏 | 全平台 |
| Git | gitsigns.nvim | 行内 Git 状态标记 | 全平台 |
| Git TUI | lazygit (通过 snacks.nvim 终端) | 浮窗 Git 操作 | 全平台 |
| 启动页 | snacks.nvim dashboard | 启动画面 | 全平台 |
| 跳转 | flash.nvim | 两键快速跳转到任意位置 | 全平台 |
| 环绕编辑 | mini.surround | 添加/删除/替换包裹符号 | 全平台 |
| 自动配对 | mini.pairs | 自动补全括号引号 | 全平台 |
| 键位提示 | which-key.nvim | 按键后弹出后续键位提示 | 全平台 |
| 平滑滚动 | snacks.nvim scroll | `<C-d>`/`<C-u>` 等滚动命令带动画效果 | 全平台 |
| 缩进线 | snacks.nvim indent | 缩进参考线 | 全平台 |
| 注释 | ts-comments.nvim | Treesitter 感知的注释切换（gcc/gc） | 全平台 |
| 撤销树 | undotree | 可视化撤销历史 | 全平台 |
| 翻译 | translate.nvim | 选中文本翻译为中文（Google 翻译） | 全平台 |
| 输入法 | im-select.nvim | 离开插入模式自动切英文，回来恢复中文 | macOS: im-select, Linux: fcitx5-remote / ibus |
| Markdown 渲染 | render-markdown.nvim | Buffer 内渲染标题、代码块、表格、勾选框 | 全平台 |
| Markdown 预览 | markdown-preview.nvim | 浏览器实时预览，支持 KaTeX/Mermaid | 全平台 |
| Markdown LSP | marksman (via mason) | 文档符号、链接跳转、补全、TOC | 全平台 |
| LaTeX | vimtex | 编译、PDF 预览、SyncTeX、文本对象 | macOS: Skim.app, Linux: zathura |
| LaTeX LSP | texlab (via mason) | 补全、诊断、跳转定义、格式化 | 全平台 |

## 键位映射

### Leader 键

| 键 | 角色 | 说明 |
|---|---|---|
| `,` | 主 Leader | 高频快速操作 |
| `Space` | 辅助 Leader | 分组操作，按下后 which-key 弹出提示面板 |

> 按下 `,` 或 `Space` 后稍等片刻，which-key 会自动弹出所有可用后续键。
> 按 `,?` 可查看全部键位映射。

### 基础操作（全环境通用）

| 键位 | 功能 |
|------|------|
| `,w` | 保存文件 |
| `U` | Redo（替代 `<C-r>`） |
| `j` / `k` | 屏幕行移动（非实际行） |
| `Y` | 复制到行尾 |
| `vv` | 选中当前行内容 |
| `<` / `>` (visual) | 缩进后保持选中 |
| `,;` | 在行尾追加分号 |
| `<BS>` | 清除搜索高亮 |
| `<C-h>` / `<C-l>` (命令行) | 跳转到行首/行尾 |
| `,ss` | 切换拼写检查 |
| `,sn` / `,sp` | 下/上一个拼写错误 |
| `*` / `#` (visual) | 搜索选中文本 |

### `,` Leader 快速操作

| 键位 | 功能 | 环境 |
|------|------|------|
| `,f` | 搜索文件 | 全部 |
| `,,` | 全局文本搜索 | 全部 |
| `,e` | 切换文件树/侧栏 | 全部 |
| `,nn` | 在文件树中定位当前文件 | 全部 |
| `,o` | 代码大纲 | Neovim / IdeaVim |
| `,rn` | 重命名符号 | 全部 |
| `,ca` | 代码操作/快速修复 | 全部 |
| `,fm` | 格式化代码 | 全部 |
| `,gg` | 打开 Lazygit / Git 菜单 | 全部 |
| `,'` | 打开终端 | Neovim / VSCode |
| `,u` | 撤销树 | Neovim |
| `,rc` | 编辑配置文件 | Neovim |
| `,bd` | 关闭当前 Buffer | 全部 |
| `,bo` | 关闭其他 Buffer | 全部 |
| `,qq` | 退出 Vim（带确认） | Neovim |
| `,ts` | 翻译选中文本（浮窗显示） | Neovim |
| `,tr` | 翻译并替换选中文本 | Neovim |
| `,mp` | Markdown 浏览器预览 | Neovim |
| `,?` | 显示全部键位 | Neovim |

### `Space` 辅助 Leader

#### 搜索 & 导航

| 键位 | 功能 |
|------|------|
| `Space f` | 搜索文件 |
| `Space s` | 全局搜索文本 |
| `Space b` | 切换 Buffer |
| `Space r` | 最近打开的文件 |
| `Space h` | 搜索帮助文档 |
| `Space /` | 当前文件内搜索 |
| `Space d` | 诊断信息列表 |
| `Space km` | 查看所有键位映射 |

#### Git

| 键位 | 功能 |
|------|------|
| `Space gg` | Git 提交历史 / SCM 面板 |
| `Space gs` | Git 文件状态 |
| `Space gc` | Git 提交记录 |
| `Space gb` | 当前行 Git Blame |
| `Space gp` | 预览当前改动 (hunk) |
| `Space gr` | 重置当前改动 |
| `Space gS` | Stage 当前改动 |
| `Space gu` | 撤销 Stage |

#### 切换

| 键位 | 功能 |
|------|------|
| `Space tt` | 切换主题（实时预览） |
| `Space tz` | Zen 模式 / 无干扰模式 |

### 代码导航（全环境统一）

| 键位 | 功能 |
|------|------|
| `gd` | 跳转到定义 |
| `gD` | 跳转到声明 |
| `gr` | 查看引用 |
| `gi` | 跳转到实现 |
| `gs` | 跳转到父类方法（IdeaVim） |
| `gx` | 用系统默认应用打开光标下 URL/路径 |
| `gX` | 用系统默认应用打开当前文件（如 HTML → 浏览器） |
| `K` | 悬浮文档 |
| `]d` / `[d` | 下/上一个诊断 |
| `]f` / `[f` | 下/上一个函数（Neovim, Treesitter） |
| `]c` / `[c` | 下/上一个类（Neovim, Treesitter） |
| `]h` / `[h` | 下/上一个 Git 改动 |

### 跳转 & 动作（Neovim）

| 键位 | 功能 |
|------|------|
| `s` | Flash 跳转 — 输入目标字符，标签跳转 |
| `S` | Flash Treesitter — 按语法结构选择 |
| `f`/`F`/`t`/`T` | Flash 增强版行内跳转 — 默认扩展为多行，可见区域内高亮所有匹配并标签跳转 |
| `gcc` | 切换当前行注释 |
| `gc{motion}` | 切换指定范围注释（如 `gcap` 注释当前段落） |
| `gc` (visual) | 切换选中区域注释 |
| `sa{motion}{char}` | 添加 surround（如 `saiw"` 给单词加双引号） |
| `sd{char}` | 删除 surround（如 `sd"` 删除双引号） |
| `sr{old}{new}` | 替换 surround（如 `sr"'` 双引号换单引号） |

### Treesitter 文本对象（Neovim）

可与 `d`、`y`、`c`、`v` 等操作符组合使用：

| 文本对象 | 含义 |
|----------|------|
| `af` / `if` | 外/内 函数 |
| `ac` / `ic` | 外/内 类 |
| `aa` / `ia` | 外/内 参数 |

示例：`daf` 删除整个函数，`via` 选中当前参数，`cif` 修改函数体。

### 窗口管理（Neovim）

| 键位 | 功能 |
|------|------|
| `<C-h/j/k/l>` | 在窗口间导航 |
| `<C-w>h/j/k/l` | 向该方向分割新窗口 |
| `<A-->` / `<A-_>` | 增大/减小窗口高度 |
| `<A-(>` / `<A-)>` | 减小/增大窗口宽度 |
| `<Tab>` / `<S-Tab>` | 下/上一个 Buffer |

### IdeaVim 专属

| 键位 | 功能 |
|------|------|
| `,em` | 提取方法 |
| `,iv` | 提取变量 |
| `,ic` | 提取常量 |
| `,if` | 提取字段 |
| `,oi` | 优化 import |
| `,dd` | 选择调试配置 |
| `,db` | 切换断点 |
| `,dv` | 查看所有断点 |
| `,gb` | Git 分支列表 |
| `<C-p>` | 全局搜索 |

### 中文输入法自动切换

安装对应平台的输入法工具后自动生效，无需额外配置：

- **离开插入模式**：自动切换到英文输入法
- **进入插入模式**：自动恢复之前的输入法状态
- 切换过程异步执行，不阻塞编辑

| 平台 | 工具 | 安装 |
|------|------|------|
| macOS | im-select | `brew install im-select` |
| Linux (fcitx5) | fcitx5-remote | `apt install fcitx5` / `pacman -S fcitx5` |
| Linux (ibus) | ibus | `apt install ibus` / `pacman -S ibus` |

> 插件会自动检测当前平台和可用的输入法后端，若未检测到则跳过加载，不会报错。
>
> IdeaVim 通过内置的 `set keep-english-in-normal-and-restore-in-insert` 实现相同功能，无需上述工具。

### Markdown 编辑

打开 `.md` 文件时自动启用：

- **Buffer 内渲染**：标题带背景色、代码块高亮、表格对齐、勾选框可视化（Normal 模式显示渲染效果，Insert 模式显示原始文本）
- **浏览器预览**：`,mp` 打开浏览器实时预览，支持 KaTeX 数学公式、Mermaid 流程图
- **LSP 支持**：marksman 提供文档符号大纲、链接跳转、标题补全
- 自动启用 `wrap`、`linebreak`、`spell`

### LaTeX 编辑

打开 `.tex` 文件时自动启用：

| 功能 | 说明 |
|------|------|
| 编译 | latexmk 持续编译，保存时自动触发 |
| PDF 预览 | 自动检测可用查看器（见下表） |
| 正向搜索 | 从源码跳转到 PDF 对应位置（需 SyncTeX 兼容查看器） |
| 反向搜索 | 在 PDF 查看器中点击跳回源码 |
| 补全 | texlab LSP 提供标签、引用、命令、环境补全 |
| 文本对象 | `ie`/`ae` 环境、`ic`/`ac` 命令、`i$`/`a$` 数学公式（vimtex 提供） |

**PDF 查看器（按平台自动选择）**：

| 平台 | 查看器 | SyncTeX 支持 | 安装 |
|------|--------|-------------|------|
| macOS | Skim.app | 正向 + 反向 | `brew install --cask skim` |
| Linux（推荐） | zathura | 正向 + 反向 | `apt install zathura zathura-pdf-poppler` |
| Linux（fallback） | xdg-open | 无 | 系统默认 |

> **macOS 反向搜索配置**：Skim → 偏好设置 → 同步 → 预设选 "Custom"，命令填 `nvim`，参数填 `--headless -c "VimtexInverseSearch %line '%file'"`
>
> **Linux 反向搜索配置**：zathura 通过 SyncTeX 自动支持，无需额外配置。

## 配置定制

### 添加插件

在 `lua/plugins/` 目录下新建或编辑 `.lua` 文件，lazy.nvim 会自动扫描该目录：

```lua
-- lua/plugins/my-plugin.lua
return {
  {
    "author/plugin-name",
    event = "VeryLazy",       -- 懒加载时机
    opts = {},                -- 传递给 plugin.setup() 的配置
    keys = {                  -- 按键触发加载
      { "<leader>x", "<cmd>PluginCommand<cr>", desc = "Description" },
    },
  },
}
```

### 添加 LSP 服务器

1. `:Mason` 搜索并安装服务器
2. 在 `lua/plugins/lsp.lua` 的 `ensure_installed` 列表中添加服务器名称

### 添加格式化器

在 `lua/plugins/lsp.lua` 的 `conform.nvim` 配置中添加：

```lua
formatters_by_ft = {
  -- 已有配置...
  css = { "prettier" },        -- 新增
  markdown = { "prettier" },   -- 新增
},
```

### 切换默认主题

编辑 `lua/plugins/colorscheme.lua`，修改默认加载的主题：

```lua
-- 将 catppuccin 改为 lazy = true
-- 将目标主题改为 lazy = false, priority = 1000 并设置 vim.cmd.colorscheme()
```

### 添加 VSCode 键位

编辑 `lua/vscode/keymaps.lua`，使用 `vscode.action()` 调用 VSCode 命令：

```lua
map("n", "<leader>x", action("workbench.action.someCommand"), { desc = "Description" })
```

VSCode 命令 ID 可通过 `Cmd+Shift+P` 搜索命令后查看。

## 卸载

```bash
rm -rf ~/.config/nvim
rm -rf ~/.local/share/nvim
rm -rf ~/.local/state/nvim
rm -rf ~/.cache/nvim
```
