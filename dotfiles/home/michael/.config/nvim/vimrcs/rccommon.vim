""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" rccommon.vim
" ============
"
" Description:           Shared functions for vim scripts
" Author:                Michael De Pasquale <shaggyrogers>
" Creation Date:         2018-02-18
" Modification Date:     2018-03-01
" License:               MIT
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Editing
function! rccommon#DeleteTrailingWS(...) " {{{
    let pos = getpos(".")
    %s/\s\+$//e
    call cursor(pos[1], pos[2], pos[3])
endfunc " }}}

function! rccommon#FixMarkers(...) " {{{
    let mrks = rccommon#FoldMarkers()
    let coms = rccommon#FoldMarkers()
    exec '%s/\V\s\@<!\('.mrk[0].'\|'.mrk[1].'\)/ \0/''
    exec '%s/\V\s\@<!\('.coms[0].'\s'.mrk[0].'\|'coms[1].'\s'.mrk[1].'\)/ \0/''
endfunction " }}}

function! TestRange() range
    echom a:firstline
    echom a:lastline
endfunction

" function! rccommon#GetVisual() : Returns a list of visual selection lines {{{
" Source: https://github.com/SpaceVim/SpaceVim/blob/master/config/neovim.vim
function! rccommon#GetVisual()
    let [lnum1, col1] = getpos("'<")[1:2]
    let [lnum2, col2] = getpos("'>")[1:2]
    let lines = getline(lnum1, lnum2)
    let lines[-1] = lines[-1][:col2 - 2]
    let lines[0] = lines[0][col1 - 1:]
    return lines
endfunction"}}}

" UI
function! rccommon#HighlightTextWidth() " {{{
    call matchadd('ColorColumn', '\%>'. string(&textwidth + 1) .'v', 100)
endfunction " }}}

" Echo(msg, [hilight_group=None], [nonewline=0]) " {{{
" Echo prints a newline before msg if necessary, unless nonewline is nonzero.
function! rccommon#Echo(text, ...)
    exec (a:0 >= 1 ? 'echohl '.a:1 : '')
    exec (a:0 >= 2 && a:2 ? 'echon ' : 'echo ').'"'.a:text.'"'
    echohl 'None'
endfunction " }}}

" ConfirmYN(msg, [attempts=3], [strict=0], [default='0'], [hi='Question'])" {{{
" Using all attempts is always treated as 'N'.
" If strict is nonzero, only Y and N are accepted, and cancelling is disabled.
" Y/N are otherwise not case sensitive. Ctrl+C, Ctrl+D and Escape cancel.
" Default is returned if user cancels or exhausts attempts.
function! rccommon#ConfirmYN(msg, ...) abort
    let [l:nr, l:ucmdheight] = [get(a:, '1', 3), &cmdheight]
    let l:ypattern = get(a:, '2', 0) ? '\V\CY' : '\V\cy'
    let l:npattern = get(a:, '2', 0) ? '\V\CN' : '\V\cn'
    let l:cpattern = get(a:, '2', 0) ? '' : '\V\[\r]'
    let l:result = (a:0 < 3) ? 0 : (a:3 == 1)
    let l:hi = (a:0 < 4) ? 'Question' : a:4
    set cmdheight=2

    if get(a:, '2', 0) | let l:yn = '[Y/N] (case sensitive):' |
                \ elseif l:result | let l:yn = '[Y/n]:' |
                \ else | let l:yn = '[y/N]:' | endif

    while l:nr
        call rccommon#Echo(a:msg . ' ' . l:yn, l:hi)
        let [l:answer, l:nr] = [nr2char(getchar()), l:nr - 1]
        redraw!

        if match(l:answer, l:ypattern) >= 0 | let l:result = 1 | break | endif
        if match(l:answer, l:npattern) >= 0 | let l:result = 0  | break | endif
        if match(l:answer, l:cpattern) >= 0 | break | endif

        echo printf('Response not recognised. %d attempt%s remaining.', 
                    \ l:nr, (l:nr == 1 ? '' : 's'))
    endwhile

    exec 'set cmdheight='.l:ucmdheight
    return l:result
endfunction " }}}

function! rccommon#BufferColumns() "{{{
    if !&number | return winwidth(0) - &foldcolumn - 2 | endif
    let lln = max([&nuw - 1, strlen(string(line('$'))), 0])
    return winwidth(0) - &foldcolumn - lln - 2
endfunction
"}}}

" Syntax / Filetypes
function! rccommon#LoadFiletypeDictionary() abort " {{{
    let l:path = rccommon#ConfigDir().'/dictionaries/'.&filetype.'.txt'

    if !filereadable(path)
        return
    endif

    silent execute 'setlocal dict+=' . path
endfunction " }}}

" Plugins
function! rccommon#UpdateTagbarOptions() abort " {{{
    if exists('*UpdateTagbarOptions')
        let l:id = win_getid()
        call UpdateTagbarOptions(1)
        call win_gotoid(l:id)
    endif
endfunction " }}}

" Config Getters/Setters
function! rccommon#ConfigDir() " {{{
    return g:vim_dir
endfunction " }}}

function! rccommon#TempDir() " {{{
    return g:vim_dir_tmp
endfunction" }}}

function! rccommon#FoldMarkers() "{{{
    let l:markers = split(&foldmarker, ',')
    return [escape(l:markers[0], '\'), escape(l:markers[1], '\')]
endf "}}}

function! rccommon#CommentStrings() "{{{
    let l:res = [escape(matchstr(&commentstring, '.*\ze%s'), '\'),
                \ escape(matchstr(&commentstring, '%s\zs.*'), '\') ]
    return [l:res[0], (l:res[1] == '' ? '\$' : l:res[1])]
endf "}}}

" vim: set ts=4 sw=4 tw=79 fdm=marker et :
