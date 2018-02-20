""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" shortcuts.vim
" =============
"
" Author:                Michael De Pasquale
" Creation Date:         2017-12-02
"
" Description
" -----------
" All user-defined shortcuts and commands go here. Note that some commands
" require a terminal configured to send different keys for certain key
" combinations.
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" TODO: Add mappings to allow switching visual modes directly

" Commands{{{
" <Leader>ww : (WW)rite buffer{{{
nnoremap <leader>ww :w!<cr>
"}}}
" <Leader>ws : (W)rite buffer using (S)udo {{{
nnoremap <leader>ws :w !sudo tee % > /dev/null<cr>
nnoremap <leader>sw :w !sudo tee % > /dev/null<cr>
"}}}
" <Leader>wq : (W)rite buffer then (Q)uit{{{
nnoremap <leader>wq :wq<cr>
"}}}
" <Leader>qq : (QQ)uit editing buffer{{{
nnoremap <leader>qq :q<cr>
"}}}
" <Leader><S-q><S-q> (QQ)uit editing buffer without saving{{{
nnoremap <leader>q! :q!<cr>
nnoremap <leader><s-q> :q!<cr>
nnoremap <leader>q<esc> :q!<cr>
"}}}
" <Leader>SS - (S)ave (S)ession{{{
nnoremap <leader>SS :SSave<cr>
"}}}
" <Leader>ss - (S)how (S)yntax highight group under the cursor{{{
nnoremap <leader>ss :echo CursorSynAttr('name')<cr>
"}}}
"}}}

