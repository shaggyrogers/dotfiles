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
"}}}
" Highlight lines exceeding textwidth{{{
call ftcommon#HighlightTextWidth()
" }}}
" Update Tagbar{{{
call ftcommon#UpdateTagbarOptions()
"}}}
" Load a dictionary for this filetype, if one exists{{{
call ftcommon#LoadFiletypeDictionary()
"}}}
" Delete trailing whitespace and replace tab characters{{{
call ftcommon#DeleteTrailingWS()
retab
"}}}
" Autocommands{{{
augroup PythonFiletypeConfig
    autocmd!
    autocmd BufEnter *.py,*.pyx,*.pyd,*.pyw,*.pxi,*.pyi
                \ hi link Conceal Operator
    autocmd BufWrite *.py,*.pyx,*.pyd,*.pyw,*.pxi,*.pyi
                \ call ftcommon#DeleteTrailingWS() | retab
    autocmd VimResized *.py,*.pyx,*.pyd,*.pyw,*.pxi,*.pyi
                \ call ftcommon#UpdateTagbarOptions()
augroup end
"}}}
" vim: set ts=4 sw=4 tw=79 fdm=marker et :
