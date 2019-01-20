""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" json.vim
" ========
"
" Description:           Configuration for JSON filetype.
" Author:                Michael De Pasquale
" Creation Date:         2018-11-24
" Modification Date:     2019-01-04
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function! s:UserFtSetUp()
    call rccommon#SetAndSaveWindowOptions({'foldmethod': 'indent'})
    call rccommon#LoadFiletypeDictionary('markdown')
endfunction

augroup JSONFiletypeConfig
    autocmd! * <buffer>
    autocmd BufWinEnter <buffer> call s:UserFtSetUp()
augroup end

let b:undo_ftplugin = get(b:, 'undo_ftplugin', '')
            \ . (empty(get(b:, 'undo_ftplugin', '')) ? '' : '| ')
            \ . 'exe "autocmd! JSONFiletypeConfig * <buffer>"'

call s:UserFtSetUp()

" vim: set ts=4 sw=4 tw=79 fdm=marker et :
