""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" solarized8_flat_fork.vim
" ========================
"
" Description:           Tweaked version of vim-solarized8-flat
" Authors:               Ethan Schoonover (solarized)
"                        Lifepillar <lifepillar@lifepillar.me> (vim-solarized8)
"                        Michael De Pasquale <shaggyrogers> (tweaks)
" Creation Date:         2018-02-20
" Modification Date:     2019-12-14
" Source:                https://github.com/lifepillar/vim-solarized8
" License:               OSI approved MIT license
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


if !(has('termguicolors') && &termguicolors) && !has('gui_running') "{{{
    echoerr '[Solarized 8 Flat] There are not enough colors.'
    finish
elseif &background !=# 'dark'
    redraw
    echohl WarningMsg
    echomsg '[Solarized 8 Flat] WARNING: Only a dark background is supported.'
    echohl None
endif "}}}

let g:colors_name = 'solarized8_flat_fork' "{{{
"}}}

if !has('gui_running') && get(g:, 'solarized_termtrans', 0) "{{{
    hi Normal       guifg=#839496 guibg=NONE gui=NONE
    hi Terminal     guifg=NONE    guibg=bg gui=NONE
    hi LineNr       guifg=#586e75 guibg=bg gui=NONE
    hi SignColumn   guifg=NONE    guibg=bg gui=NONE
else
    hi Normal       guifg=#839496 guibg=#00313D gui=NONE
    hi Terminal     guifg=fg      guibg=bg      gui=NONE
    hi LineNr       guifg=#586e75 guibg=#002D38 gui=NONE
    hi SignColumn   guifg=fg      guibg=#002D38 gui=NONE
endif "}}}

hi ColorColumn   guifg=#C70B00 guibg=#004052 gui=NONE "{{{
hi Search        guifg=#FFF714 guibg=#083C4A gui=bold
hi IncSearch     guifg=#FFB81A guibg=#083C4A gui=bold
hi highlightedyankregion guifg=#51c0e1 guibg=#083C4A cterm=bold gui=bold
hi SearchCurrent         guifg=#41FF1A guibg=#083C4A cterm=bold gui=bold
hi CommandMode   guifg=#d33682 guibg=bg gui=NONE,bold
hi Comment       guifg=#838C9A guibg=bg      gui=NONE,italic
hi Conceal       guifg=#268bd2 guibg=bg      gui=NONE
hi Constant      guifg=#2aa198 guibg=bg      gui=NONE
hi Cursor        guifg=#fdf6e3 guibg=#268bd2 gui=NONE
hi CursorColumn  guifg=NONE    guibg=NONE    gui=bold
hi CursorLine    guifg=NONE    guibg=NONE    gui=underline
hi CursorLineNr  guifg=fg      guibg=NONE    gui=bold,underline
hi Directory     guifg=#268bd2 guibg=bg      gui=NONE
hi Diagnostic    guifg=#A662F1 guibg=bg      gui=NONE,bold
hi EndOfBuffer   guifg=fg      guibg=bg      gui=NONE
hi Error         guifg=#dc322f guibg=bg      gui=NONE,bold
hi ErrorMsg      guifg=#fdf6e3 guibg=#dc322f gui=NONE
hi FoldColumn    guifg=#6C92C6 guibg=bg      gui=NONE
hi Folded        guifg=#84969A guibg=bg      gui=NONE,bold
hi Identifier    guifg=#268bd2 guibg=bg      gui=NONE
hi Ignore        guifg=NONE    guibg=NONE    gui=NONE
hi IncSearch     guifg=#FFB81A guibg=#00313D gui=bold
hi InsertMode    guifg=#2aa198 guibg=#083C4A gui=NONE,bold
hi MatchParen    guifg=#fdf6e3 guibg=bg      gui=NONE
hi ModeMsg       guifg=#268bd2 guibg=bg      gui=NONE
hi MoreMsg       guifg=#268bd2 guibg=bg      gui=NONE
hi NonText       guifg=#cb4b16 guibg=bg      gui=NONE,bold
hi Pmenu         guifg=#969683 guibg=#083C4A gui=NONE
hi PmenuSbar     guifg=NONE    guibg=#7E958F gui=NONE
hi PmenuSel      guifg=#eee8d5 guibg=#28525D gui=NONE
hi PmenuThumb    guifg=NONE    guibg=#45544C gui=NONE
hi Question      guifg=#2aa198 guibg=bg      gui=NONE,bold
hi ReplaceMode   guifg=#083C4A guibg=#cb4b16 gui=NONE,bold,reverse
hi Search        guifg=#FFF714 guibg=#00313D gui=bold
hi Special       guifg=#cb4b16 guibg=bg      gui=NONE
hi StatusLine    guifg=#afd787 guibg=#444444 gui=NONE
hi StatusLineNC  guifg=#ffffff guibg=#444444 gui=NONE
hi Substitute    guifg=#DA1AFF guibg=bg      gui=bold
hi TabLineFill   guifg=#586e75 guibg=#083C4A gui=NONE
hi TabLineSel    guifg=#eee8d5 guibg=#083C4A gui=NONE
hi Todo          guifg=#d33682 guibg=bg      gui=NONE,bold
hi ToolbarButton guifg=#93a1a1 guibg=#083C4A gui=NONE,bold
hi ToolbarLine   guifg=fg      guibg=#083C4A gui=NONE
hi Type          guifg=#b58900 guibg=bg      gui=NONE
hi Underlined    guifg=#6c71c4 guibg=bg      gui=NONE
hi VertSplit     guifg=#444444 guibg=#444444 gui=NONE
hi Visual        guifg=NONE    guibg=NONE    gui=NONE,reverse
hi VisualMode    guifg=#083C4A guibg=#d33682 gui=NONE,bold,reverse
hi VisualNOS     guifg=NONE    guibg=#083C4A gui=NONE,reverse
hi WarningMsg    guifg=#FA7A17 guibg=bg      gui=NONE,bold
hi WildMenu      guifg=#6F8790 guibg=#eee8d5 gui=NONE,reverse
"}}}

