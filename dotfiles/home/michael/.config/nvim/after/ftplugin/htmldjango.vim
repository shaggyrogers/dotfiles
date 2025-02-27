""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" htmldjango.vim
" ==============
"
" Description:           Configuration for htmldjango syntax buffers
" Author:                Michael De Pasquale
" Creation Date:         2025-02-28
" Modification Date:     2025-02-28
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function! s:UserFtSetUp()
    call rccommon#SetAndSaveBufferOptions({
                \ 'textwidth': '98',
                \ })
    call rccommon#HighlightTextWidth()
endfunction

augroup HTMLDjangoFiletypeConfig
    autocmd! * <buffer>
    autocmd BufWinEnter <buffer> call s:UserFtSetUp()
    autocmd BufWrite <buffer>
                \ call rccommon#DeleteTrailingWS()
                \ | call rccommon#UpdateModificationDate()
                \ | retab
augroup end

let b:undo_ftplugin = get(b:, 'undo_ftplugin', '')
            \ . (empty(get(b:, 'undo_ftplugin', '')) ? '' : '| ')
            \ . 'exe "autocmd! HTMLDjangoFiletypeConfig * <buffer>"'

call s:UserFtSetUp()

" vim: set ts=4 sw=4 tw=79 fdm=marker et :
