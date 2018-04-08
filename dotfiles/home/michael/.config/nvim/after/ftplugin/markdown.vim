""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" markdown.vim
" ============
"
" Author:                Michael De Pasquale
" Creation Date:         2018-02-19
"
" Description
" -----------
" Configuration for markdown syntax buffers
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Buffer-local settings{{{
setlocal complete+=kspell
setlocal dictionary+=/usr/share/dict/words
setlocal spell
setlocal concealcursor=c
call rccommon#LoadFiletypeDictionary()
"}}}
" Highlight lines exceeding textwidth{{{
call rccommon#HighlightTextWidth()
" }}}
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
    autocmd BufWrite *.md call rccommon#DeleteTrailingWS()
augroup end
" }}}
" vim: set ts=4 sw=4 tw=79 fdm=marker et :
