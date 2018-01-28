""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" shortcuts.vim                                                               "
" ===========                                                                 "
"                                                                             "
" Version:               1.0.0                                                "
" Author:                Michael De Pasquale                                  "
" Creation Date:         2017-12-02                                           "
"                                                                             "
" Description                                                                 "
" -----------                                                                 "
" All user-defined shortcuts and commands go here.                            "
"                                                                             "
" Notes                                                                       "
" -----                                                                       "
" 1. Use :help index to get a list of all default commands for each mode.     "
" 2. Use :h keycodes to get a list of keycodes                                "
" 3. Use :h map-which-keys to get a guide for mapping keys                    "
" 4. For terminal mode vim/nvim, you can check if a set of input keys maps    "
"    to the same value by pressing CTRL+V, then the keys.                     "
"                                                                             "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Basic                                                       "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Ctrl+Space - start
nnoremap <C-Space> ^
inoremap <C-Space> <C-o>^

" Enable mouse
set mouse=ar
set mousehide
set mousemodel=popup
set mouseshape=i:beam,r:beam,s:updown,sd:cross,m:no,ml:up-arrow,v:rightup-arrow

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Navigation & Search                                         "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 0 Moves to the first non-blank character.
noremap 0 ^

" Ctrl-o/Ctrl-p to go forward/backward in jump list
nnoremap <C-O> <C-o>
nnoremap <C-p> <C-i>

" CTRL-h/CTRL-l : Move to next/word
noremap <C-h> b
noremap <C-l> w

