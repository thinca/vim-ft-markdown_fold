" Folding setting for markdown.
" Version: 0.1.0
" Author : thinca <thinca+vim@gmail.com>
" License: Creative Commons Attribution 2.1 Japan License
"          <http://creativecommons.org/licenses/by/2.1/jp/deed.en>

setlocal foldmethod=expr
setlocal foldexpr=MarkdownFold()

function! MarkdownFold()
  let head = s:head(v:lnum)
  if head
    return head
  elseif v:lnum != line('$') && getline(v:lnum + 1) =~ '^#'
    return '<' . s:head(v:lnum + 1)
  endif
  return '='
endfunction

function! s:head(lnum)
  return strlen(matchstr(getline(a:lnum), '^#*'))
endfunction


if exists('b:undo_ftplugin')
  let b:undo_ftplugin .= ' | '
else
  let b:undo_ftplugin = ''
endif
let b:undo_ftplugin .= 'setl fdm< fde<'
