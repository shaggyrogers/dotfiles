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
call ftcommon#HighlightTextWidth()
" }}}
" Update Tagbar{{{
call ftcommon#UpdateTagbarOptions()
"}}}
" Load dictionary for filetype, if one exists{{{
call ftcommon#LoadFiletypeDictionary()
"}}}
" Delete trailing whitespace and replace tab characters{{{
call ftcommon#DeleteTrailingWS()
retab
"}}}
" Abbreviations{{{
iabbrev au autocmd
iabbrev aug augroup
iabbrev func function
"}}}
" Autocommands{{{
augroup VimscriptFiletypeConfig
    autocmd!
    autocmd BufEnter *.vim
                \ hi! link Conceal Operator
    autocmd BufWrite *.vim call ftcommon#DeleteTrailingWS()
    autocmd VimResized *.vim call ftcommon#UpdateTagbarOptions()
augroup end
"}}}
" vim: set ts=4 sw=4 tw=79 fdm=marker et :