"" CTRL-j/CTRL-k : Move down/up a paragraph. was previously 10j/10k
noremap <C-j> }
noremap <C-k> {

" Fixed position pageup/down http://vim.wikia.com/wiki/Page_up/down_and_keep_cursor_position
nnoremap <PageDown> :set scroll=0<CR>:set scroll^=2<CR>:set scroll-=1<CR><C-D>:set scroll=0<CR>
nnoremap <PageUp> :set scroll=0<CR>:set scroll^=2<CR>:set scroll-=1<CR><C-U>:set scroll=0<CR>

" Hold alt to move in input/cmd modes.
inoremap <M-h> <left>
inoremap <M-l> <right>
inoremap <M-j> <down>
inoremap <M-k> <up>
cnoremap <M-h> <left>
cnoremap <M-l> <right>
inoremap <M-w> <C-o>w
cnoremap <M-W> <C-o>W
inoremap <M-e> <C-o>e
cnoremap <M-E> <C-o>E
inoremap <M-b> <C-o>b
cnoremap <M-B> <C-o>B
inoremap <M-f> <C-o>f
cnoremap <M-F> <C-o>F
inoremap <M-t> <C-o>t
cnoremap <M-t> <C-o>T

" Pressing * or # in visual mode searches for the current selection
" Source: Vim wiki
vnoremap <silent> * :<C-U>
\let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
\gvy?<C-R><C-R>=substitute(
\escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
\gV:call setreg('"', old_reg, old_regtype)<CR>

vnoremap <silent> # :<C-U>
\let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
\gvy?<C-R><C-R>=substitute(
\escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
\gV:call setreg('"', old_reg, old_regtype)<CR>

" Ctrl+R in visual mode writes a search-replace command for the selected text
function!SearchReplaceVisualSelection()
    " Backup user data
    let startLine = line('.')
    let startCol = col('.')
    let oldReg = getreg('"')
    let oldRegtype = getregtype('"')

    " Get input
    call inputsave()
    echom 'Search/replace helper: Leave blank to use selection, '.
           \ '\= to replace with a vimscript expression.'
    let searchExp = inputdialog('Search:', '', '____CANCEL____')

    if searchExp != '12____CANCEL____12'
        let replExp = inputdialog('Replace:', '',  '____CANCEL____')
    endif

    call inputrestore()

    " Check for cancel
    if searchExp == '____CANCEL____' || replExp == '____CANCEL____' ||
                \ (searchExp == '' && replExp == '')
        echom 'Cancelled.'
        call setreg('"', oldReg, oldRegtype)
        call cursor(startLine, startCol)
        return
    endif

    " Create search command
    execute 'normal gvy'
    let selected = substitute(escape(@", '/\.*$^~['),
                                    \ '\_s\+', '\\_s\\+', 'g')
    call setreg('"', oldReg, oldRegtype)
    call cursor(startLine, startCol)

    if searchExp == '' | let searchExp = selected | elseif replExp == ''
                \ | let replExp = selected | endif

    " Write to buffer
    echom 'searchExp: '.searchExp
    echom 'replExp: '.replExp
    call feedkeys(':%s/'.searchExp.'/'.replExp.'/g', 't')
endfunction

vnoremap <C-r> <ESC>:call SearchReplaceVisualSelection()<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Editing Shortcuts                                           "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" (S)tamp - pastes without copying
noremap <C-s> p:let @"=@0<CR>

" yank to system clipboard.
noremap <Leader>y "+y
noremap <Leader>Y "+y$
xnoremap <Silent> <Leader>y y:let @+=@0<CR>
xnoremap <Silent> <Leader>Y Y:let @+=@0<CR>

" Yank character
nnoremap yc y<Right>

" put system clipboard. Use from insert mode with <C-o>.
xnoremap <Leader>p <ESC>:let @"=@+<CR>gvgp
xnoremap <Leader>P <ESC>:let @"=@+<CR>gvgP:let @"=@0<CR>
nnoremap <Leader>p "+gp
nnoremap <Leader>P "+gP

" Alt+Return : Create a copy of the current line below.
nnoremap <M-CR> :t.<CR>
inoremap <M-CR> <C-o>:t.<CR>

" Make cl/ch/dl/dh act on lines instead of characters
nnoremap cl c$
nnoremap ch c0
nnoremap dl d$
nnoremap dh d0

" Make vl/vh enter visual block, act on rest of line
nnoremap vl <C-v>$
nnoremap vh <C-v>0

" Make vk/vj enter visual line and select up/down
nnoremap vk <S-v><Up>
nnoremap vj <S-v><Down>

" Make yk/yj yank the left/right part of the current line
nnoremap yl y$
nnoremap yh y0

" CR/Ctrl-CR : Add newline above/below. Removes CR shortcut for unmodifiable windows.
func! UpdateCRShortcuts()
    if getbufvar(bufnr(''), '&modifiable', 0)
        nnoremap <CR> o<Space><BS><esc>
    else
        silent! nunmap <CR>
    endif
endfunc

augroup shortcuts_crshortcuts
    autocmd!
    autocmd  shortcuts_crshortcuts BufEnter * call UpdateCRShortcuts()
augroup end

nnoremap <CR> o<Space><BS><esc>
nnoremap gzm O<Space><BS><esc>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Windows & Tabs / UI                                         "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" F3 - toggle list mode
nnoremap <silent><F3> :set list!<CR>
inoremap <silent><F3> <Esc>:set list!<CR>i<Right>
xnoremap <silent><F3> <Esc>:set list!<CR>gv

" F4 - toggle relative line numbers
func! ToggleRelativeNum()
    if &relativenumber == 1
        set norelativenumber
    else
        set relativenumber
    endif
endfunc

nnoremap <silent><F4> :call ToggleRelativeNum()<CR>
inoremap <silent><F4> <Esc>:call ToggleRelativeNum()<CR>i<Right>
xnoremap <silent><F4> <Esc>:call ToggleRelativeNum()<CR>gv

" Alt+PageUp/Alt+PageDown : Resize current window by +/-5
nmap <M-PageUp> :resize +5<cr>
nmap <M-PageDown> :resize -5<cr>

" Space to fold visual selection/toggle fold. Must set fdm=manual.
nnoremap <space> za
vnoremap <space> zf

" Alt-R : Show registers window
nnoremap <M-r> :registers<CR>
nnoremap <M-c> :changes<CR>

" Tab / Shift-Tab: Next tab/previous tab
nnoremap <silent> <Tab> :tabnext<cr>
nnoremap <silent> <S-Tab> :tabprevious<cr>

" Ctrl+Tab / Ctrl+Shift-Tab: Move tab forward/backward
" Requires terminal configured to send \x00gz/\x00gZ
nnoremap <silent> gzz :tabm +1<cr>
nnoremap <silent> gzZ :tabm -1<cr>

" Ctrl+Tab / Ctrl+Shift-Tab: Move tab forward/backward
" Requires terminal configured to send \x00gz/\x00gZ
nnoremap <silent> gzf :call feedkeys(']m', 't')<CR>
nnoremap <silent> gzF :call feedkeys('[m', 't')<CR>

" CTRL-T : Open a new tab
let g:__new_tab_cmd = ":tabnew . / | Startify\<CR>"
nnoremap <silent><expr><C-t> g:__new_tab_cmd

" Alt+Tab : Next window
nnoremap <M-Tab> <C-w>w

" Ctrl+Arrow keys : Resize window
" Returns 1 if window can move in dir (<left>/<right>/<up>/<down>)
function! MyWindowResize(dir)
    if CanMoveWindow(a:dir)
        if a:dir == 'k' || a:dir == 'j'
            exe "wincmd +"
        elseif a:dir == 'h' || a:dir == 'l'
            exe "wincmd >"
        endif
    elseif !CanMoveWindow({'h': 'l','j': 'k','k': 'j','l': 'h'}[a:dir])
        return
    else
        if a:dir == 'k' || a:dir == 'j'
            exe "wincmd -"
        elseif a:dir == 'h' || a:dir == 'l'
            exe "wincmd <"
        endif
    endif
endfunction

nnoremap <Silent><Expr> <C-Left>   call MyWindowResize('h')
nnoremap <Silent><Expr> <C-Right>  call MyWindowResize('l')
nnoremap <Silent><Expr> <C-Down>   call MyWindowResize('j')
nnoremap <Silent><Expr> <C-Up>     call MyWindowResize('k')

" Arrow keys : Move window
nnoremap <left>   <C-w>h
nnoremap <right>  <C-w>l
nnoremap <down>   <C-w>j
nnoremap <up>     <C-w>k

" Alt+Arrow keys : Move tabs
nnoremap <silent> <M-right>  :tabnext<CR>
nnoremap <silent> <M-left>   :tabprev<CR>
nnoremap <silent> <M-down>   :tabm -1<CR>
nnoremap <silent> <M-up>     :tabm +1<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Terminal                                                    "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Leave terminal insert mode with escape
tnoremap <Esc> <C-\><C-n>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Misc.                                                       "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Disable annoying ex mode shortcut
noremap <S-q> <Nop>

" TODO: Allow changing to visual block from other visual modes
"xnoremap <C-v> :call EnterVisualBlock()<CR>

" Make macros work for each line in the visual selection
xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>
vnoremap . :norm.<CR>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Commands, Command Shortcuts                                 "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" <Leader>+(WW)rite (W)rite / (W)rite (S)udo / (W)rite (Quit) / (QQ)uit
" / 2x<Esc>
" <leader>ww / <leader><S-w> : (W)rite to file/sudo (W)rite to file respectively
noremap <leader>ww :w!<cr>
noremap <leader>ws :w !sudo tee % > /dev/null<cr>
noremap <leader>sw :w !sudo tee % > /dev/null<cr>
noremap <leader>wq :wq<cr>
noremap <leader>qw :wq<cr>
noremap <leader>qq :q<cr>
noremap <leader>q! :q!<cr>
noremap <leader><s-q><s-q> :q!<cr>
noremap <leader><Esc><Esc> :q!<cr>

" Save session
noremap <leader>SS :SSave<cr>

"" <Leader>ss = SynStack
function! SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc
map <leader>ss :call SynStack()<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Helper Functions                                            "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" /str without <CR>
function! SearchLine(str)
    exe "menu Foo.Bar /" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction

" Source for 2 functions below is https://github.com/amix/vimrc
" :str without <CR>
function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction

" Stores the current visual selection in the pattern register.
function! VisualSelection(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'gv'
        call CmdLine("Ag \"" . l:pattern . "\" " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

" Executes a macro for each line in the last visual selection
" https://github.com/robertmeta/vimfiles/blob/master/vimrc
function! ExecuteMacroOverVisualRange()
    echo '@'.getcmdline()
    execute ":'<,'>normal @".nr2char(getchar())
endfunction

" Returns 1 if window can move in dir (<left>/<right>/<up>/<down>)
function! CanMoveWindow(dir)
    let prevNr = winnr()
    exe "wincmd " . a:dir
    let curNr = winnr()
    exe curNr . "wincmd w"
    return curNr != prevNr
endfunction

" Moves in the given direction until encountering a non-whitespace char.
" Dir is either j (down) or k (up)
function! ColumnNextChar(dir)
    let fact = {'j': 1, 'k': -1}[tolower(a:dir)]
    let len = 0

    while line(".") > 1 && (strlen(getline(".")) < col(".")||
            \ getline(".")[col(".") - 1] =~ '\s')
        exe 'norm '.a:dir
    endwhile
endfunction
