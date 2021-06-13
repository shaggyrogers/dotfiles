""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" smali.vim
" =========
"
" Description:           Configuration for smali syntax buffers.
" Author:                Michael De Pasquale
" Creation Date:         2021-06-13
" Modification Date:     2021-06-13
"
" Note:                  Relies on vim-smali for filetype detection.
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


function! s:UserFtSetUp()
    let l:ml = rccommon#ParseModeline()

    if ! (has_key(l:ml, 'tw') || has_key(l:ml, 'textwidth'))
        setlocal textwidth=127
    endif

    if ! (has_key(l:ml, 'fdm') || has_key(l:ml, 'foldmethod'))
        call rccommon#SetAndSaveWindowOptions({'foldmethod': 'indent'})
    endif

    call rccommon#HighlightTextWidth()
    call rccommon#LoadFiletypeDictionary()
endfunction

augroup SmaliFiletypeConfig
    autocmd! * <buffer>
    autocmd BufWinEnter <buffer> call s:UserFtSetUp()
    autocmd BufWrite <buffer>
                \ call rccommon#DeleteTrailingWS()
                \ | retab
augroup end

let b:undo_ftplugin = get(b:, 'undo_ftplugin', '')
            \ . (empty(get(b:, 'undo_ftplugin', '')) ? '' : '| ')
            \ . 'exe "autocmd! SmaliFiletypeConfig * <buffer>"'

call s:UserFtSetUp()

" vim: set ts=4 sw=4 tw=79 fdm=marker et :
