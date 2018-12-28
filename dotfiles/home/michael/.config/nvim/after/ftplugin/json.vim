""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" json.vim
" ========
"
" Description:           Configuration for JSON filetype.
" Author:                Michael De Pasquale
" Creation Date:         2018-11-24
" Modification Date:     2018-11-25
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Buffer-local options {{{
set foldmethod=indent
"}}}

" Load text dictionary{{{
call rccommon#LoadFiletypeDictionary('markdown')
"}}}

" vim: set ts=4 sw=4 tw=79 fdm=marker et :
