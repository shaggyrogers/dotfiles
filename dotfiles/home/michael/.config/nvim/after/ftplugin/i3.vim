""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" i3.vim
" ======
"
" Author:                Michael De Pasquale
" Creation Date:         2018-02-19
"
" Description
" -----------
" Configuration for i3 config files
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Highlight lines exceeding textwidth{{{
call ftcommon#HighlightTextWidth()
" }}}
" Delete trailing whitespace and replace tab characters{{{
call ftcommon#DeleteTrailingWS()
retab
"}}}
" Autocommands{{{
augroup i3FiletypeConfig
    autocmd!
    autocmd BufWrite *
                \ if &ft == 'i3' | call ftcommon#DeleteTrailingWS() | endif
    autocmd BufWritePost * if &ft == 'i3' | silent execute '!i3-msg restart'
                \ | silent execute "!sleep 0.5; i3-msg [title='nvim '] focus"
                \ | endif
augroup end
"}}}
" vim: set ts=4 sw=4 tw=79 fdm=marker et :
