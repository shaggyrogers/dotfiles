""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" python.vim
" ==========
"
" Description:           Configuration for python syntax buffers
" Author:                Michael De Pasquale
" Creation Date:         2018-02-18
" Modification Date:     2019-01-04
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function! s:UserFtSetUp()
    hi link pyNiceBuiltin pythonBuiltin
    hi link pyNiceComment Comment
    hi link pyNiceKeyword Keyword
    hi link pyNiceOperator Operator
    hi link pyNiceStatement Statement
    hi link Conceal Operator

    call rccommon#SetAndSaveBufferOptions({
                \ 'define': '^\s*\\(def\\\\|class\\)'
                \ })
    call rccommon#SetAndSaveWindowOptions({'foldmethod': 'marker'})
    call rccommon#HighlightTextWidth()
    call rccommon#UpdateTagbarOptions()
    call rccommon#LoadFiletypeDictionary()
endfunction

augroup PythonFiletypeConfig
    autocmd! * <buffer>
    autocmd BufWinEnter <buffer> call s:UserFtSetUp()
    autocmd BufEnter <buffer> hi link Conceal Operator
    autocmd BufWrite <buffer>
                \ call rccommon#DeleteTrailingWS()
                \ | call rccommon#UpdateModificationDate()
                \ | retab
    autocmd VimResized <buffer>
                \ call rccommon#UpdateTagbarOptions()
augroup end

let b:undo_ftplugin = get(b:, 'undo_ftplugin', '')
            \ . (empty(get(b:, 'undo_ftplugin', '')) ? '' : '| ')
            \ . 'exe "autocmd! PythonFiletypeConfig * <buffer>"'

call s:UserFtSetUp()

" vim: set ts=4 sw=4 tw=79 fdm=marker et :
