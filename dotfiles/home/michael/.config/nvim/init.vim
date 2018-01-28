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
" Main initialisation script for neovim
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


set runtimepath+=~/.config/nvim/
set termguicolors
let g:__vimrcs_dir__ = '~/.config/nvim/vimrcs/'
let g:__vimrc_errors__ = []

" Add config scripts to this list.
let g:__vimrcs__ = [
            \ 'general.vim',
            \ 'shortcuts.vim',
            \ 'filetypes.vim',
            \ 'plugins.vim',
            \ ]

" Attempt to load each config script
for cs in g:__vimrcs__
    try
        exec 'so '.g:__vimrcs_dir__.expand(cs)
    catch
        call add(g:__vimrc_errors__, 'Error "'.v:exception.'" occured while running '.cs)
    endtry
endfor

" Display error message if any errors occured
let numErrs = len(g:__vimrc_errors__)

if numErrs > 0
    echo numErrs.' error(s) occured while executing .vimrc:'

    for sn in g:__vimrc_errors__
        echomsg '➜ '.sn
    endfor

    echomsg ' '
endif

" Automatically reload .vimrc, .gvimrc and config scripts
augroup vimrc_autoreload
    autocmd!
    autocmd vimrc_autoreload BufWritePost * call ReloadIfVimrc()
augroup end


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Helper Functions                                            "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Expands wildcards/etc, resolves, symlinks and removes whitespace.
function! ProcessPath(str)
    return substitute(resolve(expand(a:str)), '^\s*\(.\{-}\)\s*$', '\1', '')
endfunction

" Returns true if the current file path is a vimrc file
" path must be expanded and ProcessPathd
function! IsVimrc()
    let l:path = ProcessPath("%:p")

    " .vimrc and .gvimrc
    if l:path == ProcessPath($MYVIMRC) || l:path == ProcessPath($MYGVIMRC)
        return 1
    endif

    " all other vimrc files
    for v in g:__vimrcs__

        if l:path =~ expand(v).'$'

            return 1
        endif
    endfor

    return 0
endfunc

" Avoid redefining ReloadIfVimrc() while we are calling it.
if !exists('*ReloadIfVimrc')

    " Reloads the current file if it is a vimrc
    function! ReloadIfVimrc()

        if !IsVimrc()
            return
        endif

        so %
        echom 'Reloaded '.ProcessPath("%:p")
        redraw
    endfunc
endif
