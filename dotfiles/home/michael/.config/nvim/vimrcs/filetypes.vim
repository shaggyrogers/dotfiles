"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" filetypes.vim                                                               "
" =============                                                               "
"                                                                             "
" Author:                Michael De Pasquale                                  "
" Creation Date:         2017-12-02                                           "
"                                                                             "
" Description                                                                 "
" -----------                                                                 "
" Defines options, autocmds, highlighting etc. for certain filetypes.         "
"                                                                             "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" C                                                           "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup CFiletypeConfig
    autocmd!
    autocmd BufWrite *.c,*.h :call DeleteTrailingWS()
    autocmd Filetype c :call DeleteTrailingWS() |
                                \ call matchadd('ColorColumn', '\%>80v',100) |
                                \ setlocal tw=79 |
                                \ retab
augroup end


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" C++                                                         "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup CPPFiletypeConfig
    autocmd!
    autocmd BufWrite *.cpp,*.cxx,*.cc,*.c++,*.cp,*.C :call DeleteTrailingWS()
    autocmd Filetype cpp :call DeleteTrailingWS() |
                                \ call matchadd('ColorColumn', '\%>80v',100) |
                                \ setlocal tw=79 |
                                \ retab
augroup end


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Go                                                          "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup GoFiletypeConfig
    autocmd!
    autocmd BufWrite *.go :call DeleteTrailingWS()
    autocmd Filetype go :call DeleteTrailingWS() |
                                \ call matchadd('ColorColumn', '\%>80v',100) |
                                \ setlocal tw=79 |
                                \ retab
augroup end


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Java                                                        "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup JavaFiletypeConfig
    autocmd!
    autocmd BufWrite *.java,*.Java :call DeleteTrailingWS()
    autocmd Filetype java :call DeleteTrailingWS() |
                                \ call matchadd('ColorColumn', '\%>80v',100) |
                                \ setlocal tw=79 |
                                \ retab
augroup end


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Markdown                                                    "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! MarkdownFiletypeSyntax()
    try
        syntax clear mkdListItem
        syntax clear mkdGitCheckBox
        syntax clear mkdGitCheckBoxChecked
        syntax clear mkdNonListItemBlock
        syntax clear mkdTableSep
        syntax clear mkdTable
        syntax clear mkdTableVHLR
        syntax clear mkdTableVHR
        syntax clear mkdTableVHL
        syntax clear mkdTableH
        syntax clear mkdTableV

        " Github flavored markdown
        syntax clear githubFlavoredMarkdownTable
        syntax clear githubFlavoredMarkdownTableBorder
        syntax clear githubFlavoredMarkdownTableDelimiter
    catch
    endtry
    syntax match mkdListItem '\m\(^\s\{0,3}\)\@<=[*\-+]' conceal cchar=
    syntax match mkdGitCheckBox '\m\(^\s\{0,3\}[*\-+]\?\s\?\)\@<=\[ \?\]'
                            \ conceal cchar=☐
    syntax match mkdGitCheckBoxChecked  '\m\(^\s\{0,3\}[*\-+]\?\s\?\)\@<=\[x\]'
                            \ conceal cchar=☑
    syn match mkdTableSep "\(^\s\{0,3\}\)\@<=|:\?-\(:\?-\+:\?|\)\+"
                            \ contains=mkdTableVHL,mkdTableVHLR,mkdTableVHR,
                            \ mkdTable
    syn match mkdTable "\(^\s\{0,3\}\)\@<=|\([^-]*[^|-]*|\)\+" contains=mkdTableV,
                            \ markdownBoldItalic,markdownBold,markdownItalic,
                            \ markdownLinkText,markdownIdDeclaration,
                            \ githubFlavoredMarkdownMention,
                            \ githubFlavoredMarkdownIssueNumber,
                            \ githubFlavoredMarkdownStrikethrough,
                            \ githubFlavoredMarkdownEmoji
    syn match mkdTableVHLR '\([-]\)\@<=|\(-\)\@=' contained
                            \ containedin=mkdTableSep conceal cchar=╋
    syn match mkdTableVHR '\(^\s\{0,3\}\)\@<=|\(-\)\@=' contained
                            \ containedin=mkdTableSep conceal cchar=┣
    syn match mkdTableVHL '\([-]\)\@<=|$' contained containedin=mkdTableSep
                            \ conceal cchar=┫
    syn match mkdTableH '-' contained containedin=mkdTableSep conceal cchar=━
    syn match mkdTableV '|' contained containedin=mkdTable conceal cchar=┃
    hi! link Conceal Identifier

    setlocal conceallevel=2
    setlocal concealcursor="nv"
endfunction

augroup MarkdownFiletypeConfig
    autocmd!
    autocmd BufWrite *.md,*.MD :call DeleteTrailingWS()
    autocmd Filetype markdown call matchadd('ColorColumn', '\%>80v', 100) |
                                \ call MarkdownFiletypeSyntax() |
                                \ call DeleteTrailingWS() |
                                \ setlocal tw=79 |
                                \ retab
    autocmd BufEnter *.md,*.MD :hi! link Conceal Identifier
