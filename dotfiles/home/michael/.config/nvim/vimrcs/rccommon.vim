""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" rccommon.vim
" ============
"
" Description:           Shared functions for vim scripts
" Author:                Michael De Pasquale <shaggyrogers>
" Creation Date:         2018-02-18
" Modification Date:     2019-07-07
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Editing
" UpdateModificationDate() {{{
" Update modification date in file header in current buffer.
" Does not make any changes if the buffer has not been modified, or the
" modification date is already correct.
function! rccommon#UpdateModificationDate()
    if !&modified
        return
    endif

    " Search the first 14 lines for 'modification date'
    let l:lines = getbufline('', 1, 14)
    let l:i = 0
    let l:oldts = ''

    while l:i < len(l:lines) && l:oldts == ''
        let l:oldts = matchstr(l:lines[l:i],
                    \ '\m\(^.\?.\?\s*[Mm]odification [Dd]ate:\?\s*\)'
                    \ . '\@<=[0-9\-\\/]\{8,10}\s*$', 0, 1)
        let l:i += 1
    endwhile

    " Exit if not found, or already up-to-date
    if l:oldts == '' || l:oldts == strftime('%Y-%m-%d')
        return
    endif

    " Change to current date
    call setline(l:i, l:lines[l:i-1][0:-len(l:oldts)-1] . strftime('%Y-%m-%d'))
endfunc " }}}

" DeleteTrailingWS() {{{
" Remove trailing whitespace in current buffer
function! rccommon#DeleteTrailingWS(...)
    let pos = getpos(".")
    %s/\s\+$//e
    call cursor(pos[1], pos[2], pos[3])
endfunc " }}}

" GetVisual() {{{
" Returns a list of visual selection lines
" Source: https://github.com/SpaceVim/SpaceVim/blob/master/config/neovim.vim
function! rccommon#GetVisual() abort
    let [lnum1, col1] = getpos("'<")[1:2]
    let [lnum2, col2] = getpos("'>")[1:2]
    let lines = getline(lnum1, lnum2)
    let lines[-1] = lines[-1][:col2 - 2]
    let lines[0] = lines[0][col1 - 1:]
    return lines
endfunction" }}}

" ExecNoCursor : Executes a command and restores the cursor position. {{{
function! rccommon#ExecNoCursor(cmd) abort
    let pos = getpos('.')
    exec a:cmd
    call cursor(pos[1], pos[2], pos[3])
endfunction
"}}}

