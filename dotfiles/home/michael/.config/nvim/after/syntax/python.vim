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

if !has('conceal')
    echoerr 'Python syntax tweaks could not be applied: conceal not supported!'
    finish
endif

" Clear syntax groups if they exist
try
    syntax clear pyNiceBuiltin
    syntax clear pyNiceComment
    syntax clear pyNiceKeyword
    syntax clear pyNiceOperator
    syntax clear pyNiceStatement
    syntax clear pythonOperator
catch
endtry

" Create syntax groups
syntax match pythonOperator '\V\[=\-+*/%|^&~<>]\|!='
syntax keyword pythonOperator is or and

" Source: https://github.com/ehamberg/vim-cute-python
syntax keyword pyNiceBuiltin all conceal cchar=∀
syntax keyword pyNiceBuiltin any conceal cchar=∃
syntax keyword pyNiceOperator sum conceal cchar=∑
syntax keyword pyNiceStatement lambda conceal cchar=λ
syntax match pyNiceKeyword "\m\<\%(math\.\)\?pi\>" conceal cchar=
syntax match pyNiceKeyword "\m\<\%(math\.\)\?sqrt\>" conceal cchar=√
syntax match pyNiceKeyword "\m\<\%(math\.\)\?fsum\>" conceal cchar=∑
syntax match pyNiceKeyword "\m\<\%(math\.\)\?inf\>" conceal cchar=∞
syntax match pyNiceKeyword "\m\<\%(numbers\.\)\?Real\>" conceal cchar=ℝ
syntax match pyNiceKeyword "\m\<\%(numbers\.\)\?Complex\>" conceal cchar=ℂ
syntax match pyNiceKeyword "\m\<\%(numbers\.\)\?Integral\>" conceal cchar=ℤ
syntax match pyNiceKeyword "\m\<\%(numbers\.\)\?Rational\>" conceal cchar=ℚ
syntax match pyNiceOperator "\m\%(if \)\@3<!\<not\%( \|\>\)" conceal cchar=¬
syntax match pyNiceOperator "\m\%(is \)\@3<!\<not\%( \|\>\)" conceal cchar=¬
syntax match pyNiceOperator "\m\%( \|\)\*\*\%( \|\)2\>" conceal cchar=²
syntax match pyNiceOperator "\m\%( \|\)\*\*\%( \|\)3\>" conceal cchar=³
syntax match pyNiceOperator "\m\%( \|\)\*\*\%( \|\)n\>" conceal cchar=ⁿ
syntax match pyNiceOperator "\m\%( \|\)\*\*\%( \|\)4\>" conceal cchar=⁴
syntax match pyNiceOperator "\m\%( \|\)\*\*\%( \|\)5\>" conceal cchar=⁵
syntax match pyNiceOperator "\m\%( \|\)\*\*\%( \|\)6\>" conceal cchar=⁶
syntax match pyNiceOperator "\m\%( \|\)\*\*\%( \|\)7\>" conceal cchar=⁷
syntax match pyNiceOperator "\m\%( \|\)\*\*\%( \|\)8\>" conceal cchar=⁸
syntax match pyNiceOperator "\m\%( \|\)\*\*\%( \|\)9\>" conceal cchar=⁹
syntax match pyNiceOperator "\m\%( \|\)\*\*\%( \|\)9\>" conceal cchar=⁹
syntax match pyNiceOperator "\m\<in\>" conceal cchar=∈
syntax match pyNiceOperator "\m\<not in\>" conceal cchar=∉

syn match pythonBuiltinSpecial "\v<type>%(\s?\()@="
syn match pythonBuiltinSpecial "\v<exec>%(\s?\()@="
syn match pythonBuiltinSpecial "\v<id>%(\s?\()@="
syn match pythonBuiltinSpecial "\v<print>%(\s?\()@="
syn match pythonBuiltinSpecial "\v<hash>%(\s?\()@="
syn match pythonBuiltinSpecial "\v<breakpoint>%(\s?\()@="
syn match pythonBuiltinSpecial "\v<help>%(\s?\()@="
syn match pythonBuiltinSpecial "\v<compile>%(\s?\()@="

" TODO: Finish
" '"\s*\%([sS]:\|\h\w*#\)\=\u\w*\(\s\+\u\w*\)*:'hs=s+1
syntax match pyNiceComment '\m\%(^\s\{0,4}#\s\{0,4}\([*\-+][^*\-+]\)\?\s*\)<=\[ \?\]' contained conceal cchar=☐
syntax match pyNiceComment
            \ '\m\(^\s\{0,4}#\s\{0,4}\([*\-+][^*\-+]\)\?\s*\)<=\[[*x+]\]'
            \ contained conceal cchar=☑
syntax match pyNiceComment
            \ '\m\(^\s\{0,4}#\s\{0,4}\)\@16<=[*+]\([^*\-+]\|$\)=' contained
            \ conceal cchar=•
syntax match pyNiceComment
            \ '\m\(^\s\{0,4}#\s\{0,4}\)\@16<=[\-]\([^*\-+]\|$\)=' contained
            \ conceal cchar=
syntax keyword pythonTodo
            \ BUG CHECK DEBUG DEPRECATED FINISH FIXME HACK NOTE NOTES
            \ OPTIMISE TBD TODO REVIEW XXX contained
syntax keyword pythonCommentCaution
            \ BUG CHECK DEBUG DEPRECATED FINISH FIXME HACK NOTE NOTES
            \ OPTIMISE TBD TODO REVIEW XXX contained
syntax cluster pyNiceCommentGroup contains=pythonTodo,pyNiceComment,@spell
syntax match pythonComment "\m#.*$" contains=pythonTodo,@spell,@pyNiceCommentGroup


hi link pythonBuiltinSpecial Diagnostic
hi link pythonOperator Operator
hi link pythonOperator Operator
hi link pyNiceStatement Statement
hi link pyNiceKeyword Keyword
hi! link Conceal Operator
"

" vim: set ts=4 sw=4 tw=0 fdm=marker et :
