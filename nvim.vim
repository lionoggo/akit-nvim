let s:home = fnamemodify(resolve(expand('<sfile>:p')), ':h')
let s:home = s:home.'/config'

" 插件配置文件所在路径
let plugin_config_path = s:home.'/plugins_config'
let file_list = split(globpath(plugin_config_path,'*.vim'),'\n')

" 定义加载文件的命令
command! -nargs=1 LoadScript exec 'source '.s:home.'/'.'<args>'

" 加载基础配置
LoadScript basic.vim

" 加载filetype
LoadScript filetypes.vim

" 加载按键映射配置
LoadScript keymap.vim

" 加载插件
LoadScript plugin.vim

" 加载插件配置文件
for file in file_list
	exec 'source' fnameescape(file)
endfor

