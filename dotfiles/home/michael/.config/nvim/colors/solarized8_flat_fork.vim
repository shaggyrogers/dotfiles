" Name:         Solarized 8 Flat Forked
" Description:  Precision colors for machines and people
" Author:       Ethan Schoonover
" Source:       https://github.com/lifepillar/vim-solarized8
" License:      OSI approved MIT license

if !(has('termguicolors') && &termguicolors) && !has('gui_running')
      \ && (!exists('&t_Co') || &t_Co < (get(g:, 'solarized_use16', 0) ? 16 : 256))
  echoerr '[Solarized 8 Flat] There are not enough colors.'
  finish
endif

hi clear
if exists('syntax_on')
  syntax reset
endif

let g:colors_name = 'solarized8_flat_fork'

" 256-color variant
if &background ==# 'dark'
  if !has('gui_running') && get(g:, 'solarized_termtrans', 0)
    hi Normal ctermfg=246 ctermbg=NONE guifg=#839496 guibg=NONE guisp=NONE cterm=NONE gui=NONE
    hi Terminal ctermfg=fg ctermbg=NONE guifg=fg guibg=NONE guisp=NONE cterm=NONE gui=NONE
    hi ColorColumn ctermfg=NONE ctermbg=236 guifg=NONE guibg=NONE guisp=NONE cterm=NONE gui=NONE
  else
    hi Normal ctermfg=246 ctermbg=235 guifg=#839496 guibg=#00313D guisp=NONE cterm=NONE gui=NONE
    hi Terminal ctermfg=fg ctermbg=235 guifg=fg guibg=#00313D guisp=NONE cterm=NONE gui=NONE
    hi ColorColumn ctermfg=NONE ctermbg=236 guifg=NONE guibg=#083C4A guisp=NONE cterm=NONE gui=NONE
  endif

  hi Conceal ctermfg=32 ctermbg=NONE guifg=#268bd2 guibg=NONE guisp=NONE cterm=NONE gui=NONE

  if get(g:, 'solarized_old_cursor_style', 0)
    hi Cursor ctermfg=235 ctermbg=246 guifg=#00313D guibg=#839496 guisp=NONE cterm=NONE gui=NONE
  else
    hi Cursor ctermfg=230 ctermbg=32 guifg=#fdf6e3 guibg=#268bd2 guisp=NONE cterm=NONE gui=NONE
  endif

  if !has('gui_running') && get(g:, 'solarized_termtrans', 0)
    hi CursorColumn ctermfg=NONE ctermbg=236 guifg=NONE guibg=NONE guisp=NONE cterm=NONE gui=NONE
    hi CursorLine ctermfg=NONE ctermbg=235 guifg=NONE guibg=NONE guisp=#586e75 cterm=NONE,underline gui=NONE,underline
  else
    hi CursorColumn ctermfg=NONE ctermbg=236 guifg=NONE guibg=#083C4A guisp=NONE cterm=NONE gui=NONE
    hi CursorLine ctermfg=NONE ctermbg=235 guifg=NONE guibg=#00313D guisp=#586e75 cterm=NONE,underline gui=NONE,underline
  endif

  if get(g:, "solarized_visibility", "") == "high"
    if !has('gui_running') && get(g:, 'solarized_termtrans', 0)
        hi CursorLineNr ctermfg=166 ctermbg=NONE guifg=#cb4b16 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold,underline
    else
        hi CursorLineNr ctermfg=166 ctermbg=NONE guifg=#cb4b16 guibg=#002D38 guisp=NONE cterm=NONE,bold gui=NONE,bold,underline
    endif

    hi NonText ctermfg=166 ctermbg=NONE guifg=#cb4b16 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
    hi SpecialKey ctermfg=166 ctermbg=NONE guifg=#cb4b16 guibg=NONE guisp=NONE cterm=NONE,reverse gui=NONE,reverse
    hi SpellBad ctermfg=61 ctermbg=254 guifg=#6c71c4 guibg=NONE guisp=#dc322f cterm=NONE,reverse,underline gui=NONE,reverse,undercurl
    hi SpellCap ctermfg=61 ctermbg=254 guifg=#6c71c4 guibg=NONE guisp=#dc322f cterm=NONE,reverse,underline gui=NONE,reverse,undercurl
    hi SpellLocal ctermfg=136 ctermbg=254 guifg=#b58900 guibg=NONE guisp=#dc322f cterm=NONE,reverse,underline gui=NONE,reverse,undercurl
    hi SpellRare ctermfg=37 ctermbg=254 guifg=#2aa198 guibg=NONE guisp=#dc322f cterm=NONE,reverse,underline gui=NONE,reverse,undercurl
    hi Title ctermfg=136 ctermbg=NONE guifg=#b58900 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold

  elseif get(g:, "solarized_visibility", "") == "low"

    if !has('gui_running') && get(g:, 'solarized_termtrans', 0)
      hi CursorLineNr ctermfg=242 ctermbg=NONE guifg=#586e75 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold,underline
    else
      hi CursorLineNr ctermfg=242 ctermbg=NONE guifg=#586e75 guibg=#002D38 guisp=NONE cterm=NONE,bold gui=NONE,bold,underline
    endif

    hi NonText ctermfg=236 ctermbg=NONE guifg=#083C4A guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
    hi SpecialKey ctermfg=236 ctermbg=NONE guifg=#083C4A guibg=NONE guisp=NONE cterm=NONE,reverse gui=NONE,reverse
    hi SpellBad ctermfg=61 ctermbg=NONE guifg=#6c71c4 guibg=NONE guisp=#6c71c4 cterm=NONE,undercurl gui=NONE,undercurl
    hi SpellCap ctermfg=61 ctermbg=NONE guifg=#6c71c4 guibg=NONE guisp=#6c71c4 cterm=NONE,underline gui=NONE,undercurl
    hi SpellLocal ctermfg=136 ctermbg=NONE guifg=#b58900 guibg=NONE guisp=#b58900 cterm=NONE,underline gui=NONE,undercurl
    hi SpellRare ctermfg=37 ctermbg=NONE guifg=#2aa198 guibg=NONE guisp=#2aa198 cterm=NONE,underline gui=NONE,undercurl
    hi Title ctermfg=242 ctermbg=NONE guifg=#586e75 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
  else

    if !has('gui_running') && get(g:, 'solarized_termtrans', 0)
        hi CursorLineNr ctermfg=246 ctermbg=NONE guifg=#839496 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold,underline
    else
        hi CursorLineNr ctermfg=246 ctermbg=NONE guifg=#839496 guibg=#002D38 guisp=NONE cterm=NONE,bold gui=NONE,bold,underline
    endif

    hi NonText ctermfg=66 ctermbg=NONE guifg=#6F8790 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
    hi SpecialKey ctermfg=66 ctermbg=236 guifg=#6F8790 guibg=#083C4A guisp=NONE cterm=NONE,bold gui=NONE,bold
    hi SpellBad ctermfg=61 ctermbg=NONE guifg=#6c71c4 guibg=NONE guisp=#6c71c4 cterm=NONE,underline gui=NONE,undercurl
    hi SpellCap ctermfg=61 ctermbg=NONE guifg=#6c71c4 guibg=NONE guisp=#6c71c4 cterm=NONE,underline gui=NONE,undercurl
    hi SpellLocal ctermfg=136 ctermbg=NONE guifg=#b58900 guibg=NONE guisp=#b58900 cterm=NONE,underline gui=NONE,undercurl
    hi SpellRare ctermfg=37 ctermbg=NONE guifg=#2aa198 guibg=NONE guisp=#2aa198 cterm=NONE,underline gui=NONE,undercurl
    hi Title ctermfg=136 ctermbg=NONE guifg=#b58900 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
  endif
  if get(g:, "solarized_diffmode", "") == "high"
    hi DiffAdd ctermfg=106 ctermbg=NONE guifg=#719E07 guibg=NONE guisp=NONE cterm=NONE,reverse gui=NONE,reverse
    hi DiffChange ctermfg=136 ctermbg=NONE guifg=#b58900 guibg=NONE guisp=NONE cterm=NONE,reverse gui=NONE,reverse
    hi DiffDelete ctermfg=160 ctermbg=NONE guifg=#dc322f guibg=NONE guisp=NONE cterm=NONE,reverse gui=NONE,reverse
    hi DiffText ctermfg=32 ctermbg=NONE guifg=#268bd2 guibg=NONE guisp=NONE cterm=NONE,reverse gui=NONE,reverse
  elseif get(g:, "solarized_diffmode", "") == "low"
    hi DiffAdd ctermfg=106 ctermbg=NONE guifg=#719E07 guibg=NONE guisp=#719E07 cterm=NONE gui=NONE
    hi DiffChange ctermfg=136 ctermbg=NONE guifg=#b58900 guibg=NONE guisp=#b58900 cterm=NONE gui=NONE
    hi DiffDelete ctermfg=160 ctermbg=NONE guifg=#dc322f guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
    hi DiffText ctermfg=32 ctermbg=NONE guifg=#268bd2 guibg=NONE guisp=#268bd2 cterm=NONE gui=NONE
  else
    hi DiffAdd ctermfg=106 ctermbg=236 guifg=#719E07 guibg=#083C4A guisp=#719E07 cterm=NONE gui=NONE
    hi DiffChange ctermfg=136 ctermbg=236 guifg=#b58900 guibg=#083C4A guisp=#b58900 cterm=NONE gui=NONE
    hi DiffDelete ctermfg=160 ctermbg=236 guifg=#dc322f guibg=#083C4A guisp=NONE cterm=NONE,bold gui=NONE,bold
    hi DiffText ctermfg=32 ctermbg=236 guifg=#268bd2 guibg=#083C4A guisp=#268bd2 cterm=NONE gui=NONE
  endif
  hi Directory ctermfg=32 ctermbg=NONE guifg=#268bd2 guibg=NONE guisp=NONE cterm=NONE gui=NONE
  hi EndOfBuffer ctermfg=NONE ctermbg=NONE guifg=NONE guibg=NONE guisp=NONE cterm=NONE gui=NONE
  hi ErrorMsg ctermfg=160 ctermbg=230 guifg=#dc322f guibg=#fdf6e3 guisp=NONE cterm=NONE,reverse gui=NONE,reverse
  hi FoldColumn ctermfg=246 ctermbg=NONE guifg=#839496 guibg=NONE guisp=NONE cterm=NONE gui=NONE
  hi Folded ctermfg=246 ctermbg=NONE guifg=#839496 guibg=NONE guisp=#00313D cterm=NONE,bold gui=NONE,bold
  hi IncSearch ctermfg=166 ctermbg=NONE guifg=#cb4b16 guibg=NONE guisp=NONE cterm=NONE,standout gui=NONE,standout

  if !has('gui_running') && get(g:, 'solarized_termtrans', 0)
      hi LineNr ctermfg=242 ctermbg=NONE guifg=#586e75 guibg=NONE guisp=NONE cterm=NONE gui=NONE
    else
      hi LineNr ctermfg=242 ctermbg=NONE guifg=#586e75 guibg=#002D38 guisp=NONE cterm=NONE gui=NONE
  endif

  hi MatchParen ctermfg=230 ctermbg=236 guifg=#fdf6e3 guibg=#083C4A guisp=NONE cterm=NONE,bold gui=NONE,bold
  hi ModeMsg ctermfg=32 ctermbg=NONE guifg=#268bd2 guibg=NONE guisp=NONE cterm=NONE gui=NONE
  hi MoreMsg ctermfg=32 ctermbg=NONE guifg=#268bd2 guibg=NONE guisp=NONE cterm=NONE gui=NONE
  hi Pmenu ctermfg=236 ctermbg=246 guifg=#083C4A guibg=#839496 guisp=NONE cterm=NONE,reverse gui=NONE,reverse
  hi PmenuSbar ctermfg=236 ctermbg=242 guifg=#083C4A guibg=#586e75 guisp=NONE cterm=NONE,reverse gui=NONE,reverse
  hi PmenuSel ctermfg=66 ctermbg=254 guifg=#6F8790 guibg=#eee8d5 guisp=NONE cterm=NONE,reverse gui=NONE,reverse
  hi PmenuThumb ctermfg=242 ctermbg=235 guifg=#586e75 guibg=#00313D guisp=NONE cterm=NONE,reverse gui=NONE,reverse
  hi Question ctermfg=37 ctermbg=NONE guifg=#2aa198 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
  hi! link QuickFixLine Search
  hi Search ctermfg=136 ctermbg=NONE guifg=#b58900 guibg=NONE guisp=NONE cterm=NONE,reverse gui=NONE,reverse

  if !has('gui_running') && get(g:, 'solarized_termtrans', 0)
    hi SignColumn ctermfg=246 ctermbg=NONE guifg=#839496 guibg=NONE guisp=NONE cterm=NONE gui=NONE
  else
    hi SignColumn ctermfg=246 ctermbg=NONE guifg=#839496 guibg=#002D38 guisp=NONE cterm=NONE gui=NONE
  endif

  " May cause side effects - changes the airline color below vertical split and wild menu
  hi StatusLineNC guifg=#ffffff guibg=#444444 gui=NONE
  hi StatusLine guifg=#afd787 guibg=#444444 gui=NONE
  hi TabLineSel ctermfg=254 ctermbg=236 guifg=#eee8d5 guibg=#083C4A guisp=NONE cterm=NONE gui=NONE
  hi TabLineFill ctermfg=242 ctermbg=236 guifg=#586e75 guibg=#083C4A guisp=NONE cterm=NONE gui=NONE
  hi InsertMode ctermfg=236 ctermbg=37 guifg=#083C4A guibg=#2aa198 guisp=NONE cterm=NONE,bold,reverse gui=NONE,bold,reverse
  hi ReplaceMode ctermfg=236 ctermbg=166 guifg=#083C4A guibg=#cb4b16 guisp=NONE cterm=NONE,bold,reverse gui=NONE,bold,reverse
  hi VisualMode ctermfg=236 ctermbg=162 guifg=#083C4A guibg=#d33682 guisp=NONE cterm=NONE,bold,reverse gui=NONE,bold,reverse
  hi CommandMode ctermfg=236 ctermbg=162 guifg=#083C4A guibg=#d33682 guisp=NONE cterm=NONE,bold,reverse gui=NONE,bold,reverse
  hi! link StatusLineTerm StatusLine
  hi! link StatusLineTermNC StatusLineNC

  hi VertSplit ctermfg=236 ctermbg=236 guifg=#444444 guibg=#444444 guisp=NONE cterm=NONE gui=NONE

  hi Visual ctermfg=242 ctermbg=235 guifg=#586e75 guibg=#00313D guisp=NONE cterm=NONE,reverse gui=NONE,reverse
  hi VisualNOS ctermfg=NONE ctermbg=236 guifg=NONE guibg=#083C4A guisp=NONE cterm=NONE,reverse gui=NONE,reverse
  hi WarningMsg ctermfg=166 ctermbg=NONE guifg=#cb4b16 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
  hi WildMenu ctermfg=66 ctermbg=254 guifg=#6F8790 guibg=#eee8d5 guisp=NONE cterm=NONE,reverse gui=NONE,reverse
  hi! link Boolean Constant
  hi! link Character Constant
  hi Comment ctermfg=242 ctermbg=NONE guifg=#586e75 guibg=NONE guisp=NONE cterm=NONE gui=NONE,italic
  hi! link Conditional Statement
  hi Constant ctermfg=37 ctermbg=NONE guifg=#2aa198 guibg=NONE guisp=NONE cterm=NONE gui=NONE
  hi! link Define PreProc
  hi! link Debug Special
  hi! link Delimiter Special
  hi Error ctermfg=160 ctermbg=NONE guifg=#dc322f guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
  hi! link Exception Statement
  hi! link Float Constant
  hi! link Function Identifier
  hi Identifier ctermfg=32 ctermbg=NONE guifg=#268bd2 guibg=NONE guisp=NONE cterm=NONE gui=NONE
  hi Ignore ctermfg=NONE ctermbg=NONE guifg=NONE guibg=NONE guisp=NONE cterm=NONE gui=NONE
  hi! link Include PreProc
  hi! link Keyword Statement
  hi! link Label Statement
  hi! link Macro PreProc
  hi! link Number Constant
  hi! link Operator Statement
  hi! link PreCondit PreProc
  if get(g:, 'solarized_use_bolditalic_syntax', 0)
    hi PreProc ctermfg=166 ctermbg=NONE guifg=#cb4b16 guibg=NONE guisp=NONE cterm=NONE gui=NONE,italic
    hi Statement ctermfg=106 ctermbg=NONE guifg=#719E07 guibg=NONE guisp=NONE cterm=NONE gui=NONE,bold,italic
  else
    hi PreProc ctermfg=166 ctermbg=NONE guifg=#cb4b16 guibg=NONE guisp=NONE cterm=NONE gui=NONE
    hi Statement ctermfg=106 ctermbg=NONE guifg=#719E07 guibg=NONE guisp=NONE cterm=NONE gui=NONE
  endif
  hi! link Repeat Statement
  hi Special ctermfg=166 ctermbg=NONE guifg=#cb4b16 guibg=NONE guisp=NONE cterm=NONE gui=NONE
  hi! link SpecialChar Special
  hi! link SpecialComment Special
  hi! link StorageClass Type
  hi! link String Constant
  hi! link Structure Type
  hi! link Tag Special
  hi Todo ctermfg=162 ctermbg=NONE guifg=#d33682 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
  hi Type ctermfg=136 ctermbg=NONE guifg=#b58900 guibg=NONE guisp=NONE cterm=NONE gui=NONE
  hi! link Typedef Type
  hi Underlined ctermfg=61 ctermbg=NONE guifg=#6c71c4 guibg=NONE guisp=NONE cterm=NONE gui=NONE
  hi! link lCursor Cursor
  hi ToolbarLine ctermfg=NONE ctermbg=236 guifg=NONE guibg=#083C4A guisp=NONE cterm=NONE gui=NONE
  hi ToolbarButton ctermfg=247 ctermbg=236 guifg=#93a1a1 guibg=#083C4A guisp=NONE cterm=NONE,bold gui=NONE,bold
  if get(g:, 'solarized_extra_hi_groups', 0)
    hi! link vimVar Identifier
    hi! link vimFunc Function
    hi! link vimUserFunc Function
    hi! link helpSpecial Special
    hi! link vimSet Normal
    hi! link vimSetEqual Normal

    " IndentGuides
    if !has('gui_running') && get(g:, 'solarized_termtrans', 0)
      hi IndentGuidesOdd  ctermfg=242 ctermbg=0 guifg=NONE guibg=#004052
      hi IndentGuidesEven ctermfg=242 ctermbg=0 guifg=NONE guibg=#004D61
    else
      hi IndentGuidesOdd  ctermfg=242 ctermbg=0 guifg=#003947 guibg=#003B4B
      hi IndentGuidesEven ctermfg=242 ctermbg=0 guifg=#80C5C7 guibg=#004557
    endif

    " ALE
    if !has('gui_running') && get(g:, 'solarized_termtrans', 0)
      hi Error ctermfg=160 ctermbg=NONE guifg=#dc322f guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
      hi Warning ctermfg=NONE ctermbg=NONE guifg=#FFEB3B guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE
      hi Info ctermfg=NONE ctermbg=NONE guifg=#007BDD guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE
    else
      hi Error ctermfg=160 ctermbg=NONE guifg=#dc322f guibg=#002D38 guisp=NONE cterm=NONE,bold gui=NONE,bold
      hi Warning ctermfg=NONE ctermbg=NONE guifg=#FFEB3B guibg=#002D38 guisp=NONE cterm=NONE,bold gui=NONE
      hi Info ctermfg=NONE ctermbg=NONE guifg=#007BDD guibg=#002D38 guisp=NONE cterm=NONE,bold gui=NONE
    endif

    hi! link ALEErrorSign Error
    hi! link ALEWarningSign Warning
    hi! link ALEInfoSign Info

    " NERDTree
    hi! link NERDTreeOpenable Type
    hi! link NERDTreeClosable Type
    hi! link NERDTreeBookmark Constant

    hi vimCommentString ctermfg=61 ctermbg=NONE guifg=#6c71c4 guibg=NONE guisp=NONE cterm=NONE gui=NONE
    hi vimCommand ctermfg=136 ctermbg=NONE guifg=#b58900 guibg=NONE guisp=NONE cterm=NONE gui=NONE
    hi vimCmdSep ctermfg=32 ctermbg=NONE guifg=#268bd2 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
    hi helpExample ctermfg=247 ctermbg=NONE guifg=#93a1a1 guibg=NONE guisp=NONE cterm=NONE gui=NONE
    hi helpOption ctermfg=37 ctermbg=NONE guifg=#2aa198 guibg=NONE guisp=NONE cterm=NONE gui=NONE
    hi helpNote ctermfg=162 ctermbg=NONE guifg=#d33682 guibg=NONE guisp=NONE cterm=NONE gui=NONE
    hi helpVim ctermfg=162 ctermbg=NONE guifg=#d33682 guibg=NONE guisp=NONE cterm=NONE gui=NONE
    hi helpHyperTextJump ctermfg=32 ctermbg=NONE guifg=#268bd2 guibg=NONE guisp=NONE cterm=NONE gui=NONE
    hi helpHyperTextEntry ctermfg=106 ctermbg=NONE guifg=#719E07 guibg=NONE guisp=NONE cterm=NONE gui=NONE
    hi vimIsCommand ctermfg=66 ctermbg=NONE guifg=#6F8790 guibg=NONE guisp=NONE cterm=NONE gui=NONE
    hi vimSynMtchOpt ctermfg=136 ctermbg=NONE guifg=#b58900 guibg=NONE guisp=NONE cterm=NONE gui=NONE
    hi vimSynType ctermfg=37 ctermbg=NONE guifg=#2aa198 guibg=NONE guisp=NONE cterm=NONE gui=NONE
    hi vimHiLink ctermfg=32 ctermbg=NONE guifg=#268bd2 guibg=NONE guisp=NONE cterm=NONE gui=NONE
    hi vimHiGroup ctermfg=32 ctermbg=NONE guifg=#268bd2 guibg=NONE guisp=NONE cterm=NONE gui=NONE
    hi vimGroup ctermfg=32 ctermbg=NONE guifg=#268bd2 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold

    hi! link diffAdded Statement
    hi! link diffLine Identifier
    hi gitcommitComment ctermfg=242 ctermbg=NONE guifg=#586e75 guibg=NONE guisp=NONE cterm=NONE gui=NONE,italic
    hi! link gitcommitUntracked gitcommitComment
    hi! link gitcommitDiscarded gitcommitComment
    hi! link gitcommitSelected gitcommitComment
    hi gitcommitUnmerged ctermfg=106 ctermbg=NONE guifg=#719E07 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
    hi gitcommitOnBranch ctermfg=242 ctermbg=NONE guifg=#586e75 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
    hi gitcommitBranch ctermfg=162 ctermbg=NONE guifg=#d33682 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
    hi! link gitcommitNoBranch gitcommitBranch
    hi gitcommitdiscardedtype ctermfg=160 ctermbg=NONE guifg=#dc322f guibg=NONE guisp=NONE cterm=NONE gui=NONE
    hi gitcommitselectedtype ctermfg=106 ctermbg=NONE guifg=#719E07 guibg=NONE guisp=NONE cterm=NONE gui=NONE
    hi gitcommitHeader ctermfg=242 ctermbg=NONE guifg=#586e75 guibg=NONE guisp=NONE cterm=NONE gui=NONE
    hi gitcommitUntrackedFile ctermfg=37 ctermbg=NONE guifg=#2aa198 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
    hi gitcommitDiscardedFile ctermfg=160 ctermbg=NONE guifg=#dc322f guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
    hi gitcommitSelectedFile ctermfg=106 ctermbg=NONE guifg=#719E07 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
    hi gitcommitUnmergedFile ctermfg=136 ctermbg=NONE guifg=#b58900 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
    hi gitcommitFile ctermfg=246 ctermbg=NONE guifg=#839496 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
    hi! link gitcommitDiscardedArrow gitcommitDiscardedFile
    hi! link gitcommitSelectedArrow gitcommitSelectedFile
    hi! link gitcommitUnmergedArrow gitcommitUnmergedFile
    hi htmlTag ctermfg=242 ctermbg=NONE guifg=#586e75 guibg=NONE guisp=NONE cterm=NONE gui=NONE
    hi htmlEndTag ctermfg=242 ctermbg=NONE guifg=#586e75 guibg=NONE guisp=NONE cterm=NONE gui=NONE
    hi htmlTagN ctermfg=247 ctermbg=NONE guifg=#93a1a1 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
    hi htmlTagName ctermfg=32 ctermbg=NONE guifg=#268bd2 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
    hi htmlSpecialTagName ctermfg=32 ctermbg=NONE guifg=#268bd2 guibg=NONE guisp=NONE cterm=NONE gui=NONE,italic
    hi htmlArg ctermfg=66 ctermbg=NONE guifg=#6F8790 guibg=NONE guisp=NONE cterm=NONE gui=NONE
    hi javaScript ctermfg=136 ctermbg=NONE guifg=#b58900 guibg=NONE guisp=NONE cterm=NONE gui=NONE

    " hi perlHereDoc ctermfg=247 ctermbg=235 guifg=#93a1a1 guibg=#00313D guisp=NONE cterm=NONE gui=NONE
    " hi perlVarPlain ctermfg=136 ctermbg=235 guifg=#b58900 guibg=#00313D guisp=NONE cterm=NONE gui=NONE
    " hi perlStatementFileDesc ctermfg=37 ctermbg=235 guifg=#2aa198 guibg=#00313D guisp=NONE cterm=NONE gui=NONE
    " hi texstatement ctermfg=37 ctermbg=235 guifg=#2aa198 guibg=#00313D guisp=NONE cterm=NONE gui=NONE
    " hi texmathzonex ctermfg=136 ctermbg=235 guifg=#b58900 guibg=#00313D guisp=NONE cterm=NONE gui=NONE
    " hi texmathmatcher ctermfg=136 ctermbg=235 guifg=#b58900 guibg=#00313D guisp=NONE cterm=NONE gui=NONE
    " hi texreflabel ctermfg=136 ctermbg=235 guifg=#b58900 guibg=#00313D guisp=NONE cterm=NONE gui=NONE
    " hi rubyDefine ctermfg=247 ctermbg=235 guifg=#93a1a1 guibg=#00313D guisp=NONE cterm=NONE,bold gui=NONE,bold
    " hi! link rubySymbol Type
    " hi rubyBoolean ctermfg=162 ctermbg=235 guifg=#d33682 guibg=#00313D guisp=NONE cterm=NONE gui=NONE

    let hs_highlight_boolean=1
    let hs_highlight_delimiters=1
    hi cPreCondit ctermfg=166 ctermbg=NONE guifg=#cb4b16 guibg=NONE guisp=NONE cterm=NONE gui=NONE
    hi VarId ctermfg=32 ctermbg=NONE guifg=#268bd2 guibg=NONE guisp=NONE cterm=NONE gui=NONE
    hi ConId ctermfg=136 ctermbg=NONE guifg=#b58900 guibg=NONE guisp=NONE cterm=NONE gui=NONE
    hi hsImport ctermfg=162 ctermbg=NONE guifg=#d33682 guibg=NONE guisp=NONE cterm=NONE gui=NONE
    hi hsString ctermfg=66 ctermbg=NONE guifg=#6F8790 guibg=NONE guisp=NONE cterm=NONE gui=NONE
    hi hsStructure ctermfg=37 ctermbg=NONE guifg=#2aa198 guibg=NONE guisp=NONE cterm=NONE gui=NONE
    hi hs_hlFunctionName ctermfg=32 ctermbg=NONE guifg=#268bd2 guibg=NONE guisp=NONE cterm=NONE gui=NONE
    hi hsStatement ctermfg=37 ctermbg=NONE guifg=#2aa198 guibg=NONE guisp=NONE cterm=NONE gui=NONE
    hi hsImportLabel ctermfg=37 ctermbg=NONE guifg=#2aa198 guibg=NONE guisp=NONE cterm=NONE gui=NONE
    hi hs_OpFunctionName ctermfg=136 ctermbg=NONE guifg=#b58900 guibg=NONE guisp=NONE cterm=NONE gui=NONE
    hi hs_DeclareFunction ctermfg=166 ctermbg=NONE guifg=#cb4b16 guibg=NONE guisp=NONE cterm=NONE gui=NONE
    hi hsVarSym ctermfg=37 ctermbg=NONE guifg=#2aa198 guibg=NONE guisp=NONE cterm=NONE gui=NONE
    hi hsType ctermfg=136 ctermbg=NONE guifg=#b58900 guibg=NONE guisp=NONE cterm=NONE gui=NONE
    hi hsTypedef ctermfg=37 ctermbg=NONE guifg=#2aa198 guibg=NONE guisp=NONE cterm=NONE gui=NONE
    hi hsModuleName ctermfg=106 ctermbg=NONE guifg=#719E07 guibg=NONE guisp=NONE cterm=NONE gui=NONE
    hi! link hsImportParams Delimiter
    hi! link hsDelimTypeExport Delimiter
    hi! link hsModuleStartLabel hsStructure
    hi! link hsModuleWhereLabel hsModuleStartLabel
    hi hsNiceOperator ctermfg=37 ctermbg=NONE guifg=#2aa198 guibg=NONE guisp=NONE cterm=NONE gui=NONE
    hi hsniceoperator ctermfg=37 ctermbg=NONE guifg=#2aa198 guibg=NONE guisp=NONE cterm=NONE gui=NONE

   " hi pandocTitleBlock ctermfg=32 ctermbg=NONE guifg=#268bd2 guibg=NONE guisp=NONE cterm=NONE gui=NONE
   " hi pandocTitleBlockTitle ctermfg=32 ctermbg=NONE guifg=#268bd2 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
   " hi pandocTitleComment ctermfg=32 ctermbg=NONE guifg=#268bd2 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
   " hi pandocComment ctermfg=242 ctermbg=NONE guifg=#586e75 guibg=NONE guisp=NONE cterm=NONE gui=NONE,italic
   " hi pandocVerbatimBlock ctermfg=136 ctermbg=NONE guifg=#b58900 guibg=NONE guisp=NONE cterm=NONE gui=NONE
   " hi! link pandocVerbatimBlockDeep pandocVerbatimBlock
   " hi! link pandocCodeBlock pandocVerbatimBlock
   " hi! link pandocCodeBlockDelim pandocVerbatimBlock
   " hi pandocBlockQuote ctermfg=32 ctermbg=NONE guifg=#268bd2 guibg=NONE guisp=NONE cterm=NONE gui=NONE
   " hi pandocBlockQuoteLeader1 ctermfg=32 ctermbg=NONE guifg=#268bd2 guibg=NONE guisp=NONE cterm=NONE gui=NONE
   " hi pandocBlockQuoteLeader2 ctermfg=37 ctermbg=NONE guifg=#2aa198 guibg=NONE guisp=NONE cterm=NONE gui=NONE
   " hi pandocBlockQuoteLeader3 ctermfg=136 ctermbg=NONE guifg=#b58900 guibg=NONE guisp=NONE cterm=NONE gui=NONE
   " hi pandocBlockQuoteLeader4 ctermfg=160 ctermbg=NONE guifg=#dc322f guibg=NONE guisp=NONE cterm=NONE gui=NONE
   " hi pandocBlockQuoteLeader5 ctermfg=246 ctermbg=NONE guifg=#839496 guibg=NONE guisp=NONE cterm=NONE gui=NONE
   " hi pandocBlockQuoteLeader6 ctermfg=242 ctermbg=NONE guifg=#586e75 guibg=NONE guisp=NONE cterm=NONE gui=NONE
   " hi pandocListMarker ctermfg=162 ctermbg=NONE guifg=#d33682 guibg=NONE guisp=NONE cterm=NONE gui=NONE
   " hi pandocListReference ctermfg=162 ctermbg=NONE guifg=#d33682 guibg=NONE guisp=NONE cterm=NONE gui=NONE
   " hi pandocDefinitionBlock ctermfg=61 ctermbg=NONE guifg=#6c71c4 guibg=NONE guisp=NONE cterm=NONE gui=NONE
   " hi pandocDefinitionTerm ctermfg=61 ctermbg=NONE guifg=#6c71c4 guibg=NONE guisp=NONE cterm=NONE,standout gui=NONE,standout
   " hi pandocDefinitionIndctr ctermfg=61 ctermbg=NONE guifg=#6c71c4 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
   " hi pandocEmphasisDefinition ctermfg=61 ctermbg=NONE guifg=#6c71c4 guibg=NONE guisp=NONE cterm=NONE gui=NONE,italic
   " hi pandocEmphasisNestedDefinition ctermfg=61 ctermbg=NONE guifg=#6c71c4 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
   " hi pandocStrongEmphasisDefinition ctermfg=61 ctermbg=NONE guifg=#6c71c4 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
   " hi pandocStrongEmphasisNestedDefinition ctermfg=61 ctermbg=NONE guifg=#6c71c4 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
   " hi pandocStrongEmphasisEmphasisDefinition ctermfg=61 ctermbg=NONE guifg=#6c71c4 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
   " hi pandocStrikeoutDefinition ctermfg=61 ctermbg=NONE guifg=#6c71c4 guibg=NONE guisp=NONE cterm=NONE,reverse gui=NONE,reverse
   " hi pandocVerbatimInlineDefinition ctermfg=61 ctermbg=NONE guifg=#6c71c4 guibg=NONE guisp=NONE cterm=NONE gui=NONE
   " hi pandocSuperscriptDefinition ctermfg=61 ctermbg=NONE guifg=#6c71c4 guibg=NONE guisp=NONE cterm=NONE gui=NONE
   " hi pandocSubscriptDefinition ctermfg=61 ctermbg=NONE guifg=#6c71c4 guibg=NONE guisp=NONE cterm=NONE gui=NONE
   " hi pandocTable ctermfg=32 ctermbg=NONE guifg=#268bd2 guibg=NONE guisp=NONE cterm=NONE gui=NONE
   " hi pandocTableStructure ctermfg=32 ctermbg=NONE guifg=#268bd2 guibg=NONE guisp=NONE cterm=NONE gui=NONE
   " hi! link pandocTableStructureTop pandocTableStructre
   " hi! link pandocTableStructureEnd pandocTableStructre
   " hi pandocTableZebraLight ctermfg=32 ctermbg=235 guifg=#268bd2 guibg=#00313D guisp=NONE cterm=NONE gui=NONE
   " hi pandocTableZebraDark ctermfg=32 ctermbg=236 guifg=#268bd2 guibg=#083C4A guisp=NONE cterm=NONE gui=NONE
   " hi pandocEmphasisTable ctermfg=32 ctermbg=NONE guifg=#268bd2 guibg=NONE guisp=NONE cterm=NONE gui=NONE,italic
   " hi pandocEmphasisNestedTable ctermfg=32 ctermbg=NONE guifg=#268bd2 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
   " hi pandocStrongEmphasisTable ctermfg=32 ctermbg=NONE guifg=#268bd2 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
   " hi pandocStrongEmphasisNestedTable ctermfg=32 ctermbg=NONE guifg=#268bd2 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
   " hi pandocStrongEmphasisEmphasisTable ctermfg=32 ctermbg=NONE guifg=#268bd2 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
   " hi pandocStrikeoutTable ctermfg=32 ctermbg=NONE guifg=#268bd2 guibg=NONE guisp=NONE cterm=NONE,reverse gui=NONE,reverse
   " hi pandocVerbatimInlineTable ctermfg=32 ctermbg=NONE guifg=#268bd2 guibg=NONE guisp=NONE cterm=NONE gui=NONE
   " hi pandocSuperscriptTable ctermfg=32 ctermbg=NONE guifg=#268bd2 guibg=NONE guisp=NONE cterm=NONE gui=NONE
   " hi pandocSubscriptTable ctermfg=32 ctermbg=NONE guifg=#268bd2 guibg=NONE guisp=NONE cterm=NONE gui=NONE
   " hi pandocHeading ctermfg=166 ctermbg=NONE guifg=#cb4b16 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
   " hi pandocHeadingMarker ctermfg=166 ctermbg=NONE guifg=#cb4b16 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
   " hi pandocEmphasisHeading ctermfg=166 ctermbg=NONE guifg=#cb4b16 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
   " hi pandocEmphasisNestedHeading ctermfg=166 ctermbg=NONE guifg=#cb4b16 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
   " hi pandocStrongEmphasisHeading ctermfg=166 ctermbg=NONE guifg=#cb4b16 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
   " hi pandocStrongEmphasisNestedHeading ctermfg=166 ctermbg=NONE guifg=#cb4b16 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
   " hi pandocStrongEmphasisEmphasisHeading ctermfg=166 ctermbg=NONE guifg=#cb4b16 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
   " hi pandocStrikeoutHeading ctermfg=166 ctermbg=NONE guifg=#cb4b16 guibg=NONE guisp=NONE cterm=NONE,reverse gui=NONE,reverse
   " hi pandocVerbatimInlineHeading ctermfg=166 ctermbg=NONE guifg=#cb4b16 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
   " hi pandocSuperscriptHeading ctermfg=166 ctermbg=NONE guifg=#cb4b16 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
   " hi pandocSubscriptHeading ctermfg=166 ctermbg=NONE guifg=#cb4b16 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
   " hi pandocLinkDelim ctermfg=242 ctermbg=NONE guifg=#586e75 guibg=NONE guisp=NONE cterm=NONE gui=NONE
   " hi pandocLinkLabel ctermfg=32 ctermbg=NONE guifg=#268bd2 guibg=NONE guisp=NONE cterm=NONE gui=NONE
   " hi pandocLinkText ctermfg=32 ctermbg=NONE guifg=#268bd2 guibg=NONE guisp=NONE cterm=NONE gui=NONE
   " hi pandocLinkURL ctermfg=66 ctermbg=NONE guifg=#6F8790 guibg=NONE guisp=NONE cterm=NONE gui=NONE
   " hi pandocLinkTitle ctermfg=66 ctermbg=NONE guifg=#6F8790 guibg=NONE guisp=NONE cterm=NONE gui=NONE
   " hi pandocLinkTitleDelim ctermfg=242 ctermbg=NONE guifg=#586e75 guibg=NONE guisp=#6F8790 cterm=NONE gui=NONE
   " hi pandocLinkDefinition ctermfg=37 ctermbg=NONE guifg=#2aa198 guibg=NONE guisp=#6F8790 cterm=NONE gui=NONE
   " hi pandocLinkDefinitionID ctermfg=32 ctermbg=NONE guifg=#268bd2 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
   " hi pandocImageCaption ctermfg=61 ctermbg=NONE guifg=#6c71c4 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
   " hi pandocFootnoteLink ctermfg=106 ctermbg=NONE guifg=#719E07 guibg=NONE guisp=NONE cterm=NONE gui=NONE
   " hi pandocFootnoteDefLink ctermfg=106 ctermbg=NONE guifg=#719E07 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
   " hi pandocFootnoteInline ctermfg=106 ctermbg=NONE guifg=#719E07 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
   " hi pandocFootnote ctermfg=106 ctermbg=NONE guifg=#719E07 guibg=NONE guisp=NONE cterm=NONE gui=NONE
   " hi pandocCitationDelim ctermfg=162 ctermbg=NONE guifg=#d33682 guibg=NONE guisp=NONE cterm=NONE gui=NONE
   " hi pandocCitation ctermfg=162 ctermbg=NONE guifg=#d33682 guibg=NONE guisp=NONE cterm=NONE gui=NONE
   " hi pandocCitationID ctermfg=162 ctermbg=NONE guifg=#d33682 guibg=NONE guisp=NONE cterm=NONE gui=NONE
   " hi pandocCitationRef ctermfg=162 ctermbg=NONE guifg=#d33682 guibg=NONE guisp=NONE cterm=NONE gui=NONE
   " hi pandocStyleDelim ctermfg=242 ctermbg=NONE guifg=#586e75 guibg=NONE guisp=NONE cterm=NONE gui=NONE
   " hi pandocEmphasis ctermfg=246 ctermbg=NONE guifg=#839496 guibg=NONE guisp=NONE cterm=NONE gui=NONE,italic
   " hi pandocEmphasisNested ctermfg=246 ctermbg=NONE guifg=#839496 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
   " hi pandocStrongEmphasis ctermfg=246 ctermbg=NONE guifg=#839496 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
   " hi pandocStrongEmphasisNested ctermfg=246 ctermbg=NONE guifg=#839496 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
   " hi pandocStrongEmphasisEmphasis ctermfg=246 ctermbg=NONE guifg=#839496 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
   " hi pandocStrikeout ctermfg=242 ctermbg=NONE guifg=#586e75 guibg=NONE guisp=NONE cterm=NONE,reverse gui=NONE,reverse
   " hi pandocVerbatimInline ctermfg=136 ctermbg=NONE guifg=#b58900 guibg=NONE guisp=NONE cterm=NONE gui=NONE
   " hi pandocSuperscript ctermfg=61 ctermbg=NONE guifg=#6c71c4 guibg=NONE guisp=NONE cterm=NONE gui=NONE
   " hi pandocSubscript ctermfg=61 ctermbg=NONE guifg=#6c71c4 guibg=NONE guisp=NONE cterm=NONE gui=NONE
   " hi pandocRule ctermfg=32 ctermbg=NONE guifg=#268bd2 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
   " hi pandocRuleLine ctermfg=32 ctermbg=NONE guifg=#268bd2 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
   " hi pandocEscapePair ctermfg=160 ctermbg=NONE guifg=#dc322f guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
   " hi pandocCitationRef ctermfg=162 ctermbg=NONE guifg=#d33682 guibg=NONE guisp=NONE cterm=NONE gui=NONE
   " hi pandocNonBreakingSpace ctermfg=160 ctermbg=NONE guifg=#dc322f guibg=NONE guisp=NONE cterm=NONE,reverse gui=NONE,reverse
   " hi! link pandocEscapedCharacter pandocEscapePair
   " hi! link pandocLineBreak pandocEscapePair
   " hi pandocMetadataDelim ctermfg=242 ctermbg=NONE guifg=#586e75 guibg=NONE guisp=NONE cterm=NONE gui=NONE
   " hi pandocMetadata ctermfg=32 ctermbg=NONE guifg=#268bd2 guibg=NONE guisp=NONE cterm=NONE gui=NONE
   " hi pandocMetadataKey ctermfg=32 ctermbg=NONE guifg=#268bd2 guibg=NONE guisp=NONE cterm=NONE gui=NONE
   " hi pandocMetadata ctermfg=32 ctermbg=NONE guifg=#268bd2 guibg=NONE guisp=NONE cterm=NONE,bold gui=NONE,bold
   " hi! link pandocMetadataTitle pandocMetadata
   "
  endif
  if get(g:, "solarized_term_italics", 0)
    hi Comment cterm=italic
    hi gitcommitComment cterm=italic
    hi htmlSpecialTagName cterm=italic
    hi pandocComment cterm=italic
    hi pandocEmphasisDefinition cterm=italic
    hi pandocEmphasisTable cterm=italic
    hi pandocEmphasis cterm=italic
  endif
  if has('nvim')
    hi! link TermCursor Cursor
    hi TermCursorNC ctermfg=235 ctermbg=242 guifg=#00313D guibg=#586e75 guisp=NONE cterm=NONE gui=NONE
    let g:terminal_color_8='#00313D'
    let g:terminal_color_0='#083C4A'
    let g:terminal_color_10='#586e75'
    let g:terminal_color_11='#6F8790'
    let g:terminal_color_12='#839496'
    let g:terminal_color_14='#93a1a1'
    let g:terminal_color_7='#eee8d5'
    let g:terminal_color_15='#fdf6e3'
    let g:terminal_color_3='#b58900'
    let g:terminal_color_9='#cb4b16'
    let g:terminal_color_1='#dc322f'
    let g:terminal_color_5='#d33682'
    let g:terminal_color_13='#6c71c4'
    let g:terminal_color_4='#268bd2'
    let g:terminal_color_6='#2aa198'
    let g:terminal_color_2='#719E07'
  endif
  finish
endif

" Removed 16 color variant and light background variant
