" Folding setting for markdown.
" Version: 0.3.0
" Author : thinca <thinca+vim@gmail.com>
" License: zlib License

setlocal foldmethod=expr
setlocal foldexpr=markdown#fold#get_level(v:lnum)

if exists('b:undo_ftplugin')
  let b:undo_ftplugin .= ' | '
else
  let b:undo_ftplugin = ''
endif
let b:undo_ftplugin .= 'setl fdm< fde<'
