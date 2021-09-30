"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" options.vim
" ===========
"
" Author:                Michael De Pasquale <shaggyrogers>
" Description:           Sets vim options for all filetypes.
" Creation Date:         2017-12-02
" Modification Date:     2020-09-26
" License:               MIT
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" General{{{
" Enable filetype plugins
filetype plugin indent on
set cpoptions=aABceFs_

" Default encoding
set encoding=utf8
set fileformats=unix,dos,mac

" Memory usage limits (kB) - regex, mkspell
set maxmempattern=32768
set mkspellmem=900000,10000,1000

" Spell checking
set nospell
set spelllang=en_au

" Mouse support
behave xterm
set mouse=ar
set mouseshape=i:beam,r:beam,s:updown,sd:cross,m:no,ml:up-arrow,v:rightup-arrow
" }}}

" Behaviour{{{
" Detect file changes, buffers remain open in background
set autoread
set hidden

" Persistence, sessions / backups / swap files
set history=4096
set writebackup
set nobackup
set sessionoptions=blank,curdir,folds,help,resize,slash,tabpages,winpos,winsize
set swapfile
set undofile
set undolevels=4096
set undoreload=0
set updatecount=256
set updatetime=5000
set viewoptions=cursor,curdir,folds,slash

" Persistent file directories (// = use full path)
let s:tempDir = rccommon#TempDir()
exec 'set directory='.s:tempDir.'/swap//'
exec 'set undodir='.s:tempDir.'/undo//'
exec 'set viewdir='.s:tempDir.'/view//'
exec "let $NVIM_RPLUGIN_MANIFEST='".s:tempDir."/rplugin.vim'"
exec "set shada=!,s8096,h,%," .
            \ "'" . string(&history) . ',' .
            \ 'r/dev,' .
            \ 'r/media,' .
            \ 'r/mnt,' .
            \ 'r/proc,' .
            \ 'r/run,' .
            \ 'r/sys,' .
            \ 'r/tmp,' .
            \ 'r/var/cache,' .
            \ 'r/var/crash,' .
            \ 'r/var/log,' .
            \ 'r/var/tmp,' .
            \ 'r~/.cache,' .
            \ 'r~/.local/share/Trash,' .
            \ 'r~/tmp,' .
            \ 'n'.s:tempDir.'/shada'


" Bell
set belloff=all
set noerrorbells

" Modelines
set modeline
set modelines=5

" Maximum function call depth, timouts for key codes/mappings/key sequences
set maxfuncdepth=300
set timeoutlen=750
set ttimeoutlen=30

" Jump to the first open window or tab for a buffer, or make a new tab
set switchbuf=useopen,usetab,newtab

" Always echo the number of lines changed by a command.
set report=0
"}}}

" Search & Patterns {{{
" Patterns
set ignorecase
set smartcase

" Search appearance
set nohlsearch
set inccommand=nosplit
set incsearch
set matchpairs=(:),{:},[:],<:>,{:}
set matchtime=3
set showmatch

" File Search
set tags=.tags
" }}}

" Navigation {{{
" Movement restrictions/jumps
set backspace=eol,start,indent
set selection=inclusive
set virtualedit=block,onemore
set whichwrap=h,l,<,>,[,]
" }}}

" UI{{{
" Syntax highlighting / redrawing{{{
syntax enable
"set concealcursor=nc
set conceallevel=2
set lazyredraw
set matchtime=2
set noshowmode
set redrawtime=1000
set synmaxcol=256

" Highlight everything
let python_highlight_all = 1

" Disable matchparen plugin in favour of parenmatch
let g:loaded_matchparen = 1
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
set cursorline
"set cursorcolumn
set winblend=18
let g:solarized_cursorline_linenr = 1
let g:solarized_diffmode = 'normal'
let g:solarized_extra_hi_groups = 1
let g:solarized_term_italics = 1
let g:solarized_termtrans = ($TERM == 'xterm-kitty'
                                \ || $TERM == 'xterm-256color') ? 1 : 0
let g:solarized_visibility = 'high'
colorscheme solarized8_flat_fork
"}}}

" Tab/status line{{{
set showtabline=2
set laststatus=2
set ruler
set number
"}}}

" Windows{{{
set cmdheight=2
set cmdwinheight=8
set winminheight=0
set winminwidth=1
set previewheight=8

set fillchars=vert:█,diff:-,fold:…
set guioptions-=L
set guioptions-=R
set guioptions-=l
set guioptions-=r

set nosplitbelow
set splitright
set title

" Preserve window sizes on open/close
set noequalalways
set winfixheight
"set winfixwidth

"}}}

" Wild menu{{{
set wildmenu
set wildmode=full
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store,*.o,*.so,*.md,*~,*.pyc
set wildignore+=*.pyo,*.swp,*.bak,*.class,*.sln,*.pdb,*.dll,*.tmp
set wildignore+=tags,.tags,ctags,.ctags
set wildignore+=*.jpg,*.gif,*.mp3,*.flac,*.mkv,*.mp4,*.avi,*.pdf
"}}}

" Scroll{{{
set scroll=0
set scrollback=999
set scrolljump=1
set scrolloff=12
set sidescrolloff=5
set scrollopt=ver,hor,jump
"}}}

