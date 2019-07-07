""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" go.vim
" ======
"
" Description:           Configuration for go syntax buffers
" Author:                Michael De Pasquale
" Creation Date:         2018-02-19
" Modification Date:     2019-04-13
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function! s:UserFtSetUp()
    call rccommon#HighlightTextWidth()
    call rccommon#UpdateTagbarOptions()
    call rccommon#LoadFiletypeDictionary()
endfunction

augroup GoFiletypeConfig
    autocmd! * <buffer>
    autocmd BufWinEnter <buffer> call s:UserFtSetUp()
    autocmd BufWrite <buffer>
                \ call rccommon#DeleteTrailingWS()
                \ | call rccommon#UpdateModificationDate()
                \ | retab
    autocmd VimResized <buffer>
                \ call rccommon#UpdateTagbarOptions()
augroup end

let b:undo_ftplugin = get(b:, 'undo_ftplugin', '')
            \ . (empty(get(b:, 'undo_ftplugin', '')) ? '' : '| ')
            \ . 'exe "autocmd! GoFiletypeConfig * <buffer>"'

call s:UserFtSetUp()

" vim: set ts=4 sw=4 tw=79 fdm=marker et :
