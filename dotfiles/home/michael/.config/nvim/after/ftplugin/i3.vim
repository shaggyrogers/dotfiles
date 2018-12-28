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
call rccommon#HighlightTextWidth()
" }}}

" Delete trailing whitespace and replace tab characters{{{
call rccommon#DeleteTrailingWS()
retab
"}}}

" Autocommands{{{
augroup i3FiletypeConfig
    autocmd!
    autocmd BufWrite *
                \ if &ft == 'i3' |
                \ call rccommon#DeleteTrailingWS() |
                \ call rccommon#UpdateModificationDate() |
                \ retab |
                \ endif
    autocmd BufWritePost *
                \ if &ft == 'i3' |
                    \ if rccommon#ConfirmYN('Restart i3?', 2, 0, 0, 'Warning')
                        \ | silent execute '!i3-msg restart'
                        \ | silent execute "!sleep 0.5; i3-msg [title='nvim '] focus"
                    \ | endif
                \ | endif
augroup end
"}}}

" vim: set ts=4 sw=4 tw=79 fdm=marker et :
