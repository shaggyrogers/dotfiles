""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" c.vim
" =====
"
" Description:           Configuration for C and C++ syntax buffers
" Author:                Michael De Pasquale
" Creation Date:         2018-02-19
" Modification Date:     2022-03-30
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function! s:UserFtSetUp()
    call rccommon#HighlightTextWidth()
    call rccommon#LoadFiletypeDictionary()
    call rccommon#UpdateTagbarOptions()
endfunction

augroup CFiletypeConfig
    autocmd! * <buffer>
    autocmd BufWinEnter <buffer> call s:UserFtSetUp()
    autocmd BufWrite <buffer>
                \ call rccommon#DeleteTrailingWS()
                \ | call rccommon#UpdateModificationDate()
                \ | retab
    autocmd VimResized <buffer> call rccommon#UpdateTagbarOptions()
augroup end

let b:undo_ftplugin = get(b:, 'undo_ftplugin', '')
            \ . (empty(get(b:, 'undo_ftplugin', '')) ? '' : '| ')
            \ . 'exe "autocmd! CFiletypeConfig * <buffer>"'

call s:UserFtSetUp()

" vim: set ts=4 sw=4 tw=79 fdm=marker ff=unix fenc=utf-8 et :
