""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ftcommon.vim
" ============

" Description:           Shared functions for filetype config files
" Author:                Michael De Pasquale <shaggyrogers>
" Creation Date:         2018-02-18
" Modification Date:     2018-02-28
" License:               MIT
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"function! ftcommon#DeleteTrailingWS(...) " {{{
"    echom type(a:1)
"    return
"
"    "if a:0 >= 1
"    let pos = getpos(".")
"    %s/\s\+$//e
"    call cursor(pos[1], pos[2], pos[3])
"endfunc " }}}
"
"function! ftcommon#FixMarkers(...)" {{{
"    let mrks = rccommon#GetFoldMarkers()
"    let coms = rccommon#GetFoldMarkers()
"    exec '%s/\V\s\@<!\('.mrk[0].'\|'.mrk[1].'\)/ \0/''
"    exec '%s/\V\s\@<!\('.coms[0].'\s'.mrk[0].'\|'coms[1].'\s'.mrk[1].'\)/ \0/''
"endfunction" }}}
"
"" function! Echo(msg, [no_newline=0], [hilight_group=None]) " {{{
"function! ftcommon#Echo(text, ...)
"    exec (a:0 >= 2 ? 'echohl '.a:2 : '')
"    exec (a:0 >= 1 && a:1 ? 'echon ' : 'echo ').text
"    echohl 'None'
"endfunction " }}}
"
"" function! ConfirmYN(msg, [attempts], [strict]) " {{{
"" Y characters - if strict: Y; otherwise: Y,y,
"" N characters - if strict: N; otherwise: N,n,<Esc>,<C-c>,<Enter>,<Space>
"" 3 attempts by default, returns 0 if limit is reached.
"" Strict defaults to 0. If nonzero, only 'Y', 'N' and <E will be accepted.
"function! ftcommon#ConfirmYN(msg, ...)
"    let [l:nr, l:ucmdheight] = [get(a:, '1', 3), &cmdheight]
"    let l:pattern = get(a:, '2') ? 'YN' : '\V\cyn'
"    set cmdheight=2
"    redraw
"
"    while l:nr
"        ftcommon#EchoHL(a:msg . ' ('Y/N): '
"        let [l:answer, l:nr] = [nr2char(getchar()), l:nr - 1]
"        redraw
"
"        if match(l:pattern, '\V\'.(get(a:, '2')?'C':'c').l:answer) > 0 || !l:nr
"            break
"        endif
"
"        echom printf('Response not recognised. %d attempt%s remaining.',l:nr,
"                    \ (l:nr==1? '':'s'))
"    endwhile
"
"    exec 'set cmdheight='.l:ucmdheight
"    return (l:nr && l:answer ==? 'y')
"endfunction " }}}
"
"function! ftcommon#GetConfigDir() " {{{
"    return get(g:, 'vimDir', $HOME . '/.config/nvim/dictionaries/')
"endfunction " }}}
"
"function! ftcommon#HighlightTextWidth() " {{{
"    call matchadd('ColorColumn', '\%>'. string(&textwidth + 1) .'v', 100)
"endfunction " }}}
"
"function! ftcommon#LoadFiletypeDictionary() " {{{
"    let s:config = ftcommon#GetConfigDir()
"    let s:paths = [s:config.'/dictionaries/' . &filetype,
"                \ s:config.'/dictionaries/' . &filetype '.',
"    if ! filereadable(path) | return | endif
"    silent execute 'setlocal dict+=' . path
"endfunction " }}}
"
"function! ftcommon#UpdateTagbarOptions() " {{{
"    if exists('*UpdateTagbarOptions')
"        let l:id = win_getid()
"        call UpdateTagbarOptions(1)
"        call win_gotoid(l:id)
"    endif
"endfunction " }}}

" vim: set ts=4 sw=4 tw=79 fdm=marker et :
