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

" Highlight groups for syntax tweaks{{{
hi! link Conceal Identifier
hi! link mkdBold Question
"}}}
" Buffer-local settings{{{
setlocal complete+=kspell
setlocal dictionary+=/usr/share/dict/words
setlocal spell
"}}}
" Highlight lines exceeding textwidth{{{
call ftcommon#HighlightTextWidth()
" }}}
" Delete trailing whitespace and replace tab characters{{{
call ftcommon#DeleteTrailingWS()
retab
"}}}
" Autocommands{{{
augroup MarkdownFiletypeConfig
    autocmd!
    autocmd BufEnter *.md
                \ hi! link Conceal Identifier |
                \ if exists(':TableModeEnable') | TableModeEnable | endif
    autocmd BufLeave *.md
                \ if exists(':TableModeDisable') | TableModeDisable | endif
    autocmd BufWrite *.md call filetype#DeleteTrailingWS()
augroup end
" }}}
" vim: set ts=4 sw=4 tw=79 fdm=marker et :
