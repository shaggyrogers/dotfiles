""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim.vim
" =======
"
" Author:                Michael De Pasquale
" Creation Date:         2018-02-18
"
" Description
" -----------
" Configuration for vim syntax buffers
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" highlight groups for syntax tweaks{{{
hi link vimNiceComment Comment
hi! link Conceal Operator
"}}}

" Buffer-local options{{{
setlocal foldmethod=marker
setlocal foldcolumn=2
"}}}

" Highlight lines exceeding textwidth{{{
call rccommon#HighlightTextWidth()
" }}}

" Update Tagbar{{{
call rccommon#UpdateTagbarOptions()
"}}}

" Load dictionary for filetype, if one exists{{{
call rccommon#LoadFiletypeDictionary()
"}}}

" Delete trailing whitespace and replace tab characters{{{
call rccommon#DeleteTrailingWS()
retab
"}}}

" Autocommands{{{
augroup VimscriptFiletypeConfig
    autocmd!
    autocmd BufEnter *.vim
                \ hi! link Conceal Operator
    autocmd BufWrite *.vim
                \ call rccommon#DeleteTrailingWS() |
                \ call rccommon#UpdateModificationDate() |
                \ retab
    autocmd VimResized *.vim call rccommon#UpdateTagbarOptions()
augroup end
"}}}

" vim: set ts=4 sw=4 tw=79 fdm=marker et :
