""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" python.vim
" ==========
"
" Author:                Michael De Pasquale
" Creation Date:         2018-02-20
"
" Description
" -----------
" python syntax tweaks
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" TODO:
" Remove lookbehind from comments and use containedin instead

" finish later
finish

" Clear syntax groups if they exist{{{
try
    syntax clear pyNiceBuiltin
    syntax clear pyNiceComment
    syntax clear pyNiceKeyword
    syntax clear pyNiceOperator
    syntax clear pyNiceStatement
    syntax clear pythonComment
    syntax clear pythonOperator
catch
endtry
"}}}

" Create syntax groups{{{
syn match pythonOperator '\V\[=*-/+@%&|^~<>]\|!='
syn keyword pythonOperator is or and

syntax keyword pyNiceBuiltin all conceal cchar=∀
syntax keyword pyNiceBuiltin any conceal cchar=∃
syntax keyword pyNiceOperator sum conceal cchar=∑
syntax keyword pyNiceStatement lambda conceal cchar=λ
syntax match pyNiceKeyword "\m\<\%(math\.\)\?pi\>" conceal cchar=
syntax match pyNiceKeyword "\m\<\%(math\.\)\?sqrt\>" conceal cchar=√
syntax match pyNiceOperator "\m\%(if \)\@3<!\<not\%( \|\>\)" conceal cchar=¬
syntax match pyNiceOperator "\m\%(is \)\@3<!\<not\%( \|\>\)" conceal cchar=¬
syntax match pyNiceOperator "\m\( \|\)\*\*\( \|\)2\>" conceal cchar=²
syntax match pyNiceOperator "\m\( \|\)\*\*\( \|\)3\>" conceal cchar=³
syntax match pyNiceOperator "\m\( \|\)\*\*\( \|\)n\>" conceal cchar=ⁿ
syntax match pyNiceOperator "\m\<in\>" conceal cchar=∈
syntax match pyNiceOperator "\m\<not in\>" conceal cchar=∉
syntax match pyNiceComment
            \ '\m\(^\s\{0,4}#\s\{0,4}\([*\-+][^*\-+]\)\?\s*\)<=\[ \?\]'
            \ contained conceal cchar=☐
syntax match pyNiceComment
            \ '\m\(^\s\{0,4}#\s\{0,4}\([*\-+][^*\-+]\)\?\s*\)<=\[[*x+]\]'
            \ contained conceal cchar=☑
syntax match pyNiceComment
            \ '\m\(^\s\{0,4}#\s\{0,4}\)\@16<=[*+]\([^*\-+]\|$\)=' contained
            \ conceal cchar=•
syntax match pyNiceComment
            \ '\m\(^\s\{0,4}#\s\{0,4}\)\@16<=[\-]\([^*\-+]\|$\)=' contained
            \ conceal cchar=
syn cluster pyNiceCommentGroup contains=pythonTodo,pyNiceComment,@spell
syn match pythonComment "\m#\s\{0,79}$" contains=pythonTodo,@pyNiceCommentGroup
"}}}
" vim: set ts=4 sw=4 tw=79 fdm=marker et :