hi! link Conditional      Statement "{{{
hi! link Boolean          Constant
hi! link Character        Constant
hi! link Define           PreProc
hi! link Debug            Special
hi! link Delimiter        Special
hi! link Exception        Statement
hi! link Float            Constant
hi! link Function         Identifier
hi! link Include          PreProc
hi! link Keyword          Statement
hi! link Label            Statement
hi! link Macro            PreProc
hi! link Number           Constant
hi! link Operator         Statement
hi! link PreCondit        PreProc
hi! link StatusLineTerm   StatusLine
hi! link StatusLineTermNC StatusLineNC
hi! link QuickFixLine     Search
hi! link Repeat           Statement
hi! link SpecialChar      Special
hi! link SpecialComment   Special
hi! link StorageClass     Type
hi! link String           Constant
hi! link Structure        Type
hi! link Tag              Special
hi! link Typedef          Type
hi! link lCursor          Cursor
"}}}

if get(g:, "solarized_visibility", "") == "high" "{{{
    hi SpecialKey guifg=#cb4b16 guibg=bg gui=NONE
    "guisp=#dc322f
    hi SpellBad   guifg=#6c71c4 guibg=bg gui=NONE,undercurl
    hi SpellCap   guifg=#6c71c4 guibg=bg gui=NONE,undercurl
    hi SpellLocal guifg=#b58900 guibg=bg gui=NONE,undercurl
    hi SpellRare  guifg=#2aa198 guibg=bg gui=NONE,undercurl
    hi Title      guifg=#b58900 guibg=bg gui=NONE,bold
