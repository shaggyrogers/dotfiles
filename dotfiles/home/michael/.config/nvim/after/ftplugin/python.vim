""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" python.vim
" ==========
"
" Author:                Michael De Pasquale
" Creation Date:         2018-02-18
"
" Description
" -----------
" Configuration for python syntax buffers
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Highlight groups for syntax tweaks{{{
hi link pyNiceBuiltin pythonBuiltin
hi link pyNiceComment Comment
hi link pyNiceKeyword Keyword
hi link pyNiceOperator Operator
hi link pyNiceStatement Statement
hi link Conceal Operator
"}}}

" Buffer-local options{{{
setlocal define=^\s*\\(def\\\\|class\\)
setlocal foldmethod=marker
"}}}

" Highlight lines exceeding textwidth{{{
call rccommon#HighlightTextWidth()
" }}}

" Update Tagbar{{{
call rccommon#UpdateTagbarOptions()
"}}}

" Load a dictionary for this filetype, if one exists{{{
call rccommon#LoadFiletypeDictionary()
"}}}

" Delete trailing whitespace and replace tab characters{{{
call rccommon#DeleteTrailingWS()
retab
"}}}

" Autocommands{{{
augroup PythonFiletypeConfig
    autocmd!
    autocmd BufEnter *.py,*.pyx,*.pyd,*.pyw,*.pxi,*.pyi
                \ hi link Conceal Operator
    autocmd BufWrite *.py,*.pyx,*.pyd,*.pyw,*.pxi,*.pyi
                \ call rccommon#DeleteTrailingWS() |
                \ call rccommon#UpdateModificationDate() |
                \ retab
    autocmd VimResized *.py,*.pyx,*.pyd,*.pyw,*.pxi,*.pyi
                \ call rccommon#UpdateTagbarOptions()
augroup end
"}}}

" vim: set ts=4 sw=4 tw=79 fdm=marker et :
