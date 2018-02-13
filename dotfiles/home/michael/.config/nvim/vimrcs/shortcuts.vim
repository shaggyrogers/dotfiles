"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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
" Enable mouse
set mouse=ar
set mousehide
set mousemodel=popup
set mouseshape=i:beam,r:beam,s:updown,sd:cross,m:no,ml:up-arrow,v:rightup-arrow


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Navigation & Search                                         "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Move up/down to wrapped lines instead of actual lines
noremap j gj
noremap k gk

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
function! PageDown(mode)
    set scroll=0 | set scroll^=2 | set scroll-=1
    exec "normal! \<C-D>"
    set scroll=0
endfunction
function! PageUp(mode)
    set scroll=0 | set scroll^=2 | set scroll-=1
    exec "normal! \<C-U>"
    set scroll=0
endfunction
nnoremap <PageDown> :call PageDown('n')<CR>
nnoremap <PageUp> :call PageUp('n')<CR>

" Moves visual blocks and lines.
function! MoveTextLine(dir, cmode)
    let dir = {'j': 1, 'k': -2}[tolower(a:dir)]

    if a:cmode ==? 'v'
        let y1 = line("'<")
        let y2 = line("'>")
        let diff = (y2 - y1)
        if a:dir ==? 'k' | let diff = 0 | endif
        if y2 >= line('$') | silent exec 'normal! gv'
                    \ | return | endif
        silent exec y1.','.y2 . 'm ' . string(y1 + dir + diff)
        silent exec 'normal! gv=gv'
        return
    endif

    if a:cmode ==? 'n'
        let coln = col('.')
        let pind = indent('.')
        let ln = line('.') + dir
        silent exec 'normal! =='
        silent exec 'm ' . ln
        let coln = coln + (indent('.') - pind)
        if a:dir ==? 'k' | let ln = ln + 1 | endif
        call cursor(ln, coln)
    endif
endfunction

" Hold alt to jump through whitespace, characters or to the start/end of lines
"   aaa a   a   asdasda  asd ddasda  asda
function! DoMoveLR(dir)
    let flags = 'n'
    if a:dir ==? 'h' | let flags = flags . 'b' | endif
    let pos = searchpos('[^     ][  ]',   flags, line('.'), 200)

    if pos[0] == 0 && pos[1] == 0
        if a:dir ==? 'l' | silent exec 'normal! $'
        else | silent exec 'normal! 0' | endif
        return
    else
        call setpos('.', [0, pos[0], pos[1], 0])
    endif
endfunction

function! DoVisualMove(dir)
    exec 'normal! gv'
    if a:dir ==? 'h' || a:dir ==? 'l'
        call DoMoveLR(a:dir)
        return
    endif
    call MoveNextChar(a:dir)
endfunction

function! DoVisualIndent(dir)
endfunction

nnoremap <silent> <M-h> :call DoMoveLR('h')<CR>
nnoremap <silent> <M-j> :call MoveNextChar('j')<CR>
nnoremap <silent> <M-k> :call MoveNextChar('k')<CR>
nnoremap <silent> <M-l> :call DoMoveLR('l')<CR>
nnoremap <M-H> <<
nnoremap <silent> <M-J> :call MoveTextLine('j','n')<CR>
nnoremap <silent> <M-K> :call MoveTextLine('k','n')<CR>
nnoremap <M-L> >>
xnoremap <M-h> :<C-u>call DoVisualMove('h')<CR>
xnoremap <M-j> :<C-u>call DoVisualMove('j')<CR>
xnoremap <M-k> :<C-u>call DoVisualMove('k')<CR>
xnoremap <M-l> :<C-u>call DoVisualMove('l')<CR>
xnoremap <M-H> <gv
xnoremap <M-K> :<C-u>call MoveTextLine('k','v')<CR>
xnoremap <M-J> :<C-u>call MoveTextLine('j','v')<CR>
xnoremap <M-L> >gv
inoremap <M-h> <Left>
inoremap <M-j> <Down>
inoremap <M-k> <Up>
inoremap <M-l> <Right>
inoremap <M-H> <esc>:call DoMoveLR('h')<CR>a
inoremap <M-J> <esc>:call MoveNextChar('j')<CR>a
inoremap <M-K> <esc>:call MoveNextChar('k')<CR>a
inoremap <M-L> <esc>:call DoMoveLR('l')<CR>a

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
" put/yank to system clipboard.
function! DoYankLine(mode, reg) range
    let cp = getpos('.')
    exec 'normal! V\"' . a:reg
    cursor(cp[1], cp[2], cp[3])
