" 防止重复加载
if get(s:, 'loaded',0) != 0
    finish
else
    let s:loaded = 1
endif
" 初始化全局
call common#common#init(fnamemodify(resolve(expand('<sfile>:p')), ':h'))

" 定义载入配置命令
command! -nargs=1 LoadScript exec 'source ' . g:config_root_path . '<args>'

" 加载基础配置
LoadScript basic.vim
" 加载插件
LoadScript plugins.vim
" 加载按键映射配置
LoadScript keymap.vim
" 加载themes
LoadScript theme/themes.vim

"插件配置文件所在路径
let file_list = split(globpath(g:plugins_config_root_path,'*.vim'),'\n')
"加载插件配置文件
for file in file_list
    exec 'source' fnameescape(file)
endfor

" " 依据插件名字载入对应的插件配置
" function s:source_config(plugName) abort
"     let l:config_path = g:plugins_config_root_path . a:plugName . ".vim"
"     if filereadable(l:config_path)
"         exec 'source' fnameescape(l:config_path)
"     endif
" endfunction
"
" " TODO 从plug.vim中寻找何时载入插件
" " 载入插件配置
" for [plugName, _] in items(g:plugs)
"     if common#functions#HasInstall(plugName)
"         call s:source_config(plugName)
"     endif
" endfor
"
