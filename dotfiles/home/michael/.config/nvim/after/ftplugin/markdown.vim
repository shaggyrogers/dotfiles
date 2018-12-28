""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" markdown.vim
" ============
"
" Description:           Commands for markdown syntax buffers.
" Author:                Michael De Pasquale <shaggyrogers>
" Creation Date:         2018-02-19
" Modification Date:     2018-11-18
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
augroup MarkdownFiletypeConfig
    autocmd!
    autocmd BufEnter *.md
                \ hi! link Conceal Identifier |
                \ if exists(':TableModeEnable') |
                    \ silent exec 'TableModeEnable'
                \ | endif
    autocmd BufLeave *.md
                \ if exists(':TableModeDisable') |
                    \ silent exec 'TableModeDisable'
                \ | endif
    autocmd BufWrite *.md
                \ call rccommon#DeleteTrailingWS() |
                \ call rccommon#UpdateModificationDate() |
                \ retab
augroup end
" }}}

" vim: set ts=4 sw=4 tw=79 fdm=marker et :
