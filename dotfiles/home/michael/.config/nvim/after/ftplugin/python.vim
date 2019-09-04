""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" python.vim
" ==========
"
" Description:           Configuration for python syntax buffers
" Author:                Michael De Pasquale
" Creation Date:         2018-02-18
" Modification Date:     2019-07-21
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

    " Foldmethod "defaults" to marker, will be changed to expr by simpylfold
    " unless explicitly disabled using a modeline.
    let l:ml = rccommon#ParseModeline()

    if has_key(l:ml, 'fdm') || has_key(l:ml, 'foldmethod')
        let l:fdm = (has_key(l:ml, 'fdm') ? l:ml['fdm'] : l:ml['foldmethod'])

        if l:fdm != 'expr'
            let b:loaded_SimpylFold = 1
            let b:undo_ftplugin = get(b:, 'undo_ftplugin', '')
                    \ . (empty(get(b:, 'undo_ftplugin', '')) ? '' : ' | ')
                    \ . 'unlet! b:loaded_SimpylFold'
        endif

    else
        call rccommon#SetAndSaveWindowOptions({'foldmethod': 'marker'})
    endif

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