elseif get(g:, "solarized_visibility", "") == "low"
    hi SpecialKey guifg=#083C4A guibg=bg gui=NONE,reverse
    " guisp=#6c71c4        guisp=#2aa198              guisp=#b58900
    hi SpellBad   guifg=#6c71c4 guibg=bg gui=NONE,undercurl
    hi SpellCap   guifg=#6c71c4 guibg=bg gui=NONE,undercurl
    hi SpellLocal guifg=#b58900 guibg=bg gui=NONE,undercurl
    hi SpellRare  guifg=#2aa198 guibg=bg gui=NONE,undercurl
    hi Title      guifg=#586e75 guibg=bg gui=NONE,bold
else
    " guisp=#6c71c4 guisp=#b58900 guisp=#2aa198
    hi SpecialKey guifg=#6F8790 guibg=bg gui=NONE,bold
    hi SpellBad   guifg=#6c71c4 guibg=bg gui=NONE,undercurl
    hi SpellCap   guifg=#6c71c4 guibg=bg gui=NONE,undercurl
    hi SpellLocal guifg=#b58900 guibg=bg gui=NONE,undercurl
    hi SpellRare  guifg=#2aa198 guibg=bg gui=NONE,undercurl
    hi Title      guifg=#b58900 guibg=bg gui=NONE,bold
endif "}}}

if get(g:, "solarized_diffmode", "") == "high" "{{{
    hi DiffAdd    guifg=#719E07 guibg=bg gui=NONE,reverse
    hi DiffChange guifg=#b58900 guibg=bg gui=NONE,reverse
    hi DiffDelete guifg=#dc322f guibg=bg gui=NONE,reverse
    hi DiffText   guifg=#268bd2 guibg=bg gui=NONE,reverse
elseif get(g:, "solarized_diffmode", "") == "low"
    " guisp=#719E07 guisp=#b58900 guisp=#268bd2
    hi DiffAdd    guifg=#719E07 guibg=bg  gui=NONE
    hi DiffChange guifg=#b58900 guibg=bg  gui=NONE
    hi DiffDelete guifg=#dc322f guibg=bg  gui=NONE,bold
    hi DiffText   guifg=#268bd2 guibg=bg  gui=NONE
else
    hi DiffAdd    guifg=#719E07 guibg=#083C4A guisp=#719E07 gui=NONE
    hi DiffChange guifg=#b58900 guibg=#083C4A guisp=#b58900 gui=NONE
    hi DiffDelete guifg=#dc322f guibg=#083C4A gui=NONE,bold
    hi DiffText   guifg=#268bd2 guibg=#083C4A guisp=#268bd2 gui=NONE
endif "}}}

if get(g:, 'solarized_use_bolditalic_syntax', 0) "{{{
    hi PreProc   guifg=#cb4b16 guibg=bg gui=NONE,italic
    hi Statement guifg=#719E07 guibg=bg gui=NONE,bold,italic
else
    hi PreProc   guifg=#cb4b16 guibg=bg gui=NONE
    hi Statement guifg=#719E07 guibg=bg gui=NONE
endif "}}}