endfunction

nmap <Leader>y "+y
nmap <Leader>Y V"+y
xmap <Leader>y "+y
nmap <Leader>p "+p
nmap <Leader>P "+P
xmap <Leader>p "+p<CR>
xmap <Leader>P "+P<CR>
nmap p p:let @"=@0<CR>
nmap P P:let @"=@0<CR>
xmap p p:let @"=@0<CR>
xmap P P:let @"=@0<CR>

" Keep selection when indenting
" https://github.com/mhinz/vim-galore
xnoremap <  <gv
xnoremap >  >gv

" Alt+Return : Create a copy of the current line below.
nnoremap <M-CR> :t.<CR>
inoremap <M-CR> <C-o>:t.<CR>

" Make cl/ch/dl/dh act on lines instead of characters
nnoremap cl c$
nnoremap ch c0
nnoremap yl y$
nnoremap yh y0
nnoremap dl d$
nnoremap dh d0
nnoremap <S-c> Vc
nnoremap <S-y> Vy
nnoremap <S-d> Vd

" Jump in a direction when entering visual selction modes
function! VisualInitialMove(modec, dir)
    if a:modec ==# 'V' | exec "normal! \<S-v>"
    elseif a:modec ==# 'v' | exec 'normal! v'
    elseif a:modec ==# '^V' | exec 'normal! '
    endif

    call MoveNextCharBlank(a:dir, 1)
    return
endfunction

nnoremap <silent> vh <esc>:call VisualInitialMove('v', 'h')<CR>
nnoremap <silent> vj <esc>:call VisualInitialMove('v', 'j')<CR>
nnoremap <silent> vk <esc>:call VisualInitialMove('v', 'k')<CR>
nnoremap <silent> vl <esc>:call VisualInitialMove('v', 'l')<CR>
nnoremap <silent> <S-v>h 0<S-v>
nnoremap <silent> <S-v>j <esc>:call VisualInitialMove('V', 'j')<CR>
nnoremap <silent> <S-v>k <esc>:call VisualInitialMove('V', 'k')<CR>
nnoremap <silent> <S-v>l $<S-v>
nnoremap <silent> <C-v>h <esc>:call VisualInitialMove('^V', 'h')<CR>
nnoremap <silent> <C-v>j <esc>:call VisualInitialMove('^V', 'j')<CR>
nnoremap <silent> <C-v>l <esc>:call VisualInitialMove('^V', 'l')<CR>
nnoremap <silent> <C-v>k <esc>:call VisualInitialMove('^V', 'k')<CR>

" double tap / press v again to just enter the mode
nnoremap <silent> vv v
nnoremap <silent> <S-v>v <S-v>
nnoremap <silent> <S-v><S-v> <S-v>
nnoremap <silent> <C-v>v <C-v>
nnoremap <silent> <C-v><C-v> <C-v>

" CR/Ctrl-CR : Add newline above/below. Removes CR shortcut for unmodifiable windows.
func! UpdateCRShortcut()
    if getbufvar(bufnr(''), '&modifiable', 0)
        nnoremap <CR> :<c-u>put =repeat(nr2char(10), v:count1)<cr>
    else
        silent! nunmap <CR>
    endif
endfunc

augroup UpdateCRShorcut
    autocmd!
    autocmd BufEnter * call UpdateCRShortcut()
augroup end


"https://github.com/mhinz/vim-galore
nnoremap <F11>zm  :<c-u>put! =repeat(nr2char(10), v:count1)<cr>'[
nnoremap <CR>  :<c-u>put =repeat(nr2char(10), v:count1)<cr>