" Folding{{{
set foldclose=
set foldcolumn=2
set foldlevelstart=1
"set foldlevelstart=0
set foldlevel=0
set foldnestmax=8
set foldmethod=manual
set foldopen=hor,mark,percent,quickfix,search,tag
"set foldopen=hor,mark,percent,quickfix,search,tag,undo
set foldtext=FoldTextCustom()
"}}}

" Text display{{{
set listchars=eol:⏎,tab:␉⇥,space:⸳,extends:⋙,precedes:⋘,nbsp:␠
set nolist
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
" t - Auto-wrap text using textwidth
" c - Auto-wrap comments using textwidth, inserting the current comment
" q - Allow formatting comments ('gq')
" j - Remove comment leader when joining comments
" l - Don't break long lines that were already long
" 1 - Numbered lists (need to set formatlistpat and enable autoindent)
set formatoptions=1cjlqrt

"}}}

" Lines{{{
set textwidth=79
" local to window
set linebreak
"set breakat=!@*-+;:,./?({>%|
"set breakat=^I!@*-+;:,./?
"}}}
"}}}

" TOhtml  {{{
let g:html_dynamic_folds = 1
let g:html_use_css = 1
let g:html_number_lines = 1
let g:html_line_ids = 1
let g:html_ignore_conceal = 0
let g:html_ignore_folding = 0
let g:html_no_foldcolumn = 0
let g:html_no_invalid = 0
let g:html_hover_unfold = 0
let g:html_pre_wrap = 0
let g:html_expand_tabs = 1
let g:html_prevent_copy = 'fn'
" let g:html_font = 'monospace'
"}}}

" Autocommands{{{
augroup VimrcOptions
    autocmd!

    " Move quickfix window to the bottom
    autocmd FileType qf wincmd J

    " Initialise terminal
    autocmd TermOpen * call s:InitialiseTerminal()

    " Change title to include file on buffer entry
    autocmd BufEnter *
                \ execute 'set titlestring=nvim%' .
                \ '=-%=%<%{expand(\"%:~:.:t\")}%=[%l/%L]%=(%P)' .
                \ ' titlelen=70'
                \ | execute 'set scrolloff=' . string(winheight(0) / 4)

    " Upon opening file, go to last cursor position and update folds
    autocmd BufReadPost *
                \ if line("'\"") > 0 && line("'\"") <= line("$")
                    \ | execute "normal! g'\""
                    \ | execute "normal! zx"
                \ | endif

    " Disable cursorline for insert mode and on buffer leave
    autocmd BufEnter * set cursorline
    autocmd BufLeave * set nocursorline

    " Show/hide textwidth on insert enter/leave
    autocmd InsertEnter *
                \ set nocursorline
                \ | if &textwidth > 0
                    \ | execute 'set colorcolumn='.string(&textwidth + 1)
                \ | endif
    autocmd InsertLeave *
                \ set cursorline
                \ | execute 'set colorcolumn='

    " F
    autocmd VimLeave *
                \ if v:dying
                \ | echo "\nAAAAaaaarrrggghhhh!!!\n"
                \ | endif
augroup end
"}}}

" Functions{{{
" FoldTextCustom : Builds a string to display for a closed fold{{{
function! FoldTextCustom()
    let fchr = matchstr(&fillchars, 'fold:\zs.')
    let level = foldlevel(v:foldstart)
    let fcnt = v:foldend - v:foldstart
    let line = getline(v:foldstart)

    if &foldmarker != ''
        let fm = escape(matchstr(&foldmarker, '[^,]\+'), '\')
        let line = substitute(line, '\V'.fm , '', 'g')
    endif

    " Assumes the sign column has width 2 and line numbers are enabled.
    let cols = rccommon#BufferColumns()
    let cmtl = escape(matchstr(&commentstring, '.*\ze%s', '\'), '')
    let linestart = ' ' " . repeat(fchr, level - 1)
    let lineend = repeat(fchr, 4) . string(fcnt).' lines'.repeat(fchr,
                \ 5 - strchars(string(level))).'['.string(level).']'.fchr.fchr

    let line = substitute(line, '\V' . cmtl , '', '')
"    let line = substitute(line, '^\V\s\{0,8}' . cmtl  . '\s\{0,8}', '', '')
"    let line = substitute(line, '\V\s\{0,8}' . cmtl . '\s\{0,8}\$', '', '')
    let ftag = matchstr(line, '\m\[\zs[^\[]\+\ze]$', 0, 1)

    if ftag != ''
        let lineend = repeat(fchr, 4) . ftag . lineend
        let line = substitute(line, '\V\s\*['.escape(ftag,'\').']\$', '', '')
    endif

    let addlen = strchars(linestart) + strchars(lineend)
    let line = substitute(strcharpart(line, 0, cols - addlen), '\s\+$', '', '')
    return linestart.line . repeat(fchr, cols-strchars(line)-addlen) . lineend
endfunction
"}}}

" InitialiseTerminal : Load bash prompt and set terminal buffer options{{{
" Should be called in a TermOpen autocommand.
function! s:InitialiseTerminal()
    if &buftype != 'terminal' || get(b:, '_term_configured', 0)
        return
    endif

    call feedkeys("asource ~/.config/bash/bash_prompt.sh\<CR>clear\<CR>", 't')
    setlocal foldcolumn=0 signcolumn=no nonumber
    let b:_term_configured = 1
endfunction
"}}}
"}}}

" vim: set ts=4 sw=4 tw=79 fdm=marker et :
