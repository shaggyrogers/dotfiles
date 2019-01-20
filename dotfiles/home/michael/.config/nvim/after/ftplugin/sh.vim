""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" sh.vim
" ======
"
" Description:           Configuration for buffers containing shell scripts
" Author:                Michael De Pasquale
" Creation Date:         2018-02-19
" Modification Date:     2019-01-04
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function! s:UserFtSetUp()
    call rccommon#HighlightTextWidth()
endfunction

augroup SHFiletypeConfig
    autocmd! * <buffer>
    autocmd BufWinEnter <buffer> call s:UserFtSetUp()
    autocmd BufWrite *.sh
                \ call rccommon#DeleteTrailingWS()
                \ | call rccommon#UpdateModificationDate()
                \ | retab
augroup end

let b:undo_ftplugin = get(b:, 'undo_ftplugin', '')
            \ . (empty(get(b:, 'undo_ftplugin', '')) ? '' : '| ')
            \ . 'exe "autocmd! SHFiletypeConfig * <buffer>"'

call s:UserFtSetUp()

" vim: set ts=4 sw=4 tw=79 fdm=marker et :
