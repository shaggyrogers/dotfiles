""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" markdown.vim
" ============
"
" Author:                Michael De Pasquale
" Creation Date:         2018-02-20
"
" Description
" -----------
" markdown syntax tweaks
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Clear syntax groups if they exist{{{
try
    syntax clear mkdBold
    syntax clear mkdGitCheckBox
    syntax clear mkdGitCheckBoxChecked
    syntax clear mkdListItem
    syntax clear mkdNonListItemBlock
    syntax clear mkdTable
    syntax clear mkdTableH
    syntax clear mkdTableSep
    syntax clear mkdTableV
    syntax clear mkdTableVHL
    syntax clear mkdTableVHLR
    syntax clear mkdTableVHR

    " Github flavored markdown
    syntax clear githubFlavoredMarkdownTable
    syntax clear githubFlavoredMarkdownTableBorder
    syntax clear githubFlavoredMarkdownTableDelimiter
catch
endtry
"}}}

" Create syntax groups{{{
syntax match mkdListItem '\m\(^\s\{0,3}\)\@<=[*+]\([*\-+]\)\@!' conceal
        \ cchar=•
syntax match mkdListItem '\m\(^\s\{0,3}\)\@<=[\-]\([*\-+]\)\@!' conceal
        \ cchar=
syntax match mkdGitCheckBox
        \ '\m\(^\s\{0,3\}\([*\-+]\([*\-+]\)\@<!\)\?\s\?\)\@<=\[ \?\]'
        \ conceal cchar=☐
syntax match mkdGitCheckBoxChecked
        \ '\m\(^\s\{0,3\}\([*\-+]\([*\-+]\)\@<!\)\?\s\?\)\@<=\[x\]'
        \ conceal cchar=☑
syn match mkdTableSep "\(^\s\{0,3\}\)\@<=|:\?-\(:\?-\+:\?|\)\+"
        \ contains=mkdTableVHL,mkdTableVHLR,mkdTableVHR,
        \ mkdTable
syn match mkdTable "\(^\s\{0,3\}\)\@<=|\([^\-|][^|]*|\)\+"
        \ contains=mkdTableV,markdownBoldItalic,markdownBold,
        \ markdownItalic,markdownLinkText,markdownIdDeclaration,
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
"}}}
" vim: set ts=4 sw=4 tw=79 fdm=marker et :
