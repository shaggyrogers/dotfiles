""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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
" all filetypes                                               "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup AllFiletypeConfig
    autocmd!
    autocmd FileType * :call LoadFiletypeDictionary()
augroup end


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" C                                                           "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup CFiletypeConfig
    autocmd!
    autocmd BufWrite *.c,*.h :call DeleteTrailingWS()
    autocmd Filetype c :call matchadd('ColorColumn', '\%>80v',100) |
                \ setlocal tw=79 |
                \ set foldcolumn=1 |
                \ call DoTagbar() |
                \ retab
augroup end


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" C++                                                         "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup CPPFiletypeConfig
    autocmd!
    autocmd BufWrite *.cpp,*.cxx,*.cc,*.c++,*.cp,*.C :call DeleteTrailingWS()
    autocmd Filetype cpp :call matchadd('ColorColumn', '\%>80v',100) |
                \ setlocal tw=79 |
                \ set foldcolumn=1 |
                \ call DoTagbar() |
                \ retab
augroup end


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Go                                                          "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup GoFiletypeConfig
    autocmd!
    autocmd BufWrite *.go :call DeleteTrailingWS()
    autocmd Filetype go :call matchadd('ColorColumn', '\%>80v',100) |
                \ setlocal tw=79 |
                \ set foldcolumn=1 |
                \ call DoTagbar() |
                \ retab
augroup end


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Java                                                        "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup JavaFiletypeConfig
    autocmd!
    autocmd BufWrite *.java,*.Java :call DeleteTrailingWS()
    autocmd Filetype java :call matchadd('ColorColumn', '\%>80v',100) |
                \ setlocal tw=79 |
                \ set foldcolumn=1 |
                \ call DoTagbar() |
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
        syntax clear mkdBold

        " Github flavored markdown
        syntax clear githubFlavoredMarkdownTable
        syntax clear githubFlavoredMarkdownTableBorder
        syntax clear githubFlavoredMarkdownTableDelimiter
    catch
    endtry

    syntax match mkdListItem '\m\(^\s\{0,3}\)\@<=[*+]\([*\-+]\)\@!' conceal cchar=•
    syntax match mkdListItem '\m\(^\s\{0,3}\)\@<=[\-]\([*\-+]\)\@!' conceal cchar=
    syntax match mkdGitCheckBox '\m\(^\s\{0,3\}\([*\-+]\([*\-+]\)\@<!\)\?\s\?\)\@<=\[ \?\]'
                            \ conceal cchar=☐
    syntax match mkdGitCheckBoxChecked  '\m\(^\s\{0,3\}\([*\-+]\([*\-+]\)\@<!\)\?\s\?\)\@<=\[x\]'
                            \ conceal cchar=☑
    syn match mkdTableSep "\(^\s\{0,3\}\)\@<=|:\?-\(:\?-\+:\?|\)\+"
                            \ contains=mkdTableVHL,mkdTableVHLR,mkdTableVHR,
                            \ mkdTable
    syn match mkdTable "\(^\s\{0,3\}\)\@<=|\([^\-|][^|]*|\)\+" contains=mkdTableV,
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
    hi! link mkdBold Question

    setlocal conceallevel=2
    setlocal concealcursor="nv"
endfunction

