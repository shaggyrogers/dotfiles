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
filetype plugin indent on
set cpo=aABceFs_
set spelllang=en_au
set encoding=utf8
set ffs=unix,dos,mac
set nospell
set lbr
set wrap

" indentation
set expandtab
set smarttab
set shiftwidth=4
set tabstop=4
set autoindent
set copyindent

" Enable mouse
set mouse=ar
set mousehide
set mousemodel=popup
set mouseshape=i:beam,r:beam,s:updown,sd:cross,m:no,ml:up-arrow,v:rightup-arrow


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Behaviour                                                   "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Detect external changes to buffers, allow buffers to be open in background
set autoread
set hidden

" Command / undo history
set history=4096
set undolevels=2048

" persistent undo
set undodir=~/.config/nvim/temp_data/undo
set undoreload=0
set undofile

" Disable backups & swap files
set nobackup
set noswapfile

" Set session data
set viewoptions=cursor,curdir,folds,options
set viewdir=~/.config/nvim/temp_data/view

" Ignore compiled files for wildmenu
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store,*.o,*.so,*.md,*~,*.pyc
set wildignore+=*.pyo,*.swp,*.bak,*.class,*.sln,*.pdb,*.dll,*.tmp
set wildignore+=tags,.tags,ctags,.ctags
set wildignore+=*.jpg,*.gif,*.mp3,*.flac,*.mkv,*.mp4,*.avi,*.pdf


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

" Show matching brackets when the cursor is above them
set showmatch
set mat=2


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Navigation                                                  "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" block selection is unrestricted, any mode can move just past the end of a line
set virtualedit=block,onemore

" Jump to the first open window or tab for a buffer, or make a new tab
set switchbuf=useopen,usetab,newtab

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
" UI/Visual                                                   "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting
syntax enable

" Don't show mode text (airline already does), don't redraw for macros etc
set noshowmode
set lazyredraw

" enable truecolor support
if exists('+termguicolors') | set termguicolors
    elseif exists('+guicolors') | set guicolors
endif

" Colorscheme & related options
let g:solarized_termtrans = 1  " 1 if term bg is transparent
let g:solarized_visibility = 'high'
let g:solarized_statusline = 'normal'
let g:solarized_term_italics = 0
let g:solarized_termcolors = 256
let g:solarized_old_cursor_style = 0
let g:solarized_extra_hi_groups = 1
let g:solarized_use_bolditalic_syntax = 1
set background=dark
set cursorline
colorscheme solarized8_flat_fork

" Window title
set title

augroup setTitlestring
    au!
    autocmd BufEnter * :set title
                \ titlestring=nvim%=-%=%<%{expand(\"%:~:.:t\")}%=[%l/%L]%=(%P) titlelen=70
augroup end

" Tabline / statusline
set showtabline=2
set laststatus=2
set ruler
set number

" Window
set previewheight=8
set fillchars=vert:█,diff:-
set guioptions-=r
set guioptions-=R
set guioptions-=l
set guioptions-=L
set cmdheight=2
set wildmenu
set wildmode=full
set nosplitbelow
set splitright

" scroll
set scroll=0
set scrolloff=12
set scrollback=999
set scrollopt=ver,jump

" List
set listchars=eol:⏎,tab:␉⇥,space:⸳,extends:⋙,precedes:⋘,nbsp:␠
set nolist

" Folding
set foldtext=FoldTextCustom()
set foldopen=hor,mark,percent,quickfix,search,tag,undo
set foldclose=
set foldcolumn=0
set foldmethod=manual

" Hide cursorline in insert mode
augroup cursorlineToggle
    au!
    autocmd InsertLeave,WinEnter * set cursorline
    autocmd InsertEnter,WinLeave * set nocursorline
augroup end

" Disable built-in matchparen plugin in favour of autoload/parenmatch
let g:loaded_matchparen = 1


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Editing                                                     "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Keyword completion
set complete=.,w,b,t,k,kspell,s,i
set completeopt=menu,menuone,preview
set pumheight=10

" Automatic formatting
set formatoptions=tcqjr


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


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Helper functions                                            "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Custom fold text.
function! FoldTextCustom()
    let line = getline(v:foldstart)
    let foldtextstart = strpart(line, 0, (winwidth(0)*2)/3)
    let foldtextend = string(v:foldend - v:foldstart).' lines'.repeat('…', 8)
    let foldtextlength = strlen(substitute(foldtextstart .  foldtextend, '.',
                \ 'x', 'g')) + &foldcolumn
    return foldtextstart . repeat('…', winwidth(0) - foldtextlength) .
            \ foldtextend
endfunction
