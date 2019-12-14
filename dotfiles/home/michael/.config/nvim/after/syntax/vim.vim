""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim.vim
" =======
"
" Description:           vim syntax tweaks
" Author:                Michael De Pasquale
" Creation Date:         2018-02-20
" Modification Date:     2019-12-14
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Clear syntax groups if they exist
try
    syntax clear vimNiceComment
catch
endtry

" Create syntax groups
syntax match vimNiceComment
        \ '\m\(^\s*"\s*\([*\-+][^*\-+]\)\?\s*\)\@8<=\[ \?\]'
        \ contained conceal cchar=☐
syntax match vimNiceComment
        \ '\m\(^\s*"\s*\([*\-+][^*\-+]\)\?\s*\)\@8<=\[[*x+]\]'
        \ contained conceal cchar=☑
syntax match vimNiceComment
        \ '\m\(^\s*"\s*\)\@8<=[*+]\([^*\-+]\|$\)\@70='
        \ contained conceal cchar=⦁
syntax match vimNiceComment
        \ '\m\(^\s*"\s*\)\@8<=[\-]\([^*\-+]\|$\)\@70='
        \ contained conceal cchar=⚊

syn cluster vimCommentGroup contains=vimNiceComment,vimTodo,@vimCommentGroup

" vim: set ts=4 sw=4 tw=79 fdm=marker ff=unix fenc=utf-8 et :
