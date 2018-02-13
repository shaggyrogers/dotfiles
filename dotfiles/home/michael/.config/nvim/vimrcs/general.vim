"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" general.vim
" ===========
"
" Version:               1.0.0
" Author:                Michael De Pasquale
" Creation Date:         2017-12-02
"
" Description
" -----------
" General vim settings go here.
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Basics                                                      "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vi compatiblity options
set cpo=aABceFs_

" Set language and disable spell checking
set spelllang=en_au
set nospell

" utf-8 encoding
set encoding=utf8

" Use 4 spaces for indentation
set expandtab
set smarttab
set shiftwidth=4
set tabstop=4

" Enable autoindent and smartindent
set autoindent
set smartindent

" Enable line break and line wrapping
set lbr
set wrap

" Default to unix line endings
set ffs=unix,dos,mac

" Enable filetype detection, filetype plugins and indentation
filetype plugin indent on


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Navigation                                                  "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Allow block selection to move anywhere
set virtualedit=block

" Jump to the first open window or tab for a buffer, or make a new tab
set switchbuf=useopen,usetab,newtab

" Keep 5 lines above and below the cursor while scrolling up/down
set scrolloff=5

" Allow backspace over indentation, eol characters and start position.
set backspace=eol,start,indent

" Automatically jump to start of next/prev line
set whichwrap+=<,>,h,l,[,]

" When editing a file, always jump to the last cursor position
augroup LastFileLocation
    au!
    autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
                        \ | exe "normal! g'\"" | endif
augroup end


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Behaviour                                                   "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Detect external modifications to files in buffer
set autoread

" Allow buffers to remain 'open' in the background.
set hidden

" Set command history to 4096 lines, undo history to
set history=4096

" Enable persistent undo, set folder
set undodir=~/.config/nvim/temp_data/undodir
set undolevels=2048
set undoreload=0
set undofile

" Disable automatic backups & swap files
set nobackup
set noswapfile
"set updatetime=500

" Set :mkview data
set viewoptions=cursor,curdir,folds,options
set viewdir=~/.config/nvim/temp_data/undodir

" Ignore compiled files for wildmenu
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store,*.o,*.so,*.md,*~,*.pyc
set wildignore+=*.pyo,*.swp,*.bak,*.class,*.sln,*.pdb,*.dll,*.tmp
set wildignore+=tags,.tags,ctags,.ctags
set wildignore+=*.jpg,*.gif,*.mp3,*.flac,*.mkv,*.mp4,*.avi,*.pdf

" Set fold method to manual. Shortcut is spacebar.
set foldmethod=manual


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Patterns & Search                                           "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Ignore case if pattern contains only lowercase letters
set ignorecase
set smartcase

" Enable search highlighting, incremental search and substitute preview
set hlsearch
set incsearch
set inccommand=nosplit

" Set magic mode for patterns
set magic

" Show matching brackets when the cursor is above them
set showmatch
set mat=2


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" UI/Visual                                                   "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting
syntax enable

let term='ucrkitty'
call system('TERM=ucrkitty')

" Don't show normal mode text (airline shows mode)
set noshowmode

" Don't redraw while executing macros, registers etc.
set lazyredraw

" enable truecolor support
if exists('+termguicolors') | set termguicolors
    elseif exists('+guicolors') | set guicolors
endif

" Colorscheme
let g:solarized_termtrans = 1  " 1 if term bg is transparent
let g:solarized_visibility = 'normal'
let g:solarized_statusline = 'normal'
let g:solarized_term_italics = 0
let g:solarized_termcolors = 256
let g:solarized_old_cursor_style = 0
let g:solarized_extra_hi_groups = 1
let g:solarized_use_bolditalic_syntax = 1
set background=dark
colorscheme solarized8_flat_fork

" Custom window title
set title
augroup setTitlestring
    au!
    autocmd BufEnter * :set title titlestring=nvim%=-%=%<%{expand(\"%:~:.:t\")}%=[%l/%L]%=(%P) titlelen=70
augroup end

" Always show tab and status lines
set showtabline=2
set laststatus=2

" Enable wildmenu
set wildmenu
set wildmode=full

" Show current line and column numbers and display line numbers
set ruler
set number

" Highlight current line.
set cursorline

" Use 2 lines for command bar
set cmdheight=2

" Split windows to the right and above
set nosplitbelow
set splitright

" Disable scrollbars
set guioptions-=r
set guioptions-=R
set guioptions-=l
set guioptions-=L

" Set listchars characters and disable list - toggle is F3
set listchars=eol:⏎,tab:␉⇥,space:⸳,extends:⋙,precedes:⋘,nbsp:␠
set nolist

" Set separator  fill char
set fillchars=vert:█,diff:-

" Set custom fold text
" can't remember where I found this. Slightly modified.
function! FoldTextCustom()
    let line = ' ' . substitute(getline(v:foldstart),
                            \ '^\s*"\?\s*\|\s*"\?\s*{{' . '{\d*\s*', '', 'g')
    let numLines = v:foldend - v:foldstart
    let foldtextstart = strpart(''. line, 0, (winwidth(0)*2)/3)
    let foldtextend = numLines.' lines'.repeat('…', 8)
    let foldtextlength = strlen(substitute(foldtextstart .
                                \ foldtextend, '.', 'x', 'g')) + &foldcolumn
    return foldtextstart . repeat('…', winwidth(0) - foldtextlength) .
            \ foldtextend
endfunction
set foldtext=FoldTextCustom()

" Hide cursorline in insert mode
augroup cursorlineToggle
    au!
    autocmd InsertLeave,WinEnter * set cursorline
    autocmd InsertEnter,WinLeave * set nocursorline
augroup end

" Preview window height (default 12)
set previewheight=8

" Disable built-in matchparen plugin in favour of autoload/parenmatch
let g:loaded_matchparen = 1


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Editing                                                     "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Keyword completion
set complete=.,w,b,t,k,kspell,s,i
set completeopt=menu,menuone,preview
set pumheight=10

" Pasting
set copyindent

" Automatic formatting
set formatoptions=tcqjr

" Enable the cursor to move one character past the last
set virtualedit=onemore


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Misc.                                                       "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Disable bell
set noerrorbells
set belloff=all
set vb

" Enable modelines
set modeline
set modelines=5

" Maximum function call depth - 100 is default
set maxfuncdepth=300

" Timeout of 500 for mapped sequences, 750ms for key code sequences
set timeoutlen=750
set tm=500

" Always echo the number of lines changed.
set report=0
