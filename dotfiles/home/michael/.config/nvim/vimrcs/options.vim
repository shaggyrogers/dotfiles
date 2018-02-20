"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" options.vim
" ===========
"
" Author:                Michael De Pasquale
" Creation Date:         2017-12-02
"
" Description
" -----------
" Sets global options.
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" General{{{
" Enable filetype plugins{{{
filetype plugin indent on
set cpoptions=aABceFs_
"}}}
" Encoding{{{
set encoding=utf8
set fileformats=unix,dos,mac
"}}}
" Spell checking{{{
set nospell
set spelllang=en_au
"}}}
" Configure mouse{{{
set mouse=ar
set mousehide
set mousemodel=popup
set mouseshape=i:beam,r:beam,s:updown,sd:cross,m:no,ml:up-arrow,v:rightup-arrow
" }}}
" }}}

" Behaviour{{{
" Detect file changes, buffers remain open in background{{{
set autoread
set hidden
"}}}
" Command / undo history{{{
set history=4096
set undolevels=2048
"}}}
" Persistent undo / sessions / backups / swap files{{{
set nobackup
set noswapfile
set undodir=~/.config/nvim/temp_data/undo
set undofile
set undoreload=0
set viewdir=~/.config/nvim/temp_data/view
set viewoptions=cursor,curdir,folds,options
"}}}
" Bell{{{
set belloff=all
set noerrorbells
"}}}
" Modelines{{{
set modeline
set modelines=5
"}}}
" Maximum function call depth, timouts for key codes/mappings/key sequences{{{
set maxfuncdepth=300
set timeoutlen=750
set ttimeoutlen=30
"}}}
" Jump to the first open window or tab for a buffer, or make a new tab{{{
set switchbuf=useopen,usetab,newtab
"}}}
" Always echo the number of lines changed.{{{
set report=0
"}}}
"}}}

" Patterns {{{
" Case sensitivity{{{
set ignorecase
set smartcase
"}}}
" Search/replace{{{
set hlsearch
set inccommand=nosplit
set incsearch
"}}}
" Pair matching{{{
set matchpairs=(:),{:},[:],<:>,{:}
set matchtime=3
set showmatch
"}}}
" tags{{{
set tags=.tags
"}}}
" }}}

" Navigation {{{
" Movement restrictions/jumps
set virtualedit=block,onemore
set backspace=eol,start,indent
set whichwrap=h,l,<,>,[,]

" When editing a file, always jump to the last cursor position
augroup LastFileLocation
    au!
    autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
                        \ | exe "normal! g'\"" | endif
augroup end

" }}}

" UI{{{
" Enable syntax highlighting{{{
syntax enable
"}}}
" Don't show mode text, don't redraw unless necessary{{{
set noshowmode
set lazyredraw
"}}}
" Truecolor support{{{
if exists('+termguicolors')
    set termguicolors
elseif exists('+guicolors')
    set guicolors
endif
"}}}
" Colorscheme{{{
set background=dark
let g:solarized_cursor_ul = 1
let g:solarized_diffmode = 'normal'
let g:solarized_extra_hi_groups = 1
let g:solarized_term_italics = 1
let g:solarized_termtrans = 1
let g:solarized_visibility = 'high'
colorscheme solarized8_flat_fork
"}}}
" Tab/status line{{{
set showtabline=2
set laststatus=2
set ruler
set number
"}}}
" Window{{{
set previewheight=8
set fillchars=vert:█,diff:-,fold:…
set guioptions-=r
set guioptions-=R
set guioptions-=l
set guioptions-=L
set cmdheight=2
set nosplitbelow
set splitright
set title
"}}}
" Conceal{{{
set concealcursor=nc
set conceallevel=2
"}}}
" Wildmenu{{{
set wildmenu
set wildmode=full
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store,*.o,*.so,*.md,*~,*.pyc
set wildignore+=*.pyo,*.swp,*.bak,*.class,*.sln,*.pdb,*.dll,*.tmp
set wildignore+=tags,.tags,ctags,.ctags
set wildignore+=*.jpg,*.gif,*.mp3,*.flac,*.mkv,*.mp4,*.avi,*.pdf
"}}}
" Scroll{{{
set scroll=0
set scrolloff=12
set scrollback=999
set scrollopt=ver,jump
"}}}
" List{{{
set listchars=eol:⏎,tab:␉⇥,space:⸳,extends:⋙,precedes:⋘,nbsp:␠
set nolist
"}}}
" Folding{{{
set foldtext=FoldTextCustom()
set foldopen=hor,mark,percent,quickfix,search,tag,undo
set foldclose=
set foldcolumn=2
set foldmethod=manual
"}}}
" Lines{{{
set cursorline
set showbreak==>
set wrap
"}}}
"}}}

" Editing{{{
" Keyword completion{{{
set complete=.,w,b,t,k,kspell,s,i
set completeopt=menu,menuone,preview
set pumheight=10
"}}}
" Indentation{{{
set autoindent
set copyindent
set expandtab
set shiftround
set shiftwidth=4
set smarttab
set softtabstop=4
set tabstop=4
"}}}
" Automatic formatting{{{
set formatoptions=tcqjr
"}}}
" Lines{{{
set textwidth=79
set linebreak
"set breakat=!@*-+;:,./?({>%|
"set breakat=^I!@*-+;:,./?
"}}}
"}}}

" Autocommands{{{
augroup CursorlineToggle
    au!
    " Hide cursorline in insert mode
    autocmd InsertLeave,WinEnter * set cursorline
    autocmd InsertEnter,WinLeave * set nocursorline

    " Window title
    autocmd BufEnter * set title
                \ titlestring=nvim%=-%=%<%{expand(\"%:~:.:t\")}%=[%l/%L]%=(%P) titlelen=70

    " Move quickfix to the bottom of the screen on open
    autocmd FileType qf wincmd J
augroup end

" Disable built-in matchparen plugin in favour of autoload/parenmatch
let g:loaded_matchparen = 1
"}}}

" Functions{{{
" GetBufferColumns : Get the visible buffer columns for the current window{{{
" Assumes the sign column has width 2.
function! GetBufferColumns()
    if !&number | return winwidth(0) - &foldcolumn - 2 | endif
    let lln = max([&nuw - 1, strlen(string(line('$'))), 0])
    return winwidth(0) - &foldcolumn - lln - 2
endfunction
"}}}
" FoldTextCustom : Builds a string to display for a closed fold{{{
function! FoldTextCustom()
    let fchr = matchstr(&fillchars, 'fold:\zs.')
    let flev = foldlevel(v:foldstart)
    let fcnt = v:foldend - v:foldstart
    let line = getline(v:foldstart)

    if &foldmarker != ''
        let fm = escape(matchstr(&foldmarker, '[^,]\+'), '\')
        let line = substitute(line, '\V'.fm , repeat(fchr, strchars(fm)), 'g')
    endif

    " Assumes the sign column has width 2 and line numbers are enabled.
    let cols = GetBufferColumns()
    let level =  repeat(fchr, 5 - strchars(string(flev))) . '[' .
                \ string(flev) . ']' . repeat(fchr, 2)
    let linestr = repeat(fchr, 4) . string(fcnt) . ' lines' . level
    let line = substitute(strcharpart(line, 0, cols - strchars(linestr)),
                \ '\s\+$', '', '')
    return line . repeat(fchr, cols - strchars(line) - strchars(linestr)) .
                \ linestr
endfunction
"}}}
"}}}
" vim: set ts=4 sw=4 tw=79 fdm=manual et :
