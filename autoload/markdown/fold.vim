" Folding setting for markdown.
" Version: 0.2.0
" Author : thinca <thinca+vim@gmail.com>
" License: zlib License

let s:save_cpo = &cpo
set cpo&vim

function! markdown#fold#get_level(lnum)
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

let &cpo = s:save_cpo
unlet s:save_cpo
