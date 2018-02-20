""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" init.vim
" ========
"
" Author:                Michael De Pasquale
" Creation Date:         2017-12-06
"
" Description
" -----------
" Loads vimrcs and creates an autocommand to relead them automatically.
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Configuration{{{
let g:vimDir = resolve(expand('~/.config/nvim'))
let g:vimrcDir = g:vimDir . '/vimrcs'
execute 'set runtimepath+=' . g:vimDir
let g:vimrcFiles = [
            \ 'options.vim',
            \ 'shortcuts.vim',
            \ 'plugins.vim',
            \ ]
"}}}

" Load vimrcs{{{
function! LoadVimrcs()
    let l:errs = []

    for cs in g:vimrcFiles
        try | exec 'so '.g:vimrcDir . '/' . expand(cs)
        catch | call add(l:errs,'Error "'.v:exception.'" during reload of '.cs)
        endtry
    endfor

    " Display error message if any errors occured
    let numErrs = len(l:errs)

    if numErrs > 0
        echo numErrs.' error(s) occured while executing .vimrc:'
        for sn in l:errs | echomsg '➜ '.sn | endfor
        echomsg ' '
    endif
endfunction

call LoadVimrcs()
"}}}

" Autocommands{{{
augroup ReloadVimScript
    autocmd!
    autocmd BufWritePost */*.vim
                \ call ReloadVimScript(resolve(expand("<amatch>")))
augroup end
"}}}

" Functions{{{
" GetLoadedScripts : Returns a list of all currently loaded scripts.{{{
" Adapted from script 'getting the scriptnames in a Dictionary'
" see :h scriptnames-dictionary
function! GetLoadedScripts()
    let scriptnames_output = '' | let scripts = []
    redir => scriptnames_output | silent scriptnames | redir END

    for line in split(scriptnames_output, "\n")
        let nr = matchstr(line, '\d\+')
        let name = substitute(line, '.\+:\s*', '', '')
        let scripts += [resolve(expand(name))]
    endfor

    return scripts
endfunction
"}}}
" IsLoadedVimScript : Returns true if str is a loaded vim script{{{
function! IsLoadedVimScript(str)
    let l:str = resolve(expand(a:str))
    let l:scriptList = GetLoadedScripts()
    if index(l:scriptList, l:str) != -1 | return 1 | endif
    return 0
endfunc
"}}}
" ReloadVimScript : Reloads the given script if necessary.{{{
if !exists('*ReloadVimScript')
    function! ReloadVimScript(path) abort

        if IsLoadedVimScript(a:path)
            try | execute 'source ' . a:path
            catch
                echom 'Failed to reload ' . a:path . ': ' v:exception
                return
            endtry

            redraw | echom 'Reloaded ' . a:path | return
        endif
    endfunction
endif
"}}}
"}}}
" vim: set ts=4 sw=4 tw=80 fdm=marker et :