augroup MarkdownFiletypeConfig
    autocmd!
    autocmd BufWrite *.md,*.MD :call DeleteTrailingWS()
    autocmd Filetype markdown call matchadd('ColorColumn', '\%>80v', 100) |
                \ setlocal tw=79 |
                \ set foldcolumn=1 |
                \ setlocal dictionary+=/usr/share/dict/words |
                \ setlocal complete+=kspell |
                \ setlocal spell |
                \ retab
    autocmd BufEnter *.md,*.MD call MarkdownFiletypeSyntax() | TableModeEnable
    autocmd BufLeave *.md,*.MD TableModeDisable
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
        syntax clear pythonComment
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
    syntax match pyNiceComment '\m\(^\s*#\s*\([*\-+][^*\-+]\)\?\s*\)\@<=\[ \?\]' contained conceal cchar=☐
    syntax match pyNiceComment '\m\(^\s*#\s*\([*\-+][^*\-+]\)\?\s*\)\@<=\[[*x+]\]' contained conceal cchar=☑
    syntax match pyNiceComment '\m\(^\s*#\s*\)\@<=[*+]\([^*\-+]\|$\)\@=' contained conceal cchar=•
    syntax match pyNiceComment '\m\(^\s*#\s*\)\@<=[\-]\([^*\-+]\|$\)\@=' contained conceal cchar=
    syn cluster pyNiceCommentGroup contains=pythonTodo,pyNiceComment,@spell
    syn match pythonComment "#.*$" contains=pythonTodo,@pyNiceCommentGroup

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
                \ setlocal tw=79 |
                \ set foldcolumn=1 |
                \ setlocal nosmartindent |
                \ setlocal autoindent |
                \ setlocal smarttab |
                \ setlocal expandtab |
                \ filetype indent on |
                \ setlocal define=^\s*\\(def\\\\|class\\) |
                \ call matchadd('ColorColumn', '\%>80v', 100) |
                \ call PythonFiletypeSyntax() |
                \ call DoTagbar() |
                \ retab

    autocmd BufWrite *.py,*.pyx,*.pyd,*.pyw,*.pxi,*.pyi
                                                \ call DeleteTrailingWS()
    autocmd BufEnter *.py,*.pyx,*.pyd,*.pyw,*.pxi,*.pyi :call PythonFiletypeSyntax()

    " TODO: Abbreviations
augroup end

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Shell/Bash Scripts                                          "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup BashFiletypeConfig
    autocmd!
    autocmd BufWrite *.sh,*.bash :call DeleteTrailingWS()
    autocmd Filetype sh :call matchadd('ColorColumn', '\%>80v', 100) |
                \ setlocal tw=79 |
                \ set foldcolumn=1 |
                \ retab
augroup end

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim Scripts                                                 "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! VimScriptFiletypeSyntax()
    try
        syntax clear vimNiceComment
    catch
    endtry

    syntax match vimNiceComment '\m\(^\s*"\s*\([*\-+][^*\-+]\)\?\s*\)\@<=\[ \?\]' contained conceal cchar=☐
    syntax match vimNiceComment '\m\(^\s*"\s*\([*\-+][^*\-+]\)\?\s*\)\@<=\[[*x+]\]' contained conceal cchar=☑
    syntax match vimNiceComment '\m\(^\s*"\s*\)\@<=[*+]\([^*\-+]\|$\)\@=' contained conceal cchar=•
    syntax match vimNiceComment '\m\(^\s*"\s*\)\@<=[\-]\([^*\-+]\|$\)\@=' contained conceal cchar=
    syn cluster vimCommentGroup contains=vimNiceComment,@vimCommentGroup

    hi link vimNiceComment Comment
    hi! link Conceal Operator

    setlocal conceallevel=2 | setlocal concealcursor=""
endfunction

augroup VimscriptFiletypeConfig
    autocmd!
    autocmd BufWrite *.vim :call DeleteTrailingWS()
    autocmd Filetype vim :call matchadd('ColorColumn', '\%>80v',100) |
                \ setlocal tw=79 | set foldcolumn=1 |
                \ retab |
                \ call DoTagbar() |
                \ call VimScriptFiletypeSyntax()
    autocmd BufEnter *.vim :call VimScriptFiletypeSyntax()
augroup end

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Helper Functions                                            "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Delete trailing whitespace
func! DeleteTrailingWS()
    let l = line(".") | let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
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


" Load a dictionary for the current filetype, if one exists
function! LoadFiletypeDictionary()
    let path = $HOME . '/.config/nvim/dictionaries/' . &filetype .'.txt'
    if ! filereadable(path) | return | endif
    silent execute 'setlocal dict+=' . path
endfunction

" Show tagbar and update options if window is big enough
function! DoTagbar()
    if exists('*UpdateTagbarOptions')
        let l:id = win_getid()
        call UpdateTagbarOptions(1)
        call win_gotoid(l:id)
    endif
endfunction