if get(g:, 'solarized_extra_hi_groups', 0) "{{{
" ¶«¦§¨­ϸϟϞ׀װܘ܀ܙᚋ᚛ᚐᚑ᛫᛬᳡ᳲᳳᳵᳶᳵ‖‗†‡•‣…›‹※‼‽⁂⁃⁆⁅⁊⁋⁍⁎⁏⁐⁑⁒⁕⁖⁘⁙⁚⁛⁜⁝⁞↵
    " ALE{{{
    if !has('gui_running') && get(g:, 'solarized_termtrans', 0)
        hi Error   guifg=#dc322f guibg=bg gui=NONE,bold
        hi Info    guifg=#007BDD guibg=bg gui=NONE
        hi Warning guifg=#FFEB3B guibg=bg gui=NONE
    else
        hi Error   guifg=#dc322f guibg=#002D38 gui=NONE,bold
        hi Info    guifg=#007BDD guibg=#002D38 gui=NONE
        hi Warning guifg=#FFEB3B guibg=#002D38 gui=NONE
    endif

    hi! link ALEErrorSign   Error
    hi! link ALEWarningSign Warning
    hi! link ALEInfoSign    Info
    "}}}
    " Cursorword {{{
    hi CursorWord0 guifg=NONE guibg=bg gui=bold,underline
    hi CursorWord1 guifg=NONE guibg=bg gui=bold,underline
    "}}}
    " NERDTree{{{
    hi! link NERDTreeOpenable Type
    hi! link NERDTreeClosable Type
    hi! link NERDTreeBookmark Constant
    "}}}
    " Git{{{
    hi gitcommitComment       guifg=#586e75 guibg=bg gui=NONE,italic
    hi gitcommitUnmerged      guifg=#719E07 guibg=bg gui=NONE,bold
    hi gitcommitOnBranch      guifg=#586e75 guibg=bg gui=NONE,bold
    hi gitcommitBranch        guifg=#d33682 guibg=bg gui=NONE,bold
    hi gitcommitdiscardedtype guifg=#dc322f guibg=bg gui=NONE
    hi gitcommitselectedtype  guifg=#719E07 guibg=bg gui=NONE
    hi gitcommitHeader        guifg=#586e75 guibg=bg gui=NONE
    hi gitcommitUntrackedFile guifg=#2aa198 guibg=bg gui=NONE,bold
    hi gitcommitDiscardedFile guifg=#dc322f guibg=bg gui=NONE,bold
    hi gitcommitSelectedFile  guifg=#719E07 guibg=bg gui=NONE,bold
    hi gitcommitUnmergedFile  guifg=#b58900 guibg=bg gui=NONE,bold
    hi gitcommitFile          guifg=fg      guibg=bg gui=NONE,bold

    hi! link gitcommitUntracked      gitcommitComment
    hi! link gitcommitDiscarded      gitcommitComment
    hi! link gitcommitSelected       gitcommitComment
    hi! link gitcommitNoBranch       gitcommitBranch
    hi! link gitcommitDiscardedArrow gitcommitDiscardedFile
    hi! link gitcommitSelectedArrow  gitcommitSelectedFile
    hi! link gitcommitUnmergedArrow  gitcommitUnmergedFile
    hi! link diffAdded               Statement
    hi! link diffLine                Identifier
    "}}}
    " Haskell{{{
    let hs_highlight_boolean=1
    let hs_highlight_delimiters=1

    hi cPreCondit         guifg=#cb4b16 guibg=bg gui=NONE
    hi VarId              guifg=#268bd2 guibg=bg gui=NONE
    hi ConId              guifg=#b58900 guibg=bg gui=NONE
    hi hsImport           guifg=#d33682 guibg=bg gui=NONE
    hi hsString           guifg=#6F8790 guibg=bg gui=NONE
    hi hsStructure        guifg=#2aa198 guibg=bg gui=NONE
    hi hs_hlFunctionName  guifg=#268bd2 guibg=bg gui=NONE
    hi hsStatement        guifg=#2aa198 guibg=bg gui=NONE
    hi hsImportLabel      guifg=#2aa198 guibg=bg gui=NONE
    hi hs_OpFunctionName  guifg=#b58900 guibg=bg gui=NONE
    hi hs_DeclareFunction guifg=#cb4b16 guibg=bg gui=NONE
    hi hsVarSym           guifg=#2aa198 guibg=bg gui=NONE
    hi hsType             guifg=#b58900 guibg=bg gui=NONE
    hi hsTypedef          guifg=#2aa198 guibg=bg gui=NONE
    hi hsModuleName       guifg=#719E07 guibg=bg gui=NONE
    hi hsNiceOperator     guifg=#2aa198 guibg=bg gui=NONE
    hi hsniceoperator     guifg=#2aa198 guibg=bg gui=NONE

    hi! link hsImportParams     Delimiter
    hi! link hsDelimTypeExport  Delimiter
    hi! link hsModuleStartLabel hsStructure
    hi! link hsModuleWhereLabel hsModuleStartLabel
    "}}}
    " IndentGuides{{{
    if !has('gui_running') && get(g:, 'solarized_termtrans', 0)
        hi IndentGuidesEven guifg=fg guibg=#004D61
        hi IndentGuidesOdd  guifg=fg guibg=#004052
    else
        hi IndentGuidesEven guifg=#80C5C7 guibg=#004557
        hi IndentGuidesOdd  guifg=#003947 guibg=#003B4B
    endif
    "}}}
    " Miscellaneous{{{
    hi htmlTag               guifg=#586e75 guibg=bg gui=NONE
    hi htmlEndTag            guifg=#586e75 guibg=bg gui=NONE
    hi htmlTagN              guifg=#93a1a1 guibg=bg gui=NONE,bold
    hi htmlTagName           guifg=#268bd2 guibg=bg gui=NONE,bold
    hi htmlSpecialTagName    guifg=#268bd2 guibg=bg gui=NONE,italic
    hi htmlArg               guifg=#6F8790 guibg=bg gui=NONE
    hi javaScript            guifg=#b58900 guibg=bg gui=NONE
    hi perlHereDoc           guifg=#93a1a1 guibg=bg gui=NONE
    hi perlVarPlain          guifg=#b58900 guibg=bg gui=NONE
    hi perlStatementFileDesc guifg=#2aa198 guibg=bg gui=NONE
    hi texstatement          guifg=#2aa198 guibg=bg gui=NONE
    hi texmathzonex          guifg=#b58900 guibg=bg gui=NONE
    hi texmathmatcher        guifg=#b58900 guibg=bg gui=NONE
    hi texreflabel           guifg=#b58900 guibg=bg gui=NONE
    hi rubyDefine            guifg=#93a1a1 guibg=bg gui=NONE,bold
    hi rubyBoolean           guifg=#d33682 guibg=bg gui=NONE
    " }}}
    " Pandoc{{{
    hi pandocTitleBlock                       guifg=#268bd2 guibg=bg      gui=NONE
    hi pandocTitleBlockTitle                  guifg=#268bd2 guibg=bg      gui=NONE,bold
    hi pandocTitleComment                     guifg=#268bd2 guibg=bg      gui=NONE,bold
    hi pandocComment                          guifg=#586e75 guibg=bg      gui=NONE,italic
    hi pandocVerbatimBlock                    guifg=#b58900 guibg=bg      gui=NONE
    hi pandocBlockQuote                       guifg=#268bd2 guibg=bg      gui=NONE
    hi pandocBlockQuoteLeader1                guifg=#268bd2 guibg=bg      gui=NONE
    hi pandocBlockQuoteLeader2                guifg=#2aa198 guibg=bg      gui=NONE
    hi pandocBlockQuoteLeader3                guifg=#b58900 guibg=bg      gui=NONE
    hi pandocBlockQuoteLeader4                guifg=#dc322f guibg=bg      gui=NONE
    hi pandocBlockQuoteLeader5                guifg=fg      guibg=bg      gui=NONE
    hi pandocBlockQuoteLeader6                guifg=#586e75 guibg=bg      gui=NONE
    hi pandocListMarker                       guifg=#d33682 guibg=bg      gui=NONE
    hi pandocListReference                    guifg=#d33682 guibg=bg      gui=NONE
    hi pandocDefinitionBlock                  guifg=#6c71c4 guibg=bg      gui=NONE
    hi pandocDefinitionTerm                   guifg=#6c71c4 guibg=bg      gui=NONE,standout
    hi pandocDefinitionIndctr                 guifg=#6c71c4 guibg=bg      gui=NONE,bold
    hi pandocEmphasisDefinition               guifg=#6c71c4 guibg=bg      gui=NONE,italic
    hi pandocEmphasisNestedDefinition         guifg=#6c71c4 guibg=bg      gui=NONE,bold
    hi pandocStrongEmphasisDefinition         guifg=#6c71c4 guibg=bg      gui=NONE,bold
    hi pandocStrongEmphasisNestedDefinition   guifg=#6c71c4 guibg=bg      gui=NONE,bold
    hi pandocStrongEmphasisEmphasisDefinition guifg=#6c71c4 guibg=bg      gui=NONE,bold
    hi pandocStrikeoutDefinition              guifg=#6c71c4 guibg=bg      gui=NONE,reverse
    hi pandocVerbatimInlineDefinition         guifg=#6c71c4 guibg=bg      gui=NONE
    hi pandocSuperscriptDefinition            guifg=#6c71c4 guibg=bg      gui=NONE
    hi pandocSubscriptDefinition              guifg=#6c71c4 guibg=bg      gui=NONE
    hi pandocTable                            guifg=#268bd2 guibg=bg      gui=NONE
    hi pandocTableStructure                   guifg=#268bd2 guibg=bg      gui=NONE
    hi pandocTableZebraLight                  guifg=#268bd2 guibg=#00313D gui=NONE
    hi pandocTableZebraDark                   guifg=#268bd2 guibg=#083C4A gui=NONE
    hi pandocEmphasisTable                    guifg=#268bd2 guibg=bg      gui=NONE,italic
    hi pandocEmphasisNestedTable              guifg=#268bd2 guibg=bg      gui=NONE,bold
    hi pandocStrongEmphasisTable              guifg=#268bd2 guibg=bg      gui=NONE,bold
    hi pandocStrongEmphasisNestedTable        guifg=#268bd2 guibg=bg      gui=NONE,bold
    hi pandocStrongEmphasisEmphasisTable      guifg=#268bd2 guibg=bg      gui=NONE,bold
    hi pandocStrikeoutTable                   guifg=#268bd2 guibg=bg      gui=NONE,reverse
    hi pandocVerbatimInlineTable              guifg=#268bd2 guibg=bg      gui=NONE
    hi pandocSuperscriptTable                 guifg=#268bd2 guibg=bg      gui=NONE
    hi pandocSubscriptTable                   guifg=#268bd2 guibg=bg      gui=NONE
    hi pandocHeading                          guifg=#cb4b16 guibg=bg      gui=NONE,bold
    hi pandocHeadingMarker                    guifg=#cb4b16 guibg=bg      gui=NONE,bold
    hi pandocEmphasisHeading                  guifg=#cb4b16 guibg=bg      gui=NONE,bold
    hi pandocEmphasisNestedHeading            guifg=#cb4b16 guibg=bg      gui=NONE,bold
    hi pandocStrongEmphasisHeading            guifg=#cb4b16 guibg=bg      gui=NONE,bold
    hi pandocStrongEmphasisNestedHeading      guifg=#cb4b16 guibg=bg      gui=NONE,bold
    hi pandocStrongEmphasisEmphasisHeading    guifg=#cb4b16 guibg=bg      gui=NONE,bold
    hi pandocStrikeoutHeading                 guifg=#cb4b16 guibg=bg      gui=NONE,reverse
    hi pandocVerbatimInlineHeading            guifg=#cb4b16 guibg=bg      gui=NONE,bold
    hi pandocSuperscriptHeading               guifg=#cb4b16 guibg=bg      gui=NONE,bold
    hi pandocSubscriptHeading                 guifg=#cb4b16 guibg=bg      gui=NONE,bold
    hi pandocLinkDelim                        guifg=#586e75 guibg=bg      gui=NONE
    hi pandocLinkLabel                        guifg=#268bd2 guibg=bg      gui=NONE
    hi pandocLinkText                         guifg=#268bd2 guibg=bg      gui=NONE
    hi pandocLinkURL                          guifg=#6F8790 guibg=bg      gui=NONE
    hi pandocLinkTitle                        guifg=#6F8790 guibg=bg      gui=NONE
    hi pandocLinkTitleDelim                   guifg=#586e75 guibg=bg      guisp=#6F8790     gui=NONE
    hi pandocLinkDefinition                   guifg=#2aa198 guibg=bg      guisp=#6F8790     gui=NONE
    hi pandocLinkDefinitionID                 guifg=#268bd2 guibg=bg      gui=NONE,bold
    hi pandocImageCaption                     guifg=#6c71c4 guibg=bg      gui=NONE,bold
    hi pandocFootnoteLink                     guifg=#719E07 guibg=bg      gui=NONE
    hi pandocFootnoteDefLink                  guifg=#719E07 guibg=bg      gui=NONE,bold
    hi pandocFootnoteInline                   guifg=#719E07 guibg=bg      gui=NONE,bold
    hi pandocFootnote                         guifg=#719E07 guibg=bg      gui=NONE
    hi pandocCitationDelim                    guifg=#d33682 guibg=bg      gui=NONE
    hi pandocCitation                         guifg=#d33682 guibg=bg      gui=NONE
    hi pandocCitationID                       guifg=#d33682 guibg=bg      gui=NONE
    hi pandocCitationRef                      guifg=#d33682 guibg=bg      gui=NONE
    hi pandocStyleDelim                       guifg=#586e75 guibg=bg      gui=NONE
    hi pandocEmphasis                         guifg=fg      guibg=bg      gui=NONE,italic
    hi pandocEmphasisNested                   guifg=fg      guibg=bg      gui=NONE,bold
    hi pandocStrongEmphasis                   guifg=fg      guibg=bg      gui=NONE,bold
    hi pandocStrongEmphasisNested             guifg=fg      guibg=bg      gui=NONE,bold
    hi pandocStrongEmphasisEmphasis           guifg=fg      guibg=bg      gui=NONE,bold
    hi pandocStrikeout                        guifg=#586e75 guibg=bg      gui=NONE,reverse
    hi pandocVerbatimInline                   guifg=#b58900 guibg=bg      gui=NONE
    hi pandocSuperscript                      guifg=#6c71c4 guibg=bg      gui=NONE
    hi pandocSubscript                        guifg=#6c71c4 guibg=bg      gui=NONE
    hi pandocRule                             guifg=#268bd2 guibg=bg      gui=NONE,bold
    hi pandocRuleLine                         guifg=#268bd2 guibg=bg      gui=NONE,bold
    hi pandocEscapePair                       guifg=#dc322f guibg=bg      gui=NONE,bold
    hi pandocCitationRef                      guifg=#d33682 guibg=bg      gui=NONE
    hi pandocNonBreakingSpace                 guifg=#dc322f guibg=bg      gui=NONE,reverse
    hi pandocMetadataDelim                    guifg=#586e75 guibg=bg      gui=NONE
    hi pandocMetadata                         guifg=#268bd2 guibg=bg      gui=NONE
    hi pandocMetadataKey                      guifg=#268bd2 guibg=bg      gui=NONE
    hi pandocMetadata                         guifg=#268bd2 guibg=bg      gui=NONE,bold

    hi! link pandocVerbatimBlockDeep pandocVerbatimBlock
    hi! link pandocCodeBlock         pandocVerbatimBlock
    hi! link pandocCodeBlockDelim    pandocVerbatimBlock
    hi! link pandocTableStructureTop pandocTableStructre
    hi! link pandocTableStructureEnd pandocTableStructre
    hi! link pandocEscapedCharacter  pandocEscapePair
    hi! link pandocLineBreak         pandocEscapePair
    hi! link pandocMetadataTitle     pandocMetadata
    " }}}
    " Rainbow{{{
    hi rainbow_o1 ctermfg=NONE guifg=#CB4B16 gui=NONE,bold
    hi rainbow_o2 ctermfg=NONE guifg=#DA7E0B gui=NONE,bold
    hi rainbow_o3 ctermfg=NONE guifg=#B8B41E gui=NONE,bold
    hi rainbow_o4 ctermfg=NONE guifg=#83BD14 gui=NONE,bold
    hi rainbow_o5 ctermfg=NONE guifg=#12A65B gui=NONE,bold
    hi rainbow_o6 ctermfg=NONE guifg=#1C959C gui=NONE,bold
    hi rainbow_o7 ctermfg=NONE guifg=#2252BF gui=NONE,bold
    hi rainbow_o8 ctermfg=NONE guifg=#782FDA gui=NONE,bold
    hi rainbow_o9 ctermfg=NONE guifg=#B62072 gui=NONE,bold
    "}}}
    " Ruby {{{
    hi! link rubySymbol Type
    "}}}
    " Vim{{{
    hi helpExample        guifg=#93a1a1 guibg=bg gui=NONE
    hi helpHyperTextEntry guifg=#719E07 guibg=bg gui=NONE
    hi helpHyperTextJump  guifg=#268bd2 guibg=bg gui=NONE
    hi helpNote           guifg=#d33682 guibg=bg gui=NONE
    hi helpOption         guifg=#2aa198 guibg=bg gui=NONE
    hi helpVim            guifg=#d33682 guibg=bg gui=NONE
    hi vimCmdSep          guifg=#268bd2 guibg=bg gui=NONE,bold
    hi vimCommand         guifg=#b58900 guibg=bg gui=NONE
    hi vimGroup           guifg=#268bd2 guibg=bg gui=NONE,bold
    hi vimHiGroup         guifg=#268bd2 guibg=bg gui=NONE
    hi vimHiLink          guifg=#268bd2 guibg=bg gui=NONE
    hi vimIsCommand       guifg=#b58920 guibg=bg gui=NONE
    hi vimSynMtchOpt      guifg=#b58900 guibg=bg gui=NONE
    hi vimSynType         guifg=#2aa198 guibg=bg gui=NONE
    hi vimFunction        guifg=#C2BA00 guibg=bg gui=NONE

    hi! link helpSpecial      Special
    hi! link vimCommentString Comment
    hi! link vimFunc          Function
    hi! link vimSet           PreProc
    hi! link vimSetEqual      Normal
    hi! link vimUserFunc      Function
    hi! link vimVar           Identifier
    "}}}
