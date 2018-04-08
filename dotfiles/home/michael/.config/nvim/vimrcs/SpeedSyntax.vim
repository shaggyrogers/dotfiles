""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SpeedSyntax.vim
" ===============
"
" Author:                Michael De Pasquale
" Creation Date:         2018-02-24
" License:               MIT
" Description:           Attempts to speed up syntax highlighting.
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Was working, don't have time to fix, not really that useful anyway
"function! SpeedSyntax#CursorHighlightClear(...) "{{{
"    let pos = getpos('.')
"    return
"
"    if &cuc && pos[2] != get(b:,'_SpeedSytax_col',-1)
"            set nocursorcolumn | let b:_SpeedSyntax_col = pos[2]
"    endif
"
"    if &cul && pos[1] != get(b:, '_SpeedSytax_line', -1)
"            set nocursorline | let b:_SpeedSyntax_line = pos[2]
"    endif
"
"    call SpeedSyntax#CursorHighightStopTimer()
"    let b:cursor_highlight_timer =
"                \ timer_start(get(g:, 'SpeedSyntax_cursor_delay', 250),
"                \ function('SpeedSyntax#CursorHighightSet'))
"endfunction "}}}
"
"function! SpeedSyntax#CursorHighightStopTimer() "{{{
"    if get(b:, 'cursor_highlight_timer', -1) != -1
"        call timer_stop(b:cursor_highlight_timer)
"    endif
"endfunction "}}}
"
"function! SpeedSyntax#CursorHighightSet(...) "{{{
"    if get(g:, 'SpeedSyntax_cursor_column', 0) | set cursorcolumn | endif
"    if get(g:, 'SpeedSyntax_cursor_line', 0) | set cursorline | endif
"endfunction "}}}

" vim: set ts=4 sw=4 tw=79 fdm=marker et :