" Movement{{{
" j/k : Move up/down screen lines instead of buffer lines  {{{
noremap j gj
noremap k gk
"}}}
" 0 : Move to the first non-blank character.{{{
noremap 0 ^
"}}}
" Ctrl + o/p : Go forward/backward in jump list{{{
nnoremap <C-O> <C-o>
nnoremap <C-p> <C-i>
"}}}
" PageUp / PageDown : Scroll one page up/down{{{
nnoremap <PageDown> :<C-u>call PageUpDown('j', 2 * v:count1)<CR>
nnoremap <PageUp> :<C-u>call PageUpDown('k', 2 * v:count1)<CR>
inoremap <PageDown> <C-o>:<C-u>call PageUpDown('j', 2 * v:count1)<CR>
inoremap <PageUp> <C-o>:<C-u>call PageUpDown('k', 2 * v:count1)<CR>
xnoremap <PageDown> <esc>:<C-u>call PageUpDown('j', 2 * v:count1)<CR>gv
xnoremap <PageUp> <esc>:<C-u>call PageUpDown('k', 2 * v:count1)<CR>gv
"}}}
" CTRL + h/l : Scroll half of a page up/down{{{
nnoremap <C-h> :<C-u>call PageUpDown('k')<CR>
nnoremap <C-l> :<C-u>call PageUpDown('j')<CR>
inoremap <C-h> <C-o>:<C-u>call PageUpDown('k')<CR>
inoremap <C-l> <C-o>:<C-u>call PageUpDown('j')<CR>
xnoremap <C-h> <esc>:<C-u>call PageUpDown('k')<CR>gv
xnoremap <C-l> <esc>:<C-u>call PageUpDown('j')<CR>gv
"}}}
" CTRL + j/k : Jump to the next/previous function{{{
nnoremap <silent> <C-j> :call feedkeys(']]')<cr>zx
nnoremap <silent> <C-k> :call feedkeys('[[')<cr>zx
inoremap <silent> <C-j> <esc>:call feedkeys(']]')<cr>zxa
inoremap <silent> <C-k> <esc>:call feedkeys('[[')<cr>zxa
xnoremap <silent> <C-j> <esc>:call feedkeys(']]')<cr>zxgv
xnoremap <silent> <C-k> <esc>:call feedkeys('[[')<cr>zxgv
"}}}
" Alt + h/l : Move just before whitespace characters{{{
nnoremap <silent> <M-h> :call DoMoveLR('h')<CR>
nnoremap <silent> <M-l> :call DoMoveLR('l')<CR>
inoremap <silent> <M-h> <esc>:call DoMoveLR('h')<CR>a
inoremap <silent> <M-l> <esc>:call DoMoveLR('l')<CR>a
xnoremap <silent> <M-h> :<C-u>call DoVisualMove('h')<CR>
xnoremap <silent> <M-l> :<C-u>call DoVisualMove('l')<CR>
"}}}
" Alt + j/k : Move through whitespace/non whitespace characters{{{
nnoremap <silent> <M-j> :call MoveNextChar('j')<CR>
nnoremap <silent> <M-k> :call MoveNextChar('k')<CR>
inoremap <silent> <M-j> <esc>:call MoveNextChar('j')<CR>a
inoremap <silent> <M-k> <esc>:call MoveNextChar('k')<CR>a
xnoremap <silent> <M-j> :<C-u>call DoVisualMove('j')<CR>
xnoremap <silent> <M-k> :<C-u>call DoVisualMove('k')<CR>
"}}}
" Alt + Shift + h/l : Jump to the start/end of the current line{{{
nnoremap <silent> <M-H> 0
nnoremap <silent> <M-L> g_
inoremap <silent> <M-H> <esc>0i
inoremap <silent> <M-L> <esc>g_a
xnoremap <silent> <M-H> 0
xnoremap <silent> <M-L> g_
"}}}
" Alt + Shift + j/k : Jump to the next/previous paragraph{{{
nnoremap <silent> <M-J> }
nnoremap <silent> <M-K> {
inoremap <silent> <M-J> <esc>}i
inoremap <silent> <M-K> <esc>{i
xnoremap <silent> <M-J> }
xnoremap <silent> <M-K> {
"}}}
"}}}

" Search{{{
" * : Search forwards for the current visual selection{{{
" Source: Vim wiki
vnoremap <silent> * :<C-U>
\let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
\gvy?<C-R><C-R>=substitute(
\escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
\gV:call setreg('"', old_reg, old_regtype)<CR>
"}}}
" # : Search backwards for the current visual selection{{{
vnoremap <silent> # :<C-U>
\let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
\gvy?<C-R><C-R>=substitute(
\escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
\gV:call setreg('"', old_reg, old_regtype)<CR>

" Ctrl+R in visual mode writes a search-replace command for the selected text
vnoremap <C-r> <ESC>:call SearchReplaceVisualSelection()<CR>
"}}}
"}}}

" Editing{{{
" <Leader> + P/p/y/Y : Put from system clipboard / Yank to system clipboard{{{
nmap <silent> <Leader>y "+y
nmap <silent> <Leader>Y :call ExecNoCursor('normal! V"+y')<CR>
xmap <silent> <Leader>y "+y
xmap <silent> <Leader>Y "+Y
nmap <silent> <Leader>p :call ExecNoCursor('normal! "+p')<CR>:let @"=@0<CR>
nmap <silent> <Leader>P :call ExecNoCursor('normal! "+P')<CR>:let @"=@0<CR>
xmap <silent> <Leader>p <esc>:call ExecNoCursor('normal! gv"+p')<CR>:let @"=@0<CR>
xmap <silent> <Leader>P <esc>:call ExecNoCursor('normal! gv"+P')<CR>:let @"=@0<CR>
"}}}
" Change put behaviour {{{
" * Put without copying replaced text
" * Put without moving cursor
" * Revert to previous yank text after putting deleted text from explicit
"   delete & substitute commands
nnoremap <silent> p :call ExecNoCursor('normal! p')<CR>:let @"=@0<CR>
nnoremap <silent> P :call ExecNoCursor('normal! P')<CR>:let @"=@0<CR>
xnoremap <silent> p <esc>:call ExecNoCursor("normal! gvp")<CR>:let @"=@0<CR>
xnoremap <silent> P <esc>:call ExecNoCursor("normal! gvP")<CR>:let @"=@0<CR>
"}}}
" Keep selection when indenting{{{
xnoremap <  <gv
xnoremap >  >gv
"}}}
" Make cl/ch/dl/dh act on lines instead of characters{{{
nnoremap cl c$
nnoremap ch c0
nnoremap yl y$
nnoremap yh y0
nnoremap dl d$
nnoremap dh d0
nnoremap <S-c> Vc
nnoremap <S-y> Vy
nnoremap <S-d> Vd
"}}}
" Ctrl + Alt + Shift + h/l : Next error / Prev error{{{
nnoremap <silent> <F11>zH :ALEPreviousWrap<CR>
nnoremap <silent> <F11>zL :ALENextWrap<CR>
"}}}
" Ctrl + Alt + Shift + j/k : Go to definition / Jump to tag{{{
nnoremap <silent> <F11>zJ :ptag<CR>
nnoremap <silent> <F11>zJ :ptag<CR>
nnoremap <silent> <F11>zK gd
"}}}
" Alt + u/i : Swap words left / right{{{
" http://vim.wikia.com/wiki/Swapping_characters,_words_and_lines
nnoremap <silent> <M-u> "_yiw?\w\+\_W\+\%#<CR>:s/\(\%#\w\+\)\(\_W\+\)\(\w\+\)/\3\2\1/<CR><c-o><c-l>:nohlsearch<CR>
nnoremap <silent> <M-i> "_yiw:s/\(\%#\w\+\)\(\_W\+\)\(\w\+\)/\3\2\1/<CR><c-o>/\w\+\_W\+<CR><c-l>:nohlsearch<CR>
"}}}
" CR/Shift + CR : Insert newline after/before current line{{{
"https://github.com/mhinz/vim-galore
nnoremap <F11>zm  :<c-u>put! =repeat(nr2char(10), v:count1)<cr>'[
nnoremap <CR>  :<c-u>put =repeat(nr2char(10), v:count1)<cr>
"}}}
" Alt + Return : Create a copy of the current line below.{{{
nnoremap <M-CR> :t.<CR>
inoremap <M-CR> <C-o>:t.<CR>

augroup UpdateCRShorcut
    autocmd!
    autocmd BufEnter * call UpdateCRShortcut()
augroup end
"}}}
"}}}

" Windows & Tabs / UI{{{
" Space : Fold visual selection / toggle fold {{{
nnoremap <space> za
vnoremap <space> zf
"}}}
" Ctrl + Space : Close other folds{{{
" requires terminal configured to send the keys below for ctrl+alt+space
nnoremap <C-Space> zx
inoremap <C-Space> <esc>zxa
xnoremap <C-Space> <esc>zxgv
"}}}
" Ctrl + Alt + Space : Toggle folding{{{
" requires terminal configured to send the keys below for ctrl+alt+space
nnoremap <F11>zKspc zi
inoremap <F11>zKspc <esc>zia
xnoremap <F11>zKspc <esc>zigv
"}}}
" Tab / Shift + Tab: Next tab/previous tab{{{
nnoremap <silent> <Tab> :tabnext<cr>
nnoremap <silent> <S-Tab> :tabprevious<cr>
"}}}
" Ctrl + Tab / Ctrl + Shift + Tab: Move tab forward/backward{{{
nnoremap <silent> <F11>Zt :tabmove +<cr>
nnoremap <silent> <F11>ZT :tabmove -<cr>
xnoremap <silent> <F11>Zt <esc>:tabmove -<cr>gv
xnoremap <silent> <F11>ZT <esc>:tabmove +<cr>gv
inoremap <silent> <F11>Zt <C-o>:tabmove -<cr>
inoremap <silent> <F11>ZT <C-o>:tabmove +<cr>
"}}}
" CTRL + T : Open a new tab{{{
let g:__new_tab_cmd = ":tabnew . / | Startify\<CR>"
nnoremap <silent><expr><C-t> g:__new_tab_cmd
"}}}
" Alt + Tab : Cycle selected window in current tab{{{
nnoremap <M-Tab> <C-w>w
"}}}
" Ctrl + Alt + -/= : Resize window up/down{{{
nnoremap <silent><F11>zKMIN :call NaturalWindowResize('j')<CR>:redraw<CR>
vnoremap <silent><F11>zKMIN <esc>:call NaturalWindowResize('j')<CR>:redraw<CR>gv
inoremap <silent><F11>zKMIN <C-o>:call NaturalWindowResize('j')<CR><C-o>:redraw<CR>
nnoremap <silent><F11>zKEQL :call NaturalWindowResize('k')<CR>:redraw<CR>
vnoremap <silent><F11>zKEQL <esc>:call NaturalWindowResize('k')<CR>:redraw<CR>gv
inoremap <silent><F11>zKEQL <C-o>:call NaturalWindowResize('k')<CR><C-o>:redraw<CR>
"}}}
" Ctrl + Alt + _/+ : Resize window left/right{{{
nnoremap <silent><F11>zKUND :call NaturalWindowResize('h')<CR>:redraw<CR>
vnoremap <silent><F11>zKUND <esc>:call NaturalWindowResize('h')<CR>:redraw<CR>gv
inoremap <silent><F11>zKUND <C-o>:call NaturalWindowResize('h')<CR><C-o>:redraw<CR>
nnoremap <silent><F11>zKPLS :call NaturalWindowResize('l')<CR>:redraw<CR>
vnoremap <silent><F11>zKPLS <esc>:call NaturalWindowResize('l')<CR>:redraw<CR>gv
inoremap <silent><F11>zKPLS <C-o>:call NaturalWindowResize('l')<CR><C-o>:redraw<CR>
"}}}
"}}}

" Terminal{{{
" Escape : Exit terminal edit mode{{{
tnoremap <Esc> <C-\><C-n>
 "}}}
 "}}}

" Macros{{{
" Alt + q/w : Execute (Q)/(W) macros{{{
nnoremap <M-q> @q
nnoremap <M-w> @w
"}}}
" <Leader>m : Quick (M)acro edit{{{
" Source: https://github.com/mhinz/vim-galore
nnoremap <leader>m  :<c-u><c-r><c-r>='let @'. v:register .' = '.
            \ string(getreg(v:register))<cr><c-f><left>
"}}}
" Make macros / repeat work for each line in the visual selection{{{
xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>
vnoremap . :normal . <CR>
"}}}
"}}}

" Miscellaneous{{{
" Shift + q : NOP - disable ex mode shortcut{{{
noremap <S-q> <Nop>
"}}}
" <Leader> + ml : Append modeline after last line in buffer.{{{
" Source: http://vim.wikia.com/wiki/Modeline_magic
nnoremap <silent> <Leader>ml :call AppendModeline()<CR>
"}}}
"}}}

" Functions{{{
" Wrappers / Input{{{
" ExecuteMacroOverVisualRange : Executes for lines in the visual selection{{{
" https://github.com/robertmeta/vimfiles/blob/master/vimrc
function! ExecuteMacroOverVisualRange()
    echo '@'.getcmdline()
    execute ":'<,'>normal @".nr2char(getchar())
endfunction
"}}}
" VisualBlockSelect : Selects a given region with visual block mode.{{{
function! VisualBlockSelect(x1, y1, x2, y2)
    call cursor(a:y1, a:x1)
    silent exec 'normal! '
    call cursor(a:y2, a:x2)
endfunction
"}}}
" ExecNoCursor : Executes a command and restores the cursor position.{{{
function! ExecNoCursor(cmd)
    let pos = getpos('.')
    exec a:cmd
    call cursor(pos[1], pos[2], pos[3])
endfunction
"}}}
" EnterMode : Enters the given mode{{{
function! EnterMode(mode)
    if a:mode ==# 'V' | exec "normal! \<S-v>"
    elseif a:mode ==# 'v' | exec 'normal! v'
    elseif a:mode ==# '^V' | exec 'normal! '
    elseif a:mode ==# 'i' | exec 'normal! i'
    elseif a:mode ==# 'a' | exec 'normal! a'
    elseif a:mode ==# 'n' | exec "normal! \<esc>"
    endif
endfunction
"}}}
" SearchReplaceVisualSelection : Search/replace command assistant{{{
function! SearchReplaceVisualSelection()
    " Backup user data, get search string
    let startPos = getpos('.')
    let oldReg = getreg('"') | let oldRegtype = getregtype('"')
    call inputsave()
    let srch = inputdialog('Search:', '', "")

    if srch == ''
        call setreg('"', oldReg, oldRegtype)
        call cursor(startPos[1], startPos[2], startPos[3])
        call inputrestore()
        return
    endif

    " Get replace string
    let repl = inputdialog('Replace:', '',  '____CANCEL____')
    call inputrestore()

    if repl == ""
        call setreg('"', oldReg, oldRegtype)
        call cursor(startPos[1], startPos[2], startPos[3])
        return
    endif

    " Create search command and write to buffer
    execute 'normal gvy'
    let selected = substitute(escape(@", '/\.*$^~['),
                \ '\_s\+', '\\_s\\+', 'g')
    call setreg('"', oldReg, oldRegtype)
    call cursor(startPos[1], startPos[2], startPos[3])
    if srch == '' | let srch = selected
    elseif repl == '' | let repl = selected | endif
    call feedkeys(':%s/'.srch.'/'.repl.'/g', 't')
endfunction
"}}}
" NaturalWindowResize : Intuitive window resize{{{
" Returns 1 if window can move in dir (<left>/<right>/<up>/<down>)
function! NaturalWindowResize(dir)
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
"}}}
"}}}
" Movement{{{
" PageUpDown : Page up/down without moving cursor{{{
function! PageUpDown(dir, ...)
    if a:0 > 0 | let l:ct = a:1 | else | let l:ct = v:count1 | endif
    let l:back = &scroll | set scroll=0
    if a:dir == 'j' | let l:cm = "\<C-D>" | else | let l:cm = "\<C-U>" | endif
    exec 'normal! ' . repeat(l:cm, l:ct) | exec ':set scroll=' . l:back
endfunction
"}}}
" DoMoveLR : Jump just before whitespace characters left/right{{{
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
"}}}
" DoVisualMove : DoMoveLR for visual modes{{{
function! DoVisualMove(dir)
    exec 'normal! gv'
    if a:dir ==? 'h' || a:dir ==? 'l' | call DoMoveLR(a:dir) | endif
    call MoveNextChar(a:dir)
endfunction
"}}}
" MoveNextChar : Move through whitespace/non-whitespace characters{{{
" Moves through non-whitespace characters or whitespace characters depending
" on the character under the cursor. Stops at a non-whitespace character.
" Dir is either j (down) or k (up)
function! MoveNextChar(dir)
    return MoveNextCharBlank(a:dir, 0)
endfunction
"}}}
" MoveNextCharBlank : MoveNextChar, but can stop at blank characters{{{
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
"}}}
"}}}
" Misc{{{
" GetCharInDir : Returns the character in the given direction{{{
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
"}}}
" CanMoveWindow : Returns whether the window can be moved in a direction{{{
" Returns 1 if window can move in dir (<left>/<right>/<up>/<down>)
function! CanMoveWindow(dir)
    let prevNr = winnr() | exe "wincmd " . a:dir
    let curNr = winnr() | exe prevNr . "wincmd w"
    return curNr != prevNr
endfunction
"}}}
" CursorSynAttr : Get a syntax attribute for text under the cursor{{{
function! CursorSynAttr(attr)
    return synIDattr(synIDtrans(synID(line('.'), col('.'), 'TRUE')), a:attr)
endfunc
"}}}
" UpdateCRShortcut : Update the <Enter> shortcut for adding newlines{{{
function! UpdateCRShortcut()
    if getbufvar(bufnr(''), '&modifiable', 0)
        nnoremap <CR> :<c-u>put =repeat(nr2char(10), v:count1)<cr>
    else | silent! nunmap <CR> | endif
endfunc
"}}}
" AppendModeline : Adds a modeline comment or replacing the existing modeline{{{
" Append modeline after last line in buffer.
" Source: http://vim.wikia.com/wiki/Modeline_magic
function! AppendModeline()
    " Remove existing modeline
    if match(getline(line('$')), '\V' .
                \ escape(matchstr(&commentstring,'\zs.*\ze%s'), '\') .
                \ '\s\*\[Vv]im\?:\s\+se\[t]', 0, 1) >= 0
        call ExecNoCursor(string(line('$')) . 'd')
    endif

    " Build and append new modeline
    let l:modeline = printf(" vim: set ts=%d sw=%d tw=%d fdm=%s %set :",
                \ &tabstop, &shiftwidth, &textwidth, &foldmethod,
                \ &expandtab ? '' : 'no')
    let l:modeline = substitute(&commentstring, "%s", l:modeline, "")
    call append(line("$"), l:modeline)
endfunction
"}}}
"}}}
"}}}
" vim: set ts=4 sw=4 tw=79 fdm=marker et :