" AppendModeline : Update or add a modeline {{{
" Source: http://vim.wikia.com/wiki/Modeline_magic (with alterations)
function! rccommon#AppendModeline() abort
    " Build modeline
    let l:modeline = printf(
                \ ' vim: set ts=%d sw=%d tw=%d fdm=%s fenc=%s %set : ',
                \ &tabstop, &shiftwidth, &textwidth, &foldmethod,
                \ &fileencoding, &expandtab ? '' : 'no')
    let l:modeline = substitute(
                \ &commentstring,
                \ '\V%s',
                \ printf(
                \     ' vim: set ts=%d sw=%d tw=%d fdm=%s fenc=%s %set : ',
                \     &tabstop, &shiftwidth, &textwidth, &foldmethod,
                \     &fileencoding, &expandtab ? '' : 'no'
                \ ),
                \ ''
                \ )

    " Backup and change options
    let urp = &report
    set report=9999

    " Remove existing modeline
    if match(getline(line('$')), '\V' .
                \ escape(matchstr(&commentstring,'\zs.*\ze%s'), '\') .
                \ '\s\*\[Vv]im\?:\s\+se\[t]', 0, 1) >= 0
        call rccommon#ExecNoCursor(string(line('$')) . 'd')
        echom 'Removed existing modeline.'
    endif

    call append(line("$"), l:modeline)
    echom 'Added new modeline: "' . l:modeline . '"'

    " Restore options
    exec 'set report='.urp
endfunction
"}}}

" UI
" Echo(msg, [hilight_group=None], [nonewline=0]) {{{
" Echo prints a newline before msg if necessary, unless nonewline is nonzero.
function! rccommon#Echo(text, ...)
    if a:0 >= 1
        execute 'echohl ' . a:1
    endif

    execute 'echo' . (a:0 >= 2 && a:2 ? 'n' : '') . ' "' . a:text . '"'

    if a:0 >= 1
        echohl 'None'
    endif
endfunction " }}}

" ConfirmYN(msg, [attempts=3], [strict=0], [default='0'], [hi='Question']) {{{
" Displays a confirmation prompt with a given message, and returns the result.
" If strict is nonzero, only Y and N are accepted, and cancelling is disabled.
" Y/N are otherwise not case sensitive. Ctrl+C, Ctrl+D and Escape cancel.
" 'default' is returned if user cancels or exhausts attempts.
function! rccommon#ConfirmYN(msg, ...) abort
    let [l:nr, l:ucmdheight] = [get(a:, '1', 3), &cmdheight]
    let l:ypattern = get(a:, '2', 0) ? '\V\CY' : '\V\cy'
    let l:npattern = get(a:, '2', 0) ? '\V\CN' : '\V\cn'
    let l:cpattern = get(a:, '2', 0) ? '' : '\V\[\r]'
    let l:result = a:0 < 3 ? 0 : (a:3 == 1)
    let l:hi = a:0 < 4 ? 'Question' : a:4
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

    exec 'set cmdheight=' . l:ucmdheight
    return l:result
endfunction " }}}

" BufferColumns() {{{
" Returns the width (in characters) of the editable part of the current buffer,
" i.e. not including the gutter and line numbers.
" Not necessarily accurate, but should be within a few characters.
function! rccommon#BufferColumns()
    if !&number
        return winwidth(0) - &foldcolumn - 2
    endif

    let lln = max([&nuw, strlen(string(line('$'))), 0])
    return winwidth(0) - &foldcolumn - lln - 2
endfunction
" }}}

" Syntax / Filetypes / ftplugins
" HighlightTextWidth() {{{
" Highlight characters that exceed &textwidth.
" Window-local, must only be used in a filetype plugin.
function! rccommon#HighlightTextWidth() abort
    if &textwidth == 0
        echoerr 'HighlightTextWidth: textwidth must be greater than 0!'
        return
    endif

    if exists('w:_highlight_tw_matchid')
        try
            unlet w:_highlight_tw_matchid
            call matchdelete(w:_highlight_tw_matchid)
            call remove(b:_highlight_tw_ids,
                        \ index(b:_highlight_tw_ids, w:_highlight_tw_matchid))
        catch /.*/
        endtry
    endif

    let w:_highlight_tw_matchid =
                \ matchadd('ColorColumn',
                \ '\%>'. string(&textwidth + 1) .'v', 100)

    if !exists('b:_highlight_tw_ids')
        let b:_highlight_tw_ids = []
        augroup HighlightTextWidthWinLeave
            autocmd! * <buffer>
            autocmd BufLeave <buffer>
                    \ if exists("w:_highlight_tw_matchid")
                    \ | call matchdelete(w:_highlight_tw_matchid)
                    \ | call remove(b:_highlight_tw_ids,
                        \ index(b:_highlight_tw_ids, w:_highlight_tw_matchid))
                    \ | unlet w:_highlight_tw_matchid
                    \ | endif
        augroup end
        let b:undo_ftplugin = get(b:, 'undo_ftplugin', '')
                    \ . (empty(get(b:, 'undo_ftplugin', '')) ? '' : '| ')
                    \ . 'exe "autocmd! HighlightTextWidthWinLeave * <buffer>"'
                    \ . ' | if exists("b:_highlight_tw_ids")'
                    \ . ' | for matchid in b:_highlight_tw_ids'
                    \ . ' | silent! call matchdelete(matchid)'
                    \ . ' | endfor'
                    \ . ' | unlet b:_highlight_tw_ids'
                    \ . ' | execute "call rccommon#ExecuteInBufferWindows("'
                    \ . ' . bufnr("") . ",'
                    \ . ' \"silent! unlet w:_highlight_tw_matchid\")"'
                    \ . ' | endif'
    endif

    call add(b:_highlight_tw_ids, w:_highlight_tw_matchid)
endfunction " }}}

" LoadFiletypeDictionary([filetype=&ft]) {{{
" Buffer-local, must only be used in a filetype plugin.
" Adds a dictionary for the current buffer's filetype to 'dictionary' option.
" Filetype dictionaries are located in g:vim_dir . '/dictionaries' folder.
" The optional argument can be used to load a dictionary for a given
" filetype.
" Modifies b:undo_ftplugin to remove the dictionary when the buffer's
" filetype is changed.
function! rccommon#LoadFiletypeDictionary(...) abort
    if exists('b:_user_ftplugin_dict')
        return
    endif

    let l:filetype = get(a:, '1', &filetype)
    let l:path = rccommon#ConfigDir() . '/dictionaries/' . l:filetype . '.txt'

    if !filereadable(l:path)
        return
    endif

    let l:path = escape(l:path, ' ",*|[')
    silent execute 'setlocal dict+=' . l:path
    let b:_user_ftplugin_dict = 1
    let b:undo_ftplugin = get(b:, 'undo_ftplugin', '')
                \ . (empty(get(b:, 'undo_ftplugin', '')) ? '' : '| ')
                \ . 'setlocal dict-=' . l:path
                \ . ' | unlet b:_user_ftplugin_dict'
endfunction " }}}

" ExecuteInBufferWindows(bufnr, commands) {{{
" Executes commands in all windows containing a given buffer number.
function! rccommon#ExecuteInBufferWindows(bufnr, commands) abort
    " Get a list of window IDs containing bufnr
    let l:winids = win_findbuf(a:bufnr)

    if !len(l:winids)
        return
    endif

    " Backup eventignore, current window and window view
    let l:eventignorePrev = &eventignore
    let l:winid = win_getid()
    let l:winview = winsaveview()

    " Disable autocommands temporarily
    set eventignore=all

    " Run commands in each window
    try
        for win in l:winids
            call win_gotoid(win)
            execute a:commands
        endfor

    finally
        " Restore eventignore, window and window view
        execute 'set eventignore=' . l:eventignorePrev
        call win_gotoid(l:winid)
        call winrestview(l:winview)
    endtry
endfunction " }}}

" SetAndSaveWindowOptions(optdict) {{{
" Set window-local options using a dict.Stores defaults in a window-local dict.
" If an option is already in the dict, it will be left as-is.
" Use v:true and v:false for boolean options.
function! rccommon#SetAndSaveWindowOptions(optsdict) abort
    let l:defaults = get(w:, '_user_ftplugin_winopts_prev', {})

    try
        for opt in keys(a:optsdict)
            if !has_key(l:defaults, opt)
                let l:defaults[opt] = rccommon#GetOption(opt, a:optsdict[opt])
            endif

            call rccommon#SetLocalOption(opt, a:optsdict[opt])
        endfor
    finally
        if !exists('b:_set_winopts_remove')
            augroup SetWinOptsWinLeave
                autocmd! * <buffer>
                autocmd BufLeave <buffer> call rccommon#RestoreWindowOptions()
            augroup end
            let b:undo_ftplugin = get(b:, 'undo_ftplugin', '')
                        \ . (empty(get(b:, 'undo_ftplugin', '')) ? '' : '| ')
                        \ . 'execute "call rccommon#ExecuteInBufferWindows("'
                        \ . ' . bufnr("") . ",'
                        \ . ' \"call rccommon#RestoreWindowOptions()\")"'
                        \ . ' | exe "autocmd! SetWinOptsWinLeave * <buffer>"'
                        \ . ' | unlet b:_set_winopts_remove'
            let b:_set_winopts_remove = 1
        endif

        let w:_user_ftplugin_winopts_prev = l:defaults
    endtry
endfunction  "}}}

" RestoreWindowOptions() - CALLED AUTOMATICALLY! {{{
" Restore options changed by SetAndSaveWindowOptions().
function! rccommon#RestoreWindowOptions() abort
    if !exists('w:_user_ftplugin_winopts_prev')
        return
    endif

    for opt in keys(w:_user_ftplugin_winopts_prev)
        call rccommon#SetLocalOption(opt, w:_user_ftplugin_winopts_prev[opt])
    endfor

    unlet w:_user_ftplugin_winopts_prev
endfunction  "}}}

" SetAndSaveBufferOptions(optdict) {{{
" Set buffer-local options using a dict.Stores defaults in a buffer-local dict.
" If an option is already in the dict, it will be left as-is.
" Use v:true and v:false for boolean options.
function! rccommon#SetAndSaveBufferOptions(optsdict) abort
    let l:defaults = get(b:, '_user_ftplugin_bufopts_prev', {})

    try
        for opt in keys(a:optsdict)
            if !has_key(l:defaults, opt)
                let l:defaults[opt] = rccommon#GetOption(opt, a:optsdict[opt])
            endif

            call rccommon#SetLocalOption(opt, a:optsdict[opt])
        endfor
    finally
        if !exists('b:_user_ftplugin_bufopts_prev')
            let b:undo_ftplugin = get(b:, 'undo_ftplugin', '')
                        \ . (empty(get(b:, 'undo_ftplugin', '')) ? '' : '| ')
                        \ . 'call rccommon#RestoreBufferOptions()'
        endif

        let b:_user_ftplugin_bufopts_prev = l:defaults
    endtry
endfunction  "}}}

function! rccommon#SetLocalOption(opt, val)  "{{{
    if a:val == v:true
        execute 'setlocal ' . a:opt
    elseif a:val == v:false
        execute 'setlocal no' . a:opt
    else
        execute 'setlocal ' . a:opt . '=' . a:val
    endif
endfunction  "}}}

function! rccommon#GetOption(opt, setVal)  "{{{
    if a:setVal == v:true || a:setVal == v:false
        execute 'return (&' . a:opt . ' ? v:true : v:false)'
    else
        execute 'return &' . a:opt
    endif
endfunction  "}}}

" RestoreBufferOptions() - CALLED AUTOMATICALLY {{{
" Restore options changed by SetAndSaveBufferOptions().
function! rccommon#RestoreBufferOptions() abort
    if !exists('b:_user_ftplugin_bufopts_prev')
        return
    endif

    for opt in keys(b:_user_ftplugin_bufopts_prev)
        call rccommon#SetLocalOption(opt, w:_user_ftplugin_winopts_prev[opt])
    endfor

    unlet b:_user_ftplugin_bufopts_prev
endfunction  "}}}

" Pars
function! rccommon#ParseModeline() abort "{{{
    let l:modelines = &modelines
    let l:lastln = line('$')

    " Get lines in buffer potentially containing a modeline
    if l:lastln <= l:modelines * 2
        let l:lines = getline(1, l:modelines * 2)
    else
        let l:lines = getline(1, l:modelines)
                    \ + getline(l:lastln - l:modelines - 1, l:lastln)
    endif

    " Find a modeline
    let l:mlexpr = '\C\m^.\{-}\s\+\%(vim\?\|ex\):\s*'
                \ . '\%(set\? \%(\%([a-z]\+\%(=\%(\\:\|[^ :]\)\+\)\?\) \?\)*'
                \ . '\s\?:\|\(\([a-z]\+\(=\(\\:\|[^ :]\)\+\)\?\|\)[: ]\)*'
                \ . '\([a-z]\+\(=\(\\:\|[^ :]\)\+\)\?\)\)'
    let l:match = match(l:lines, l:mlexpr)

    if l:match == -1
        return {}
    endif

    " Parse
    let l:ml = substitute(l:lines[l:match], '\C\m^.* \(vim\?\|ex\):\s*', '',
                \ '')

    if l:ml[0:2] == 'se ' || l:ml[0:3] == 'set '
        let l:ml = (l:ml[0:2] == 'se ' ? l:ml[3:] : l:ml[4:])
        let l:ml = substitute(l:ml, '\m:[^:]*$', '', '')
        let l:opts = split(l:ml, '\m\%(\s\|\\\@<!:\)', 0)
    else
        let l:opts = split(l:ml, '\m\%(\s\|\\\@<!:\)', 0)
    endif

    let l:result = {}

    for opt in l:opts
        if opt == '' | continue | endif

        let l:eq = match(opt, '\m=')

        if l:eq != -1
            " a=b
            let l:name = opt[0:l:eq - 1]
            let l:val = opt[l:eq + 1:]

        else
            " [no]{option}
            let l:val = (opt[0:1] == 'no' ? (v:false) : (v:true))
            let l:name = (opt[0:1] == 'no' ? opt[2:] : opt)
        endif

        " Strip whitespace
        let l:name = substitute(l:name, '\m^\s*\(.\{-}\)\s*$', '\1', '')

        if l:val != v:true && l:val != v:false
            let l:val = substitute(l:val, '\m^\s*\(.\{-}\)\s*$', '\1', '')
        endif

        let l:result[l:name] = l:val
    endfor

    return l:result
endfunction " }}}

" Plugins
" UpdateTagbarOptions() {{{
" Updates tagbar window width.
function! rccommon#UpdateTagbarOptions() abort
    if exists('*UpdateTagbarOptions')
        let l:id = win_getid()
        call UpdateTagbarOptions(1)
        call win_gotoid(l:id)
    endif
endfunction " }}}

" Config Getters/Setters
" ConfigDir() {{{
function! rccommon#ConfigDir()
    return g:vim_dir
endfunction " }}}

" TempDir() {{{
function! rccommon#TempDir()
    return g:vim_dir_tmp
endfunction" }}}

" FoldMarkers() {{{
function! rccommon#FoldMarkers()
    let l:markers = split(&foldmarker, ',')
    return [escape(l:markers[0], '\'), escape(l:markers[1], '\')]
endf " }}}

" CommentStrings() {{{
function! rccommon#CommentStrings()
    let l:res = [escape(matchstr(&commentstring, '.*\ze%s'), '\'),
                \ escape(matchstr(&commentstring, '%s\zs.*'), '\') ]
    return [l:res[0], (l:res[1] == '' ? '\$' : l:res[1])]
endf " }}}

" vim: set ts=4 sw=4 tw=79 fdm=marker fenc=utf-8 et :