" Replaced with splitjoin
" Ctrl+Space - add new lines to arguments and indent
"function! ArgNewlines()
"    let l:save_view = winsaveview()
"    let cp = getpos('.')
"
"    " Add spaces for arguments
"    silent exec 's/\(.*(.*\)\@<=,\([^   ].*)\)\@=/, /g'
"    let llen = strlen(getline('.'))
"
"    " If the line is too long, add newlines for arguments and indent lines
"    if llen <= &tw
"        call setpos('.', cp)
"        return
"    endif
"
"    let cnt = CountLine('\(.*(.*\)\@<=,\(.*)\)\@=')
"    if cnt == 0 | return | endif
"    silent exe 's/\(.*(.*\)\@<=,\(.*)\)\@=/,\r/g'
"    call feedkeys(string(cnt) . '==', 't')
"
"    " Restore position
"    call winrestview(l:save_view)
"    call histdel('search', -3)
"    call setpos('.', cp)
"endfunction
"
"nnoremap <C-Space> :call ArgNewlines()<CR>

" Swap words left / right
" http://vim.wikia.com/wiki/Swapping_characters,_words_and_lines
nnoremap <silent> <M-u> "_yiw?\w\+\_W\+\%#<CR>:s/\(\%#\w\+\)\(\_W\+\)\(\w\+\)/\3\2\1/<CR><c-o><c-l>:nohlsearch<CR>
nnoremap <silent> <M-i> "_yiw:s/\(\%#\w\+\)\(\_W\+\)\(\w\+\)/\3\2\1/<CR><c-o>/\w\+\_W\+<CR><c-l>:nohlsearch<CR>

" Incrementing word
let g:__increment = 0

function! DoIncrement(dec)
    let rega = @" | let regb = @0
    exec 'normal! viwy' | let oldval = @0
    if a:dec == 1 | exec 'normal! ' . g:__increment . "\<C-x>" | else |
                \ exec 'normal! ' . g:__increment . "\<C-a>" | endif
    exec "normal! viwy"| let newval = @0
    let @" = rega
    let @0 = regb
    if oldval ==# newval | return | endif
    let g:__increment = g:__increment + 1
endfunction

nmap <M-a> :let g:__increment = g:__increment + 1<CR>:exec "normal! ".g:__increment."\<C-a>"<CR>
nmap <M-x> :let g:__increment = g:__increment + 1<CR>:exec "normal! ".g:__increment."\<C-x>"<CR>
nmap <M-X> :let g:__increment = 0<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Windows & Tabs / UI                                         "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Space to fold visual selection/toggle fold.
nnoremap <space> za
vnoremap <space> zf

" Tab / Shift-Tab: Next tab/previous tab
nnoremap <silent> <Tab> :tabnext<cr>
nnoremap <silent> <S-Tab> :tabprevious<cr>

" Ctrl+Tab / Ctrl+Shift-Tab: Move tab forward/backward
" Requires terminal configured to send terminal F11 escape code
function! MoveTab(dir)
    try | if a:dir ==? 'h' | tabmove - | else | tabmove + | endif
    catch | endtry
endfunction

nnoremap <silent> <F11>Zt :call MoveTab('l')<cr>
nnoremap <silent> <F11>ZT :call MoveTab('h')<cr>
xnoremap <silent> <F11>Zt <esc>:call MoveTab('l')<cr>gv
xnoremap <silent> <F11>ZT <esc>:call MoveTab('h')<cr>gv
inoremap <silent> <F11>Zt <C-o>:call MoveTab('l')<cr>
inoremap <silent> <F11>ZT <C-o>:call MoveTab('h')<cr>

" Ctrl+shift+hjkl
" Requires terminal configured to send terminal F11 escape code
map <silent> <F11>ZH [-
map <silent> <F11>ZU [+
map <silent> <F11>ZJ ]=
map <silent> <F11>ZK [=
map <silent> <F11>ZI ]-
map <silent> <F11>ZL ]+

