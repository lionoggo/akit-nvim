" 防止重复加载
"
if get(s:, 'loaded',0) != 0
    finish
else
    let s:loaded = 1
endif

" 初始化全局
call common#common#init()

" 定义加载文件的命令
command! -nargs=1 LoadScript exec 'source '.s:home.'/'.'<args>'

" 获取本文件所在目录
let s:home = fnamemodify(resolve(expand('<sfile>:p')), ':h')
" let custom_plugin_config_path=s:home.'/plugin'
let s:home = s:home.'/config'

" 插件配置文件所在路径
let plugin_config_path = s:home.'/plugins_config'
let file_list = split(globpath(plugin_config_path,'*.vim'),'\n')

" 加载基础配置
LoadScript basic.vim

" 加载按键映射配置
LoadScript keymap.vim

" 加载themes
LoadScript themes.vim

" 加载插件
LoadScript plugin.vim

" 加载插件配置文件
for file in file_list
    exec 'source' fnameescape(file)
endfor

" let custom_file_list = split(globpath(custom_plugin_config_path,'*.vim'),'\n')
" for file in custom_file_list
"     exec 'source' fnameescape(file)
" endfor
