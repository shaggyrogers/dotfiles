""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" conf.vim
" ========
"
" Description:           Buffer configuration for .conf files
" Author:                Michael De Pasquale
" Creation Date:         2019-01-01
" Modification Date:     2019-01-04
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function! s:UserFtSetUp()
    call rccommon#SetAndSaveBufferOptions({
                \ 'textwidth': '0',
                \ 'wrapmargin': '0',
                \ })
    call rccommon#LoadFiletypeDictionary('markdown')
    call rccommon#UpdateTagbarOptions()
endfunction

augroup ConfFiletypeConfig
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
            \ . 'exe "autocmd! ConfFiletypeConfig * <buffer>"'

call s:UserFtSetUp()

" vim: set ts=4 sw=4 tw=79 fdm=marker et :
