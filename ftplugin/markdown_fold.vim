" Folding setting for markdown.
" Version: 0.1.1
" Author : thinca <thinca+vim@gmail.com>
" License: zlib License

setlocal foldmethod=expr
setlocal foldexpr=MarkdownFold(v:lnum)

if exists('b:undo_ftplugin')
  let b:undo_ftplugin .= ' | '
else
  let b:undo_ftplugin = ''
endif
let b:undo_ftplugin .= 'setl fdm< fde<'

if exists('*MarkdownFold')
  finish
endif

function! MarkdownFold(lnum)
  let head = s:head(a:lnum)
  if head
    return head
  elseif a:lnum != line('$')
    let next = s:head(a:lnum + 1)
    if next
      return '<' . next
    endif
  endif
  return '='
endfunction

function! s:head(lnum)
  let current = getline(a:lnum)
  let sharps = strlen(matchstr(current, '^#*'))
  if sharps
    return sharps
  endif

  " <h2> <h3> ...
  let h = matchstr(current, '^\s*<\s*h\zs\d\ze\>') - 0
  if h
    return h
  endif

  if current =~ '\S'
    let next = getline(a:lnum + 1)
    if next =~ '^=\+$'
      return 1
    elseif next =~ '^-\+$'
      return 2
    endif
  endif
  return 0
endfunction

