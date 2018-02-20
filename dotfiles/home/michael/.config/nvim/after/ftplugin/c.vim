""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" java.vim
" ========
"
" Author:                Michael De Pasquale
" Creation Date:         2018-02-19
"
" Description
" -----------
" Configuration for java syntax buffers
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

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
augroup CFiletypeConfig
    autocmd!
    autocmd BufWrite *.c,*.h call ftcommon#DeleteTrailingWS()
    autocmd VimResized *.c,*.h call ftcommon#UpdateTagbarOptions()
augroup end
"}}}
" vim: set ts=4 sw=4 tw=79 fdm=marker et :