" Ctrl+alt+shift+hjkl
map <silent> <F11>zH :ALEPreviousWrap<CR>
map <silent> <F11>zJ :ptag<CR>
map <silent> <F11>zK gd
map <silent> <F11>zL :ALENextWrap<CR>

" CTRL-T : Open a new tab
let g:__new_tab_cmd = ":tabnew . / | Startify\<CR>"
nnoremap <silent><expr><C-t> g:__new_tab_cmd

" Alt+Tab : Next window
nnoremap <M-Tab> <C-w>w

" More natural window resize. Extends windoow in the given direction.
" Returns 1 if window can move in dir (<left>/<right>/<up>/<down>)
function! MyWindowResize(dir)
    if CanMoveWindow(a:dir)
        if a:dir == 'k' || a:dir == 'j' | exe "wincmd +"
        elseif a:dir == 'h' || a:dir == 'l' | exe "wincmd >"
        endif
    elseif !CanMoveWindow({'h': 'l','j': 'k','k': 'j','l': 'h'}[a:dir])
        return
    else
        if a:dir == 'k' || a:dir == 'j' | exe "wincmd -"
        elseif a:dir == 'h' || a:dir == 'l' | exe "wincmd <"
        endif
    endif
endfunction

" Resize using Ctrl+Alt and +/-, up/down normally and left-right with shift
" Requires terminal capable of and configured to send the corresponding keys
nnoremap <silent><F11>zKUND :call MyWindowResize('h')<CR>
vnoremap <silent><F11>zKUND <esc>:call MyWindowResize('h')<CR>gv
inoremap <silent><F11>zKUND <C-o>:call MyWindowResize('h')<CR>
nnoremap <silent><F11>zKPLS :call MyWindowResize('l')<CR>
vnoremap <silent><F11>zKPLS <esc>:call MyWindowResize('l')<CR>gv
inoremap <silent><F11>zKPLS <C-o>:call MyWindowResize('l')<CR>
nnoremap <silent><F11>zKMIN :call MyWindowResize('j')<CR>
vnoremap <silent><F11>zKMIN <esc>:call MyWindowResize('j')<CR>gv
inoremap <silent><F11>zKMIN <C-o>:call MyWindowResize('j')<CR>
nnoremap <silent><F11>zKEQL :call MyWindowResize('k')<CR>
vnoremap <silent><F11>zKEQL <esc>:call MyWindowResize('k')<CR>gv
inoremap <silent><F11>zKEQL <C-o>:call MyWindowResize('k')<CR>


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

" Make macros / repeat work for each line in the visual selection
xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>
vnoremap . :normal . <CR>

" Quick macro edit - from https://github.com/mhinz/vim-galore
nnoremap <leader>m  :<c-u><c-r><c-r>='let @'. v:register .' = '.
            \ string(getreg(v:register))<cr><c-f><left>

" <C-Space>, <C-M-Space> - Quick macro shortcuts for q and w
" Requires terminal that outputs <F11>zKspc on pressing <C-M-Space>
nnoremap <C-Space> @q
nnoremap <F11>zKspc @w
vnoremap <C-Space> :normal @q<CR>gv
vnoremap <F11>zKspc :normal @w<CR>gv


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Commands, Command Shortcuts                                 "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" (W)rite
nnoremap <leader>w :w!<cr>
nnoremap <leader>ww :w!<cr>

" (W)rite (S)udo / (S)udo (W)rite
nnoremap <leader>ws :w !sudo tee % > /dev/null<cr>
nnoremap <leader>sw :w !sudo tee % > /dev/null<cr>

" (W)rite (Q)uit / (Q)uit (W)rite
nnoremap <leader>wq :wq<cr>
nnoremap <leader>qw :wq<cr>

" (Q)uit
nnoremap <leader>q :q<cr>
nnoremap <leader><esc> :q<cr>
nnoremap <leader>qq :q<cr>

" (Q)uit!
nnoremap <leader>q! :q!<cr>
nnoremap <leader><s-q> :q!<cr>
nnoremap <leader>q<esc> :q!<cr>

" (Esc)(Esc)
nnoremap <leader><Esc><Esc> :Wipeout<CR>

