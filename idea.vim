" 防止重复加载
if get(s:, 'loaded',0) != 0
    finish
else
    let s:loaded = 1
endif

" 获取本文件所在目录
let s:home = fnamemodify(resolve(expand('<sfile>:p')), ':h')
let s:home = s:home.'/config'

" 插件配置文件所在路径
let plugin_config_path = s:home.'/plugins_config'
let file_list = split(globpath(plugin_config_path,'*.vim'),'\n')

" 定义加载文件的命令
command! -nargs=1 LoadScript exec 'source '.s:home.'/'.'<args>'

" 加载基础配置
LoadScript basic.vim

" 加载按键映射配置
LoadScript keymap.vim
