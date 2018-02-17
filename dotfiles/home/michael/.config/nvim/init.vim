""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" init.vim
" ========
"
" Version:               1.0.0
" Author:                Michael De Pasquale
" Creation Date:         2017-12-06
" License:               None
"
" Description
" -----------
" Loads vimrcs and creates autocmd to relead them on write.
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set runtimepath+=~/.config/nvim/
set termguicolors
let g:__vimrcs_dir__ = '~/.config/nvim/vimrcs/'
let g:__vimrc_errors__ = []
let g:__vimrcs__ = [
            \ 'general.vim',
            \ 'shortcuts.vim',
            \ 'filetypes.vim',
            \ 'plugins.vim',
            \ ]

" Load vimrcs
function! LoadVimrcs()
    for cs in g:__vimrcs__
        try | exec 'so '.g:__vimrcs_dir__.expand(cs)
        catch | call add(g:__vimrc_errors__,
                    \ 'Error "'.v:exception.'" occured while running '.cs)
        endtry
    endfor

    " Display error message if any errors occured
    let numErrs = len(g:__vimrc_errors__)

    if numErrs > 0
        echo numErrs.' error(s) occured while executing .vimrc:'
        for sn in g:__vimrc_errors__ | echomsg '➜ '.sn | endfor
        echomsg ' '
    endif
endfunction

call LoadVimrcs()

" Automatically reload .vimrc, .gvimrc and config scripts
augroup ReloadVimScript
    autocmd!
    autocmd BufWritePost */*.vim call ReloadVimScripts(expand("<amatch>"))
augroup end


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Helper Functions                                            "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Expands wildcards, resolves symlinks and removes whitespace
function! ProcessPath(str)
    let l:res = resolve(expand(a:str))
    return substitute(l:res, '^\s*\(.*\)\s*$', '\1', '')
endfunction

" Returns a list of all loaded scripts. Applies ProcessPath to each.
" Adapted from script 'getting the scriptnames in a Dictionary'
" see :h scriptnames-dictionary
function! GetLoadedScripts()
    let scriptnames_output = ''
    let scripts = []

    " Get list of scripts
    redir => scriptnames_output
        silent scriptnames
    redir END

    " Parse each line
    for line in split(scriptnames_output, "\n")
        let nr = matchstr(line, '\d\+')
        let name = substitute(line, '.\+:\s*', '', '')
        let scripts += [ProcessPath(name)]
    endfor

    return scripts
endfunction

" Returns true if the current file path is a loaded vim script
function! IsLoadedVimScript(str)
    let l:str = ProcessPath(a:str)
    let l:scriptList = GetLoadedScripts()
    if index(l:scriptList, l:str) != -1 | return 1 | endif
    return 0
endfunc

" Reload vim scripts
if !exists('*ReloadVimScripts')
    function! ReloadVimScripts(path) abort
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