augroup end


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Python                                                      "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! PythonFiletypeSyntax()
    try
        syntax clear pythonOperator
        syntax clear pyNiceOperator
        syntax clear pyNiceKeyword
        syntax clear pyNiceBuiltin
        syntax clear pyNiceStatement
        syntax clear pyNiceComment
    catch
    endtry

    syn match pythonOperator '\V=\|*\|-\|/\|+\|@\|%\|&\||\|^\|~\|<\|>\|!='
    syn keyword pythonOperator is or and

    syntax keyword pyNiceOperator sum conceal cchar=∑
    syntax match pyNiceOperator "\m\%(is \)\@<!\<not\%( \|\>\)" conceal cchar=¬
    syntax match pyNiceOperator "\m\%(if \)\@<!\<not\%( \|\>\)" conceal cchar=¬
    syntax match pyNiceOperator "\m\( \|\)\*\*\( \|\)2\>" conceal cchar=²
    syntax match pyNiceOperator "\m\( \|\)\*\*\( \|\)3\>" conceal cchar=³
    syntax match pyNiceOperator "\m\( \|\)\*\*\( \|\)n\>" conceal cchar=ⁿ
    syntax match pyNiceKeyword "\m\<\%(math\.\)\?sqrt\>" conceal cchar=√
    syntax match pyNiceKeyword "\m\<\%(math\.\)\?pi\>" conceal cchar=
    syntax match pyNiceOperator "\m\<not in\>" conceal cchar=∉
    syntax match pyNiceOperator "\m\<in\>" conceal cchar=∈
    syntax keyword pyNiceStatement lambda conceal cchar=λ
    syntax keyword pyNiceBuiltin all conceal cchar=∀
    syntax keyword pyNiceBuiltin any conceal cchar=∃
    syntax match pyNiceComment '\m\(^\s*#\s*[*\-+]\s)\?\)\@<=\[ \?\]'
                                                \ conceal cchar=☐
    syntax match pyNiceComment '\m\(^\s*#\s*[*\-+]\s\?\)\@<=\[x\]' conceal cchar=☑
    syntax match pyNiceComment '\m\(^\s*#\s*\)\@<=[*\-+]' conceal cchar=

    hi link pyNiceComment Comment
    hi link pyNiceOperator Operator
    hi link pyNiceStatement Statement
    hi link pyNiceKeyword Keyword
    hi link pyNiceBuiltin pythonBuiltin
    hi! link Conceal Operator

    setlocal conceallevel=2 | setlocal concealcursor=""
endfunction

augroup PythonFiletypeConfig
    autocmd!
    autocmd Filetype python setlocal nocindent | setlocal tabstop=4 |
                            \ setlocal softtabstop=4 |
                            \ setlocal shiftwidth=4 |
                            \ setlocal textwidth=80 |
                            \ setlocal nosmartindent |
                            \ setlocal autoindent |
                            \ setlocal smarttab |
                            \ setlocal expandtab |
                            \ setlocal tw=79 |
                            \ filetype indent on |
                            \ call matchadd('ColorColumn', '\%>80v', 100) |
                            \ call DeleteTrailingWS() |
                            \ call PythonFiletypeSyntax() |
                            \ retab

    autocmd BufWrite *.py,*.pyx,*.pyd,*.pyw,*.pxi,*.pyi
                                                \ call DeleteTrailingWS()
    autocmd BufEnter *.py,*.pyx,*.pyd,*.pyw,*.pxi,*.pyi
                            \ :hi! link Conceal Operator

    " TODO: Abbreviations
augroup end

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Shell/Bash Scripts                                          "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup BashFiletypeConfig
    autocmd!
    autocmd BufWrite *.sh,*.bash :call DeleteTrailingWS()
    autocmd Filetype sh :call matchadd('ColorColumn', '\%>80v', 100) |
                                        \ call DeleteTrailingWS() |
                                        \ setlocal tw=79 |
                                        \ retab
augroup end

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim Scripts                                                 "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup VimscriptFiletypeConfig
    autocmd!
    autocmd BufWrite *.vim :call DeleteTrailingWS()
    autocmd Filetype vim :call matchadd('ColorColumn', '\%>80v',100) |
                                        \ call DeleteTrailingWS() |
                                        \ setlocal tw=79 |
                                        \ retab
augroup end

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Helper Functions                                            "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Delete trailing whitespace
func! DeleteTrailingWS()
    exe "normal mz"
    %s/\s\+$//ge
    exe "normal `z"
endfunc

" Return true/false if the cursor is at a given Highlight group.
function! IsCursorHiGroup(group)
    let hiList = map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')

    for gr in hiList
        if gr == a:group
            return 1
        end
    endfor

    return 0
endfunc