" Save session
nnoremap <leader>SS :SSave<cr>

"" <Leader>ss = SynStack
function! SynStack()
    if !exists("*synstack")
        return
    endif
    echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc
nnoremap <leader>ss :call SynStack()<cr>


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
    exe prevNr . "wincmd w"
    return curNr != prevNr
endfunction


" Returns [char, x, y] where x,y is the new position and char is 's' for
" whitespace or no character, 'o' for all other characters or 'e' if the
" buffer ends.
function! GetCharInDir(dir, xp, yp, blank)
    let xOff = {'h': -1, 'j': 0, 'k': 0, 'l': 1}[tolower(a:dir)]
    let yOff = {'h': 0, 'j': 1, 'k': -1, 'l': 0}[tolower(a:dir)]
    let xs = a:xp | let ys = a:yp
    let xp = a:xp + xOff | let yp = a:yp + yOff
    let char = 'o'

    if yp > line('$') || yp <= 1 | let char = 'e'
    elseif a:dir ==? 'j' || a:dir ==? 'k'
        if strlen(getline(yp)[xp - 1]) == 0 | let char = 's'
        elseif getline(yp)[xp - 1] =~ '\s' | let char = 's' | endif
    elseif a:dir ==? 'h' && xp <= 1 | let char = 'e'
    elseif a:dir ==? 'l' && xp >= strlen(getline(ys)) | let char = 'e'
    elseif (a:dir ==? 'h' || a:dir ==? 'l') && getline(yp)[xp - 1] =~ '\s'
        let char = 's'
    endif

    if a:blank == 1  && char == 's' | let char = 'b' | endif
    return [char, xp, yp]
endfunction

" Selects a region with visual block mode.
function! VisualBlockSelect(x1, y1, x2, y2)
    call cursor(a:y1, a:x1)
    silent exec 'normal! '
    call cursor(a:y2, a:x2)
endfunction

" Moves through non-whitespace characters or whitespace characters depending
" on the character under the cursor. Stops at a non-whitespace character.
" Dir is either j (down) or k (up)
function! MoveNextChar(dir)
    return MoveNextCharBlank(a:dir, 0)
endfunction

function! MoveNextCharBlank(dir, stopBlank)
    let result = GetCharInDir(a:dir, col('.'), line('.'), a:stopBlank)
    let startChar = result[0]
    let ldir = tolower(a:dir)
    if result[0] ==? 'e' | return | endif

    while result[0] == startChar
        let result = GetCharInDir(a:dir, result[1], result[2], a:stopBlank)
    endwhile


    if result[0] ==? 's' || result[0] ==? 'b'
        if ldir ==? 'j' || ldir  ==? 'k'
            call cursor(result[2] + {'j': -1, 'k': 1}[ldir], result[1])
        elseif ldir ==? 'h' || ldir  ==? 'l'
            call cursor(result[2], result[1] + {'h': 1, 'l': -1}[ldir])
        endif

        return
    endif

    call cursor(result[2], result[1])
endfunction

" https://vi.stackexchange.com/questions/6975/store-the-number-of-matches-in
" -vimscript-function
"  Count the number of matches on the current line / entire file
function! CountLine(pattern)
    return Count(a:pattern, 1)
endfunction

function! Count(pattern, lineOnly)
    let lstr = ''
    if lineOnly == 1 | lstr = '%' | endif

    redir => cnt
        try | silent exe lstr . 's/' . a:pattern . '//gn'
                    \ | catch | return 0 | endtry
    redir END

    let res = strpart(cnt, 0, stridx(cnt, " "))
    return substitute(res, '[^0-9]', '', '')
endfunction

" Sets mode
function! EnterMode(mode)
    if a:mode ==# 'V' | exec "normal! \<S-v>"
    elseif a:mode ==# 'v' | exec 'normal! v'
    elseif a:mode ==# '^V' | exec 'normal! '
    elseif a:mode ==# 'i' | exec 'normal! i'
    elseif a:mode ==# 'a' | exec 'normal! a'
    elseif a:mode ==# 'n' | exec "normal! \<esc>"
    endif
endfunction