endif "}}}

if get(g:, "solarized_term_italics", 0) "{{{
    hi Comment                  gui=italic
    hi gitcommitComment         gui=italic
    hi htmlSpecialTagName       gui=italic
    hi pandocComment            gui=italic
    hi pandocEmphasisDefinition gui=italic
    hi pandocEmphasisTable      gui=italic
    hi pandocEmphasis           gui=italic
endif "}}}

if has('nvim') "{{{
    hi TermCursorNC guifg=#00313D guibg=#586e75 gui=NONE
    hi! link TermCursor Cursor

    let g:terminal_color_0  = '#083C4A'
    let g:terminal_color_1  = '#dc322f'
    let g:terminal_color_2  = '#719E07'
    let g:terminal_color_3  = '#b58900'
    let g:terminal_color_4  = '#268bd2'
    let g:terminal_color_5  = '#d33682'
    let g:terminal_color_6  = '#2aa198'
    let g:terminal_color_7  = '#eee8d5'
    let g:terminal_color_8  = '#00313D'
    let g:terminal_color_9  = '#cb4b16'
    let g:terminal_color_10 = '#586e75'
    let g:terminal_color_11 = '#6F8790'
    let g:terminal_color_12 = '#839496'
    let g:terminal_color_13 = '#6c71c4'
    let g:terminal_color_14 = '#93a1a1'
    let g:terminal_color_15 = '#fdf6e3'
endif "}}}

if exists('*AirlineRefresh') "{{{
    AirlineRefresh | AirlineRefresh
endif "}}}

" vim: set ts=4 sw=4 tw=79 fdm=marker et :
