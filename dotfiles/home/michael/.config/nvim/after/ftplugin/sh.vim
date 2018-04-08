""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" sh.vim
" ======
"
" Author:                Michael De Pasquale
" Creation Date:         2018-02-19
"
" Description
" -----------
" Configuration for buffers containing shell scripts
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Highlight lines exceeding textwidth{{{
call rccommon#HighlightTextWidth()
" }}}
" Delete trailing whitespace and replace tab characters{{{
call rccommon#DeleteTrailingWS()
retab
"}}}
" Autocommands{{{
augroup BashFiletypeConfig
    autocmd!
    autocmd BufWrite *.sh call rccommon#DeleteTrailingWS()
augroup end
"}}}
" vim: set ts=4 sw=4 tw=79 fdm=marker et :
