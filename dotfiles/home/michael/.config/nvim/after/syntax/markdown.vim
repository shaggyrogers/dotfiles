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
syntax match mkdListItem '\m\(^\s\{0,4}\)\@3<=[*+]\([*\-+]\)\@1!' conceal
        \ cchar=•
syntax match mkdListItem '\m\(^\s\{0,4}\)\@3<=[\-]\([*\-+]\)\@1!' conceal
        \ cchar=
syntax match mkdGitCheckBox
        \ '\m\(^\s\{0,16\}\([*\-+]\([*\-+]\)\@1<!\)\?\s\?\)\@32<=\[ \?\]'
        \ conceal cchar=☐
syntax match mkdGitCheckBoxChecked
        \ '\m\(^\s\{0,16\}\([*\-+]\([*\-+]\)\@1<!\)\?\s\?\)\@32<=\[x\]'
        \ conceal cchar=☑

" Regular expressions are fine, but can't get this to work :\
syn match mkdTableSep "\(^\s\{0,16\}\)\@16<=|[: ]\?-\([: ]\?-\+[: ]\?|\)\+"
        \ contains=mkdTableVHL,mkdTableVHLR,mkdTableVHR,
        \ mkdTable
syn match mkdTable "\(^\s\{0,16\}\)\@16<=|\([^\-|]\s\?[^|]*|\)\+"
        \ contains=mkdTableV,markdownBoldItalic,markdownBold,
        \ markdownItalic,markdownLinkText,markdownIdDeclaration,
        \ githubFlavoredMarkdownMention,
        \ githubFlavoredMarkdownIssueNumber,
        \ githubFlavoredMarkdownStrikethrough,
        \ githubFlavoredMarkdownEmoji
syn match mkdTableVHLR '\(-\s\?\)\@2<=|\(\s\?-\)\@2=' contained
        \ containedin=mkdTableSep conceal cchar=╋
syn match mkdTableVHR '\(^\s\{0,16\}\)\@16<=|\(\s\?-\)\@2=' contained
        \ containedin=mkdTableSep conceal cchar=┣
syn match mkdTableVHL '\(-\s\?\)\@2<=|$' contained containedin=mkdTableSep
        \ conceal cchar=┫
syn match mkdTableH '-' contained containedin=mkdTableSep conceal cchar=━
syn match mkdTableV '|' contained containedin=mkdTable conceal cchar=┃

hi! link Conceal Identifier
hi! link mkdHeading Title
hi! link mkdBold Question "}}}

" vim: set ts=4 sw=4 tw=79 fdm=marker et :
