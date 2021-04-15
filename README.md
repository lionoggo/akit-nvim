![VIM](https://dnp4pehkvoo6n.cloudfront.net/43c5af597bd5c1a64eb1829f011c208f/as/Ultimate%20Vimrc.svg)

# The Ultimate vimrc

This configuration is the ultimate vimrc for neovim.

## How to install ?
### Install for your own user only

```shell
git clone --depth=1 https://github.com/lionoggo/akit-nvim.git ~/.nvim_runtime
sh ~/.nvim_runtime/install_akit_nvim.sh
```

## Fonts

I recommend using [Hack font](http://sourcefoundry.org/hack/)

## Structure
```bash
├── autoload/
│   ├── common/
│   │   ├── common.vim
│   │   └── functions.vim
├── config/
│   ├── plugins/
│   ├── other/
│   ├── theme/
│   │   ├── theme.vim
│   │   ├── statusline.vim
│   │   └── tabline.vim
│   ├── base.vim
│   ├── keymap.vim
│   └── plugin_list.vim
├── plugin/
├── ftplugin/
├── init.vim
└── vimrc -> ./init.vim
```

1. `autoload/`

在neovim中,`autoload/`目录用于自动加载.

2. `config/`

   该目录是主要的配置文件目录。

   - `config/plugins/`

     此目录下面就是所有插件的配置，一个插件对应一个文件，文件的名称与插件的名称相同，比如插件`Plug "user_name/plugin_name.vim"`对应的配置文件名称为`plugin_name.vim`。

     > 对于插件的配置文件，有一个小小的规范，某个插件的按键映射最好写到对应配置文件的最后。

   - `config/other/`

     此目录主要存放一些插件需要用到的文件，比如插件[coc](https://github.com/neoclide/coc.nvim)用到的`coc-settings.json`，ycm用到的`ycm_extra_conf.py`等文件。

3. `plugin/`

   在(neo)vim中，`plugin/`目录下的配置会在(neo)vim启动的时候自动加载，因此，我主要用于存放一些自定义的配置在这里。

4. `ftplugin`

   该目录是(neo)vim的目录，该目录下的文件都是以`文件类型.vim`格式进行命名，比如`c.vim`，`cpp.vim`，表示遇到`c`，`cpp`文件的时候要执行对应文件的代码。



## Included Plugins


## Included color schemes


## Key Mappings

### Plugin related mappings

### Normal mode mappings

### Visual mode mappings

### Insert mode mappings

### Command line mappings

### Spell checking

## How to uninstall

Just do following:
* Remove `~/.nvim_runtime`
* Remove any lines that reference `.nvim_runtime` in your `~/.config/nvim/init.vim`
