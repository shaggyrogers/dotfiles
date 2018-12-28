""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" text.vim
" ========
"
" Description:           Commands for text buffers.
" Author:                Michael De Pasquale <shaggyrogers>
" Creation Date:         2018-05-11
" Modification Date:     2018-05-11
" License:               MIT
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Buffer-local settings{{{
setlocal complete+=kspell
setlocal concealcursor=c
setlocal dictionary+=/usr/share/dict/words
setlocal linebreak
setlocal spell
setlocal textwidth=0
setlocal wrapmargin=0

call rccommon#LoadFiletypeDictionary()
"}}}

" Delete trailing whitespace and replace tab characters{{{
call rccommon#DeleteTrailingWS()
retab
"}}}

" Autocommands{{{
augroup TextFiletypeConfig
    autocmd!
    autocmd BufWrite *
                \ if &ft == 'text' |
                \ call rccommon#DeleteTrailingWS() |
                \ call rccommon#UpdateModificationDate() |
                \ retab
                \ fi
augroup end
" }}}

" vim: set ts=4 sw=4 tw=79 fdm=marker et :
