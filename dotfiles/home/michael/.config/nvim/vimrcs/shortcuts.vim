""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" shortcuts.vim
" =============
"
" Description:           Contains all non-plugin shortcuts.
" Author:                Michael De Pasquale <shaggyrogers>
" Creation Date:         2017-12-02
" Modification Date:     2019-01-04
" License:               MIT
"
" Note that some key combinations require kitty with a certain configuration.
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" TODO:
" * Add mappings to allow switching visual modes directly
" * Join undo where appropriate and make sure user data is preserved
" * Reset and revert user settings where necessary
" * Make Shift+j delete all but 1 of the blank lines below

" Commands {{{
function! RepeatCommandShortcut(shortcut) "{{{
    exec a:shortcut . repeat('|' . a:shortcut, v:count1-1)
endfunction " }}}
" <Leader> + s : show (S)yntax highight group under the cursor {{{
nnoremap <leader>s <cmd>:echo CursorSynInfo('name')<CR>
"}}}
" <Leader> + w : (W)rite buffer {{{
nnoremap <leader>w <cmd>:w!<CR>
"}}}
" <Leader> + Shift + w: (W)rite buffer using sudo {{{
command! W w !sudo tee % > /dev/null
nnoremap <leader><s-w> <cmd>:W<CR>
"}}}
" <Leader> + q : (Q)uit buffer {{{
nnoremap <leader>q :<cmd>call RepeatCommandShortcut('q')<CR>
xnoremap <leader>q :<cmd>call RepeatCommandShortcut('q')<CR>
"}}}
" <Leader> + Shift + q : (Q)uit buffer without saving {{{
nnoremap <leader><s-q> <cmd>:call RepeatCommandShortcut('q!')<CR>
xnoremap <leader><s-q> <cmd>:call RepeatCommandShortcut('q!')<CR>
"}}}
" <Leader> + S : Save (S)ession {{{
nnoremap <leader>SS <cmd>:SSave<CR>
xnoremap <leader>SS <cmd>:SSave<CR>
"}}}
" <Leader> + End + End : Save all buffers and exit vim {{{
nnoremap <leader><End><End> <cmd>:confirm wqall<CR>
xnoremap <leader><End><End> <cmd>:confirm wqall<CR>
"}}}
"}}}

" Movement {{{
" j, k : Move screen lines unless a count is given, save  >5 lines as jump {{{
nnoremap <expr> j v:count ? (v:count > 5 ? "m'" . v:count : '') . 'j' : 'gj'
nnoremap <expr> k v:count ? (v:count > 5 ? "m'" . v:count : '') . 'k' : 'gk'
xnoremap <expr> j v:count ? (v:count > 5 ? "m'" . v:count : '') . 'j' : 'gj'
xnoremap <expr> k v:count ? (v:count > 5 ? "m'" . v:count : '') . 'k' : 'gk'
" }}}
" 0 : Move to the first non-blank character. {{{
noremap 0 ^
"}}}
" Ctrl + o/p : Go forward/backward in jump list {{{
nnoremap <C-O> <C-o>
nnoremap <C-p> <C-i>
"}}}
" PageUp / PageDown : Scroll one page up/down {{{
nnoremap <PageDown> <cmd>call PageUpDown('j', 2 * v:count1)<CR>
nnoremap <PageUp> <cmd>call PageUpDown('k', 2 * v:count1)<CR>
inoremap <PageDown> <cmd>call PageUpDown('j', 2 * v:count1)<CR>
inoremap <PageUp> <cmd>call PageUpDown('k', 2 * v:count1)<CR>
xnoremap <PageDown> <cmd>call PageUpDown('j', 2 * v:count1)<CR>
xnoremap <PageUp> <cmd>call PageUpDown('k', 2 * v:count1)<CR>
"}}}
" CTRL + h/l : Scroll half of a page up/down {{{
nnoremap <C-h> <cmd>call PageUpDown('k')<CR>
nnoremap <C-l> <cmd>call PageUpDown('j')<CR>
xnoremap <C-h> <cmd>call PageUpDown('k')<CR>
xnoremap <C-l> <cmd>call PageUpDown('j')<CR>
"}}}
" CTRL + j/k : Jump to the next/previous fold {{{
nnoremap <silent> <C-j> zj
nnoremap <silent> <C-k> zk
xnoremap <silent> <C-j> zj
xnoremap <silent> <C-k> zk
"}}}
" Alt + h/l : Move just before whitespace characters {{{
nnoremap <silent> <M-h> <cmd>call DoMoveLR('h')<CR>
nnoremap <silent> <M-l> <cmd>call DoMoveLR('l')<CR>
inoremap <silent> <M-h> <esc>:call DoMoveLR('h')<CR>a
inoremap <silent> <M-l> <esc>:call DoMoveLR('l')<CR>a
xnoremap <silent> <M-h> :<C-u>call DoVisualMove('h')<CR>
xnoremap <silent> <M-l> :<C-u>call DoVisualMove('l')<CR>
"}}}
" Alt + j/k : Move through whitespace/non whitespace characters {{{
nnoremap <silent> <M-j> :call MoveNextChar('j')<CR>
nnoremap <silent> <M-k> :call MoveNextChar('k')<CR>
inoremap <silent> <M-j> <esc>:call MoveNextChar('j')<CR>a
inoremap <silent> <M-k> <esc>:call MoveNextChar('k')<CR>a
xnoremap <silent> <M-j> :<C-u>call DoVisualMove('j')<CR>
xnoremap <silent> <M-k> :<C-u>call DoVisualMove('k')<CR>
"}}}
" Alt + Shift + h/l : Jump to the start/end of the current line {{{
nnoremap <silent> <M-H> 0
nnoremap <silent> <M-L> g_
inoremap <silent> <M-H> <esc>0i
inoremap <silent> <M-L> <esc>g_a
xnoremap <silent> <M-H> 0
xnoremap <silent> <M-L> g_
"}}}
" Alt + Shift + j/k : Jump to the next/previous paragraph {{{
nnoremap <silent> <M-J> }
nnoremap <silent> <M-K> {
inoremap <silent> <M-J> <esc>}i
inoremap <silent> <M-K> <esc>{i
xnoremap <silent> <M-J> }
xnoremap <silent> <M-K> {
"}}}
" Ctrl + Alt + Shift + h/l : Next error / Prev error {{{
nnoremap <silent> <Char-0x10>HZ <cmd>ALEPreviousWrap<CR>
nnoremap <silent> <Char-0x10>Hd <cmd>ALENextWrap<CR>
"}}}
" Ctrl + Alt + Shift + j/k : Go to definition / Jump to tag {{{
nnoremap <silent> <Char-0x10>Hb <cmd>ptag<CR>
nnoremap <silent> <Char-0x10>Hc gd
"}}}
" Ctrl + Alt + Shift + o/p : Next/prev git change {{{
nnoremap <silent> <Char-0x10>Hg <cmd>call feedkeys('[c', 't')<CR>
nnoremap <silent> <Char-0x10>Hh <cmd>call feedkeys(']c', 't')<CR>
"}}}
"}}}

" Search {{{
" * : Search forwards for the current visual selection {{{
" Source: Vim wiki
vnoremap <silent> * :<C-U>
\let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
\gvy?<C-R><C-R>=substitute(
\escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
\gV:call setreg('"', old_reg, old_regtype)<CR>
"}}}
" # : Search backwards for the current visual selection {{{
vnoremap <silent> # :<C-U>
\let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
\gvy?<C-R><C-R>=substitute(
\escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
\gV:call setreg('"', old_reg, old_regtype)<CR>

" Ctrl+R in visual mode writes a search-replace command for the selected text
vnoremap <C-r> <ESC>:call SearchReplaceVisualSelection()<CR>
"}}}
" Ctrl + n / Ctrl + Shift + n : Next / Previous match and update folds{{{
nmap <silent> <expr> <C-n> ':<C-u>execute "normal '.v:count1.'nzx"<CR>'
nmap <silent> <expr> <Char-0x10>Ff ':<C-u>execute "normal '.v:count1.'Nzx"<CR>'
"}}}
"}}}

" Editing {{{
" <Leader> + P/p/y/Y : Put/yank from/to system clipboard {{{
nnoremap <silent> <Leader>y "+y
nnoremap <silent> <Leader>Y V"+y
xnoremap <silent> <Leader>y "+ygv
xnoremap <silent> <Leader>Y "+Ygv
nnoremap <silent> <Leader>p "+p`[
nnoremap <silent> <Leader>P "+P`[
xnoremap <silent> <expr> <Leader>p '"+pgv'
xnoremap <silent> <expr> <Leader>P '"+Pgv'
"}}}
" y / Y : Keep visual selection when yanking {{{
xnoremap y ygv
xnoremap Y Ygv
"}}}
" p / P : Change put behaviour {{{
" * Put without copying replaced text
" * Put without moving cursor
" * Ctrl + Shift + p toggles copying when pasting visual selection
function! s:GetPutRegister()
    let @" = @0
    return '"'
endfunction

function! PostPut()
    let @" = @0
    return ''
endfunction

nnoremap <silent> <expr> p '"'.<SID>GetPutRegister().'p`[@=PostPut()'."\<CR>"
nnoremap <silent> <expr> P '"'.<SID>GetPutRegister().'P`[@=PostPut()'."\<CR>"
xnoremap <silent> <expr> p '"'.<SID>GetPutRegister().'p'
xnoremap <silent> <expr> P '"'.<SID>GetPutRegister().'P'
" }}}
" Ctrl + Alt + p / P: Paste & jump [NI]{{{
nnoremap <silent> <expr> <Char-0x10>Gh
            \ 'i<C-o>"'.<SID>GetPutRegister().'p'."\<Esc>".'@=PostPut()'.
            \ "\<CR>"
inoremap <silent> <expr> <Char-0x10>Gh
            \ '<C-o>"'.<SID>GetPutRegister().'p<C-o>@=PostPut()'."\<CR>"
" }}}
" x : Delete character / selection without yanking {{{
nnoremap x "_x
xnoremap x "_x
" }}}
" <, >, = : Fast indent, keep selection when indenting {{{
xnoremap <nowait> < <gv
xnoremap <nowait> > >gv
xnoremap <nowait> = =gv
nnoremap <nowait> < <<
nnoremap <nowait> > >>
nnoremap <nowait> = ==
"}}}
" Make cl/ch/dl/dh act on lines instead of characters {{{
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
" Alt + u/i : Swap words left / right {{{
" http://vim.wikia.com/wiki/Swapping_characters,_words_and_lines
nnoremap <silent> <M-u> "_yiw?\w\+\_W\+\%#<CR>:s/\(\%#\w\+\)\(\_W\+\)\(\w\+\)/\3\2\1/<CR><c-o><c-l>:nohlsearch<CR>
nnoremap <silent> <M-i> "_yiw:s/\(\%#\w\+\)\(\_W\+\)\(\w\+\)/\3\2\1/<CR><c-o>/\w\+\_W\+<CR><c-l>:nohlsearch<CR>
"}}}
" Enter / Shift + Enter : Insert newline after / before current line {{{
nnoremap <Char-0x10>Bz  :<c-u>put! =repeat(nr2char(10), v:count1)<cr>'[
nnoremap <CR> <cmd>put =repeat(nr2char(10), v:count1)<cr>
"}}}
" Ctrl + Enter: Insert newline at cursor {{{
nnoremap <Char-0x10>Ez i<CR><Esc>
" }}}
" Alt + Enter : Create a copy of the current line below {{{
nnoremap <expr> <M-CR> repeat(":\<C-u>t.\<CR>", v:count1)
inoremap <expr> <M-CR> repeat("\<C-o>:\<C-u>t.\<CR>", v:count1)

augroup UpdateCRShorcut
    autocmd!
    autocmd BufEnter * call UpdateCRShortcut()
augroup end
"}}}
" <Leader> + Space : Delete trailing whitespace {{{
nnoremap <Leader><Space> <cmd>:call rccommon#DeleteTrailingWS()<CR>
" }}}
" Alt + d / Alt + Shift + d : Convert decimal to hex / hex to decimal [X]{{{
xnoremap <M-d> <cmd>:Dec2hex<CR>
xnoremap <M-D> <cmd>:Hex2dec<CR>
"}}}
" }}}

" Windows & Tabs / UI {{{
" Space : Fold visual selection / toggle fold {{{
nnoremap <silent> <space> za
"vnoremap <silent> <expr> <space> "zfzngv:'<,'>s/\([ ]\{0,2\}\)# [{}]\{3\}/  \0<CR>zN"
vnoremap <space> <cmd>call DoFold()<CR>

function! DoFold()  "{{{
    let l:back = &commentstring
    let &commentstring = '  ' . substitute(&commentstring, '\m^[ ]\+', '', '')
    execute 'normal! zf'
    let &commentstring = l:back
endfunction  "}}}
"}}}
" Ctrl + Space : Close other folds {{{
" requires terminal configured to send the keys below for ctrl+alt+space
nnoremap <C-Space> zx
inoremap <C-Space> <esc>zxa
xnoremap <C-Space> <esc>zxgv
"}}}
" Ctrl + Alt + Space : Toggle folding {{{
" requires terminal configured to send the keys below for ctrl+alt+space
"nnoremap <F11>zKspc zi
"inoremap <F11>zKspc <esc>zia
"xnoremap <F11>zKspc <esc>zigv
nnoremap <Char-0x10>GA zi
inoremap <Char-0x10>GA <esc>zia
xnoremap <Char-0x10>GA <esc>zigv
"}}}
" Tab / Shift + Tab: Next tab/previous tab {{{
nnoremap <silent> <Tab> <cmd>:tabnext<cr>
nnoremap <silent> <S-Tab> <cmd>:tabprevious<cr>
"}}}
" Ctrl + Tab / Ctrl + Shift + Tab: Move tab forward/backward {{{
nnoremap <silent> <Char-0x10>E0 <cmd>:tabmove +<cr>
nnoremap <silent> <Char-0x10>F0 <cmd>:tabmove -<cr>
xnoremap <silent> <Char-0x10>E0 <cmd>:tabmove +<cr>gv
xnoremap <silent> <Char-0x10>F0 <cmd>:tabmove -<cr>gv
inoremap <silent> <Char-0x10>E0 <cmd>:tabmove -<cr>
inoremap <silent> <Char-0x10>F0 <cmd>:tabmove +<cr>
"}}}
" CTRL + T : Open a new tab {{{
"let g:__new_tab_cmd = ":tabnew . / | Startify\<CR>"
"nnoremap <silent><expr><C-t> g:__new_tab_cmd
nnoremap <silent> <C-t> <cmd>:tabe<CR>
"}}}
" Alt + Tab : Cycle selected window in current tab {{{
nnoremap <M-Tab> <C-w>w
"}}}
" Ctrl + Alt + -/= : Resize window up/down {{{
nnoremap <silent> <Char-0x10>GD <cmd>:call NaturalWindowResize('j')<CR><cmd>:redraw<CR>
vnoremap <silent> <Char-0x10>GD <cmd>:call NaturalWindowResize('j')<CR><cmd>:redraw<CR>gv
inoremap <silent> <Char-0x10>GD <cmd>:call NaturalWindowResize('j')<CR><C-o><cmd>:redraw<CR>
nnoremap <silent> <Char-0x10>GR <cmd>:call NaturalWindowResize('k')<CR><cmd>:redraw<CR>
vnoremap <silent> <Char-0x10>GR <cmd>:call NaturalWindowResize('k')<CR><cmd>:redraw<CR>gv
inoremap <silent> <Char-0x10>GR <cmd>:call NaturalWindowResize('k')<CR><C-o><cmd>:redraw<CR>
"}}}
" Ctrl + Alt + _/+ : Resize window left/right {{{
nnoremap <silent> <Char-0x10>HD <cmd>:call NaturalWindowResize('h')<CR><cmd>:redraw<CR>
vnoremap <silent> <Char-0x10>HD <cmd>:call NaturalWindowResize('h')<CR><cmd>:redraw<CR>gv
inoremap <silent> <Char-0x10>HD <cmd>:call NaturalWindowResize('h')<CR><C-o><cmd>:redraw<CR>
nnoremap <silent> <Char-0x10>HR <cmd>:call NaturalWindowResize('l')<CR><cmd>:redraw<CR>
vnoremap <silent> <Char-0x10>HR <cmd>:call NaturalWindowResize('l')<CR><cmd>:redraw<CR>gv
inoremap <silent> <Char-0x10>HR <cmd>:call NaturalWindowResize('l')<CR><C-o><cmd>:redraw<CR>
"}}}
" Backspace : Switch to secondary buffer {{{
nnoremap <BS> <C-^>
" }}}
"}}}

" Terminal {{{
" Leader+Escape : Exit terminal edit mode {{{
tnoremap <nowait> <Leader><Esc> <C-\><C-n>
 "}}}
 "}}}

" Macros {{{
" Alt + q/w : Execute (Q)/(W) macros {{{
nnoremap <M-q> @q
nnoremap <M-w> @w
"}}}
" <Leader> + m : Quick (M)acro edit {{{
" Source: https://github.com/mhinz/vim-galore
nnoremap <leader>m  :<c-u><c-r><c-r>='let @'. v:register .' = '.
            \ string(getreg(v:register))<cr><c-f><left>
"}}}
" Make macros / repeat work for each line in the visual selection {{{
xnoremap @ <cmd>:call ExecuteMacroOverVisualRange()<CR>
vnoremap . <cmd>:normal . <CR>
"}}}
"}}}

" Miscellaneous {{{
" Shift + q : NOP - disable ex mode shortcut {{{
noremap <S-q> <Nop>
"}}}
" Alt + f : Print filename{{{
nmap <M-f> <cmd>:echom expand('%:p')<CR>
imap <M-f> <cmd>:echom expand('%:p')<CR>
xmap <M-f> <cmd>:echom expand('%:p')<CR>
"}}}
" <Leader> + ml : Append modeline after last line in buffer. {{{
" Source: http://vim.wikia.com/wiki/Modeline_magic
nnoremap <silent> <Leader>ml <cmd>:call AppendModeline()<CR>
"}}}
"}}}

" Functions {{{

" Wrappers / Input {{{
" http://vim.wikia.com/wiki/Convert_between_hex_and_decimal
" Dec2hex / Hex2dec{{{
command! -nargs=? -range Dec2hex call s:Dec2hex(<line1>, <line2>, '<args>')
function! s:Dec2hex(line1, line2, arg) range
  if empty(a:arg)
    if histget(':', -1) =~# "^'<,'>" && visualmode() !=# 'V'
      let cmd = 's/\%V\<\d\+\>/\=printf("0x%x",submatch(0)+0)/g'
    else
      let cmd = 's/\<\d\+\>/\=printf("0x%x",submatch(0)+0)/g'
    endif
    try
      execute a:line1 . ',' . a:line2 . cmd
    catch
      echo 'Error: No decimal number found'
    endtry
  else
    echo printf('%x', a:arg + 0)
  endif
endfunction
command! -nargs=? -range Hex2dec call s:Hex2dec(<line1>, <line2>, '<args>')
function! s:Hex2dec(line1, line2, arg) range
  if empty(a:arg)
    if histget(':', -1) =~# "^'<,'>" && visualmode() !=# 'V'
      let cmd = 's/\%V0x\x\+/\=submatch(0)+0/g'
    else
      let cmd = 's/0x\x\+/\=submatch(0)+0/g'
    endif
    try
      execute a:line1 . ',' . a:line2 . cmd
    catch
      echo 'Error: No hex number starting "0x" found'
    endtry
  else
    echo (a:arg =~? '^0x') ? a:arg + 0 : ('0x'.a:arg) + 0
  endif
endfunction"}}}
" ExecuteMacroOverVisualRange : Executes for lines in the visual selection {{{
" https://github.com/robertmeta/vimfiles/blob/master/vimrc
function! ExecuteMacroOverVisualRange()
    echo '@'.getcmdline()
    execute ":'<,'>normal @".nr2char(getchar())
endfunction
"}}}
" VisualBlockSelect : Selects a given region with visual block mode. {{{
function! VisualBlockSelect(x1, y1, x2, y2)
    call cursor(a:y1, a:x1)
    silent exec 'normal! '
    call cursor(a:y2, a:x2)
endfunction
"}}}
" ExecNoCursor : Executes a command and restores the cursor position. {{{
function! ExecNoCursor(cmd)
    let pos = getpos('.')
    exec a:cmd
    call cursor(pos[1], pos[2], pos[3])
endfunction
"}}}
" SearchReplaceVisualSelection : Search/replace command assistant {{{
function! SearchReplaceVisualSelection()
    " Backup user data, get search string
    let oldReg = getreg('"')
    let oldRegtype = getregtype('"')
    call inputsave()

    if &cmdheight >= 2
        echom 'Leave blank for selection. Replace expressions have form \=exp'
    endif

    let srch = inputdialog('Search:', '', "")

    if srch == ''
        call setreg('"', oldReg, oldRegtype)
        return inputrestore()
    endif

    " Get replace string
    let repl = inputdialog('Replace:', '', "")
    call setreg('"', oldReg, oldRegtype)
    call inputrestore()

    if repl == ""
        return setreg('"', oldReg, oldRegtype)
    endif

    " Create search command and write to buffer
    execute 'normal gvy'
    let selected = substitute(escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')
    let lefts = 2
    if srch == '' | let srch = selected | endif
    if repl == '' | let repl = selected | endif
    call feedkeys(":\<C-u>%s/".srch.'/'.repl."/g\<Left>\<Left>", 't')
endfunction
"}}}
" NaturalWindowResize : Intuitive window resize {{{
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

" Movement {{{
" PageUpDown(dir, [count=1]) {{{
" Scroll count half pages in dir (j or k)
function! PageUpDown(dir, ...) abort
    if a:dir != 'j' && a:dir != 'k'
        echoerr 'PageUpDown: Invalid direction ' . a:dir . ' (j or k expected)'
        return
    endif

    let l:ct = a:0 > 0 ? a:1 : v:count1
    let l:sobackup = &scrolloff
    execute 'setlocal scrolloff=' . winheight(0)

    try
        execute 'normal! ' . winheight(0) / 2 * l:ct . 'g' . a:dir

    finally
        execute 'setlocal scrolloff=' . l:sobackup
    endtry
endfunction
"}}}
" DoMoveLR : Jump just before whitespace characters left/right {{{
function! DoMoveLR(dir) abort
    if a:dir != 'h' && a:dir != 'l'
        echoerr 'DoMoveLR: Invalid direction ' . a:dir . ' (h or l expected)'
        return
    endif

    let flags = 'n' . (a:dir == 'h' ? 'b' : '')
    let pos = searchpos('[^     ][  ]',   flags, line('.'), 200)

    if pos[0] == 0 && pos[1] == 0
        silent exec 'normal! ' . (a:dir == 'l' ? '$' : '0')
        return
    endif

    call setpos('.', [0, pos[0], pos[1], 0])
endfunction
"}}}
" DoVisualMove : DoMoveLR for visual modes {{{
function! DoVisualMove(dir) abort
    exec 'normal! gv'

    if a:dir ==? 'h' || a:dir ==? 'l'
        call DoMoveLR(a:dir)
    endif

    call MoveNextChar(a:dir)
endfunction
"}}}
" MoveNextChar : Move through whitespace/non-whitespace characters {{{
" Moves through non-whitespace characters or whitespace characters depending
" on the character under the cursor. Stops at a non-whitespace character.
" Dir is either j (down) or k (up)
function! MoveNextChar(dir) abort
    return MoveNextCharBlank(a:dir, 0)
endfunction
"}}}
" MoveNextCharBlank : MoveNextChar, but can stop at blank characters {{{
function! MoveNextCharBlank(dir, stopBlank) abort
    let result = GetCharInDir(a:dir, col('.'), line('.'), a:stopBlank)
    let startChar = result[0]
    let ldir = tolower(a:dir)

    if result[0] ==? 'e'
        return
    endif

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

" Misc {{{
" GetCharInDir : Returns the character in the given direction {{{
" Returns [char, x, y] where x,y is the new position and char is 's' for
" whitespace or no character, 'o' for all other characters or 'e' if the
" buffer ends.
function! GetCharInDir(dir, xp, yp, blank) abort
    let xOff = {'h': -1, 'j': 0, 'k': 0, 'l': 1}[tolower(a:dir)]
    let yOff = {'h': 0, 'j': 1, 'k': -1, 'l': 0}[tolower(a:dir)]
    let xs = a:xp
    let ys = a:yp
    let xp = a:xp + xOff
    let yp = a:yp + yOff
    let char = 'o'

    if yp > line('$') || yp <= 1
        let char = 'e'
    elseif a:dir ==? 'j' || a:dir ==? 'k'
        if strlen(getline(yp)[xp - 1]) == 0 || getline(yp)[xp - 1] =~ '\s'
            let char = 's'
        endif
    elseif a:dir ==? 'h' && xp <= 1
        let char = 'e'
    elseif a:dir ==? 'l' && xp >= strlen(getline(ys))
        let char = 'e'
    elseif (a:dir ==? 'h' || a:dir ==? 'l') && getline(yp)[xp - 1] =~ '\s'
        let char = 's'
    endif

    if a:blank == 1  && char == 's'
        let char = 'b'
    endif

    return [char, xp, yp]
endfunction
"}}}
" CanMoveWindow : Returns whether the window can be moved in a direction {{{
" Returns 1 if window can move in dir (<left>/<right>/<up>/<down>)
function! CanMoveWindow(dir) abort
    let prevNr = winnr()
    execute "wincmd " . a:dir
    let curNr = winnr()
    execute prevNr . "wincmd w"
    return curNr != prevNr
endfunction
"}}}
" CursorSynInfo : Print syntax information for hte text under the cursor {{{
function! CursorSynInfo(attr) abort
    let l:pos = getpos('.')
    let l:c = synIDattr(synIDtrans(synID(pos[1], pos[2], 'TRUE')), a:attr)
    let l:stack = map(synstack(l:pos[1], l:pos[2]),
                \ 'synIDattr(v:val, "'.a:attr.'")')
    let l:repls = map(synstack(l:pos[1], l:pos[2]),
                \ 'synIDattr(synIDtrans(v:val), "'.a:attr.'")')

    for i in range(len(l:stack))
        if l:stack[i] != l:repls[i]
            let l:stack[i] = l:stack[i].' -> '.l:repls[i]
        endif
    endfor

    return synIDattr(synIDtrans(synID(line('.'), col('.'), 'TRUE')), a:attr).
                \ ' - '.string(l:stack)
endfunc
"}}}
" UpdateCRShortcut : Update the <Enter> shortcut for adding newlines {{{
function! UpdateCRShortcut() abort
    if getbufvar(bufnr(''), '&modifiable', 0)
        nnoremap <CR> :<c-u>put =repeat(nr2char(10), v:count1)<cr>
    else
        silent! nunmap <CR>
    endif
endfunc
"}}}
" AppendModeline : Adds a modeline comment or replacing the existing modeline {{{
" Append modeline after last line in buffer.
" Source: http://vim.wikia.com/wiki/Modeline_magic
function! AppendModeline() abort
    " Backup and change options
    let urp = &report
    let umagic = &magic
    set report=9999
    set magic

    " Remove existing modeline
    if match(getline(line('$')), '\V' .
                \ escape(matchstr(&commentstring,'\zs.*\ze%s'), '\') .
                \ '\s\*\[Vv]im\?:\s\+se\[t]', 0, 1) >= 0
        call ExecNoCursor(string(line('$')) . 'd')
        echom 'Removed existing modeline.'
    endif

    " Build and append new modeline
    let l:modeline = printf(" vim: set ts=%d sw=%d tw=%d fdm=%s %set : ",
                \ &tabstop, &shiftwidth, &textwidth, &foldmethod,
                \ &expandtab ? '' : 'no')
    let l:modeline = substitute(&commentstring, "%s", l:modeline, "")
    call append(line("$"), l:modeline)
    echom 'Added new modeline: "' . l:modeline . '"'

    " Restore options
    exec 'set report='.urp
    if umagic
        set magic
    else
        set nomagic
    endif
endfunction
"}}}
"}}}

" }}}

" Map Unsupported Keys - Kitty {{{
" Replace 2xCtrl+P/0x10 with Ctrl+i
nnoremap <Char-0x10><Char-0x10> <C-i>
xnoremap <Char-0x10><Char-0x10> <C-i>
snoremap <Char-0x10><Char-0x10> <C-i>
onoremap <Char-0x10><Char-0x10> <C-i>
inoremap <Char-0x10><Char-0x10> <C-i>
cnoremap <Char-0x10><Char-0x10> <C-i>
tnoremap <Char-0x10><Char-0x10> <C-i>

" Key Encoding Scheme {{{
"
" Encoding is taken from kitty's keyboard extension:
" https://github.com/kovidgoyal/kitty/blob/master/protocol-extensions.asciidoc
"
" A key mapping has form:
"
"   [ Prefix ] [ Modifiers ] [ Key ]
"
" where
"
" * Prefix is \x11,
" * Modifiers are encoded using letters A-P as shown below, and
" * Keys are identified using a unique 1-2 character code, see the link below:
" https://github.com/kovidgoyal/kitty/blob/master/key_encoding.asciidoc

" Modifiers    #
"--------------#
" shift   0x1  #
" alt     0x2  #
" control 0x4  #
" super   0x8  #

" Encodings for each combination                                 #
"----------------------------------------------------------------#
"  key combination       value: numeric  encoded   nvim missing? #
"  -                               0         A          [ ]      #
"  shift                           1         B          [ ]      #
"  alt                             2         C          [ ]      #
"  alt + shift                     3         D          [ ]      #
"  control                         4         E          [ ]      #
"  control + shift                 5         F          [x]      #
"  alt + control                   6         G          [x]      #
"  alt + control + shift           7         H          [x]      #
"  super                           8         I          [x]      #
"  shift + super                   9         J          [x]      #
"  alt + super                     10        K          [x]      #
"  alt + shift + super             11        L          [x]      #
"  control + super                 12        M          [x]      #
"  control + shift + super         13        N          [x]      #
"  alt + control + super           14        O          [x]      #
"  alt + control + shift + super   15        P          [x]      #

"  }}}

" Normal {{{
" Shift - Special keys [B] {{{
" enter, backspace, escape
"nmap <Char-0x10>Bz <Nop>
" ^ shift + enter : insert newline before current line
nmap <Char-0x10>B1 <Nop>
nmap <Char-0x10>By <Nop>
" }}}
" Ctrl - Special keys [E] {{{
" enter, backspace, escape
"nmap <Char-0x10>Ez <Nop>
" ^ Ctrl + Enter : Insert newline at cursor
nmap <Char-0x10>E1 <Nop>
nmap <Char-0x10>Ey <Nop>
"nmap <Char-0x10>E0 <Nop>
" Ctrl + Tab : Move tab
" }}}
" Ctrl + Shift [F]{{{
" Alphanumerics [Ctrl + Shift]{{{
nmap <Char-0x10>FS <Nop>
nmap <Char-0x10>FT <Nop>
nmap <Char-0x10>FU <Nop>
nmap <Char-0x10>FV <Nop>
nmap <Char-0x10>FW <Nop>
nmap <Char-0x10>FX <Nop>
nmap <Char-0x10>FY <Nop>
"nmap <Char-0x10>FZ <Nop>
" Ctrl + Shift + h : Jump to previous marked position
nmap <Char-0x10>Fa <Nop>
"nmap <Char-0x10>Fb <Nop>
" Ctrl + Shift + j : Jump to next marked position
"nmap <Char-0x10>Fc <Nop>
" Ctrl + Shift + k : Jump to prev marked position
"nmap <Char-0x10>Fd <Nop>
" Ctrl + Shift + l : Jump to next marked position
nmap <Char-0x10>Fe <Nop>
"nmap <Char-0x10>Ff <Nop>
" Ctrl + Shift + n : Jump to previous match and update folds
nmap <Char-0x10>Fg <Nop>
"nmap <Char-0x10>Fh <Nop>
" Ctrl + Shift + p : Toggle paste mode
nmap <Char-0x10>Fi <Nop>
nmap <Char-0x10>Fj <Nop>
nmap <Char-0x10>Fk <Nop>
nmap <Char-0x10>Fl <Nop>
nmap <Char-0x10>Fm <Nop>
nmap <Char-0x10>Fn <Nop>
nmap <Char-0x10>Fo <Nop>
nmap <Char-0x10>Fp <Nop>
nmap <Char-0x10>Fq <Nop>
nmap <Char-0x10>Fr <Nop>
nmap <Char-0x10>FG <Nop>
nmap <Char-0x10>FH <Nop>
nmap <Char-0x10>FI <Nop>
nmap <Char-0x10>FJ <Nop>
nmap <Char-0x10>FK <Nop>
nmap <Char-0x10>FL <Nop>
nmap <Char-0x10>FM <Nop>
nmap <Char-0x10>FN <Nop>
nmap <Char-0x10>FO <Nop>
nmap <Char-0x10>FP <Nop>
" }}}

" Symbols [Ctrl + Shift]{{{
nmap <Char-0x10>FB <Nop>
nmap <Char-0x10>Ft <Nop>
nmap <Char-0x10>F1 <Nop>
nmap <Char-0x10>FC <Nop>
nmap <Char-0x10>F3 <Nop>
nmap <Char-0x10>F- <Nop>
nmap <Char-0x10>Fz <Nop>
nmap <Char-0x10>FR <Nop>
nmap <Char-0x10>Fy <Nop>
nmap <Char-0x10>Fv <Nop>
nmap <Char-0x10>Fs <Nop>
nmap <Char-0x10>FD <Nop>
nmap <Char-0x10>F! <Nop>
nmap <Char-0x10>FE <Nop>
nmap <Char-0x10>Fu <Nop>
nmap <Char-0x10>FQ <Nop>
nmap <Char-0x10>FF <Nop>
nmap <Char-0x10>FA <Nop>
"nmap <Char-0x10>F0 <Nop>
nmap <Char-0x10>Fw <Nop>
nmap <Char-0x10>Fx <Nop>
nmap <Char-0x10>F^ <Nop>
" }}}

" Function keys [Ctrl + Shift]{{{
nmap <Char-0x10>F/ <Nop>
nmap <Char-0x10>F* <Nop>
nmap <Char-0x10>F? <Nop>
nmap <Char-0x10>F& <Nop>
nmap <Char-0x10>F< <Nop>
nmap <Char-0x10>F> <Nop>
nmap <Char-0x10>F( <Nop>
nmap <Char-0x10>F) <Nop>
nmap <Char-0x10>F[ <Nop>
nmap <Char-0x10>F] <Nop>
nmap <Char-0x10>F{ <Nop>
nmap <Char-0x10>F} <Nop>
nmap <Char-0x10>F@ <Nop>
nmap <Char-0x10>F% <Nop>
nmap <Char-0x10>F$ <Nop>
nmap <Char-0x10>F# <Nop>
nmap <Char-0x10>FBA <Nop>
nmap <Char-0x10>FBB <Nop>
nmap <Char-0x10>FBC <Nop>
nmap <Char-0x10>FBD <Nop>
nmap <Char-0x10>FBE <Nop>
nmap <Char-0x10>FBF <Nop>
nmap <Char-0x10>FBG <Nop>
nmap <Char-0x10>FBH <Nop>
nmap <Char-0x10>FBI <Nop>
" }}}

" Modifiers / modes etc [Ctrl + Shift]{{{
nmap <Char-0x10>F: <Nop>
nmap <Char-0x10>F2 <Nop>
nmap <Char-0x10>FBc <Nop>
nmap <Char-0x10>FBb <Nop>
nmap <Char-0x10>FBa <Nop>
nmap <Char-0x10>FBd <Nop>
nmap <Char-0x10>F= <Nop>
nmap <Char-0x10>FBg <Nop>
nmap <Char-0x10>FBf <Nop>
nmap <Char-0x10>FBe <Nop>
nmap <Char-0x10>FBh <Nop>
nmap <Char-0x10>F+ <Nop>
" }}}

" Movement [Ctrl + Shift]{{{
nmap <Char-0x10>F6 <Nop>
nmap <Char-0x10>F. <Nop>
nmap <Char-0x10>F5 <Nop>
nmap <Char-0x10>F9 <Nop>
nmap <Char-0x10>F8 <Nop>
nmap <Char-0x10>F4 <Nop>
nmap <Char-0x10>F7 <Nop>
" }}}

" Numpad [Ctrl + Shift]{{{
nmap <Char-0x10>FBJ <Nop>
nmap <Char-0x10>FBK <Nop>
nmap <Char-0x10>FBL <Nop>
nmap <Char-0x10>FBM <Nop>
nmap <Char-0x10>FBN <Nop>
nmap <Char-0x10>FBO <Nop>
nmap <Char-0x10>FBP <Nop>
nmap <Char-0x10>FBQ <Nop>
nmap <Char-0x10>FBR <Nop>
nmap <Char-0x10>FBS <Nop>
nmap <Char-0x10>FBX <Nop>
nmap <Char-0x10>FBT <Nop>
nmap <Char-0x10>FBU <Nop>
nmap <Char-0x10>FBY <Nop>
nmap <Char-0x10>FBZ <Nop>
nmap <Char-0x10>FBV <Nop>
nmap <Char-0x10>FBW <Nop>
" }}}
" }}}
" Alt + Ctrl [G]{{{
" Alphanumerics [Alt + Ctrl]{{{
nmap <Char-0x10>GS <Nop>
nmap <Char-0x10>GT <Nop>
nmap <Char-0x10>GU <Nop>
nmap <Char-0x10>GV <Nop>
nmap <Char-0x10>GW <Nop>
nmap <Char-0x10>GX <Nop>
nmap <Char-0x10>GY <Nop>
"nmap <Char-0x10>GZ <Nop>
nmap <Char-0x10>Ga <Nop>
"nmap <Char-0x10>Gb <Nop>
"nmap <Char-0x10>Gc <Nop>
"nmap <Char-0x10>Gd <Nop>
nmap <Char-0x10>Ge <Nop>
nmap <Char-0x10>Gf <Nop>
nmap <Char-0x10>Gg <Nop>
"nmap <Char-0x10>Gh <Nop>
" ^ Ctrl + Alt + p : Paste & jump
nmap <Char-0x10>Gi <Nop>
nmap <Char-0x10>Gj <Nop>
nmap <Char-0x10>Gk <Nop>
nmap <Char-0x10>Gl <Nop>
nmap <Char-0x10>Gm <Nop>
nmap <Char-0x10>Gn <Nop>
nmap <Char-0x10>Go <Nop>
nmap <Char-0x10>Gp <Nop>
nmap <Char-0x10>Gq <Nop>
nmap <Char-0x10>Gr <Nop>
nmap <Char-0x10>GG <Nop>
nmap <Char-0x10>GH <Nop>
nmap <Char-0x10>GI <Nop>
nmap <Char-0x10>GJ <Nop>
nmap <Char-0x10>GK <Nop>
nmap <Char-0x10>GL <Nop>
nmap <Char-0x10>GM <Nop>
nmap <Char-0x10>GN <Nop>
nmap <Char-0x10>GO <Nop>
nmap <Char-0x10>GP <Nop>
" }}}

" Symbols [Alt + Ctrl]{{{
nmap <Char-0x10>GB <Nop>
nmap <Char-0x10>Gt <Nop>
nmap <Char-0x10>G1 <Nop>
nmap <Char-0x10>GC <Nop>
nmap <Char-0x10>G3 <Nop>
nmap <Char-0x10>G- <Nop>
nmap <Char-0x10>Gz <Nop>
"nmap <Char-0x10>GR <Nop>
" Ctrl + Alt + = : Resize window up/down
nmap <Char-0x10>Gy <Nop>
nmap <Char-0x10>Gv <Nop>
nmap <Char-0x10>Gs <Nop>
"nmap <Char-0x10>GD <Nop>
" Ctrl + Alt + - : Resize window up/down
nmap <Char-0x10>G! <Nop>
nmap <Char-0x10>GE <Nop>
nmap <Char-0x10>Gu <Nop>
nmap <Char-0x10>GQ <Nop>
nmap <Char-0x10>GF <Nop>
"nmap <Char-0x10>GA <Nop>
nmap <Char-0x10>G0 <Nop>
nmap <Char-0x10>Gw <Nop>
nmap <Char-0x10>Gx <Nop>
nmap <Char-0x10>G^ <Nop>
" }}}

" Function keys [Alt + Ctrl]{{{
nmap <Char-0x10>G/ <Nop>
nmap <Char-0x10>G* <Nop>
nmap <Char-0x10>G? <Nop>
nmap <Char-0x10>G& <Nop>
nmap <Char-0x10>G< <Nop>
nmap <Char-0x10>G> <Nop>
nmap <Char-0x10>G( <Nop>
nmap <Char-0x10>G) <Nop>
nmap <Char-0x10>G[ <Nop>
nmap <Char-0x10>G] <Nop>
nmap <Char-0x10>G{ <Nop>
nmap <Char-0x10>G} <Nop>
nmap <Char-0x10>G@ <Nop>
nmap <Char-0x10>G% <Nop>
nmap <Char-0x10>G$ <Nop>
nmap <Char-0x10>G# <Nop>
nmap <Char-0x10>GBA <Nop>
nmap <Char-0x10>GBB <Nop>
nmap <Char-0x10>GBC <Nop>
nmap <Char-0x10>GBD <Nop>
nmap <Char-0x10>GBE <Nop>
nmap <Char-0x10>GBF <Nop>
nmap <Char-0x10>GBG <Nop>
nmap <Char-0x10>GBH <Nop>
nmap <Char-0x10>GBI <Nop>
" }}}

" Modifiers [Alt + Ctrl]{{{
nmap <Char-0x10>G: <Nop>
nmap <Char-0x10>G2 <Nop>
nmap <Char-0x10>GBc <Nop>
nmap <Char-0x10>GBb <Nop>
nmap <Char-0x10>GBa <Nop>
nmap <Char-0x10>GBd <Nop>
nmap <Char-0x10>G= <Nop>
nmap <Char-0x10>GBg <Nop>
nmap <Char-0x10>GBf <Nop>
nmap <Char-0x10>GBe <Nop>
nmap <Char-0x10>GBh <Nop>
nmap <Char-0x10>G+ <Nop>
" }}}

" Movement [Alt + Ctrl]{{{
nmap <Char-0x10>G6 <Nop>
nmap <Char-0x10>G. <Nop>
nmap <Char-0x10>G5 <Nop>
nmap <Char-0x10>G9 <Nop>
nmap <Char-0x10>G8 <Nop>
nmap <Char-0x10>G4 <Nop>
nmap <Char-0x10>G7 <Nop>
" }}}

" Numpad [Alt + Ctrl]{{{
nmap <Char-0x10>GBJ <Nop>
nmap <Char-0x10>GBK <Nop>
nmap <Char-0x10>GBL <Nop>
nmap <Char-0x10>GBM <Nop>
nmap <Char-0x10>GBN <Nop>
nmap <Char-0x10>GBO <Nop>
nmap <Char-0x10>GBP <Nop>
nmap <Char-0x10>GBQ <Nop>
nmap <Char-0x10>GBR <Nop>
nmap <Char-0x10>GBS <Nop>
nmap <Char-0x10>GBX <Nop>
nmap <Char-0x10>GBT <Nop>
nmap <Char-0x10>GBU <Nop>
nmap <Char-0x10>GBY <Nop>
nmap <Char-0x10>GBZ <Nop>
nmap <Char-0x10>GBV <Nop>
nmap <Char-0x10>GBW <Nop>
" }}}
" }}}
" Alt + Ctrl + Shift [H]{{{
" Alphanumerics [Alt + Ctrl + Shift]{{{
nmap <Char-0x10>HS <Nop>
nmap <Char-0x10>HT <Nop>
nmap <Char-0x10>HU <Nop>
nmap <Char-0x10>HV <Nop>
nmap <Char-0x10>HW <Nop>
nmap <Char-0x10>HX <Nop>
nmap <Char-0x10>HY <Nop>
"nmap <Char-0x10>HZ <Nop>
" ^ ctrl + alt + shift + h : prev error
nmap <Char-0x10>Ha <Nop>
"nmap <Char-0x10>Hb <Nop>
" ^ ctrl + alt + shift + j : go to definition
"nmap <Char-0x10>Hc <Nop>
" ^ ctrl + alt + shift + k : jump to tag
"nmap <Char-0x10>Hd <Nop>
" ^ ctrl + alt + shift + l : next error
nmap <Char-0x10>He <Nop>
nmap <Char-0x10>Hf <Nop>
"nmap <Char-0x10>Hg <Nop>
" ^ ctrl + alt + shift + o : next git change
"nmap <Char-0x10>Hh <Nop>
" ^ ctrl + alt + shift + p : prev git chjange
nmap <Char-0x10>Hi <Nop>
nmap <Char-0x10>Hj <Nop>
nmap <Char-0x10>Hk <Nop>
nmap <Char-0x10>Hl <Nop>
nmap <Char-0x10>Hm <Nop>
nmap <Char-0x10>Hn <Nop>
nmap <Char-0x10>Ho <Nop>
nmap <Char-0x10>Hp <Nop>
nmap <Char-0x10>Hq <Nop>
nmap <Char-0x10>Hr <Nop>
nmap <Char-0x10>HG <Nop>
nmap <Char-0x10>HH <Nop>
nmap <Char-0x10>HI <Nop>
nmap <Char-0x10>HJ <Nop>
nmap <Char-0x10>HK <Nop>
nmap <Char-0x10>HL <Nop>
nmap <Char-0x10>HM <Nop>
nmap <Char-0x10>HN <Nop>
nmap <Char-0x10>HO <Nop>
nmap <Char-0x10>HP <Nop>
" }}}

" Symbols [Alt + Ctrl + Shift]{{{
nmap <Char-0x10>HB <Nop>
nmap <Char-0x10>Ht <Nop>
nmap <Char-0x10>H1 <Nop>
nmap <Char-0x10>HC <Nop>
nmap <Char-0x10>H3 <Nop>
nmap <Char-0x10>H- <Nop>
nmap <Char-0x10>Hz <Nop>
"nmap <Char-0x10>HR <Nop>
" Ctrl + Alt + _ : Resize window
nmap <Char-0x10>Hy <Nop>
nmap <Char-0x10>Hv <Nop>
nmap <Char-0x10>Hs <Nop>
"nmap <Char-0x10>HD <Nop>
" Ctrl + Alt + + : Resize window
nmap <Char-0x10>H! <Nop>
nmap <Char-0x10>HE <Nop>
nmap <Char-0x10>Hu <Nop>
nmap <Char-0x10>HQ <Nop>
nmap <Char-0x10>HF <Nop>
nmap <Char-0x10>HA <Nop>
nmap <Char-0x10>H0 <Nop>
nmap <Char-0x10>Hw <Nop>
nmap <Char-0x10>Hx <Nop>
nmap <Char-0x10>H^ <Nop>
" }}}

" Function keys [Alt + Ctrl + Shift]{{{
nmap <Char-0x10>H/ <Nop>
nmap <Char-0x10>H* <Nop>
nmap <Char-0x10>H? <Nop>
nmap <Char-0x10>H& <Nop>
nmap <Char-0x10>H< <Nop>
nmap <Char-0x10>H> <Nop>
nmap <Char-0x10>H( <Nop>
nmap <Char-0x10>H) <Nop>
nmap <Char-0x10>H[ <Nop>
nmap <Char-0x10>H] <Nop>
nmap <Char-0x10>H{ <Nop>
nmap <Char-0x10>H} <Nop>
nmap <Char-0x10>H@ <Nop>
nmap <Char-0x10>H% <Nop>
nmap <Char-0x10>H$ <Nop>
nmap <Char-0x10>H# <Nop>
nmap <Char-0x10>HBA <Nop>
nmap <Char-0x10>HBB <Nop>
nmap <Char-0x10>HBC <Nop>
nmap <Char-0x10>HBD <Nop>
nmap <Char-0x10>HBE <Nop>
nmap <Char-0x10>HBF <Nop>
nmap <Char-0x10>HBG <Nop>
nmap <Char-0x10>HBH <Nop>
nmap <Char-0x10>HBI <Nop>
" }}}

" Modifiers [Alt + Ctrl + Shift]{{{
nmap <Char-0x10>H: <Nop>
nmap <Char-0x10>H2 <Nop>
nmap <Char-0x10>HBc <Nop>
nmap <Char-0x10>HBb <Nop>
nmap <Char-0x10>HBa <Nop>
nmap <Char-0x10>HBd <Nop>
nmap <Char-0x10>H= <Nop>
nmap <Char-0x10>HBg <Nop>
nmap <Char-0x10>HBf <Nop>
nmap <Char-0x10>HBe <Nop>
nmap <Char-0x10>HBh <Nop>
nmap <Char-0x10>H+ <Nop>
" }}}

" Movement [Alt + Ctrl + Shift]{{{
nmap <Char-0x10>H6 <Nop>
nmap <Char-0x10>H. <Nop>
nmap <Char-0x10>H5 <Nop>
nmap <Char-0x10>H9 <Nop>
nmap <Char-0x10>H8 <Nop>
nmap <Char-0x10>H4 <Nop>
nmap <Char-0x10>H7 <Nop>
" }}}

" Numpad [Alt + Ctrl + Shift]{{{
nmap <Char-0x10>HBJ <Nop>
nmap <Char-0x10>HBK <Nop>
nmap <Char-0x10>HBL <Nop>
nmap <Char-0x10>HBM <Nop>
nmap <Char-0x10>HBN <Nop>
nmap <Char-0x10>HBO <Nop>
nmap <Char-0x10>HBP <Nop>
nmap <Char-0x10>HBQ <Nop>
nmap <Char-0x10>HBR <Nop>
nmap <Char-0x10>HBS <Nop>
nmap <Char-0x10>HBX <Nop>
nmap <Char-0x10>HBT <Nop>
nmap <Char-0x10>HBU <Nop>
nmap <Char-0x10>HBY <Nop>
nmap <Char-0x10>HBZ <Nop>
nmap <Char-0x10>HBV <Nop>
nmap <Char-0x10>HBW <Nop>
" }}}
" }}}
" Super [I]{{{
" Alphanumerics [Super]{{{
nmap <Char-0x10>IS <Nop>
nmap <Char-0x10>IT <Nop>
nmap <Char-0x10>IU <Nop>
nmap <Char-0x10>IV <Nop>
nmap <Char-0x10>IW <Nop>
nmap <Char-0x10>IX <Nop>
nmap <Char-0x10>IY <Nop>
nmap <Char-0x10>IZ <Nop>
nmap <Char-0x10>Ia <Nop>
nmap <Char-0x10>Ib <Nop>
nmap <Char-0x10>Ic <Nop>
nmap <Char-0x10>Id <Nop>
nmap <Char-0x10>Ie <Nop>
nmap <Char-0x10>If <Nop>
nmap <Char-0x10>Ig <Nop>
nmap <Char-0x10>Ih <Nop>
nmap <Char-0x10>Ii <Nop>
nmap <Char-0x10>Ij <Nop>
nmap <Char-0x10>Ik <Nop>
nmap <Char-0x10>Il <Nop>
nmap <Char-0x10>Im <Nop>
nmap <Char-0x10>In <Nop>
nmap <Char-0x10>Io <Nop>
nmap <Char-0x10>Ip <Nop>
nmap <Char-0x10>Iq <Nop>
nmap <Char-0x10>Ir <Nop>
nmap <Char-0x10>IG <Nop>
nmap <Char-0x10>IH <Nop>
nmap <Char-0x10>II <Nop>
nmap <Char-0x10>IJ <Nop>
nmap <Char-0x10>IK <Nop>
nmap <Char-0x10>IL <Nop>
nmap <Char-0x10>IM <Nop>
nmap <Char-0x10>IN <Nop>
nmap <Char-0x10>IO <Nop>
nmap <Char-0x10>IP <Nop>
" }}}

" Symbols [Super]{{{
nmap <Char-0x10>IB <Nop>
nmap <Char-0x10>It <Nop>
nmap <Char-0x10>I1 <Nop>
nmap <Char-0x10>IC <Nop>
nmap <Char-0x10>I3 <Nop>
nmap <Char-0x10>I- <Nop>
nmap <Char-0x10>Iz <Nop>
nmap <Char-0x10>IR <Nop>
nmap <Char-0x10>Iy <Nop>
nmap <Char-0x10>Iv <Nop>
nmap <Char-0x10>Is <Nop>
nmap <Char-0x10>ID <Nop>
nmap <Char-0x10>I! <Nop>
nmap <Char-0x10>IE <Nop>
nmap <Char-0x10>Iu <Nop>
nmap <Char-0x10>IQ <Nop>
nmap <Char-0x10>IF <Nop>
nmap <Char-0x10>IA <Nop>
nmap <Char-0x10>I0 <Nop>
nmap <Char-0x10>Iw <Nop>
nmap <Char-0x10>Ix <Nop>
nmap <Char-0x10>I^ <Nop>
" }}}

" Function keys [Super]{{{
nmap <Char-0x10>I/ <Nop>
nmap <Char-0x10>I* <Nop>
nmap <Char-0x10>I? <Nop>
nmap <Char-0x10>I& <Nop>
nmap <Char-0x10>I< <Nop>
nmap <Char-0x10>I> <Nop>
nmap <Char-0x10>I( <Nop>
nmap <Char-0x10>I) <Nop>
nmap <Char-0x10>I[ <Nop>
nmap <Char-0x10>I] <Nop>
nmap <Char-0x10>I{ <Nop>
nmap <Char-0x10>I} <Nop>
nmap <Char-0x10>I@ <Nop>
nmap <Char-0x10>I% <Nop>
nmap <Char-0x10>I$ <Nop>
nmap <Char-0x10>I# <Nop>
nmap <Char-0x10>IBA <Nop>
nmap <Char-0x10>IBB <Nop>
nmap <Char-0x10>IBC <Nop>
nmap <Char-0x10>IBD <Nop>
nmap <Char-0x10>IBE <Nop>
nmap <Char-0x10>IBF <Nop>
nmap <Char-0x10>IBG <Nop>
nmap <Char-0x10>IBH <Nop>
nmap <Char-0x10>IBI <Nop>
" }}}

" Modifiers [Super]{{{
nmap <Char-0x10>I: <Nop>
nmap <Char-0x10>I2 <Nop>
nmap <Char-0x10>IBc <Nop>
nmap <Char-0x10>IBb <Nop>
nmap <Char-0x10>IBa <Nop>
nmap <Char-0x10>IBd <Nop>
nmap <Char-0x10>I= <Nop>
nmap <Char-0x10>IBg <Nop>
nmap <Char-0x10>IBf <Nop>
nmap <Char-0x10>IBe <Nop>
nmap <Char-0x10>IBh <Nop>
nmap <Char-0x10>I+ <Nop>
" }}}

" Movement [Super]{{{
nmap <Char-0x10>I6 <Nop>
nmap <Char-0x10>I. <Nop>
nmap <Char-0x10>I5 <Nop>
nmap <Char-0x10>I9 <Nop>
nmap <Char-0x10>I8 <Nop>
nmap <Char-0x10>I4 <Nop>
nmap <Char-0x10>I7 <Nop>
" }}}

" Numpad [Super]{{{
nmap <Char-0x10>IBJ <Nop>
nmap <Char-0x10>IBK <Nop>
nmap <Char-0x10>IBL <Nop>
nmap <Char-0x10>IBM <Nop>
nmap <Char-0x10>IBN <Nop>
nmap <Char-0x10>IBO <Nop>
nmap <Char-0x10>IBP <Nop>
nmap <Char-0x10>IBQ <Nop>
nmap <Char-0x10>IBR <Nop>
nmap <Char-0x10>IBS <Nop>
nmap <Char-0x10>IBX <Nop>
nmap <Char-0x10>IBT <Nop>
nmap <Char-0x10>IBU <Nop>
nmap <Char-0x10>IBY <Nop>
nmap <Char-0x10>IBZ <Nop>
nmap <Char-0x10>IBV <Nop>
nmap <Char-0x10>IBW <Nop>
" }}}
" }}}
" Shift + Super [J]{{{
" Alphanumerics [Shift + Super]{{{
nmap <Char-0x10>JS <Nop>
nmap <Char-0x10>JT <Nop>
nmap <Char-0x10>JU <Nop>
nmap <Char-0x10>JV <Nop>
nmap <Char-0x10>JW <Nop>
nmap <Char-0x10>JX <Nop>
nmap <Char-0x10>JY <Nop>
nmap <Char-0x10>JZ <Nop>
nmap <Char-0x10>Ja <Nop>
nmap <Char-0x10>Jb <Nop>
nmap <Char-0x10>Jc <Nop>
nmap <Char-0x10>Jd <Nop>
nmap <Char-0x10>Je <Nop>
nmap <Char-0x10>Jf <Nop>
nmap <Char-0x10>Jg <Nop>
nmap <Char-0x10>Jh <Nop>
nmap <Char-0x10>Ji <Nop>
nmap <Char-0x10>Jj <Nop>
nmap <Char-0x10>Jk <Nop>
nmap <Char-0x10>Jl <Nop>
nmap <Char-0x10>Jm <Nop>
nmap <Char-0x10>Jn <Nop>
nmap <Char-0x10>Jo <Nop>
nmap <Char-0x10>Jp <Nop>
nmap <Char-0x10>Jq <Nop>
nmap <Char-0x10>Jr <Nop>
nmap <Char-0x10>JG <Nop>
nmap <Char-0x10>JH <Nop>
nmap <Char-0x10>JI <Nop>
nmap <Char-0x10>JJ <Nop>
nmap <Char-0x10>JK <Nop>
nmap <Char-0x10>JL <Nop>
nmap <Char-0x10>JM <Nop>
nmap <Char-0x10>JN <Nop>
nmap <Char-0x10>JO <Nop>
nmap <Char-0x10>JP <Nop>
" }}}

" Symbols [Shift + Super]{{{
nmap <Char-0x10>JB <Nop>
nmap <Char-0x10>Jt <Nop>
nmap <Char-0x10>J1 <Nop>
nmap <Char-0x10>JC <Nop>
nmap <Char-0x10>J3 <Nop>
nmap <Char-0x10>J- <Nop>
nmap <Char-0x10>Jz <Nop>
nmap <Char-0x10>JR <Nop>
nmap <Char-0x10>Jy <Nop>
nmap <Char-0x10>Jv <Nop>
nmap <Char-0x10>Js <Nop>
nmap <Char-0x10>JD <Nop>
nmap <Char-0x10>J! <Nop>
nmap <Char-0x10>JE <Nop>
nmap <Char-0x10>Ju <Nop>
nmap <Char-0x10>JQ <Nop>
nmap <Char-0x10>JF <Nop>
nmap <Char-0x10>JA <Nop>
nmap <Char-0x10>J0 <Nop>
nmap <Char-0x10>Jw <Nop>
nmap <Char-0x10>Jx <Nop>
nmap <Char-0x10>J^ <Nop>
" }}}

" Function keys [Shift + Super]{{{
nmap <Char-0x10>J/ <Nop>
nmap <Char-0x10>J* <Nop>
nmap <Char-0x10>J? <Nop>
nmap <Char-0x10>J& <Nop>
nmap <Char-0x10>J< <Nop>
nmap <Char-0x10>J> <Nop>
nmap <Char-0x10>J( <Nop>
nmap <Char-0x10>J) <Nop>
nmap <Char-0x10>J[ <Nop>
nmap <Char-0x10>J] <Nop>
nmap <Char-0x10>J{ <Nop>
nmap <Char-0x10>J} <Nop>
nmap <Char-0x10>J@ <Nop>
nmap <Char-0x10>J% <Nop>
nmap <Char-0x10>J$ <Nop>
nmap <Char-0x10>J# <Nop>
nmap <Char-0x10>JBA <Nop>
nmap <Char-0x10>JBB <Nop>
nmap <Char-0x10>JBC <Nop>
nmap <Char-0x10>JBD <Nop>
nmap <Char-0x10>JBE <Nop>
nmap <Char-0x10>JBF <Nop>
nmap <Char-0x10>JBG <Nop>
nmap <Char-0x10>JBH <Nop>
nmap <Char-0x10>JBI <Nop>
" }}}

" Modifiers [Shift + Super]{{{
nmap <Char-0x10>J: <Nop>
nmap <Char-0x10>J2 <Nop>
nmap <Char-0x10>JBc <Nop>
nmap <Char-0x10>JBb <Nop>
nmap <Char-0x10>JBa <Nop>
nmap <Char-0x10>JBd <Nop>
nmap <Char-0x10>J= <Nop>
nmap <Char-0x10>JBg <Nop>
nmap <Char-0x10>JBf <Nop>
nmap <Char-0x10>JBe <Nop>
nmap <Char-0x10>JBh <Nop>
nmap <Char-0x10>J+ <Nop>
" }}}

" Movement [Shift + Super]{{{
nmap <Char-0x10>J6 <Nop>
nmap <Char-0x10>J. <Nop>
nmap <Char-0x10>J5 <Nop>
nmap <Char-0x10>J9 <Nop>
nmap <Char-0x10>J8 <Nop>
nmap <Char-0x10>J4 <Nop>
nmap <Char-0x10>J7 <Nop>
" }}}

" Numpad [Shift + Super]{{{
nmap <Char-0x10>JBJ <Nop>
nmap <Char-0x10>JBK <Nop>
nmap <Char-0x10>JBL <Nop>
nmap <Char-0x10>JBM <Nop>
nmap <Char-0x10>JBN <Nop>
nmap <Char-0x10>JBO <Nop>
nmap <Char-0x10>JBP <Nop>
nmap <Char-0x10>JBQ <Nop>
nmap <Char-0x10>JBR <Nop>
nmap <Char-0x10>JBS <Nop>
nmap <Char-0x10>JBX <Nop>
nmap <Char-0x10>JBT <Nop>
nmap <Char-0x10>JBU <Nop>
nmap <Char-0x10>JBY <Nop>
nmap <Char-0x10>JBZ <Nop>
nmap <Char-0x10>JBV <Nop>
nmap <Char-0x10>JBW <Nop>
" }}}
" }}}
" Alt + Super [K]{{{
" Alphanumerics [Alt + Super]{{{
nmap <Char-0x10>KS <Nop>
nmap <Char-0x10>KT <Nop>
nmap <Char-0x10>KU <Nop>
nmap <Char-0x10>KV <Nop>
nmap <Char-0x10>KW <Nop>
nmap <Char-0x10>KX <Nop>
nmap <Char-0x10>KY <Nop>
nmap <Char-0x10>KZ <Nop>
nmap <Char-0x10>Ka <Nop>
nmap <Char-0x10>Kb <Nop>
nmap <Char-0x10>Kc <Nop>
nmap <Char-0x10>Kd <Nop>
nmap <Char-0x10>Ke <Nop>
nmap <Char-0x10>Kf <Nop>
nmap <Char-0x10>Kg <Nop>
nmap <Char-0x10>Kh <Nop>
nmap <Char-0x10>Ki <Nop>
nmap <Char-0x10>Kj <Nop>
nmap <Char-0x10>Kk <Nop>
nmap <Char-0x10>Kl <Nop>
nmap <Char-0x10>Km <Nop>
nmap <Char-0x10>Kn <Nop>
nmap <Char-0x10>Ko <Nop>
nmap <Char-0x10>Kp <Nop>
nmap <Char-0x10>Kq <Nop>
nmap <Char-0x10>Kr <Nop>
nmap <Char-0x10>KG <Nop>
nmap <Char-0x10>KH <Nop>
nmap <Char-0x10>KI <Nop>
nmap <Char-0x10>KJ <Nop>
nmap <Char-0x10>KK <Nop>
nmap <Char-0x10>KL <Nop>
nmap <Char-0x10>KM <Nop>
nmap <Char-0x10>KN <Nop>
nmap <Char-0x10>KO <Nop>
nmap <Char-0x10>KP <Nop>
" }}}

" Symbols [Alt + Super]{{{
nmap <Char-0x10>KB <Nop>
nmap <Char-0x10>Kt <Nop>
nmap <Char-0x10>K1 <Nop>
nmap <Char-0x10>KC <Nop>
nmap <Char-0x10>K3 <Nop>
nmap <Char-0x10>K- <Nop>
nmap <Char-0x10>Kz <Nop>
nmap <Char-0x10>KR <Nop>
nmap <Char-0x10>Ky <Nop>
nmap <Char-0x10>Kv <Nop>
nmap <Char-0x10>Ks <Nop>
nmap <Char-0x10>KD <Nop>
nmap <Char-0x10>K! <Nop>
nmap <Char-0x10>KE <Nop>
nmap <Char-0x10>Ku <Nop>
nmap <Char-0x10>KQ <Nop>
nmap <Char-0x10>KF <Nop>
nmap <Char-0x10>KA <Nop>
nmap <Char-0x10>K0 <Nop>
nmap <Char-0x10>Kw <Nop>
nmap <Char-0x10>Kx <Nop>
nmap <Char-0x10>K^ <Nop>
" }}}

" Function keys [Alt + Super]{{{
nmap <Char-0x10>K/ <Nop>
nmap <Char-0x10>K* <Nop>
nmap <Char-0x10>K? <Nop>
nmap <Char-0x10>K& <Nop>
nmap <Char-0x10>K< <Nop>
nmap <Char-0x10>K> <Nop>
nmap <Char-0x10>K( <Nop>
nmap <Char-0x10>K) <Nop>
nmap <Char-0x10>K[ <Nop>
nmap <Char-0x10>K] <Nop>
nmap <Char-0x10>K{ <Nop>
nmap <Char-0x10>K} <Nop>
nmap <Char-0x10>K@ <Nop>
nmap <Char-0x10>K% <Nop>
nmap <Char-0x10>K$ <Nop>
nmap <Char-0x10>K# <Nop>
nmap <Char-0x10>KBA <Nop>
nmap <Char-0x10>KBB <Nop>
nmap <Char-0x10>KBC <Nop>
nmap <Char-0x10>KBD <Nop>
nmap <Char-0x10>KBE <Nop>
nmap <Char-0x10>KBF <Nop>
nmap <Char-0x10>KBG <Nop>
nmap <Char-0x10>KBH <Nop>
nmap <Char-0x10>KBI <Nop>
" }}}

" Modifiers [Alt + Super]{{{
nmap <Char-0x10>K: <Nop>
nmap <Char-0x10>K2 <Nop>
nmap <Char-0x10>KBc <Nop>
nmap <Char-0x10>KBb <Nop>
nmap <Char-0x10>KBa <Nop>
nmap <Char-0x10>KBd <Nop>
nmap <Char-0x10>K= <Nop>
nmap <Char-0x10>KBg <Nop>
nmap <Char-0x10>KBf <Nop>
nmap <Char-0x10>KBe <Nop>
nmap <Char-0x10>KBh <Nop>
nmap <Char-0x10>K+ <Nop>
" }}}

" Movement [Alt + Super]{{{
nmap <Char-0x10>K6 <Nop>
nmap <Char-0x10>K. <Nop>
nmap <Char-0x10>K5 <Nop>
nmap <Char-0x10>K9 <Nop>
nmap <Char-0x10>K8 <Nop>
nmap <Char-0x10>K4 <Nop>
nmap <Char-0x10>K7 <Nop>
" }}}

" Numpad [Alt + Super]{{{
nmap <Char-0x10>KBJ <Nop>
nmap <Char-0x10>KBK <Nop>
nmap <Char-0x10>KBL <Nop>
nmap <Char-0x10>KBM <Nop>
nmap <Char-0x10>KBN <Nop>
nmap <Char-0x10>KBO <Nop>
nmap <Char-0x10>KBP <Nop>
nmap <Char-0x10>KBQ <Nop>
nmap <Char-0x10>KBR <Nop>
nmap <Char-0x10>KBS <Nop>
nmap <Char-0x10>KBX <Nop>
nmap <Char-0x10>KBT <Nop>
nmap <Char-0x10>KBU <Nop>
nmap <Char-0x10>KBY <Nop>
nmap <Char-0x10>KBZ <Nop>
nmap <Char-0x10>KBV <Nop>
nmap <Char-0x10>KBW <Nop>
" }}}
" }}}
" Alt + Shift + Super [L]{{{
" Alphanumerics [Alt + Shift + Super]{{{
nmap <Char-0x10>LS <Nop>
nmap <Char-0x10>LT <Nop>
nmap <Char-0x10>LU <Nop>
nmap <Char-0x10>LV <Nop>
nmap <Char-0x10>LW <Nop>
nmap <Char-0x10>LX <Nop>
nmap <Char-0x10>LY <Nop>
nmap <Char-0x10>LZ <Nop>
nmap <Char-0x10>La <Nop>
nmap <Char-0x10>Lb <Nop>
nmap <Char-0x10>Lc <Nop>
nmap <Char-0x10>Ld <Nop>
nmap <Char-0x10>Le <Nop>
nmap <Char-0x10>Lf <Nop>
nmap <Char-0x10>Lg <Nop>
nmap <Char-0x10>Lh <Nop>
nmap <Char-0x10>Li <Nop>
nmap <Char-0x10>Lj <Nop>
nmap <Char-0x10>Lk <Nop>
nmap <Char-0x10>Ll <Nop>
nmap <Char-0x10>Lm <Nop>
nmap <Char-0x10>Ln <Nop>
nmap <Char-0x10>Lo <Nop>
nmap <Char-0x10>Lp <Nop>
nmap <Char-0x10>Lq <Nop>
nmap <Char-0x10>Lr <Nop>
nmap <Char-0x10>LG <Nop>
nmap <Char-0x10>LH <Nop>
nmap <Char-0x10>LI <Nop>
nmap <Char-0x10>LJ <Nop>
nmap <Char-0x10>LK <Nop>
nmap <Char-0x10>LL <Nop>
nmap <Char-0x10>LM <Nop>
nmap <Char-0x10>LN <Nop>
nmap <Char-0x10>LO <Nop>
nmap <Char-0x10>LP <Nop>
" }}}

" Symbols [Alt + Shift  + Super]{{{
nmap <Char-0x10>LB <Nop>
nmap <Char-0x10>Lt <Nop>
nmap <Char-0x10>L1 <Nop>
nmap <Char-0x10>LC <Nop>
nmap <Char-0x10>L3 <Nop>
nmap <Char-0x10>L- <Nop>
nmap <Char-0x10>Lz <Nop>
nmap <Char-0x10>LR <Nop>
nmap <Char-0x10>Ly <Nop>
nmap <Char-0x10>Lv <Nop>
nmap <Char-0x10>Ls <Nop>
nmap <Char-0x10>LD <Nop>
nmap <Char-0x10>L! <Nop>
nmap <Char-0x10>LE <Nop>
nmap <Char-0x10>Lu <Nop>
nmap <Char-0x10>LQ <Nop>
nmap <Char-0x10>LF <Nop>
nmap <Char-0x10>LA <Nop>
nmap <Char-0x10>L0 <Nop>
nmap <Char-0x10>Lw <Nop>
nmap <Char-0x10>Lx <Nop>
nmap <Char-0x10>L^ <Nop>
" }}}

" Function keys [Alt + Shift + Super]{{{
nmap <Char-0x10>L/ <Nop>
nmap <Char-0x10>L* <Nop>
nmap <Char-0x10>L? <Nop>
nmap <Char-0x10>L& <Nop>
nmap <Char-0x10>L< <Nop>
nmap <Char-0x10>L> <Nop>
nmap <Char-0x10>L( <Nop>
nmap <Char-0x10>L) <Nop>
nmap <Char-0x10>L[ <Nop>
nmap <Char-0x10>L] <Nop>
nmap <Char-0x10>L{ <Nop>
nmap <Char-0x10>L} <Nop>
nmap <Char-0x10>L@ <Nop>
nmap <Char-0x10>L% <Nop>
nmap <Char-0x10>L$ <Nop>
nmap <Char-0x10>L# <Nop>
nmap <Char-0x10>LBA <Nop>
nmap <Char-0x10>LBB <Nop>
nmap <Char-0x10>LBC <Nop>
nmap <Char-0x10>LBD <Nop>
nmap <Char-0x10>LBE <Nop>
nmap <Char-0x10>LBF <Nop>
nmap <Char-0x10>LBG <Nop>
nmap <Char-0x10>LBH <Nop>
nmap <Char-0x10>LBI <Nop>
" }}}

" Modifiers [Alt + Shift + Super]{{{
nmap <Char-0x10>L: <Nop>
nmap <Char-0x10>L2 <Nop>
nmap <Char-0x10>LBc <Nop>
nmap <Char-0x10>LBb <Nop>
nmap <Char-0x10>LBa <Nop>
nmap <Char-0x10>LBd <Nop>
nmap <Char-0x10>L= <Nop>
nmap <Char-0x10>LBg <Nop>
nmap <Char-0x10>LBf <Nop>
nmap <Char-0x10>LBe <Nop>
nmap <Char-0x10>LBh <Nop>
nmap <Char-0x10>L+ <Nop>
" }}}

" Movement [Alt + Shift + Super]{{{
nmap <Char-0x10>L6 <Nop>
nmap <Char-0x10>L. <Nop>
nmap <Char-0x10>L5 <Nop>
nmap <Char-0x10>L9 <Nop>
nmap <Char-0x10>L8 <Nop>
nmap <Char-0x10>L4 <Nop>
nmap <Char-0x10>L7 <Nop>
" }}}

" Numpad [Alt + Shift + Super]{{{
nmap <Char-0x10>LBJ <Nop>
nmap <Char-0x10>LBK <Nop>
nmap <Char-0x10>LBL <Nop>
nmap <Char-0x10>LBM <Nop>
nmap <Char-0x10>LBN <Nop>
nmap <Char-0x10>LBO <Nop>
nmap <Char-0x10>LBP <Nop>
nmap <Char-0x10>LBQ <Nop>
nmap <Char-0x10>LBR <Nop>
nmap <Char-0x10>LBS <Nop>
nmap <Char-0x10>LBX <Nop>
nmap <Char-0x10>LBT <Nop>
nmap <Char-0x10>LBU <Nop>
nmap <Char-0x10>LBY <Nop>
nmap <Char-0x10>LBZ <Nop>
nmap <Char-0x10>LBV <Nop>
nmap <Char-0x10>LBW <Nop>
" }}}
" }}}
" Alt + Ctrl + Shift + Super [L]{{{
" Alphanumerics [Ctrl + Super]{{{
nmap <Char-0x10>MS <Nop>
nmap <Char-0x10>MT <Nop>
nmap <Char-0x10>MU <Nop>
nmap <Char-0x10>MV <Nop>
nmap <Char-0x10>MW <Nop>
nmap <Char-0x10>MX <Nop>
nmap <Char-0x10>MY <Nop>
nmap <Char-0x10>MZ <Nop>
nmap <Char-0x10>Ma <Nop>
nmap <Char-0x10>Mb <Nop>
nmap <Char-0x10>Mc <Nop>
nmap <Char-0x10>Md <Nop>
nmap <Char-0x10>Me <Nop>
nmap <Char-0x10>Mf <Nop>
nmap <Char-0x10>Mg <Nop>
nmap <Char-0x10>Mh <Nop>
nmap <Char-0x10>Mi <Nop>
nmap <Char-0x10>Mj <Nop>
nmap <Char-0x10>Mk <Nop>
nmap <Char-0x10>Ml <Nop>
nmap <Char-0x10>Mm <Nop>
nmap <Char-0x10>Mn <Nop>
nmap <Char-0x10>Mo <Nop>
nmap <Char-0x10>Mp <Nop>
nmap <Char-0x10>Mq <Nop>
nmap <Char-0x10>Mr <Nop>
nmap <Char-0x10>MG <Nop>
nmap <Char-0x10>MH <Nop>
nmap <Char-0x10>MI <Nop>
nmap <Char-0x10>MJ <Nop>
nmap <Char-0x10>MK <Nop>
nmap <Char-0x10>ML <Nop>
nmap <Char-0x10>MM <Nop>
nmap <Char-0x10>MN <Nop>
nmap <Char-0x10>MO <Nop>
nmap <Char-0x10>MP <Nop>
" }}}

" Symbols [Ctrl + Super]{{{
nmap <Char-0x10>MB <Nop>
nmap <Char-0x10>Mt <Nop>
nmap <Char-0x10>M1 <Nop>
nmap <Char-0x10>MC <Nop>
nmap <Char-0x10>M3 <Nop>
nmap <Char-0x10>M- <Nop>
nmap <Char-0x10>Mz <Nop>
nmap <Char-0x10>MR <Nop>
nmap <Char-0x10>My <Nop>
nmap <Char-0x10>Mv <Nop>
nmap <Char-0x10>Ms <Nop>
nmap <Char-0x10>MD <Nop>
nmap <Char-0x10>M! <Nop>
nmap <Char-0x10>ME <Nop>
nmap <Char-0x10>Mu <Nop>
nmap <Char-0x10>MQ <Nop>
nmap <Char-0x10>MF <Nop>
nmap <Char-0x10>MA <Nop>
nmap <Char-0x10>M0 <Nop>
nmap <Char-0x10>Mw <Nop>
nmap <Char-0x10>Mx <Nop>
nmap <Char-0x10>M^ <Nop>
" }}}

" Function keys [Ctrl + Super]{{{
nmap <Char-0x10>M/ <Nop>
nmap <Char-0x10>M* <Nop>
nmap <Char-0x10>M? <Nop>
nmap <Char-0x10>M& <Nop>
nmap <Char-0x10>M< <Nop>
nmap <Char-0x10>M> <Nop>
nmap <Char-0x10>M( <Nop>
nmap <Char-0x10>M) <Nop>
nmap <Char-0x10>M[ <Nop>
nmap <Char-0x10>M] <Nop>
nmap <Char-0x10>M{ <Nop>
nmap <Char-0x10>M} <Nop>
nmap <Char-0x10>M@ <Nop>
nmap <Char-0x10>M% <Nop>
nmap <Char-0x10>M$ <Nop>
nmap <Char-0x10>M# <Nop>
nmap <Char-0x10>MBA <Nop>
nmap <Char-0x10>MBB <Nop>
nmap <Char-0x10>MBC <Nop>
nmap <Char-0x10>MBD <Nop>
nmap <Char-0x10>MBE <Nop>
nmap <Char-0x10>MBF <Nop>
nmap <Char-0x10>MBG <Nop>
nmap <Char-0x10>MBH <Nop>
nmap <Char-0x10>MBI <Nop>
" }}}

" Modifiers [Ctrl + Super]{{{
nmap <Char-0x10>M: <Nop>
nmap <Char-0x10>M2 <Nop>
nmap <Char-0x10>MBc <Nop>
nmap <Char-0x10>MBb <Nop>
nmap <Char-0x10>MBa <Nop>
nmap <Char-0x10>MBd <Nop>
nmap <Char-0x10>M= <Nop>
nmap <Char-0x10>MBg <Nop>
nmap <Char-0x10>MBf <Nop>
nmap <Char-0x10>MBe <Nop>
nmap <Char-0x10>MBh <Nop>
nmap <Char-0x10>M+ <Nop>
" }}}

" Movement [Ctrl + Super]{{{
nmap <Char-0x10>M6 <Nop>
nmap <Char-0x10>M. <Nop>
nmap <Char-0x10>M5 <Nop>
nmap <Char-0x10>M9 <Nop>
nmap <Char-0x10>M8 <Nop>
nmap <Char-0x10>M4 <Nop>
nmap <Char-0x10>M7 <Nop>
" }}}

" Numpad [Ctrl + Super]{{{
nmap <Char-0x10>MBJ <Nop>
nmap <Char-0x10>MBK <Nop>
nmap <Char-0x10>MBL <Nop>
nmap <Char-0x10>MBM <Nop>
nmap <Char-0x10>MBN <Nop>
nmap <Char-0x10>MBO <Nop>
nmap <Char-0x10>MBP <Nop>
nmap <Char-0x10>MBQ <Nop>
nmap <Char-0x10>MBR <Nop>
nmap <Char-0x10>MBS <Nop>
nmap <Char-0x10>MBX <Nop>
nmap <Char-0x10>MBT <Nop>
nmap <Char-0x10>MBU <Nop>
nmap <Char-0x10>MBY <Nop>
nmap <Char-0x10>MBZ <Nop>
nmap <Char-0x10>MBV <Nop>
nmap <Char-0x10>MBW <Nop>
" }}}
" }}}
" Ctrl + Shift + Super [N]{{{
" Alphanumerics [Ctrl + Shift + Super]{{{
nmap <Char-0x10>NS <Nop>
nmap <Char-0x10>NT <Nop>
nmap <Char-0x10>NU <Nop>
nmap <Char-0x10>NV <Nop>
nmap <Char-0x10>NW <Nop>
nmap <Char-0x10>NX <Nop>
nmap <Char-0x10>NY <Nop>
nmap <Char-0x10>NZ <Nop>
nmap <Char-0x10>Na <Nop>
nmap <Char-0x10>Nb <Nop>
nmap <Char-0x10>Nc <Nop>
nmap <Char-0x10>Nd <Nop>
nmap <Char-0x10>Ne <Nop>
nmap <Char-0x10>Nf <Nop>
nmap <Char-0x10>Ng <Nop>
nmap <Char-0x10>Nh <Nop>
nmap <Char-0x10>Ni <Nop>
nmap <Char-0x10>Nj <Nop>
nmap <Char-0x10>Nk <Nop>
nmap <Char-0x10>Nl <Nop>
nmap <Char-0x10>Nm <Nop>
nmap <Char-0x10>Nn <Nop>
nmap <Char-0x10>No <Nop>
nmap <Char-0x10>Np <Nop>
nmap <Char-0x10>Nq <Nop>
nmap <Char-0x10>Nr <Nop>
nmap <Char-0x10>NG <Nop>
nmap <Char-0x10>NH <Nop>
nmap <Char-0x10>NI <Nop>
nmap <Char-0x10>NJ <Nop>
nmap <Char-0x10>NK <Nop>
nmap <Char-0x10>NL <Nop>
nmap <Char-0x10>NM <Nop>
nmap <Char-0x10>NN <Nop>
nmap <Char-0x10>NO <Nop>
nmap <Char-0x10>NP <Nop>
" }}}

" Symbols [Ctrl + Shift + Super]{{{
nmap <Char-0x10>NB <Nop>
nmap <Char-0x10>Nt <Nop>
nmap <Char-0x10>N1 <Nop>
nmap <Char-0x10>NC <Nop>
nmap <Char-0x10>N3 <Nop>
nmap <Char-0x10>N- <Nop>
nmap <Char-0x10>Nz <Nop>
nmap <Char-0x10>NR <Nop>
nmap <Char-0x10>Ny <Nop>
nmap <Char-0x10>Nv <Nop>
nmap <Char-0x10>Ns <Nop>
nmap <Char-0x10>ND <Nop>
nmap <Char-0x10>N! <Nop>
nmap <Char-0x10>NE <Nop>
nmap <Char-0x10>Nu <Nop>
nmap <Char-0x10>NQ <Nop>
nmap <Char-0x10>NF <Nop>
nmap <Char-0x10>NA <Nop>
nmap <Char-0x10>N0 <Nop>
nmap <Char-0x10>Nw <Nop>
nmap <Char-0x10>Nx <Nop>
nmap <Char-0x10>N^ <Nop>
" }}}

" Function keys [Ctrl + Shift + Super]{{{
nmap <Char-0x10>N/ <Nop>
nmap <Char-0x10>N* <Nop>
nmap <Char-0x10>N? <Nop>
nmap <Char-0x10>N& <Nop>
nmap <Char-0x10>N< <Nop>
nmap <Char-0x10>N> <Nop>
nmap <Char-0x10>N( <Nop>
nmap <Char-0x10>N) <Nop>
nmap <Char-0x10>N[ <Nop>
nmap <Char-0x10>N] <Nop>
nmap <Char-0x10>N{ <Nop>
nmap <Char-0x10>N} <Nop>
nmap <Char-0x10>N@ <Nop>
nmap <Char-0x10>N% <Nop>
nmap <Char-0x10>N$ <Nop>
nmap <Char-0x10>N# <Nop>
nmap <Char-0x10>NBA <Nop>
nmap <Char-0x10>NBB <Nop>
nmap <Char-0x10>NBC <Nop>
nmap <Char-0x10>NBD <Nop>
nmap <Char-0x10>NBE <Nop>
nmap <Char-0x10>NBF <Nop>
nmap <Char-0x10>NBG <Nop>
nmap <Char-0x10>NBH <Nop>
nmap <Char-0x10>NBI <Nop>
" }}}

" Modifiers [Ctrl + Shift + Super]{{{
nmap <Char-0x10>N: <Nop>
nmap <Char-0x10>N2 <Nop>
nmap <Char-0x10>NBc <Nop>
nmap <Char-0x10>NBb <Nop>
nmap <Char-0x10>NBa <Nop>
nmap <Char-0x10>NBd <Nop>
nmap <Char-0x10>N= <Nop>
nmap <Char-0x10>NBg <Nop>
nmap <Char-0x10>NBf <Nop>
nmap <Char-0x10>NBe <Nop>
nmap <Char-0x10>NBh <Nop>
nmap <Char-0x10>N+ <Nop>
" }}}

" Movement [Ctrl + Shift + Super]{{{
nmap <Char-0x10>N6 <Nop>
nmap <Char-0x10>N. <Nop>
nmap <Char-0x10>N5 <Nop>
nmap <Char-0x10>N9 <Nop>
nmap <Char-0x10>N8 <Nop>
nmap <Char-0x10>N4 <Nop>
nmap <Char-0x10>N7 <Nop>
" }}}

" Numpad [Ctrl + Shift + Super]{{{
nmap <Char-0x10>NBJ <Nop>
nmap <Char-0x10>NBK <Nop>
nmap <Char-0x10>NBL <Nop>
nmap <Char-0x10>NBM <Nop>
nmap <Char-0x10>NBN <Nop>
nmap <Char-0x10>NBO <Nop>
nmap <Char-0x10>NBP <Nop>
nmap <Char-0x10>NBQ <Nop>
nmap <Char-0x10>NBR <Nop>
nmap <Char-0x10>NBS <Nop>
nmap <Char-0x10>NBX <Nop>
nmap <Char-0x10>NBT <Nop>
nmap <Char-0x10>NBU <Nop>
nmap <Char-0x10>NBY <Nop>
nmap <Char-0x10>NBZ <Nop>
nmap <Char-0x10>NBV <Nop>
nmap <Char-0x10>NBW <Nop>
" }}}
" }}}
" Alt + control + Super [O]{{{
" Alphanumerics [Alt + Ctrl + Super]{{{
nmap <Char-0x10>OS <Nop>
nmap <Char-0x10>OT <Nop>
nmap <Char-0x10>OU <Nop>
nmap <Char-0x10>OV <Nop>
nmap <Char-0x10>OW <Nop>
nmap <Char-0x10>OX <Nop>
nmap <Char-0x10>OY <Nop>
nmap <Char-0x10>OZ <Nop>
nmap <Char-0x10>Oa <Nop>
nmap <Char-0x10>Ob <Nop>
nmap <Char-0x10>Oc <Nop>
nmap <Char-0x10>Od <Nop>
nmap <Char-0x10>Oe <Nop>
nmap <Char-0x10>Of <Nop>
nmap <Char-0x10>Og <Nop>
nmap <Char-0x10>Oh <Nop>
nmap <Char-0x10>Oi <Nop>
nmap <Char-0x10>Oj <Nop>
nmap <Char-0x10>Ok <Nop>
nmap <Char-0x10>Ol <Nop>
nmap <Char-0x10>Om <Nop>
nmap <Char-0x10>On <Nop>
nmap <Char-0x10>Oo <Nop>
nmap <Char-0x10>Op <Nop>
nmap <Char-0x10>Oq <Nop>
nmap <Char-0x10>Or <Nop>
nmap <Char-0x10>OG <Nop>
nmap <Char-0x10>OH <Nop>
nmap <Char-0x10>OI <Nop>
nmap <Char-0x10>OJ <Nop>
nmap <Char-0x10>OK <Nop>
nmap <Char-0x10>OL <Nop>
nmap <Char-0x10>OM <Nop>
nmap <Char-0x10>ON <Nop>
nmap <Char-0x10>OO <Nop>
nmap <Char-0x10>OP <Nop>
" }}}

" Symbols [Alt + Ctrl + Super]{{{
nmap <Char-0x10>OB <Nop>
nmap <Char-0x10>Ot <Nop>
nmap <Char-0x10>O1 <Nop>
nmap <Char-0x10>OC <Nop>
nmap <Char-0x10>O3 <Nop>
nmap <Char-0x10>O- <Nop>
nmap <Char-0x10>Oz <Nop>
nmap <Char-0x10>OR <Nop>
nmap <Char-0x10>Oy <Nop>
nmap <Char-0x10>Ov <Nop>
nmap <Char-0x10>Os <Nop>
nmap <Char-0x10>OD <Nop>
nmap <Char-0x10>O! <Nop>
nmap <Char-0x10>OE <Nop>
nmap <Char-0x10>Ou <Nop>
nmap <Char-0x10>OQ <Nop>
nmap <Char-0x10>OF <Nop>
nmap <Char-0x10>OA <Nop>
nmap <Char-0x10>O0 <Nop>
nmap <Char-0x10>Ow <Nop>
nmap <Char-0x10>Ox <Nop>
nmap <Char-0x10>O^ <Nop>
" }}}

" Function keys [Alt + Ctrl + Super]{{{
nmap <Char-0x10>O/ <Nop>
nmap <Char-0x10>O* <Nop>
nmap <Char-0x10>O? <Nop>
nmap <Char-0x10>O& <Nop>
nmap <Char-0x10>O< <Nop>
nmap <Char-0x10>O> <Nop>
nmap <Char-0x10>O( <Nop>
nmap <Char-0x10>O) <Nop>
nmap <Char-0x10>O[ <Nop>
nmap <Char-0x10>O] <Nop>
nmap <Char-0x10>O{ <Nop>
nmap <Char-0x10>O} <Nop>
nmap <Char-0x10>O@ <Nop>
nmap <Char-0x10>O% <Nop>
nmap <Char-0x10>O$ <Nop>
nmap <Char-0x10>O# <Nop>
nmap <Char-0x10>OBA <Nop>
nmap <Char-0x10>OBB <Nop>
nmap <Char-0x10>OBC <Nop>
nmap <Char-0x10>OBD <Nop>
nmap <Char-0x10>OBE <Nop>
nmap <Char-0x10>OBF <Nop>
nmap <Char-0x10>OBG <Nop>
nmap <Char-0x10>OBH <Nop>
nmap <Char-0x10>OBI <Nop>
" }}}

" Modifiers [Alt + Ctrl + Super]{{{
nmap <Char-0x10>O: <Nop>
nmap <Char-0x10>O2 <Nop>
nmap <Char-0x10>OBc <Nop>
nmap <Char-0x10>OBb <Nop>
nmap <Char-0x10>OBa <Nop>
nmap <Char-0x10>OBd <Nop>
nmap <Char-0x10>O= <Nop>
nmap <Char-0x10>OBg <Nop>
nmap <Char-0x10>OBf <Nop>
nmap <Char-0x10>OBe <Nop>
nmap <Char-0x10>OBh <Nop>
nmap <Char-0x10>O+ <Nop>
" }}}

" Movement [Alt + Ctrl + Super]{{{
nmap <Char-0x10>O6 <Nop>
nmap <Char-0x10>O. <Nop>
nmap <Char-0x10>O5 <Nop>
nmap <Char-0x10>O9 <Nop>
nmap <Char-0x10>O8 <Nop>
nmap <Char-0x10>O4 <Nop>
nmap <Char-0x10>O7 <Nop>
" }}}

" Numpad [Alt + Ctrl + Super]{{{
nmap <Char-0x10>OBJ <Nop>
nmap <Char-0x10>OBK <Nop>
nmap <Char-0x10>OBL <Nop>
nmap <Char-0x10>OBM <Nop>
nmap <Char-0x10>OBN <Nop>
nmap <Char-0x10>OBO <Nop>
nmap <Char-0x10>OBP <Nop>
nmap <Char-0x10>OBQ <Nop>
nmap <Char-0x10>OBR <Nop>
nmap <Char-0x10>OBS <Nop>
nmap <Char-0x10>OBX <Nop>
nmap <Char-0x10>OBT <Nop>
nmap <Char-0x10>OBU <Nop>
nmap <Char-0x10>OBY <Nop>
nmap <Char-0x10>OBZ <Nop>
nmap <Char-0x10>OBV <Nop>
nmap <Char-0x10>OBW <Nop>
" }}}
" }}}
" Alt + control + Shift + Super [P]{{{
" Alphanumerics [Alt + Ctrl + Shift + Super]{{{
nmap <Char-0x10>PS <Nop>
nmap <Char-0x10>PT <Nop>
nmap <Char-0x10>PU <Nop>
nmap <Char-0x10>PV <Nop>
nmap <Char-0x10>PW <Nop>
nmap <Char-0x10>PX <Nop>
nmap <Char-0x10>PY <Nop>
nmap <Char-0x10>PZ <Nop>
nmap <Char-0x10>Pa <Nop>
nmap <Char-0x10>Pb <Nop>
nmap <Char-0x10>Pc <Nop>
nmap <Char-0x10>Pd <Nop>
nmap <Char-0x10>Pe <Nop>
nmap <Char-0x10>Pf <Nop>
nmap <Char-0x10>Pg <Nop>
nmap <Char-0x10>Ph <Nop>
nmap <Char-0x10>Pi <Nop>
nmap <Char-0x10>Pj <Nop>
nmap <Char-0x10>Pk <Nop>
nmap <Char-0x10>Pl <Nop>
nmap <Char-0x10>Pm <Nop>
nmap <Char-0x10>Pn <Nop>
nmap <Char-0x10>Po <Nop>
nmap <Char-0x10>Pp <Nop>
nmap <Char-0x10>Pq <Nop>
nmap <Char-0x10>Pr <Nop>
nmap <Char-0x10>PG <Nop>
nmap <Char-0x10>PH <Nop>
nmap <Char-0x10>PI <Nop>
nmap <Char-0x10>PJ <Nop>
nmap <Char-0x10>PK <Nop>
nmap <Char-0x10>PL <Nop>
nmap <Char-0x10>PM <Nop>
nmap <Char-0x10>PN <Nop>
nmap <Char-0x10>PO <Nop>
nmap <Char-0x10>PP <Nop>
" }}}

" Symbols [Alt + Ctrl + Shift + Super]{{{
nmap <Char-0x10>PB <Nop>
nmap <Char-0x10>Pt <Nop>
nmap <Char-0x10>P1 <Nop>
nmap <Char-0x10>PC <Nop>
nmap <Char-0x10>P3 <Nop>
nmap <Char-0x10>P- <Nop>
nmap <Char-0x10>Pz <Nop>
nmap <Char-0x10>PR <Nop>
nmap <Char-0x10>Py <Nop>
nmap <Char-0x10>Pv <Nop>
nmap <Char-0x10>Ps <Nop>
nmap <Char-0x10>PD <Nop>
nmap <Char-0x10>P! <Nop>
nmap <Char-0x10>PE <Nop>
nmap <Char-0x10>Pu <Nop>
nmap <Char-0x10>PQ <Nop>
nmap <Char-0x10>PF <Nop>
nmap <Char-0x10>PA <Nop>
nmap <Char-0x10>P0 <Nop>
nmap <Char-0x10>Pw <Nop>
nmap <Char-0x10>Px <Nop>
nmap <Char-0x10>P^ <Nop>
" }}}

" Function keys [Alt + Ctrl + Shift + Super]{{{
nmap <Char-0x10>p/ <Nop>
nmap <Char-0x10>p* <Nop>
nmap <Char-0x10>p? <Nop>
nmap <Char-0x10>p& <Nop>
nmap <Char-0x10>p< <Nop>
nmap <Char-0x10>p> <Nop>
nmap <Char-0x10>p( <Nop>
nmap <Char-0x10>p) <Nop>
nmap <Char-0x10>p[ <Nop>
nmap <Char-0x10>p] <Nop>
nmap <Char-0x10>p{ <Nop>
nmap <Char-0x10>p} <Nop>
nmap <Char-0x10>p@ <Nop>
nmap <Char-0x10>p% <Nop>
nmap <Char-0x10>p$ <Nop>
nmap <Char-0x10>p# <Nop>
nmap <Char-0x10>pba <Nop>
nmap <Char-0x10>pbb <Nop>
nmap <Char-0x10>pbc <Nop>
nmap <Char-0x10>pbd <Nop>
nmap <Char-0x10>pbe <Nop>
nmap <Char-0x10>pbf <Nop>
nmap <Char-0x10>pbg <Nop>
nmap <Char-0x10>pbh <Nop>
nmap <Char-0x10>pbi <Nop>
" }}}

" Modifiers [Alt + Ctrl + Shift + Super]{{{
nmap <Char-0x10>P: <Nop>
nmap <Char-0x10>P2 <Nop>
nmap <Char-0x10>PBc <Nop>
nmap <Char-0x10>PBb <Nop>
nmap <Char-0x10>PBa <Nop>
nmap <Char-0x10>PBd <Nop>
nmap <Char-0x10>P= <Nop>
nmap <Char-0x10>PBg <Nop>
nmap <Char-0x10>PBf <Nop>
nmap <Char-0x10>PBe <Nop>
nmap <Char-0x10>PBh <Nop>
nmap <Char-0x10>P+ <Nop>
" }}}

" Movement [Alt + Ctrl + Shift + Super]{{{
nmap <Char-0x10>P6 <Nop>
nmap <Char-0x10>P. <Nop>
nmap <Char-0x10>P5 <Nop>
nmap <Char-0x10>P9 <Nop>
nmap <Char-0x10>P8 <Nop>
nmap <Char-0x10>P4 <Nop>
nmap <Char-0x10>P7 <Nop>
" }}}

" Numpad [Alt + Ctrl + Shift +  Super]{{{
nmap <Char-0x10>PBJ <Nop>
nmap <Char-0x10>PBK <Nop>
nmap <Char-0x10>PBL <Nop>
nmap <Char-0x10>PBM <Nop>
nmap <Char-0x10>PBN <Nop>
nmap <Char-0x10>PBO <Nop>
nmap <Char-0x10>PBP <Nop>
nmap <Char-0x10>PBQ <Nop>
nmap <Char-0x10>PBR <Nop>
nmap <Char-0x10>PBS <Nop>
nmap <Char-0x10>PBX <Nop>
nmap <Char-0x10>PBT <Nop>
nmap <Char-0x10>PBU <Nop>
nmap <Char-0x10>PBY <Nop>
nmap <Char-0x10>PBZ <Nop>
nmap <Char-0x10>PBV <Nop>
nmap <Char-0x10>PBW <Nop>
" }}}
" }}}
" }}}

" Visual {{{
" Shift - Special keys [B] {{{
xmap <Char-0x10>Bz <Nop>
xmap <Char-0x10>B1 <Nop>
xmap <Char-0x10>By <Nop>
" }}}
" Ctrl - Special keys [E] {{{
xmap <Char-0x10>Ez <Nop>
xmap <Char-0x10>E1 <Nop>
xmap <Char-0x10>Ey <Nop>
"xmap <Char-0x10>E0 <Nop>
" Ctrl + Tab : Move tab
" }}}
" Ctrl + Shift [F]{{{
" Alphanumerics [Ctrl + Shift]{{{
xmap <Char-0x10>FS <Nop>
xmap <Char-0x10>FT <Nop>
xmap <Char-0x10>FU <Nop>
xmap <Char-0x10>FV <Nop>
xmap <Char-0x10>FW <Nop>
xmap <Char-0x10>FX <Nop>
xmap <Char-0x10>FY <Nop>
xmap <Char-0x10>FZ <Nop>
xmap <Char-0x10>Fa <Nop>
xmap <Char-0x10>Fb <Nop>
xmap <Char-0x10>Fc <Nop>
xmap <Char-0x10>Fd <Nop>
xmap <Char-0x10>Fe <Nop>
xmap <Char-0x10>Ff <Nop>
xmap <Char-0x10>Fg <Nop>
"xmap <Char-0x10>Fh <Nop>
" Ctrl + Shift + p : Paste Mode
xmap <Char-0x10>Fi <Nop>
xmap <Char-0x10>Fj <Nop>
xmap <Char-0x10>Fk <Nop>
xmap <Char-0x10>Fl <Nop>
xmap <Char-0x10>Fm <Nop>
xmap <Char-0x10>Fn <Nop>
xmap <Char-0x10>Fo <Nop>
xmap <Char-0x10>Fp <Nop>
xmap <Char-0x10>Fq <Nop>
xmap <Char-0x10>Fr <Nop>
xmap <Char-0x10>FG <Nop>
xmap <Char-0x10>FH <Nop>
xmap <Char-0x10>FI <Nop>
xmap <Char-0x10>FJ <Nop>
xmap <Char-0x10>FK <Nop>
xmap <Char-0x10>FL <Nop>
xmap <Char-0x10>FM <Nop>
xmap <Char-0x10>FN <Nop>
xmap <Char-0x10>FO <Nop>
xmap <Char-0x10>FP <Nop>
" }}}

" Symbols [Ctrl + Shift]{{{
xmap <Char-0x10>FB <Nop>
xmap <Char-0x10>Ft <Nop>
xmap <Char-0x10>F1 <Nop>
xmap <Char-0x10>FC <Nop>
xmap <Char-0x10>F3 <Nop>
xmap <Char-0x10>F- <Nop>
xmap <Char-0x10>Fz <Nop>
xmap <Char-0x10>FR <Nop>
xmap <Char-0x10>Fy <Nop>
xmap <Char-0x10>Fv <Nop>
xmap <Char-0x10>Fs <Nop>
xmap <Char-0x10>FD <Nop>
xmap <Char-0x10>F! <Nop>
xmap <Char-0x10>FE <Nop>
xmap <Char-0x10>Fu <Nop>
xmap <Char-0x10>FQ <Nop>
xmap <Char-0x10>FF <Nop>
xmap <Char-0x10>FA <Nop>
"xmap <Char-0x10>F0 <Nop>
xmap <Char-0x10>Fw <Nop>
xmap <Char-0x10>Fx <Nop>
xmap <Char-0x10>F^ <Nop>
" }}}

" Function keys [Ctrl + Shift]{{{
xmap <Char-0x10>F/ <Nop>
xmap <Char-0x10>F* <Nop>
xmap <Char-0x10>F? <Nop>
xmap <Char-0x10>F& <Nop>
xmap <Char-0x10>F< <Nop>
xmap <Char-0x10>F> <Nop>
xmap <Char-0x10>F( <Nop>
xmap <Char-0x10>F) <Nop>
xmap <Char-0x10>F[ <Nop>
xmap <Char-0x10>F] <Nop>
xmap <Char-0x10>F{ <Nop>
xmap <Char-0x10>F} <Nop>
xmap <Char-0x10>F@ <Nop>
xmap <Char-0x10>F% <Nop>
xmap <Char-0x10>F$ <Nop>
xmap <Char-0x10>F# <Nop>
xmap <Char-0x10>FBA <Nop>
xmap <Char-0x10>FBB <Nop>
xmap <Char-0x10>FBC <Nop>
xmap <Char-0x10>FBD <Nop>
xmap <Char-0x10>FBE <Nop>
xmap <Char-0x10>FBF <Nop>
xmap <Char-0x10>FBG <Nop>
xmap <Char-0x10>FBH <Nop>
xmap <Char-0x10>FBI <Nop>
" }}}

" Modifiers / modes etc [Ctrl + Shift]{{{
xmap <Char-0x10>F: <Nop>
xmap <Char-0x10>F2 <Nop>
xmap <Char-0x10>FBc <Nop>
xmap <Char-0x10>FBb <Nop>
xmap <Char-0x10>FBa <Nop>
xmap <Char-0x10>FBd <Nop>
xmap <Char-0x10>F= <Nop>
xmap <Char-0x10>FBg <Nop>
xmap <Char-0x10>FBf <Nop>
xmap <Char-0x10>FBe <Nop>
xmap <Char-0x10>FBh <Nop>
xmap <Char-0x10>F+ <Nop>
" }}}

" Movement [Ctrl + Shift]{{{
xmap <Char-0x10>F6 <Nop>
xmap <Char-0x10>F. <Nop>
xmap <Char-0x10>F5 <Nop>
xmap <Char-0x10>F9 <Nop>
xmap <Char-0x10>F8 <Nop>
xmap <Char-0x10>F4 <Nop>
xmap <Char-0x10>F7 <Nop>
" }}}

" Numpad [Ctrl + Shift]{{{
xmap <Char-0x10>FBJ <Nop>
xmap <Char-0x10>FBK <Nop>
xmap <Char-0x10>FBL <Nop>
xmap <Char-0x10>FBM <Nop>
xmap <Char-0x10>FBN <Nop>
xmap <Char-0x10>FBO <Nop>
xmap <Char-0x10>FBP <Nop>
xmap <Char-0x10>FBQ <Nop>
xmap <Char-0x10>FBR <Nop>
xmap <Char-0x10>FBS <Nop>
xmap <Char-0x10>FBX <Nop>
xmap <Char-0x10>FBT <Nop>
xmap <Char-0x10>FBU <Nop>
xmap <Char-0x10>FBY <Nop>
xmap <Char-0x10>FBZ <Nop>
xmap <Char-0x10>FBV <Nop>
xmap <Char-0x10>FBW <Nop>
" }}}
" }}}
" Alt + Ctrl [G]{{{
" Alphanumerics [Alt + Ctrl]{{{
xmap <Char-0x10>GS <Nop>
xmap <Char-0x10>GT <Nop>
xmap <Char-0x10>GU <Nop>
xmap <Char-0x10>GV <Nop>
xmap <Char-0x10>GW <Nop>
xmap <Char-0x10>GX <Nop>
xmap <Char-0x10>GY <Nop>
"xmap <Char-0x10>GZ <Nop>
" ^ Alt + Ctrl + h : Indent left
xmap <Char-0x10>Ga <Nop>
"xmap <Char-0x10>Gb <Nop>
" ^ Alt + Ctrl + h : Indent down
"xmap <Char-0x10>Gc <Nop>
" ^ Alt + Ctrl + h : Indent up
"xmap <Char-0x10>Gd <Nop>
" ^ Alt + Ctrl + h : Indent right
xmap <Char-0x10>Ge <Nop>
xmap <Char-0x10>Gf <Nop>
xmap <Char-0x10>Gg <Nop>
"xmap <Char-0x10>Gh <Nop>
" Ctrl + Alt + p : Paste & jump
xmap <Char-0x10>Gi <Nop>
xmap <Char-0x10>Gj <Nop>
xmap <Char-0x10>Gk <Nop>
xmap <Char-0x10>Gl <Nop>
xmap <Char-0x10>Gm <Nop>
xmap <Char-0x10>Gn <Nop>
xmap <Char-0x10>Go <Nop>
xmap <Char-0x10>Gp <Nop>
xmap <Char-0x10>Gq <Nop>
xmap <Char-0x10>Gr <Nop>
xmap <Char-0x10>GG <Nop>
xmap <Char-0x10>GH <Nop>
xmap <Char-0x10>GI <Nop>
xmap <Char-0x10>GJ <Nop>
xmap <Char-0x10>GK <Nop>
xmap <Char-0x10>GL <Nop>
xmap <Char-0x10>GM <Nop>
xmap <Char-0x10>GN <Nop>
xmap <Char-0x10>GO <Nop>
xmap <Char-0x10>GP <Nop>
" }}}

" Symbols [Alt + Ctrl]{{{
xmap <Char-0x10>GB <Nop>
xmap <Char-0x10>Gt <Nop>
xmap <Char-0x10>G1 <Nop>
xmap <Char-0x10>GC <Nop>
xmap <Char-0x10>G3 <Nop>
xmap <Char-0x10>G- <Nop>
xmap <Char-0x10>Gz <Nop>
"xmap <Char-0x10>GR <Nop>
" Ctrl + Alt + = : Resize window up/down
xmap <Char-0x10>Gy <Nop>
xmap <Char-0x10>Gv <Nop>
xmap <Char-0x10>Gs <Nop>
"xmap <Char-0x10>GD <Nop>
" Ctrl + Alt + - : Resize window up/down
xmap <Char-0x10>G! <Nop>
xmap <Char-0x10>GE <Nop>
xmap <Char-0x10>Gu <Nop>
xmap <Char-0x10>GQ <Nop>
xmap <Char-0x10>GF <Nop>
xmap <Char-0x10>GA <Nop>
xmap <Char-0x10>G0 <Nop>
xmap <Char-0x10>Gw <Nop>
xmap <Char-0x10>Gx <Nop>
xmap <Char-0x10>G^ <Nop>
" }}}

" Function keys [Alt + Ctrl]{{{
xmap <Char-0x10>G/ <Nop>
xmap <Char-0x10>G* <Nop>
xmap <Char-0x10>G? <Nop>
xmap <Char-0x10>G& <Nop>
xmap <Char-0x10>G< <Nop>
xmap <Char-0x10>G> <Nop>
xmap <Char-0x10>G( <Nop>
xmap <Char-0x10>G) <Nop>
xmap <Char-0x10>G[ <Nop>
xmap <Char-0x10>G] <Nop>
xmap <Char-0x10>G{ <Nop>
xmap <Char-0x10>G} <Nop>
xmap <Char-0x10>G@ <Nop>
xmap <Char-0x10>G% <Nop>
xmap <Char-0x10>G$ <Nop>
xmap <Char-0x10>G# <Nop>
xmap <Char-0x10>GBA <Nop>
xmap <Char-0x10>GBB <Nop>
xmap <Char-0x10>GBC <Nop>
xmap <Char-0x10>GBD <Nop>
xmap <Char-0x10>GBE <Nop>
xmap <Char-0x10>GBF <Nop>
xmap <Char-0x10>GBG <Nop>
xmap <Char-0x10>GBH <Nop>
xmap <Char-0x10>GBI <Nop>
" }}}

" Modifiers [Alt + Ctrl]{{{
xmap <Char-0x10>G: <Nop>
xmap <Char-0x10>G2 <Nop>
xmap <Char-0x10>GBc <Nop>
xmap <Char-0x10>GBb <Nop>
xmap <Char-0x10>GBa <Nop>
xmap <Char-0x10>GBd <Nop>
xmap <Char-0x10>G= <Nop>
xmap <Char-0x10>GBg <Nop>
xmap <Char-0x10>GBf <Nop>
xmap <Char-0x10>GBe <Nop>
xmap <Char-0x10>GBh <Nop>
xmap <Char-0x10>G+ <Nop>
" }}}

" Movement [Alt + Ctrl]{{{
xmap <Char-0x10>G6 <Nop>
xmap <Char-0x10>G. <Nop>
xmap <Char-0x10>G5 <Nop>
xmap <Char-0x10>G9 <Nop>
xmap <Char-0x10>G8 <Nop>
xmap <Char-0x10>G4 <Nop>
xmap <Char-0x10>G7 <Nop>
" }}}

" Numpad [Alt + Ctrl]{{{
xmap <Char-0x10>GBJ <Nop>
xmap <Char-0x10>GBK <Nop>
xmap <Char-0x10>GBL <Nop>
xmap <Char-0x10>GBM <Nop>
xmap <Char-0x10>GBN <Nop>
xmap <Char-0x10>GBO <Nop>
xmap <Char-0x10>GBP <Nop>
xmap <Char-0x10>GBQ <Nop>
xmap <Char-0x10>GBR <Nop>
xmap <Char-0x10>GBS <Nop>
xmap <Char-0x10>GBX <Nop>
xmap <Char-0x10>GBT <Nop>
xmap <Char-0x10>GBU <Nop>
xmap <Char-0x10>GBY <Nop>
xmap <Char-0x10>GBZ <Nop>
xmap <Char-0x10>GBV <Nop>
xmap <Char-0x10>GBW <Nop>
" }}}
" }}}
" Alt + Ctrl + Shift [H]{{{
" Alphanumerics [Alt + Ctrl + Shift]{{{
xmap <Char-0x10>HS <Nop>
xmap <Char-0x10>HT <Nop>
xmap <Char-0x10>HU <Nop>
xmap <Char-0x10>HV <Nop>
xmap <Char-0x10>HW <Nop>
xmap <Char-0x10>HX <Nop>
xmap <Char-0x10>HY <Nop>
xmap <Char-0x10>HZ <Nop>
xmap <Char-0x10>Ha <Nop>
xmap <Char-0x10>Hb <Nop>
xmap <Char-0x10>Hc <Nop>
xmap <Char-0x10>Hd <Nop>
xmap <Char-0x10>He <Nop>
xmap <Char-0x10>Hf <Nop>
xmap <Char-0x10>Hg <Nop>
xmap <Char-0x10>Hh <Nop>
xmap <Char-0x10>Hi <Nop>
xmap <Char-0x10>Hj <Nop>
xmap <Char-0x10>Hk <Nop>
xmap <Char-0x10>Hl <Nop>
xmap <Char-0x10>Hm <Nop>
xmap <Char-0x10>Hn <Nop>
xmap <Char-0x10>Ho <Nop>
xmap <Char-0x10>Hp <Nop>
xmap <Char-0x10>Hq <Nop>
xmap <Char-0x10>Hr <Nop>
xmap <Char-0x10>HG <Nop>
xmap <Char-0x10>HH <Nop>
xmap <Char-0x10>HI <Nop>
xmap <Char-0x10>HJ <Nop>
xmap <Char-0x10>HK <Nop>
xmap <Char-0x10>HL <Nop>
xmap <Char-0x10>HM <Nop>
xmap <Char-0x10>HN <Nop>
xmap <Char-0x10>HO <Nop>
xmap <Char-0x10>HP <Nop>
" }}}

" Symbols [Alt + Ctrl + Shift]{{{
xmap <Char-0x10>HB <Nop>
xmap <Char-0x10>Ht <Nop>
xmap <Char-0x10>H1 <Nop>
xmap <Char-0x10>HC <Nop>
xmap <Char-0x10>H3 <Nop>
xmap <Char-0x10>H- <Nop>
xmap <Char-0x10>Hz <Nop>
"xmap <Char-0x10>HR <Nop>
" Ctrl + Alt + _ : Resize window
xmap <Char-0x10>Hy <Nop>
xmap <Char-0x10>Hv <Nop>
xmap <Char-0x10>Hs <Nop>
"xmap <Char-0x10>HD <Nop>
" Ctrl + Alt + + : Resize window
xmap <Char-0x10>H! <Nop>
xmap <Char-0x10>HE <Nop>
xmap <Char-0x10>Hu <Nop>
xmap <Char-0x10>HQ <Nop>
xmap <Char-0x10>HF <Nop>
xmap <Char-0x10>HA <Nop>
xmap <Char-0x10>H0 <Nop>
xmap <Char-0x10>Hw <Nop>
xmap <Char-0x10>Hx <Nop>
xmap <Char-0x10>H^ <Nop>
" }}}

" Function keys [Alt + Ctrl + Shift]{{{
xmap <Char-0x10>H/ <Nop>
xmap <Char-0x10>H* <Nop>
xmap <Char-0x10>H? <Nop>
xmap <Char-0x10>H& <Nop>
xmap <Char-0x10>H< <Nop>
xmap <Char-0x10>H> <Nop>
xmap <Char-0x10>H( <Nop>
xmap <Char-0x10>H) <Nop>
xmap <Char-0x10>H[ <Nop>
xmap <Char-0x10>H] <Nop>
xmap <Char-0x10>H{ <Nop>
xmap <Char-0x10>H} <Nop>
xmap <Char-0x10>H@ <Nop>
xmap <Char-0x10>H% <Nop>
xmap <Char-0x10>H$ <Nop>
xmap <Char-0x10>H# <Nop>
xmap <Char-0x10>HBA <Nop>
xmap <Char-0x10>HBB <Nop>
xmap <Char-0x10>HBC <Nop>
xmap <Char-0x10>HBD <Nop>
xmap <Char-0x10>HBE <Nop>
xmap <Char-0x10>HBF <Nop>
xmap <Char-0x10>HBG <Nop>
xmap <Char-0x10>HBH <Nop>
xmap <Char-0x10>HBI <Nop>
" }}}

" Modifiers [Alt + Ctrl + Shift]{{{
xmap <Char-0x10>H: <Nop>
xmap <Char-0x10>H2 <Nop>
xmap <Char-0x10>HBc <Nop>
xmap <Char-0x10>HBb <Nop>
xmap <Char-0x10>HBa <Nop>
xmap <Char-0x10>HBd <Nop>
xmap <Char-0x10>H= <Nop>
xmap <Char-0x10>HBg <Nop>
xmap <Char-0x10>HBf <Nop>
xmap <Char-0x10>HBe <Nop>
xmap <Char-0x10>HBh <Nop>
xmap <Char-0x10>H+ <Nop>
" }}}

" Movement [Alt + Ctrl + Shift]{{{
xmap <Char-0x10>H6 <Nop>
xmap <Char-0x10>H. <Nop>
xmap <Char-0x10>H5 <Nop>
xmap <Char-0x10>H9 <Nop>
xmap <Char-0x10>H8 <Nop>
xmap <Char-0x10>H4 <Nop>
xmap <Char-0x10>H7 <Nop>
" }}}

" Numpad [Alt + Ctrl + Shift]{{{
xmap <Char-0x10>HBJ <Nop>
xmap <Char-0x10>HBK <Nop>
xmap <Char-0x10>HBL <Nop>
xmap <Char-0x10>HBM <Nop>
xmap <Char-0x10>HBN <Nop>
xmap <Char-0x10>HBO <Nop>
xmap <Char-0x10>HBP <Nop>
xmap <Char-0x10>HBQ <Nop>
xmap <Char-0x10>HBR <Nop>
xmap <Char-0x10>HBS <Nop>
xmap <Char-0x10>HBX <Nop>
xmap <Char-0x10>HBT <Nop>
xmap <Char-0x10>HBU <Nop>
xmap <Char-0x10>HBY <Nop>
xmap <Char-0x10>HBZ <Nop>
xmap <Char-0x10>HBV <Nop>
xmap <Char-0x10>HBW <Nop>
" }}}
" }}}
" Super [I]{{{
" Alphanumerics [Super]{{{
xmap <Char-0x10>IS <Nop>
xmap <Char-0x10>IT <Nop>
xmap <Char-0x10>IU <Nop>
xmap <Char-0x10>IV <Nop>
xmap <Char-0x10>IW <Nop>
xmap <Char-0x10>IX <Nop>
xmap <Char-0x10>IY <Nop>
xmap <Char-0x10>IZ <Nop>
xmap <Char-0x10>Ia <Nop>
xmap <Char-0x10>Ib <Nop>
xmap <Char-0x10>Ic <Nop>
xmap <Char-0x10>Id <Nop>
xmap <Char-0x10>Ie <Nop>
xmap <Char-0x10>If <Nop>
xmap <Char-0x10>Ig <Nop>
xmap <Char-0x10>Ih <Nop>
xmap <Char-0x10>Ii <Nop>
xmap <Char-0x10>Ij <Nop>
xmap <Char-0x10>Ik <Nop>
xmap <Char-0x10>Il <Nop>
xmap <Char-0x10>Im <Nop>
xmap <Char-0x10>In <Nop>
xmap <Char-0x10>Io <Nop>
xmap <Char-0x10>Ip <Nop>
xmap <Char-0x10>Iq <Nop>
xmap <Char-0x10>Ir <Nop>
xmap <Char-0x10>IG <Nop>
xmap <Char-0x10>IH <Nop>
xmap <Char-0x10>II <Nop>
xmap <Char-0x10>IJ <Nop>
xmap <Char-0x10>IK <Nop>
xmap <Char-0x10>IL <Nop>
xmap <Char-0x10>IM <Nop>
xmap <Char-0x10>IN <Nop>
xmap <Char-0x10>IO <Nop>
xmap <Char-0x10>IP <Nop>
" }}}

" Symbols [Super]{{{
xmap <Char-0x10>IB <Nop>
xmap <Char-0x10>It <Nop>
xmap <Char-0x10>I1 <Nop>
xmap <Char-0x10>IC <Nop>
xmap <Char-0x10>I3 <Nop>
xmap <Char-0x10>I- <Nop>
xmap <Char-0x10>Iz <Nop>
xmap <Char-0x10>IR <Nop>
xmap <Char-0x10>Iy <Nop>
xmap <Char-0x10>Iv <Nop>
xmap <Char-0x10>Is <Nop>
xmap <Char-0x10>ID <Nop>
xmap <Char-0x10>I! <Nop>
xmap <Char-0x10>IE <Nop>
xmap <Char-0x10>Iu <Nop>
xmap <Char-0x10>IQ <Nop>
xmap <Char-0x10>IF <Nop>
xmap <Char-0x10>IA <Nop>
xmap <Char-0x10>I0 <Nop>
xmap <Char-0x10>Iw <Nop>
xmap <Char-0x10>Ix <Nop>
xmap <Char-0x10>I^ <Nop>
" }}}

" Function keys [Super]{{{
xmap <Char-0x10>I/ <Nop>
xmap <Char-0x10>I* <Nop>
xmap <Char-0x10>I? <Nop>
xmap <Char-0x10>I& <Nop>
xmap <Char-0x10>I< <Nop>
xmap <Char-0x10>I> <Nop>
xmap <Char-0x10>I( <Nop>
xmap <Char-0x10>I) <Nop>
xmap <Char-0x10>I[ <Nop>
xmap <Char-0x10>I] <Nop>
xmap <Char-0x10>I{ <Nop>
xmap <Char-0x10>I} <Nop>
xmap <Char-0x10>I@ <Nop>
xmap <Char-0x10>I% <Nop>
xmap <Char-0x10>I$ <Nop>
xmap <Char-0x10>I# <Nop>
xmap <Char-0x10>IBA <Nop>
xmap <Char-0x10>IBB <Nop>
xmap <Char-0x10>IBC <Nop>
xmap <Char-0x10>IBD <Nop>
xmap <Char-0x10>IBE <Nop>
xmap <Char-0x10>IBF <Nop>
xmap <Char-0x10>IBG <Nop>
xmap <Char-0x10>IBH <Nop>
xmap <Char-0x10>IBI <Nop>
" }}}

" Modifiers [Super]{{{
xmap <Char-0x10>I: <Nop>
xmap <Char-0x10>I2 <Nop>
xmap <Char-0x10>IBc <Nop>
xmap <Char-0x10>IBb <Nop>
xmap <Char-0x10>IBa <Nop>
xmap <Char-0x10>IBd <Nop>
xmap <Char-0x10>I= <Nop>
xmap <Char-0x10>IBg <Nop>
xmap <Char-0x10>IBf <Nop>
xmap <Char-0x10>IBe <Nop>
xmap <Char-0x10>IBh <Nop>
xmap <Char-0x10>I+ <Nop>
" }}}

" Movement [Super]{{{
xmap <Char-0x10>I6 <Nop>
xmap <Char-0x10>I. <Nop>
xmap <Char-0x10>I5 <Nop>
xmap <Char-0x10>I9 <Nop>
xmap <Char-0x10>I8 <Nop>
xmap <Char-0x10>I4 <Nop>
xmap <Char-0x10>I7 <Nop>
" }}}

" Numpad [Super]{{{
xmap <Char-0x10>IBJ <Nop>
xmap <Char-0x10>IBK <Nop>
xmap <Char-0x10>IBL <Nop>
xmap <Char-0x10>IBM <Nop>
xmap <Char-0x10>IBN <Nop>
xmap <Char-0x10>IBO <Nop>
xmap <Char-0x10>IBP <Nop>
xmap <Char-0x10>IBQ <Nop>
xmap <Char-0x10>IBR <Nop>
xmap <Char-0x10>IBS <Nop>
xmap <Char-0x10>IBX <Nop>
xmap <Char-0x10>IBT <Nop>
xmap <Char-0x10>IBU <Nop>
xmap <Char-0x10>IBY <Nop>
xmap <Char-0x10>IBZ <Nop>
xmap <Char-0x10>IBV <Nop>
xmap <Char-0x10>IBW <Nop>
" }}}
" }}}
" Shift + Super [J]{{{
" Alphanumerics [Shift + Super]{{{
xmap <Char-0x10>JS <Nop>
xmap <Char-0x10>JT <Nop>
xmap <Char-0x10>JU <Nop>
xmap <Char-0x10>JV <Nop>
xmap <Char-0x10>JW <Nop>
xmap <Char-0x10>JX <Nop>
xmap <Char-0x10>JY <Nop>
xmap <Char-0x10>JZ <Nop>
xmap <Char-0x10>Ja <Nop>
xmap <Char-0x10>Jb <Nop>
xmap <Char-0x10>Jc <Nop>
xmap <Char-0x10>Jd <Nop>
xmap <Char-0x10>Je <Nop>
xmap <Char-0x10>Jf <Nop>
xmap <Char-0x10>Jg <Nop>
xmap <Char-0x10>Jh <Nop>
xmap <Char-0x10>Ji <Nop>
xmap <Char-0x10>Jj <Nop>
xmap <Char-0x10>Jk <Nop>
xmap <Char-0x10>Jl <Nop>
xmap <Char-0x10>Jm <Nop>
xmap <Char-0x10>Jn <Nop>
xmap <Char-0x10>Jo <Nop>
xmap <Char-0x10>Jp <Nop>
xmap <Char-0x10>Jq <Nop>
xmap <Char-0x10>Jr <Nop>
xmap <Char-0x10>JG <Nop>
xmap <Char-0x10>JH <Nop>
xmap <Char-0x10>JI <Nop>
xmap <Char-0x10>JJ <Nop>
xmap <Char-0x10>JK <Nop>
xmap <Char-0x10>JL <Nop>
xmap <Char-0x10>JM <Nop>
xmap <Char-0x10>JN <Nop>
xmap <Char-0x10>JO <Nop>
xmap <Char-0x10>JP <Nop>
" }}}

" Symbols [Shift + Super]{{{
xmap <Char-0x10>JB <Nop>
xmap <Char-0x10>Jt <Nop>
xmap <Char-0x10>J1 <Nop>
xmap <Char-0x10>JC <Nop>
xmap <Char-0x10>J3 <Nop>
xmap <Char-0x10>J- <Nop>
xmap <Char-0x10>Jz <Nop>
xmap <Char-0x10>JR <Nop>
xmap <Char-0x10>Jy <Nop>
xmap <Char-0x10>Jv <Nop>
xmap <Char-0x10>Js <Nop>
xmap <Char-0x10>JD <Nop>
xmap <Char-0x10>J! <Nop>
xmap <Char-0x10>JE <Nop>
xmap <Char-0x10>Ju <Nop>
xmap <Char-0x10>JQ <Nop>
xmap <Char-0x10>JF <Nop>
xmap <Char-0x10>JA <Nop>
xmap <Char-0x10>J0 <Nop>
xmap <Char-0x10>Jw <Nop>
xmap <Char-0x10>Jx <Nop>
xmap <Char-0x10>J^ <Nop>
" }}}

" Function keys [Shift + Super]{{{
xmap <Char-0x10>J/ <Nop>
xmap <Char-0x10>J* <Nop>
xmap <Char-0x10>J? <Nop>
xmap <Char-0x10>J& <Nop>
xmap <Char-0x10>J< <Nop>
xmap <Char-0x10>J> <Nop>
xmap <Char-0x10>J( <Nop>
xmap <Char-0x10>J) <Nop>
xmap <Char-0x10>J[ <Nop>
xmap <Char-0x10>J] <Nop>
xmap <Char-0x10>J{ <Nop>
xmap <Char-0x10>J} <Nop>
xmap <Char-0x10>J@ <Nop>
xmap <Char-0x10>J% <Nop>
xmap <Char-0x10>J$ <Nop>
xmap <Char-0x10>J# <Nop>
xmap <Char-0x10>JBA <Nop>
xmap <Char-0x10>JBB <Nop>
xmap <Char-0x10>JBC <Nop>
xmap <Char-0x10>JBD <Nop>
xmap <Char-0x10>JBE <Nop>
xmap <Char-0x10>JBF <Nop>
xmap <Char-0x10>JBG <Nop>
xmap <Char-0x10>JBH <Nop>
xmap <Char-0x10>JBI <Nop>
" }}}

" Modifiers [Shift + Super]{{{
xmap <Char-0x10>J: <Nop>
xmap <Char-0x10>J2 <Nop>
xmap <Char-0x10>JBc <Nop>
xmap <Char-0x10>JBb <Nop>
xmap <Char-0x10>JBa <Nop>
xmap <Char-0x10>JBd <Nop>
xmap <Char-0x10>J= <Nop>
xmap <Char-0x10>JBg <Nop>
xmap <Char-0x10>JBf <Nop>
xmap <Char-0x10>JBe <Nop>
xmap <Char-0x10>JBh <Nop>
xmap <Char-0x10>J+ <Nop>
" }}}

" Movement [Shift + Super]{{{
xmap <Char-0x10>J6 <Nop>
xmap <Char-0x10>J. <Nop>
xmap <Char-0x10>J5 <Nop>
xmap <Char-0x10>J9 <Nop>
xmap <Char-0x10>J8 <Nop>
xmap <Char-0x10>J4 <Nop>
xmap <Char-0x10>J7 <Nop>
" }}}

" Numpad [Shift + Super]{{{
xmap <Char-0x10>JBJ <Nop>
xmap <Char-0x10>JBK <Nop>
xmap <Char-0x10>JBL <Nop>
xmap <Char-0x10>JBM <Nop>
xmap <Char-0x10>JBN <Nop>
xmap <Char-0x10>JBO <Nop>
xmap <Char-0x10>JBP <Nop>
xmap <Char-0x10>JBQ <Nop>
xmap <Char-0x10>JBR <Nop>
xmap <Char-0x10>JBS <Nop>
xmap <Char-0x10>JBX <Nop>
xmap <Char-0x10>JBT <Nop>
xmap <Char-0x10>JBU <Nop>
xmap <Char-0x10>JBY <Nop>
xmap <Char-0x10>JBZ <Nop>
xmap <Char-0x10>JBV <Nop>
xmap <Char-0x10>JBW <Nop>
" }}}
" }}}
" Alt + Super [K]{{{
" Alphanumerics [Alt + Super]{{{
xmap <Char-0x10>KS <Nop>
xmap <Char-0x10>KT <Nop>
xmap <Char-0x10>KU <Nop>
xmap <Char-0x10>KV <Nop>
xmap <Char-0x10>KW <Nop>
xmap <Char-0x10>KX <Nop>
xmap <Char-0x10>KY <Nop>
xmap <Char-0x10>KZ <Nop>
xmap <Char-0x10>Ka <Nop>
xmap <Char-0x10>Kb <Nop>
xmap <Char-0x10>Kc <Nop>
xmap <Char-0x10>Kd <Nop>
xmap <Char-0x10>Ke <Nop>
xmap <Char-0x10>Kf <Nop>
xmap <Char-0x10>Kg <Nop>
xmap <Char-0x10>Kh <Nop>
xmap <Char-0x10>Ki <Nop>
xmap <Char-0x10>Kj <Nop>
xmap <Char-0x10>Kk <Nop>
xmap <Char-0x10>Kl <Nop>
xmap <Char-0x10>Km <Nop>
xmap <Char-0x10>Kn <Nop>
xmap <Char-0x10>Ko <Nop>
xmap <Char-0x10>Kp <Nop>
xmap <Char-0x10>Kq <Nop>
xmap <Char-0x10>Kr <Nop>
xmap <Char-0x10>KG <Nop>
xmap <Char-0x10>KH <Nop>
xmap <Char-0x10>KI <Nop>
xmap <Char-0x10>KJ <Nop>
xmap <Char-0x10>KK <Nop>
xmap <Char-0x10>KL <Nop>
xmap <Char-0x10>KM <Nop>
xmap <Char-0x10>KN <Nop>
xmap <Char-0x10>KO <Nop>
xmap <Char-0x10>KP <Nop>
" }}}

" Symbols [Alt + Super]{{{
xmap <Char-0x10>KB <Nop>
xmap <Char-0x10>Kt <Nop>
xmap <Char-0x10>K1 <Nop>
xmap <Char-0x10>KC <Nop>
xmap <Char-0x10>K3 <Nop>
xmap <Char-0x10>K- <Nop>
xmap <Char-0x10>Kz <Nop>
xmap <Char-0x10>KR <Nop>
xmap <Char-0x10>Ky <Nop>
xmap <Char-0x10>Kv <Nop>
xmap <Char-0x10>Ks <Nop>
xmap <Char-0x10>KD <Nop>
xmap <Char-0x10>K! <Nop>
xmap <Char-0x10>KE <Nop>
xmap <Char-0x10>Ku <Nop>
xmap <Char-0x10>KQ <Nop>
xmap <Char-0x10>KF <Nop>
xmap <Char-0x10>KA <Nop>
xmap <Char-0x10>K0 <Nop>
xmap <Char-0x10>Kw <Nop>
xmap <Char-0x10>Kx <Nop>
xmap <Char-0x10>K^ <Nop>
" }}}

" Function keys [Alt + Super]{{{
xmap <Char-0x10>K/ <Nop>
xmap <Char-0x10>K* <Nop>
xmap <Char-0x10>K? <Nop>
xmap <Char-0x10>K& <Nop>
xmap <Char-0x10>K< <Nop>
xmap <Char-0x10>K> <Nop>
xmap <Char-0x10>K( <Nop>
xmap <Char-0x10>K) <Nop>
xmap <Char-0x10>K[ <Nop>
xmap <Char-0x10>K] <Nop>
xmap <Char-0x10>K{ <Nop>
xmap <Char-0x10>K} <Nop>
xmap <Char-0x10>K@ <Nop>
xmap <Char-0x10>K% <Nop>
xmap <Char-0x10>K$ <Nop>
xmap <Char-0x10>K# <Nop>
xmap <Char-0x10>KBA <Nop>
xmap <Char-0x10>KBB <Nop>
xmap <Char-0x10>KBC <Nop>
xmap <Char-0x10>KBD <Nop>
xmap <Char-0x10>KBE <Nop>
xmap <Char-0x10>KBF <Nop>
xmap <Char-0x10>KBG <Nop>
xmap <Char-0x10>KBH <Nop>
xmap <Char-0x10>KBI <Nop>
" }}}

" Modifiers [Alt + Super]{{{
xmap <Char-0x10>K: <Nop>
xmap <Char-0x10>K2 <Nop>
xmap <Char-0x10>KBc <Nop>
xmap <Char-0x10>KBb <Nop>
xmap <Char-0x10>KBa <Nop>
xmap <Char-0x10>KBd <Nop>
xmap <Char-0x10>K= <Nop>
xmap <Char-0x10>KBg <Nop>
xmap <Char-0x10>KBf <Nop>
xmap <Char-0x10>KBe <Nop>
xmap <Char-0x10>KBh <Nop>
xmap <Char-0x10>K+ <Nop>
" }}}

" Movement [Alt + Super]{{{
xmap <Char-0x10>K6 <Nop>
xmap <Char-0x10>K. <Nop>
xmap <Char-0x10>K5 <Nop>
xmap <Char-0x10>K9 <Nop>
xmap <Char-0x10>K8 <Nop>
xmap <Char-0x10>K4 <Nop>
xmap <Char-0x10>K7 <Nop>
" }}}

" Numpad [Alt + Super]{{{
xmap <Char-0x10>KBJ <Nop>
xmap <Char-0x10>KBK <Nop>
xmap <Char-0x10>KBL <Nop>
xmap <Char-0x10>KBM <Nop>
xmap <Char-0x10>KBN <Nop>
xmap <Char-0x10>KBO <Nop>
xmap <Char-0x10>KBP <Nop>
xmap <Char-0x10>KBQ <Nop>
xmap <Char-0x10>KBR <Nop>
xmap <Char-0x10>KBS <Nop>
xmap <Char-0x10>KBX <Nop>
xmap <Char-0x10>KBT <Nop>
xmap <Char-0x10>KBU <Nop>
xmap <Char-0x10>KBY <Nop>
xmap <Char-0x10>KBZ <Nop>
xmap <Char-0x10>KBV <Nop>
xmap <Char-0x10>KBW <Nop>
" }}}
" }}}
" Alt + Shift + Super [L]{{{
" Alphanumerics [Alt + Shift + Super]{{{
xmap <Char-0x10>LS <Nop>
xmap <Char-0x10>LT <Nop>
xmap <Char-0x10>LU <Nop>
xmap <Char-0x10>LV <Nop>
xmap <Char-0x10>LW <Nop>
xmap <Char-0x10>LX <Nop>
xmap <Char-0x10>LY <Nop>
xmap <Char-0x10>LZ <Nop>
xmap <Char-0x10>La <Nop>
xmap <Char-0x10>Lb <Nop>
xmap <Char-0x10>Lc <Nop>
xmap <Char-0x10>Ld <Nop>
xmap <Char-0x10>Le <Nop>
xmap <Char-0x10>Lf <Nop>
xmap <Char-0x10>Lg <Nop>
xmap <Char-0x10>Lh <Nop>
xmap <Char-0x10>Li <Nop>
xmap <Char-0x10>Lj <Nop>
xmap <Char-0x10>Lk <Nop>
xmap <Char-0x10>Ll <Nop>
xmap <Char-0x10>Lm <Nop>
xmap <Char-0x10>Ln <Nop>
xmap <Char-0x10>Lo <Nop>
xmap <Char-0x10>Lp <Nop>
xmap <Char-0x10>Lq <Nop>
xmap <Char-0x10>Lr <Nop>
xmap <Char-0x10>LG <Nop>
xmap <Char-0x10>LH <Nop>
xmap <Char-0x10>LI <Nop>
xmap <Char-0x10>LJ <Nop>
xmap <Char-0x10>LK <Nop>
xmap <Char-0x10>LL <Nop>
xmap <Char-0x10>LM <Nop>
xmap <Char-0x10>LN <Nop>
xmap <Char-0x10>LO <Nop>
xmap <Char-0x10>LP <Nop>
" }}}

" Symbols [Alt + Shift  + Super]{{{
xmap <Char-0x10>LB <Nop>
xmap <Char-0x10>Lt <Nop>
xmap <Char-0x10>L1 <Nop>
xmap <Char-0x10>LC <Nop>
xmap <Char-0x10>L3 <Nop>
xmap <Char-0x10>L- <Nop>
xmap <Char-0x10>Lz <Nop>
xmap <Char-0x10>LR <Nop>
xmap <Char-0x10>Ly <Nop>
xmap <Char-0x10>Lv <Nop>
xmap <Char-0x10>Ls <Nop>
xmap <Char-0x10>LD <Nop>
xmap <Char-0x10>L! <Nop>
xmap <Char-0x10>LE <Nop>
xmap <Char-0x10>Lu <Nop>
xmap <Char-0x10>LQ <Nop>
xmap <Char-0x10>LF <Nop>
xmap <Char-0x10>LA <Nop>
xmap <Char-0x10>L0 <Nop>
xmap <Char-0x10>Lw <Nop>
xmap <Char-0x10>Lx <Nop>
xmap <Char-0x10>L^ <Nop>
" }}}

" Function keys [Alt + Shift + Super]{{{
xmap <Char-0x10>L/ <Nop>
xmap <Char-0x10>L* <Nop>
xmap <Char-0x10>L? <Nop>
xmap <Char-0x10>L& <Nop>
xmap <Char-0x10>L< <Nop>
xmap <Char-0x10>L> <Nop>
xmap <Char-0x10>L( <Nop>
xmap <Char-0x10>L) <Nop>
xmap <Char-0x10>L[ <Nop>
xmap <Char-0x10>L] <Nop>
xmap <Char-0x10>L{ <Nop>
xmap <Char-0x10>L} <Nop>
xmap <Char-0x10>L@ <Nop>
xmap <Char-0x10>L% <Nop>
xmap <Char-0x10>L$ <Nop>
xmap <Char-0x10>L# <Nop>
xmap <Char-0x10>LBA <Nop>
xmap <Char-0x10>LBB <Nop>
xmap <Char-0x10>LBC <Nop>
xmap <Char-0x10>LBD <Nop>
xmap <Char-0x10>LBE <Nop>
xmap <Char-0x10>LBF <Nop>
xmap <Char-0x10>LBG <Nop>
xmap <Char-0x10>LBH <Nop>
xmap <Char-0x10>LBI <Nop>
" }}}

" Modifiers [Alt + Shift + Super]{{{
xmap <Char-0x10>L: <Nop>
xmap <Char-0x10>L2 <Nop>
xmap <Char-0x10>LBc <Nop>
xmap <Char-0x10>LBb <Nop>
xmap <Char-0x10>LBa <Nop>
xmap <Char-0x10>LBd <Nop>
xmap <Char-0x10>L= <Nop>
xmap <Char-0x10>LBg <Nop>
xmap <Char-0x10>LBf <Nop>
xmap <Char-0x10>LBe <Nop>
xmap <Char-0x10>LBh <Nop>
xmap <Char-0x10>L+ <Nop>
" }}}

" Movement [Alt + Shift + Super]{{{
xmap <Char-0x10>L6 <Nop>
xmap <Char-0x10>L. <Nop>
xmap <Char-0x10>L5 <Nop>
xmap <Char-0x10>L9 <Nop>
xmap <Char-0x10>L8 <Nop>
xmap <Char-0x10>L4 <Nop>
xmap <Char-0x10>L7 <Nop>
" }}}

" Numpad [Alt + Shift + Super]{{{
xmap <Char-0x10>LBJ <Nop>
xmap <Char-0x10>LBK <Nop>
xmap <Char-0x10>LBL <Nop>
xmap <Char-0x10>LBM <Nop>
xmap <Char-0x10>LBN <Nop>
xmap <Char-0x10>LBO <Nop>
xmap <Char-0x10>LBP <Nop>
xmap <Char-0x10>LBQ <Nop>
xmap <Char-0x10>LBR <Nop>
xmap <Char-0x10>LBS <Nop>
xmap <Char-0x10>LBX <Nop>
xmap <Char-0x10>LBT <Nop>
xmap <Char-0x10>LBU <Nop>
xmap <Char-0x10>LBY <Nop>
xmap <Char-0x10>LBZ <Nop>
xmap <Char-0x10>LBV <Nop>
xmap <Char-0x10>LBW <Nop>
" }}}
" }}}
" Alt + Ctrl + Shift + Super [L]{{{
" Alphanumerics [Ctrl + Super]{{{
xmap <Char-0x10>MS <Nop>
xmap <Char-0x10>MT <Nop>
xmap <Char-0x10>MU <Nop>
xmap <Char-0x10>MV <Nop>
xmap <Char-0x10>MW <Nop>
xmap <Char-0x10>MX <Nop>
xmap <Char-0x10>MY <Nop>
xmap <Char-0x10>MZ <Nop>
xmap <Char-0x10>Ma <Nop>
xmap <Char-0x10>Mb <Nop>
xmap <Char-0x10>Mc <Nop>
xmap <Char-0x10>Md <Nop>
xmap <Char-0x10>Me <Nop>
xmap <Char-0x10>Mf <Nop>
xmap <Char-0x10>Mg <Nop>
xmap <Char-0x10>Mh <Nop>
xmap <Char-0x10>Mi <Nop>
xmap <Char-0x10>Mj <Nop>
xmap <Char-0x10>Mk <Nop>
xmap <Char-0x10>Ml <Nop>
xmap <Char-0x10>Mm <Nop>
xmap <Char-0x10>Mn <Nop>
xmap <Char-0x10>Mo <Nop>
xmap <Char-0x10>Mp <Nop>
xmap <Char-0x10>Mq <Nop>
xmap <Char-0x10>Mr <Nop>
xmap <Char-0x10>MG <Nop>
xmap <Char-0x10>MH <Nop>
xmap <Char-0x10>MI <Nop>
xmap <Char-0x10>MJ <Nop>
xmap <Char-0x10>MK <Nop>
xmap <Char-0x10>ML <Nop>
xmap <Char-0x10>MM <Nop>
xmap <Char-0x10>MN <Nop>
xmap <Char-0x10>MO <Nop>
xmap <Char-0x10>MP <Nop>
" }}}

" Symbols [Ctrl + Super]{{{
xmap <Char-0x10>MB <Nop>
xmap <Char-0x10>Mt <Nop>
xmap <Char-0x10>M1 <Nop>
xmap <Char-0x10>MC <Nop>
xmap <Char-0x10>M3 <Nop>
xmap <Char-0x10>M- <Nop>
xmap <Char-0x10>Mz <Nop>
xmap <Char-0x10>MR <Nop>
xmap <Char-0x10>My <Nop>
xmap <Char-0x10>Mv <Nop>
xmap <Char-0x10>Ms <Nop>
xmap <Char-0x10>MD <Nop>
xmap <Char-0x10>M! <Nop>
xmap <Char-0x10>ME <Nop>
xmap <Char-0x10>Mu <Nop>
xmap <Char-0x10>MQ <Nop>
xmap <Char-0x10>MF <Nop>
xmap <Char-0x10>MA <Nop>
xmap <Char-0x10>M0 <Nop>
xmap <Char-0x10>Mw <Nop>
xmap <Char-0x10>Mx <Nop>
xmap <Char-0x10>M^ <Nop>
" }}}

" Function keys [Ctrl + Super]{{{
xmap <Char-0x10>M/ <Nop>
xmap <Char-0x10>M* <Nop>
xmap <Char-0x10>M? <Nop>
xmap <Char-0x10>M& <Nop>
xmap <Char-0x10>M< <Nop>
xmap <Char-0x10>M> <Nop>
xmap <Char-0x10>M( <Nop>
xmap <Char-0x10>M) <Nop>
xmap <Char-0x10>M[ <Nop>
xmap <Char-0x10>M] <Nop>
xmap <Char-0x10>M{ <Nop>
xmap <Char-0x10>M} <Nop>
xmap <Char-0x10>M@ <Nop>
xmap <Char-0x10>M% <Nop>
xmap <Char-0x10>M$ <Nop>
xmap <Char-0x10>M# <Nop>
xmap <Char-0x10>MBA <Nop>
xmap <Char-0x10>MBB <Nop>
xmap <Char-0x10>MBC <Nop>
xmap <Char-0x10>MBD <Nop>
xmap <Char-0x10>MBE <Nop>
xmap <Char-0x10>MBF <Nop>
xmap <Char-0x10>MBG <Nop>
xmap <Char-0x10>MBH <Nop>
xmap <Char-0x10>MBI <Nop>
" }}}

" Modifiers [Ctrl + Super]{{{
xmap <Char-0x10>M: <Nop>
xmap <Char-0x10>M2 <Nop>
xmap <Char-0x10>MBc <Nop>
xmap <Char-0x10>MBb <Nop>
xmap <Char-0x10>MBa <Nop>
xmap <Char-0x10>MBd <Nop>
xmap <Char-0x10>M= <Nop>
xmap <Char-0x10>MBg <Nop>
xmap <Char-0x10>MBf <Nop>
xmap <Char-0x10>MBe <Nop>
xmap <Char-0x10>MBh <Nop>
xmap <Char-0x10>M+ <Nop>
" }}}

" Movement [Ctrl + Super]{{{
xmap <Char-0x10>M6 <Nop>
xmap <Char-0x10>M. <Nop>
xmap <Char-0x10>M5 <Nop>
xmap <Char-0x10>M9 <Nop>
xmap <Char-0x10>M8 <Nop>
xmap <Char-0x10>M4 <Nop>
xmap <Char-0x10>M7 <Nop>
" }}}

" Numpad [Ctrl + Super]{{{
xmap <Char-0x10>MBJ <Nop>
xmap <Char-0x10>MBK <Nop>
xmap <Char-0x10>MBL <Nop>
xmap <Char-0x10>MBM <Nop>
xmap <Char-0x10>MBN <Nop>
xmap <Char-0x10>MBO <Nop>
xmap <Char-0x10>MBP <Nop>
xmap <Char-0x10>MBQ <Nop>
xmap <Char-0x10>MBR <Nop>
xmap <Char-0x10>MBS <Nop>
xmap <Char-0x10>MBX <Nop>
xmap <Char-0x10>MBT <Nop>
xmap <Char-0x10>MBU <Nop>
xmap <Char-0x10>MBY <Nop>
xmap <Char-0x10>MBZ <Nop>
xmap <Char-0x10>MBV <Nop>
xmap <Char-0x10>MBW <Nop>
" }}}
" }}}
" Ctrl + Shift + Super [N]{{{
" Alphanumerics [Ctrl + Shift + Super]{{{
xmap <Char-0x10>NS <Nop>
xmap <Char-0x10>NT <Nop>
xmap <Char-0x10>NU <Nop>
xmap <Char-0x10>NV <Nop>
xmap <Char-0x10>NW <Nop>
xmap <Char-0x10>NX <Nop>
xmap <Char-0x10>NY <Nop>
xmap <Char-0x10>NZ <Nop>
xmap <Char-0x10>Na <Nop>
xmap <Char-0x10>Nb <Nop>
xmap <Char-0x10>Nc <Nop>
xmap <Char-0x10>Nd <Nop>
xmap <Char-0x10>Ne <Nop>
xmap <Char-0x10>Nf <Nop>
xmap <Char-0x10>Ng <Nop>
xmap <Char-0x10>Nh <Nop>
xmap <Char-0x10>Ni <Nop>
xmap <Char-0x10>Nj <Nop>
xmap <Char-0x10>Nk <Nop>
xmap <Char-0x10>Nl <Nop>
xmap <Char-0x10>Nm <Nop>
xmap <Char-0x10>Nn <Nop>
xmap <Char-0x10>No <Nop>
xmap <Char-0x10>Np <Nop>
xmap <Char-0x10>Nq <Nop>
xmap <Char-0x10>Nr <Nop>
xmap <Char-0x10>NG <Nop>
xmap <Char-0x10>NH <Nop>
xmap <Char-0x10>NI <Nop>
xmap <Char-0x10>NJ <Nop>
xmap <Char-0x10>NK <Nop>
xmap <Char-0x10>NL <Nop>
xmap <Char-0x10>NM <Nop>
xmap <Char-0x10>NN <Nop>
xmap <Char-0x10>NO <Nop>
xmap <Char-0x10>NP <Nop>
" }}}

" Symbols [Ctrl + Shift + Super]{{{
xmap <Char-0x10>NB <Nop>
xmap <Char-0x10>Nt <Nop>
xmap <Char-0x10>N1 <Nop>
xmap <Char-0x10>NC <Nop>
xmap <Char-0x10>N3 <Nop>
xmap <Char-0x10>N- <Nop>
xmap <Char-0x10>Nz <Nop>
xmap <Char-0x10>NR <Nop>
xmap <Char-0x10>Ny <Nop>
xmap <Char-0x10>Nv <Nop>
xmap <Char-0x10>Ns <Nop>
xmap <Char-0x10>ND <Nop>
xmap <Char-0x10>N! <Nop>
xmap <Char-0x10>NE <Nop>
xmap <Char-0x10>Nu <Nop>
xmap <Char-0x10>NQ <Nop>
xmap <Char-0x10>NF <Nop>
xmap <Char-0x10>NA <Nop>
xmap <Char-0x10>N0 <Nop>
xmap <Char-0x10>Nw <Nop>
xmap <Char-0x10>Nx <Nop>
xmap <Char-0x10>N^ <Nop>
" }}}

" Function keys [Ctrl + Shift + Super]{{{
xmap <Char-0x10>N/ <Nop>
xmap <Char-0x10>N* <Nop>
xmap <Char-0x10>N? <Nop>
xmap <Char-0x10>N& <Nop>
xmap <Char-0x10>N< <Nop>
xmap <Char-0x10>N> <Nop>
xmap <Char-0x10>N( <Nop>
xmap <Char-0x10>N) <Nop>
xmap <Char-0x10>N[ <Nop>
xmap <Char-0x10>N] <Nop>
xmap <Char-0x10>N{ <Nop>
xmap <Char-0x10>N} <Nop>
xmap <Char-0x10>N@ <Nop>
xmap <Char-0x10>N% <Nop>
xmap <Char-0x10>N$ <Nop>
xmap <Char-0x10>N# <Nop>
xmap <Char-0x10>NBA <Nop>
xmap <Char-0x10>NBB <Nop>
xmap <Char-0x10>NBC <Nop>
xmap <Char-0x10>NBD <Nop>
xmap <Char-0x10>NBE <Nop>
xmap <Char-0x10>NBF <Nop>
xmap <Char-0x10>NBG <Nop>
xmap <Char-0x10>NBH <Nop>
xmap <Char-0x10>NBI <Nop>
" }}}

" Modifiers [Ctrl + Shift + Super]{{{
xmap <Char-0x10>N: <Nop>
xmap <Char-0x10>N2 <Nop>
xmap <Char-0x10>NBc <Nop>
xmap <Char-0x10>NBb <Nop>
xmap <Char-0x10>NBa <Nop>
xmap <Char-0x10>NBd <Nop>
xmap <Char-0x10>N= <Nop>
xmap <Char-0x10>NBg <Nop>
xmap <Char-0x10>NBf <Nop>
xmap <Char-0x10>NBe <Nop>
xmap <Char-0x10>NBh <Nop>
xmap <Char-0x10>N+ <Nop>
" }}}

" Movement [Ctrl + Shift + Super]{{{
xmap <Char-0x10>N6 <Nop>
xmap <Char-0x10>N. <Nop>
xmap <Char-0x10>N5 <Nop>
xmap <Char-0x10>N9 <Nop>
xmap <Char-0x10>N8 <Nop>
xmap <Char-0x10>N4 <Nop>
xmap <Char-0x10>N7 <Nop>
" }}}

" Numpad [Ctrl + Shift + Super]{{{
xmap <Char-0x10>NBJ <Nop>
xmap <Char-0x10>NBK <Nop>
xmap <Char-0x10>NBL <Nop>
xmap <Char-0x10>NBM <Nop>
xmap <Char-0x10>NBN <Nop>
xmap <Char-0x10>NBO <Nop>
xmap <Char-0x10>NBP <Nop>
xmap <Char-0x10>NBQ <Nop>
xmap <Char-0x10>NBR <Nop>
xmap <Char-0x10>NBS <Nop>
xmap <Char-0x10>NBX <Nop>
xmap <Char-0x10>NBT <Nop>
xmap <Char-0x10>NBU <Nop>
xmap <Char-0x10>NBY <Nop>
xmap <Char-0x10>NBZ <Nop>
xmap <Char-0x10>NBV <Nop>
xmap <Char-0x10>NBW <Nop>
" }}}
" }}}
" Alt + control + Super [O]{{{
" Alphanumerics [Alt + Ctrl + Super]{{{
xmap <Char-0x10>OS <Nop>
xmap <Char-0x10>OT <Nop>
xmap <Char-0x10>OU <Nop>
xmap <Char-0x10>OV <Nop>
xmap <Char-0x10>OW <Nop>
xmap <Char-0x10>OX <Nop>
xmap <Char-0x10>OY <Nop>
xmap <Char-0x10>OZ <Nop>
xmap <Char-0x10>Oa <Nop>
xmap <Char-0x10>Ob <Nop>
xmap <Char-0x10>Oc <Nop>
xmap <Char-0x10>Od <Nop>
xmap <Char-0x10>Oe <Nop>
xmap <Char-0x10>Of <Nop>
xmap <Char-0x10>Og <Nop>
xmap <Char-0x10>Oh <Nop>
xmap <Char-0x10>Oi <Nop>
xmap <Char-0x10>Oj <Nop>
xmap <Char-0x10>Ok <Nop>
xmap <Char-0x10>Ol <Nop>
xmap <Char-0x10>Om <Nop>
xmap <Char-0x10>On <Nop>
xmap <Char-0x10>Oo <Nop>
xmap <Char-0x10>Op <Nop>
xmap <Char-0x10>Oq <Nop>
xmap <Char-0x10>Or <Nop>
xmap <Char-0x10>OG <Nop>
xmap <Char-0x10>OH <Nop>
xmap <Char-0x10>OI <Nop>
xmap <Char-0x10>OJ <Nop>
xmap <Char-0x10>OK <Nop>
xmap <Char-0x10>OL <Nop>
xmap <Char-0x10>OM <Nop>
xmap <Char-0x10>ON <Nop>
xmap <Char-0x10>OO <Nop>
xmap <Char-0x10>OP <Nop>
" }}}

" Symbols [Alt + Ctrl + Super]{{{
xmap <Char-0x10>OB <Nop>
xmap <Char-0x10>Ot <Nop>
xmap <Char-0x10>O1 <Nop>
xmap <Char-0x10>OC <Nop>
xmap <Char-0x10>O3 <Nop>
xmap <Char-0x10>O- <Nop>
xmap <Char-0x10>Oz <Nop>
xmap <Char-0x10>OR <Nop>
xmap <Char-0x10>Oy <Nop>
xmap <Char-0x10>Ov <Nop>
xmap <Char-0x10>Os <Nop>
xmap <Char-0x10>OD <Nop>
xmap <Char-0x10>O! <Nop>
xmap <Char-0x10>OE <Nop>
xmap <Char-0x10>Ou <Nop>
xmap <Char-0x10>OQ <Nop>
xmap <Char-0x10>OF <Nop>
xmap <Char-0x10>OA <Nop>
xmap <Char-0x10>O0 <Nop>
xmap <Char-0x10>Ow <Nop>
xmap <Char-0x10>Ox <Nop>
xmap <Char-0x10>O^ <Nop>
" }}}

" Function keys [Alt + Ctrl + Super]{{{
xmap <Char-0x10>O/ <Nop>
xmap <Char-0x10>O* <Nop>
xmap <Char-0x10>O? <Nop>
xmap <Char-0x10>O& <Nop>
xmap <Char-0x10>O< <Nop>
xmap <Char-0x10>O> <Nop>
xmap <Char-0x10>O( <Nop>
xmap <Char-0x10>O) <Nop>
xmap <Char-0x10>O[ <Nop>
xmap <Char-0x10>O] <Nop>
xmap <Char-0x10>O{ <Nop>
xmap <Char-0x10>O} <Nop>
xmap <Char-0x10>O@ <Nop>
xmap <Char-0x10>O% <Nop>
xmap <Char-0x10>O$ <Nop>
xmap <Char-0x10>O# <Nop>
xmap <Char-0x10>OBA <Nop>
xmap <Char-0x10>OBB <Nop>
xmap <Char-0x10>OBC <Nop>
xmap <Char-0x10>OBD <Nop>
xmap <Char-0x10>OBE <Nop>
xmap <Char-0x10>OBF <Nop>
xmap <Char-0x10>OBG <Nop>
xmap <Char-0x10>OBH <Nop>
xmap <Char-0x10>OBI <Nop>
" }}}

" Modifiers [Alt + Ctrl + Super]{{{
xmap <Char-0x10>O: <Nop>
xmap <Char-0x10>O2 <Nop>
xmap <Char-0x10>OBc <Nop>
xmap <Char-0x10>OBb <Nop>
xmap <Char-0x10>OBa <Nop>
xmap <Char-0x10>OBd <Nop>
xmap <Char-0x10>O= <Nop>
xmap <Char-0x10>OBg <Nop>
xmap <Char-0x10>OBf <Nop>
xmap <Char-0x10>OBe <Nop>
xmap <Char-0x10>OBh <Nop>
xmap <Char-0x10>O+ <Nop>
" }}}

" Movement [Alt + Ctrl + Super]{{{
xmap <Char-0x10>O6 <Nop>
xmap <Char-0x10>O. <Nop>
xmap <Char-0x10>O5 <Nop>
xmap <Char-0x10>O9 <Nop>
xmap <Char-0x10>O8 <Nop>
xmap <Char-0x10>O4 <Nop>
xmap <Char-0x10>O7 <Nop>
" }}}

" Numpad [Alt + Ctrl + Super]{{{
xmap <Char-0x10>OBJ <Nop>
xmap <Char-0x10>OBK <Nop>
xmap <Char-0x10>OBL <Nop>
xmap <Char-0x10>OBM <Nop>
xmap <Char-0x10>OBN <Nop>
xmap <Char-0x10>OBO <Nop>
xmap <Char-0x10>OBP <Nop>
xmap <Char-0x10>OBQ <Nop>
xmap <Char-0x10>OBR <Nop>
xmap <Char-0x10>OBS <Nop>
xmap <Char-0x10>OBX <Nop>
xmap <Char-0x10>OBT <Nop>
xmap <Char-0x10>OBU <Nop>
xmap <Char-0x10>OBY <Nop>
xmap <Char-0x10>OBZ <Nop>
xmap <Char-0x10>OBV <Nop>
xmap <Char-0x10>OBW <Nop>
" }}}
" }}}
" Alt + control + Shift + Super [P]{{{
" Alphanumerics [Alt + Ctrl + Shift + Super]{{{
xmap <Char-0x10>PS <Nop>
xmap <Char-0x10>PT <Nop>
xmap <Char-0x10>PU <Nop>
xmap <Char-0x10>PV <Nop>
xmap <Char-0x10>PW <Nop>
xmap <Char-0x10>PX <Nop>
xmap <Char-0x10>PY <Nop>
xmap <Char-0x10>PZ <Nop>
xmap <Char-0x10>Pa <Nop>
xmap <Char-0x10>Pb <Nop>
xmap <Char-0x10>Pc <Nop>
xmap <Char-0x10>Pd <Nop>
xmap <Char-0x10>Pe <Nop>
xmap <Char-0x10>Pf <Nop>
xmap <Char-0x10>Pg <Nop>
xmap <Char-0x10>Ph <Nop>
xmap <Char-0x10>Pi <Nop>
xmap <Char-0x10>Pj <Nop>
xmap <Char-0x10>Pk <Nop>
xmap <Char-0x10>Pl <Nop>
xmap <Char-0x10>Pm <Nop>
xmap <Char-0x10>Pn <Nop>
xmap <Char-0x10>Po <Nop>
xmap <Char-0x10>Pp <Nop>
xmap <Char-0x10>Pq <Nop>
xmap <Char-0x10>Pr <Nop>
xmap <Char-0x10>PG <Nop>
xmap <Char-0x10>PH <Nop>
xmap <Char-0x10>PI <Nop>
xmap <Char-0x10>PJ <Nop>
xmap <Char-0x10>PK <Nop>
xmap <Char-0x10>PL <Nop>
xmap <Char-0x10>PM <Nop>
xmap <Char-0x10>PN <Nop>
xmap <Char-0x10>PO <Nop>
xmap <Char-0x10>PP <Nop>
" }}}

" Symbols [Alt + Ctrl + Shift + Super]{{{
xmap <Char-0x10>PB <Nop>
xmap <Char-0x10>Pt <Nop>
xmap <Char-0x10>P1 <Nop>
xmap <Char-0x10>PC <Nop>
xmap <Char-0x10>P3 <Nop>
xmap <Char-0x10>P- <Nop>
xmap <Char-0x10>Pz <Nop>
xmap <Char-0x10>PR <Nop>
xmap <Char-0x10>Py <Nop>
xmap <Char-0x10>Pv <Nop>
xmap <Char-0x10>Ps <Nop>
xmap <Char-0x10>PD <Nop>
xmap <Char-0x10>P! <Nop>
xmap <Char-0x10>PE <Nop>
xmap <Char-0x10>Pu <Nop>
xmap <Char-0x10>PQ <Nop>
xmap <Char-0x10>PF <Nop>
xmap <Char-0x10>PA <Nop>
xmap <Char-0x10>P0 <Nop>
xmap <Char-0x10>Pw <Nop>
xmap <Char-0x10>Px <Nop>
xmap <Char-0x10>P^ <Nop>
" }}}

" Function keys [Alt + Ctrl + Shift + Super]{{{
xmap <Char-0x10>p/ <Nop>
xmap <Char-0x10>p* <Nop>
xmap <Char-0x10>p? <Nop>
xmap <Char-0x10>p& <Nop>
xmap <Char-0x10>p< <Nop>
xmap <Char-0x10>p> <Nop>
xmap <Char-0x10>p( <Nop>
xmap <Char-0x10>p) <Nop>
xmap <Char-0x10>p[ <Nop>
xmap <Char-0x10>p] <Nop>
xmap <Char-0x10>p{ <Nop>
xmap <Char-0x10>p} <Nop>
xmap <Char-0x10>p@ <Nop>
xmap <Char-0x10>p% <Nop>
xmap <Char-0x10>p$ <Nop>
xmap <Char-0x10>p# <Nop>
xmap <Char-0x10>pba <Nop>
xmap <Char-0x10>pbb <Nop>
xmap <Char-0x10>pbc <Nop>
xmap <Char-0x10>pbd <Nop>
xmap <Char-0x10>pbe <Nop>
xmap <Char-0x10>pbf <Nop>
xmap <Char-0x10>pbg <Nop>
xmap <Char-0x10>pbh <Nop>
xmap <Char-0x10>pbi <Nop>
" }}}

" Modifiers [Alt + Ctrl + Shift + Super]{{{
xmap <Char-0x10>P: <Nop>
xmap <Char-0x10>P2 <Nop>
xmap <Char-0x10>PBc <Nop>
xmap <Char-0x10>PBb <Nop>
xmap <Char-0x10>PBa <Nop>
xmap <Char-0x10>PBd <Nop>
xmap <Char-0x10>P= <Nop>
xmap <Char-0x10>PBg <Nop>
xmap <Char-0x10>PBf <Nop>
xmap <Char-0x10>PBe <Nop>
xmap <Char-0x10>PBh <Nop>
xmap <Char-0x10>P+ <Nop>
" }}}

" Movement [Alt + Ctrl + Shift + Super]{{{
xmap <Char-0x10>P6 <Nop>
xmap <Char-0x10>P. <Nop>
xmap <Char-0x10>P5 <Nop>
xmap <Char-0x10>P9 <Nop>
xmap <Char-0x10>P8 <Nop>
xmap <Char-0x10>P4 <Nop>
xmap <Char-0x10>P7 <Nop>
" }}}

" Numpad [Alt + Ctrl + Shift +  Super]{{{
xmap <Char-0x10>PBJ <Nop>
xmap <Char-0x10>PBK <Nop>
xmap <Char-0x10>PBL <Nop>
xmap <Char-0x10>PBM <Nop>
xmap <Char-0x10>PBN <Nop>
xmap <Char-0x10>PBO <Nop>
xmap <Char-0x10>PBP <Nop>
xmap <Char-0x10>PBQ <Nop>
xmap <Char-0x10>PBR <Nop>
xmap <Char-0x10>PBS <Nop>
xmap <Char-0x10>PBX <Nop>
xmap <Char-0x10>PBT <Nop>
xmap <Char-0x10>PBU <Nop>
xmap <Char-0x10>PBY <Nop>
xmap <Char-0x10>PBZ <Nop>
xmap <Char-0x10>PBV <Nop>
xmap <Char-0x10>PBW <Nop>
" }}}
" }}}
" }}}

" Select {{{
" Shift - Special keys [B] {{{
smap <Char-0x10>Bz <Nop>
smap <Char-0x10>B1 <Nop>
smap <Char-0x10>By <Nop>
" }}}
" Ctrl - Special keys [E] {{{
smap <Char-0x10>Ez <Nop>
smap <Char-0x10>E1 <Nop>
smap <Char-0x10>Ey <Nop>
smap <Char-0x10>E0 <Nop>
" }}}
" Ctrl + Shift [F]{{{
" Alphanumerics [Ctrl + Shift]{{{
smap <Char-0x10>FS <Nop>
smap <Char-0x10>FT <Nop>
smap <Char-0x10>FU <Nop>
smap <Char-0x10>FV <Nop>
smap <Char-0x10>FW <Nop>
smap <Char-0x10>FX <Nop>
smap <Char-0x10>FY <Nop>
smap <Char-0x10>FZ <Nop>
smap <Char-0x10>Fa <Nop>
smap <Char-0x10>Fb <Nop>
smap <Char-0x10>Fc <Nop>
smap <Char-0x10>Fd <Nop>
smap <Char-0x10>Fe <Nop>
smap <Char-0x10>Ff <Nop>
smap <Char-0x10>Fg <Nop>
smap <Char-0x10>Fh <Nop>
smap <Char-0x10>Fi <Nop>
smap <Char-0x10>Fj <Nop>
smap <Char-0x10>Fk <Nop>
smap <Char-0x10>Fl <Nop>
smap <Char-0x10>Fm <Nop>
smap <Char-0x10>Fn <Nop>
smap <Char-0x10>Fo <Nop>
smap <Char-0x10>Fp <Nop>
smap <Char-0x10>Fq <Nop>
smap <Char-0x10>Fr <Nop>
smap <Char-0x10>FG <Nop>
smap <Char-0x10>FH <Nop>
smap <Char-0x10>FI <Nop>
smap <Char-0x10>FJ <Nop>
smap <Char-0x10>FK <Nop>
smap <Char-0x10>FL <Nop>
smap <Char-0x10>FM <Nop>
smap <Char-0x10>FN <Nop>
smap <Char-0x10>FO <Nop>
smap <Char-0x10>FP <Nop>
" }}}

" Symbols [Ctrl + Shift]{{{
smap <Char-0x10>FB <Nop>
smap <Char-0x10>Ft <Nop>
smap <Char-0x10>F1 <Nop>
smap <Char-0x10>FC <Nop>
smap <Char-0x10>F3 <Nop>
smap <Char-0x10>F- <Nop>
smap <Char-0x10>Fz <Nop>
smap <Char-0x10>FR <Nop>
smap <Char-0x10>Fy <Nop>
smap <Char-0x10>Fv <Nop>
smap <Char-0x10>Fs <Nop>
smap <Char-0x10>FD <Nop>
smap <Char-0x10>F! <Nop>
smap <Char-0x10>FE <Nop>
smap <Char-0x10>Fu <Nop>
smap <Char-0x10>FQ <Nop>
smap <Char-0x10>FF <Nop>
smap <Char-0x10>FA <Nop>
smap <Char-0x10>F0 <Nop>
smap <Char-0x10>Fw <Nop>
smap <Char-0x10>Fx <Nop>
smap <Char-0x10>F^ <Nop>
" }}}

" Function keys [Ctrl + Shift]{{{
smap <Char-0x10>F/ <Nop>
smap <Char-0x10>F* <Nop>
smap <Char-0x10>F? <Nop>
smap <Char-0x10>F& <Nop>
smap <Char-0x10>F< <Nop>
smap <Char-0x10>F> <Nop>
smap <Char-0x10>F( <Nop>
smap <Char-0x10>F) <Nop>
smap <Char-0x10>F[ <Nop>
smap <Char-0x10>F] <Nop>
smap <Char-0x10>F{ <Nop>
smap <Char-0x10>F} <Nop>
smap <Char-0x10>F@ <Nop>
smap <Char-0x10>F% <Nop>
smap <Char-0x10>F$ <Nop>
smap <Char-0x10>F# <Nop>
smap <Char-0x10>FBA <Nop>
smap <Char-0x10>FBB <Nop>
smap <Char-0x10>FBC <Nop>
smap <Char-0x10>FBD <Nop>
smap <Char-0x10>FBE <Nop>
smap <Char-0x10>FBF <Nop>
smap <Char-0x10>FBG <Nop>
smap <Char-0x10>FBH <Nop>
smap <Char-0x10>FBI <Nop>
" }}}

" Modifiers / modes etc [Ctrl + Shift]{{{
smap <Char-0x10>F: <Nop>
smap <Char-0x10>F2 <Nop>
smap <Char-0x10>FBc <Nop>
smap <Char-0x10>FBb <Nop>
smap <Char-0x10>FBa <Nop>
smap <Char-0x10>FBd <Nop>
smap <Char-0x10>F= <Nop>
smap <Char-0x10>FBg <Nop>
smap <Char-0x10>FBf <Nop>
smap <Char-0x10>FBe <Nop>
smap <Char-0x10>FBh <Nop>
smap <Char-0x10>F+ <Nop>
" }}}

" Movement [Ctrl + Shift]{{{
smap <Char-0x10>F6 <Nop>
smap <Char-0x10>F. <Nop>
smap <Char-0x10>F5 <Nop>
smap <Char-0x10>F9 <Nop>
smap <Char-0x10>F8 <Nop>
smap <Char-0x10>F4 <Nop>
smap <Char-0x10>F7 <Nop>
" }}}

" Numpad [Ctrl + Shift]{{{
smap <Char-0x10>FBJ <Nop>
smap <Char-0x10>FBK <Nop>
smap <Char-0x10>FBL <Nop>
smap <Char-0x10>FBM <Nop>
smap <Char-0x10>FBN <Nop>
smap <Char-0x10>FBO <Nop>
smap <Char-0x10>FBP <Nop>
smap <Char-0x10>FBQ <Nop>
smap <Char-0x10>FBR <Nop>
smap <Char-0x10>FBS <Nop>
smap <Char-0x10>FBX <Nop>
smap <Char-0x10>FBT <Nop>
smap <Char-0x10>FBU <Nop>
smap <Char-0x10>FBY <Nop>
smap <Char-0x10>FBZ <Nop>
smap <Char-0x10>FBV <Nop>
smap <Char-0x10>FBW <Nop>
" }}}
" }}}
" Alt + Ctrl [G]{{{
" Alphanumerics [Alt + Ctrl]{{{
smap <Char-0x10>GS <Nop>
smap <Char-0x10>GT <Nop>
smap <Char-0x10>GU <Nop>
smap <Char-0x10>GV <Nop>
smap <Char-0x10>GW <Nop>
smap <Char-0x10>GX <Nop>
smap <Char-0x10>GY <Nop>
smap <Char-0x10>GZ <Nop>
smap <Char-0x10>Ga <Nop>
smap <Char-0x10>Gb <Nop>
smap <Char-0x10>Gc <Nop>
smap <Char-0x10>Gd <Nop>
smap <Char-0x10>Ge <Nop>
smap <Char-0x10>Gf <Nop>
smap <Char-0x10>Gg <Nop>
smap <Char-0x10>Gh <Nop>
smap <Char-0x10>Gi <Nop>
smap <Char-0x10>Gj <Nop>
smap <Char-0x10>Gk <Nop>
smap <Char-0x10>Gl <Nop>
smap <Char-0x10>Gm <Nop>
smap <Char-0x10>Gn <Nop>
smap <Char-0x10>Go <Nop>
smap <Char-0x10>Gp <Nop>
smap <Char-0x10>Gq <Nop>
smap <Char-0x10>Gr <Nop>
smap <Char-0x10>GG <Nop>
smap <Char-0x10>GH <Nop>
smap <Char-0x10>GI <Nop>
smap <Char-0x10>GJ <Nop>
smap <Char-0x10>GK <Nop>
smap <Char-0x10>GL <Nop>
smap <Char-0x10>GM <Nop>
smap <Char-0x10>GN <Nop>
smap <Char-0x10>GO <Nop>
smap <Char-0x10>GP <Nop>
" }}}

" Symbols [Alt + Ctrl]{{{
smap <Char-0x10>GB <Nop>
smap <Char-0x10>Gt <Nop>
smap <Char-0x10>G1 <Nop>
smap <Char-0x10>GC <Nop>
smap <Char-0x10>G3 <Nop>
smap <Char-0x10>G- <Nop>
smap <Char-0x10>Gz <Nop>
smap <Char-0x10>GR <Nop>
smap <Char-0x10>Gy <Nop>
smap <Char-0x10>Gv <Nop>
smap <Char-0x10>Gs <Nop>
smap <Char-0x10>GD <Nop>
smap <Char-0x10>G! <Nop>
smap <Char-0x10>GE <Nop>
smap <Char-0x10>Gu <Nop>
smap <Char-0x10>GQ <Nop>
smap <Char-0x10>GF <Nop>
smap <Char-0x10>GA <Nop>
smap <Char-0x10>G0 <Nop>
smap <Char-0x10>Gw <Nop>
smap <Char-0x10>Gx <Nop>
smap <Char-0x10>G^ <Nop>
" }}}

" Function keys [Alt + Ctrl]{{{
smap <Char-0x10>G/ <Nop>
smap <Char-0x10>G* <Nop>
smap <Char-0x10>G? <Nop>
smap <Char-0x10>G& <Nop>
smap <Char-0x10>G< <Nop>
smap <Char-0x10>G> <Nop>
smap <Char-0x10>G( <Nop>
smap <Char-0x10>G) <Nop>
smap <Char-0x10>G[ <Nop>
smap <Char-0x10>G] <Nop>
smap <Char-0x10>G{ <Nop>
smap <Char-0x10>G} <Nop>
smap <Char-0x10>G@ <Nop>
smap <Char-0x10>G% <Nop>
smap <Char-0x10>G$ <Nop>
smap <Char-0x10>G# <Nop>
smap <Char-0x10>GBA <Nop>
smap <Char-0x10>GBB <Nop>
smap <Char-0x10>GBC <Nop>
smap <Char-0x10>GBD <Nop>
smap <Char-0x10>GBE <Nop>
smap <Char-0x10>GBF <Nop>
smap <Char-0x10>GBG <Nop>
smap <Char-0x10>GBH <Nop>
smap <Char-0x10>GBI <Nop>
" }}}

" Modifiers [Alt + Ctrl]{{{
smap <Char-0x10>G: <Nop>
smap <Char-0x10>G2 <Nop>
smap <Char-0x10>GBc <Nop>
smap <Char-0x10>GBb <Nop>
smap <Char-0x10>GBa <Nop>
smap <Char-0x10>GBd <Nop>
smap <Char-0x10>G= <Nop>
smap <Char-0x10>GBg <Nop>
smap <Char-0x10>GBf <Nop>
smap <Char-0x10>GBe <Nop>
smap <Char-0x10>GBh <Nop>
smap <Char-0x10>G+ <Nop>
" }}}

" Movement [Alt + Ctrl]{{{
smap <Char-0x10>G6 <Nop>
smap <Char-0x10>G. <Nop>
smap <Char-0x10>G5 <Nop>
smap <Char-0x10>G9 <Nop>
smap <Char-0x10>G8 <Nop>
smap <Char-0x10>G4 <Nop>
smap <Char-0x10>G7 <Nop>
" }}}

" Numpad [Alt + Ctrl]{{{
smap <Char-0x10>GBJ <Nop>
smap <Char-0x10>GBK <Nop>
smap <Char-0x10>GBL <Nop>
smap <Char-0x10>GBM <Nop>
smap <Char-0x10>GBN <Nop>
smap <Char-0x10>GBO <Nop>
smap <Char-0x10>GBP <Nop>
smap <Char-0x10>GBQ <Nop>
smap <Char-0x10>GBR <Nop>
smap <Char-0x10>GBS <Nop>
smap <Char-0x10>GBX <Nop>
smap <Char-0x10>GBT <Nop>
smap <Char-0x10>GBU <Nop>
smap <Char-0x10>GBY <Nop>
smap <Char-0x10>GBZ <Nop>
smap <Char-0x10>GBV <Nop>
smap <Char-0x10>GBW <Nop>
" }}}
" }}}
" Alt + Ctrl + Shift [H]{{{
" Alphanumerics [Alt + Ctrl + Shift]{{{
smap <Char-0x10>HS <Nop>
smap <Char-0x10>HT <Nop>
smap <Char-0x10>HU <Nop>
smap <Char-0x10>HV <Nop>
smap <Char-0x10>HW <Nop>
smap <Char-0x10>HX <Nop>
smap <Char-0x10>HY <Nop>
smap <Char-0x10>HZ <Nop>
smap <Char-0x10>Ha <Nop>
smap <Char-0x10>Hb <Nop>
smap <Char-0x10>Hc <Nop>
smap <Char-0x10>Hd <Nop>
smap <Char-0x10>He <Nop>
smap <Char-0x10>Hf <Nop>
smap <Char-0x10>Hg <Nop>
smap <Char-0x10>Hh <Nop>
smap <Char-0x10>Hi <Nop>
smap <Char-0x10>Hj <Nop>
smap <Char-0x10>Hk <Nop>
smap <Char-0x10>Hl <Nop>
smap <Char-0x10>Hm <Nop>
smap <Char-0x10>Hn <Nop>
smap <Char-0x10>Ho <Nop>
smap <Char-0x10>Hp <Nop>
smap <Char-0x10>Hq <Nop>
smap <Char-0x10>Hr <Nop>
smap <Char-0x10>HG <Nop>
smap <Char-0x10>HH <Nop>
smap <Char-0x10>HI <Nop>
smap <Char-0x10>HJ <Nop>
smap <Char-0x10>HK <Nop>
smap <Char-0x10>HL <Nop>
smap <Char-0x10>HM <Nop>
smap <Char-0x10>HN <Nop>
smap <Char-0x10>HO <Nop>
smap <Char-0x10>HP <Nop>
" }}}

" Symbols [Alt + Ctrl + Shift]{{{
smap <Char-0x10>HB <Nop>
smap <Char-0x10>Ht <Nop>
smap <Char-0x10>H1 <Nop>
smap <Char-0x10>HC <Nop>
smap <Char-0x10>H3 <Nop>
smap <Char-0x10>H- <Nop>
smap <Char-0x10>Hz <Nop>
smap <Char-0x10>HR <Nop>
smap <Char-0x10>Hy <Nop>
smap <Char-0x10>Hv <Nop>
smap <Char-0x10>Hs <Nop>
smap <Char-0x10>HD <Nop>
smap <Char-0x10>H! <Nop>
smap <Char-0x10>HE <Nop>
smap <Char-0x10>Hu <Nop>
smap <Char-0x10>HQ <Nop>
smap <Char-0x10>HF <Nop>
smap <Char-0x10>HA <Nop>
smap <Char-0x10>H0 <Nop>
smap <Char-0x10>Hw <Nop>
smap <Char-0x10>Hx <Nop>
smap <Char-0x10>H^ <Nop>
" }}}

" Function keys [Alt + Ctrl + Shift]{{{
smap <Char-0x10>H/ <Nop>
smap <Char-0x10>H* <Nop>
smap <Char-0x10>H? <Nop>
smap <Char-0x10>H& <Nop>
smap <Char-0x10>H< <Nop>
smap <Char-0x10>H> <Nop>
smap <Char-0x10>H( <Nop>
smap <Char-0x10>H) <Nop>
smap <Char-0x10>H[ <Nop>
smap <Char-0x10>H] <Nop>
smap <Char-0x10>H{ <Nop>
smap <Char-0x10>H} <Nop>
smap <Char-0x10>H@ <Nop>
smap <Char-0x10>H% <Nop>
smap <Char-0x10>H$ <Nop>
smap <Char-0x10>H# <Nop>
smap <Char-0x10>HBA <Nop>
smap <Char-0x10>HBB <Nop>
smap <Char-0x10>HBC <Nop>
smap <Char-0x10>HBD <Nop>
smap <Char-0x10>HBE <Nop>
smap <Char-0x10>HBF <Nop>
smap <Char-0x10>HBG <Nop>
smap <Char-0x10>HBH <Nop>
smap <Char-0x10>HBI <Nop>
" }}}

" Modifiers [Alt + Ctrl + Shift]{{{
smap <Char-0x10>H: <Nop>
smap <Char-0x10>H2 <Nop>
smap <Char-0x10>HBc <Nop>
smap <Char-0x10>HBb <Nop>
smap <Char-0x10>HBa <Nop>
smap <Char-0x10>HBd <Nop>
smap <Char-0x10>H= <Nop>
smap <Char-0x10>HBg <Nop>
smap <Char-0x10>HBf <Nop>
smap <Char-0x10>HBe <Nop>
smap <Char-0x10>HBh <Nop>
smap <Char-0x10>H+ <Nop>
" }}}

" Movement [Alt + Ctrl + Shift]{{{
smap <Char-0x10>H6 <Nop>
smap <Char-0x10>H. <Nop>
smap <Char-0x10>H5 <Nop>
smap <Char-0x10>H9 <Nop>
smap <Char-0x10>H8 <Nop>
smap <Char-0x10>H4 <Nop>
smap <Char-0x10>H7 <Nop>
" }}}

" Numpad [Alt + Ctrl + Shift]{{{
smap <Char-0x10>HBJ <Nop>
smap <Char-0x10>HBK <Nop>
smap <Char-0x10>HBL <Nop>
smap <Char-0x10>HBM <Nop>
smap <Char-0x10>HBN <Nop>
smap <Char-0x10>HBO <Nop>
smap <Char-0x10>HBP <Nop>
smap <Char-0x10>HBQ <Nop>
smap <Char-0x10>HBR <Nop>
smap <Char-0x10>HBS <Nop>
smap <Char-0x10>HBX <Nop>
smap <Char-0x10>HBT <Nop>
smap <Char-0x10>HBU <Nop>
smap <Char-0x10>HBY <Nop>
smap <Char-0x10>HBZ <Nop>
smap <Char-0x10>HBV <Nop>
smap <Char-0x10>HBW <Nop>
" }}}
" }}}
" Super [I]{{{
" Alphanumerics [Super]{{{
smap <Char-0x10>IS <Nop>
smap <Char-0x10>IT <Nop>
smap <Char-0x10>IU <Nop>
smap <Char-0x10>IV <Nop>
smap <Char-0x10>IW <Nop>
smap <Char-0x10>IX <Nop>
smap <Char-0x10>IY <Nop>
smap <Char-0x10>IZ <Nop>
smap <Char-0x10>Ia <Nop>
smap <Char-0x10>Ib <Nop>
smap <Char-0x10>Ic <Nop>
smap <Char-0x10>Id <Nop>
smap <Char-0x10>Ie <Nop>
smap <Char-0x10>If <Nop>
smap <Char-0x10>Ig <Nop>
smap <Char-0x10>Ih <Nop>
smap <Char-0x10>Ii <Nop>
smap <Char-0x10>Ij <Nop>
smap <Char-0x10>Ik <Nop>
smap <Char-0x10>Il <Nop>
smap <Char-0x10>Im <Nop>
smap <Char-0x10>In <Nop>
smap <Char-0x10>Io <Nop>
smap <Char-0x10>Ip <Nop>
smap <Char-0x10>Iq <Nop>
smap <Char-0x10>Ir <Nop>
smap <Char-0x10>IG <Nop>
smap <Char-0x10>IH <Nop>
smap <Char-0x10>II <Nop>
smap <Char-0x10>IJ <Nop>
smap <Char-0x10>IK <Nop>
smap <Char-0x10>IL <Nop>
smap <Char-0x10>IM <Nop>
smap <Char-0x10>IN <Nop>
smap <Char-0x10>IO <Nop>
smap <Char-0x10>IP <Nop>
" }}}

" Symbols [Super]{{{
smap <Char-0x10>IB <Nop>
smap <Char-0x10>It <Nop>
smap <Char-0x10>I1 <Nop>
smap <Char-0x10>IC <Nop>
smap <Char-0x10>I3 <Nop>
smap <Char-0x10>I- <Nop>
smap <Char-0x10>Iz <Nop>
smap <Char-0x10>IR <Nop>
smap <Char-0x10>Iy <Nop>
smap <Char-0x10>Iv <Nop>
smap <Char-0x10>Is <Nop>
smap <Char-0x10>ID <Nop>
smap <Char-0x10>I! <Nop>
smap <Char-0x10>IE <Nop>
smap <Char-0x10>Iu <Nop>
smap <Char-0x10>IQ <Nop>
smap <Char-0x10>IF <Nop>
smap <Char-0x10>IA <Nop>
smap <Char-0x10>I0 <Nop>
smap <Char-0x10>Iw <Nop>
smap <Char-0x10>Ix <Nop>
smap <Char-0x10>I^ <Nop>
" }}}

" Function keys [Super]{{{
smap <Char-0x10>I/ <Nop>
smap <Char-0x10>I* <Nop>
smap <Char-0x10>I? <Nop>
smap <Char-0x10>I& <Nop>
smap <Char-0x10>I< <Nop>
smap <Char-0x10>I> <Nop>
smap <Char-0x10>I( <Nop>
smap <Char-0x10>I) <Nop>
smap <Char-0x10>I[ <Nop>
smap <Char-0x10>I] <Nop>
smap <Char-0x10>I{ <Nop>
smap <Char-0x10>I} <Nop>
smap <Char-0x10>I@ <Nop>
smap <Char-0x10>I% <Nop>
smap <Char-0x10>I$ <Nop>
smap <Char-0x10>I# <Nop>
smap <Char-0x10>IBA <Nop>
smap <Char-0x10>IBB <Nop>
smap <Char-0x10>IBC <Nop>
smap <Char-0x10>IBD <Nop>
smap <Char-0x10>IBE <Nop>
smap <Char-0x10>IBF <Nop>
smap <Char-0x10>IBG <Nop>
smap <Char-0x10>IBH <Nop>
smap <Char-0x10>IBI <Nop>
" }}}

" Modifiers [Super]{{{
smap <Char-0x10>I: <Nop>
smap <Char-0x10>I2 <Nop>
smap <Char-0x10>IBc <Nop>
smap <Char-0x10>IBb <Nop>
smap <Char-0x10>IBa <Nop>
smap <Char-0x10>IBd <Nop>
smap <Char-0x10>I= <Nop>
smap <Char-0x10>IBg <Nop>
smap <Char-0x10>IBf <Nop>
smap <Char-0x10>IBe <Nop>
smap <Char-0x10>IBh <Nop>
smap <Char-0x10>I+ <Nop>
" }}}

" Movement [Super]{{{
smap <Char-0x10>I6 <Nop>
smap <Char-0x10>I. <Nop>
smap <Char-0x10>I5 <Nop>
smap <Char-0x10>I9 <Nop>
smap <Char-0x10>I8 <Nop>
smap <Char-0x10>I4 <Nop>
smap <Char-0x10>I7 <Nop>
" }}}

" Numpad [Super]{{{
smap <Char-0x10>IBJ <Nop>
smap <Char-0x10>IBK <Nop>
smap <Char-0x10>IBL <Nop>
smap <Char-0x10>IBM <Nop>
smap <Char-0x10>IBN <Nop>
smap <Char-0x10>IBO <Nop>
smap <Char-0x10>IBP <Nop>
smap <Char-0x10>IBQ <Nop>
smap <Char-0x10>IBR <Nop>
smap <Char-0x10>IBS <Nop>
smap <Char-0x10>IBX <Nop>
smap <Char-0x10>IBT <Nop>
smap <Char-0x10>IBU <Nop>
smap <Char-0x10>IBY <Nop>
smap <Char-0x10>IBZ <Nop>
smap <Char-0x10>IBV <Nop>
smap <Char-0x10>IBW <Nop>
" }}}
" }}}
" Shift + Super [J]{{{
" Alphanumerics [Shift + Super]{{{
smap <Char-0x10>JS <Nop>
smap <Char-0x10>JT <Nop>
smap <Char-0x10>JU <Nop>
smap <Char-0x10>JV <Nop>
smap <Char-0x10>JW <Nop>
smap <Char-0x10>JX <Nop>
smap <Char-0x10>JY <Nop>
smap <Char-0x10>JZ <Nop>
smap <Char-0x10>Ja <Nop>
smap <Char-0x10>Jb <Nop>
smap <Char-0x10>Jc <Nop>
smap <Char-0x10>Jd <Nop>
smap <Char-0x10>Je <Nop>
smap <Char-0x10>Jf <Nop>
smap <Char-0x10>Jg <Nop>
smap <Char-0x10>Jh <Nop>
smap <Char-0x10>Ji <Nop>
smap <Char-0x10>Jj <Nop>
smap <Char-0x10>Jk <Nop>
smap <Char-0x10>Jl <Nop>
smap <Char-0x10>Jm <Nop>
smap <Char-0x10>Jn <Nop>
smap <Char-0x10>Jo <Nop>
smap <Char-0x10>Jp <Nop>
smap <Char-0x10>Jq <Nop>
smap <Char-0x10>Jr <Nop>
smap <Char-0x10>JG <Nop>
smap <Char-0x10>JH <Nop>
smap <Char-0x10>JI <Nop>
smap <Char-0x10>JJ <Nop>
smap <Char-0x10>JK <Nop>
smap <Char-0x10>JL <Nop>
smap <Char-0x10>JM <Nop>
smap <Char-0x10>JN <Nop>
smap <Char-0x10>JO <Nop>
smap <Char-0x10>JP <Nop>
" }}}

" Symbols [Shift + Super]{{{
smap <Char-0x10>JB <Nop>
smap <Char-0x10>Jt <Nop>
smap <Char-0x10>J1 <Nop>
smap <Char-0x10>JC <Nop>
smap <Char-0x10>J3 <Nop>
smap <Char-0x10>J- <Nop>
smap <Char-0x10>Jz <Nop>
smap <Char-0x10>JR <Nop>
smap <Char-0x10>Jy <Nop>
smap <Char-0x10>Jv <Nop>
smap <Char-0x10>Js <Nop>
smap <Char-0x10>JD <Nop>
smap <Char-0x10>J! <Nop>
smap <Char-0x10>JE <Nop>
smap <Char-0x10>Ju <Nop>
smap <Char-0x10>JQ <Nop>
smap <Char-0x10>JF <Nop>
smap <Char-0x10>JA <Nop>
smap <Char-0x10>J0 <Nop>
smap <Char-0x10>Jw <Nop>
smap <Char-0x10>Jx <Nop>
smap <Char-0x10>J^ <Nop>
" }}}

" Function keys [Shift + Super]{{{
smap <Char-0x10>J/ <Nop>
smap <Char-0x10>J* <Nop>
smap <Char-0x10>J? <Nop>
smap <Char-0x10>J& <Nop>
smap <Char-0x10>J< <Nop>
smap <Char-0x10>J> <Nop>
smap <Char-0x10>J( <Nop>
smap <Char-0x10>J) <Nop>
smap <Char-0x10>J[ <Nop>
smap <Char-0x10>J] <Nop>
smap <Char-0x10>J{ <Nop>
smap <Char-0x10>J} <Nop>
smap <Char-0x10>J@ <Nop>
smap <Char-0x10>J% <Nop>
smap <Char-0x10>J$ <Nop>
smap <Char-0x10>J# <Nop>
smap <Char-0x10>JBA <Nop>
smap <Char-0x10>JBB <Nop>
smap <Char-0x10>JBC <Nop>
smap <Char-0x10>JBD <Nop>
smap <Char-0x10>JBE <Nop>
smap <Char-0x10>JBF <Nop>
smap <Char-0x10>JBG <Nop>
smap <Char-0x10>JBH <Nop>
smap <Char-0x10>JBI <Nop>
" }}}

" Modifiers [Shift + Super]{{{
smap <Char-0x10>J: <Nop>
smap <Char-0x10>J2 <Nop>
smap <Char-0x10>JBc <Nop>
smap <Char-0x10>JBb <Nop>
smap <Char-0x10>JBa <Nop>
smap <Char-0x10>JBd <Nop>
smap <Char-0x10>J= <Nop>
smap <Char-0x10>JBg <Nop>
smap <Char-0x10>JBf <Nop>
smap <Char-0x10>JBe <Nop>
smap <Char-0x10>JBh <Nop>
smap <Char-0x10>J+ <Nop>
" }}}

" Movement [Shift + Super]{{{
smap <Char-0x10>J6 <Nop>
smap <Char-0x10>J. <Nop>
smap <Char-0x10>J5 <Nop>
smap <Char-0x10>J9 <Nop>
smap <Char-0x10>J8 <Nop>
smap <Char-0x10>J4 <Nop>
smap <Char-0x10>J7 <Nop>
" }}}

" Numpad [Shift + Super]{{{
smap <Char-0x10>JBJ <Nop>
smap <Char-0x10>JBK <Nop>
smap <Char-0x10>JBL <Nop>
smap <Char-0x10>JBM <Nop>
smap <Char-0x10>JBN <Nop>
smap <Char-0x10>JBO <Nop>
smap <Char-0x10>JBP <Nop>
smap <Char-0x10>JBQ <Nop>
smap <Char-0x10>JBR <Nop>
smap <Char-0x10>JBS <Nop>
smap <Char-0x10>JBX <Nop>
smap <Char-0x10>JBT <Nop>
smap <Char-0x10>JBU <Nop>
smap <Char-0x10>JBY <Nop>
smap <Char-0x10>JBZ <Nop>
smap <Char-0x10>JBV <Nop>
smap <Char-0x10>JBW <Nop>
" }}}
" }}}
" Alt + Super [K]{{{
" Alphanumerics [Alt + Super]{{{
smap <Char-0x10>KS <Nop>
smap <Char-0x10>KT <Nop>
smap <Char-0x10>KU <Nop>
smap <Char-0x10>KV <Nop>
smap <Char-0x10>KW <Nop>
smap <Char-0x10>KX <Nop>
smap <Char-0x10>KY <Nop>
smap <Char-0x10>KZ <Nop>
smap <Char-0x10>Ka <Nop>
smap <Char-0x10>Kb <Nop>
smap <Char-0x10>Kc <Nop>
smap <Char-0x10>Kd <Nop>
smap <Char-0x10>Ke <Nop>
smap <Char-0x10>Kf <Nop>
smap <Char-0x10>Kg <Nop>
smap <Char-0x10>Kh <Nop>
smap <Char-0x10>Ki <Nop>
smap <Char-0x10>Kj <Nop>
smap <Char-0x10>Kk <Nop>
smap <Char-0x10>Kl <Nop>
smap <Char-0x10>Km <Nop>
smap <Char-0x10>Kn <Nop>
smap <Char-0x10>Ko <Nop>
smap <Char-0x10>Kp <Nop>
smap <Char-0x10>Kq <Nop>
smap <Char-0x10>Kr <Nop>
smap <Char-0x10>KG <Nop>
smap <Char-0x10>KH <Nop>
smap <Char-0x10>KI <Nop>
smap <Char-0x10>KJ <Nop>
smap <Char-0x10>KK <Nop>
smap <Char-0x10>KL <Nop>
smap <Char-0x10>KM <Nop>
smap <Char-0x10>KN <Nop>
smap <Char-0x10>KO <Nop>
smap <Char-0x10>KP <Nop>
" }}}

" Symbols [Alt + Super]{{{
smap <Char-0x10>KB <Nop>
smap <Char-0x10>Kt <Nop>
smap <Char-0x10>K1 <Nop>
smap <Char-0x10>KC <Nop>
smap <Char-0x10>K3 <Nop>
smap <Char-0x10>K- <Nop>
smap <Char-0x10>Kz <Nop>
smap <Char-0x10>KR <Nop>
smap <Char-0x10>Ky <Nop>
smap <Char-0x10>Kv <Nop>
smap <Char-0x10>Ks <Nop>
smap <Char-0x10>KD <Nop>
smap <Char-0x10>K! <Nop>
smap <Char-0x10>KE <Nop>
smap <Char-0x10>Ku <Nop>
smap <Char-0x10>KQ <Nop>
smap <Char-0x10>KF <Nop>
smap <Char-0x10>KA <Nop>
smap <Char-0x10>K0 <Nop>
smap <Char-0x10>Kw <Nop>
smap <Char-0x10>Kx <Nop>
smap <Char-0x10>K^ <Nop>
" }}}

" Function keys [Alt + Super]{{{
smap <Char-0x10>K/ <Nop>
smap <Char-0x10>K* <Nop>
smap <Char-0x10>K? <Nop>
smap <Char-0x10>K& <Nop>
smap <Char-0x10>K< <Nop>
smap <Char-0x10>K> <Nop>
smap <Char-0x10>K( <Nop>
smap <Char-0x10>K) <Nop>
smap <Char-0x10>K[ <Nop>
smap <Char-0x10>K] <Nop>
smap <Char-0x10>K{ <Nop>
smap <Char-0x10>K} <Nop>
smap <Char-0x10>K@ <Nop>
smap <Char-0x10>K% <Nop>
smap <Char-0x10>K$ <Nop>
smap <Char-0x10>K# <Nop>
smap <Char-0x10>KBA <Nop>
smap <Char-0x10>KBB <Nop>
smap <Char-0x10>KBC <Nop>
smap <Char-0x10>KBD <Nop>
smap <Char-0x10>KBE <Nop>
smap <Char-0x10>KBF <Nop>
smap <Char-0x10>KBG <Nop>
smap <Char-0x10>KBH <Nop>
smap <Char-0x10>KBI <Nop>
" }}}

" Modifiers [Alt + Super]{{{
smap <Char-0x10>K: <Nop>
smap <Char-0x10>K2 <Nop>
smap <Char-0x10>KBc <Nop>
smap <Char-0x10>KBb <Nop>
smap <Char-0x10>KBa <Nop>
smap <Char-0x10>KBd <Nop>
smap <Char-0x10>K= <Nop>
smap <Char-0x10>KBg <Nop>
smap <Char-0x10>KBf <Nop>
smap <Char-0x10>KBe <Nop>
smap <Char-0x10>KBh <Nop>
smap <Char-0x10>K+ <Nop>
" }}}

" Movement [Alt + Super]{{{
smap <Char-0x10>K6 <Nop>
smap <Char-0x10>K. <Nop>
smap <Char-0x10>K5 <Nop>
smap <Char-0x10>K9 <Nop>
smap <Char-0x10>K8 <Nop>
smap <Char-0x10>K4 <Nop>
smap <Char-0x10>K7 <Nop>
" }}}

" Numpad [Alt + Super]{{{
smap <Char-0x10>KBJ <Nop>
smap <Char-0x10>KBK <Nop>
smap <Char-0x10>KBL <Nop>
smap <Char-0x10>KBM <Nop>
smap <Char-0x10>KBN <Nop>
smap <Char-0x10>KBO <Nop>
smap <Char-0x10>KBP <Nop>
smap <Char-0x10>KBQ <Nop>
smap <Char-0x10>KBR <Nop>
smap <Char-0x10>KBS <Nop>
smap <Char-0x10>KBX <Nop>
smap <Char-0x10>KBT <Nop>
smap <Char-0x10>KBU <Nop>
smap <Char-0x10>KBY <Nop>
smap <Char-0x10>KBZ <Nop>
smap <Char-0x10>KBV <Nop>
smap <Char-0x10>KBW <Nop>
" }}}
" }}}
" Alt + Shift + Super [L]{{{
" Alphanumerics [Alt + Shift + Super]{{{
smap <Char-0x10>LS <Nop>
smap <Char-0x10>LT <Nop>
smap <Char-0x10>LU <Nop>
smap <Char-0x10>LV <Nop>
smap <Char-0x10>LW <Nop>
smap <Char-0x10>LX <Nop>
smap <Char-0x10>LY <Nop>
smap <Char-0x10>LZ <Nop>
smap <Char-0x10>La <Nop>
smap <Char-0x10>Lb <Nop>
smap <Char-0x10>Lc <Nop>
smap <Char-0x10>Ld <Nop>
smap <Char-0x10>Le <Nop>
smap <Char-0x10>Lf <Nop>
smap <Char-0x10>Lg <Nop>
smap <Char-0x10>Lh <Nop>
smap <Char-0x10>Li <Nop>
smap <Char-0x10>Lj <Nop>
smap <Char-0x10>Lk <Nop>
smap <Char-0x10>Ll <Nop>
smap <Char-0x10>Lm <Nop>
smap <Char-0x10>Ln <Nop>
smap <Char-0x10>Lo <Nop>
smap <Char-0x10>Lp <Nop>
smap <Char-0x10>Lq <Nop>
smap <Char-0x10>Lr <Nop>
smap <Char-0x10>LG <Nop>
smap <Char-0x10>LH <Nop>
smap <Char-0x10>LI <Nop>
smap <Char-0x10>LJ <Nop>
smap <Char-0x10>LK <Nop>
smap <Char-0x10>LL <Nop>
smap <Char-0x10>LM <Nop>
smap <Char-0x10>LN <Nop>
smap <Char-0x10>LO <Nop>
smap <Char-0x10>LP <Nop>
" }}}

" Symbols [Alt + Shift  + Super]{{{
smap <Char-0x10>LB <Nop>
smap <Char-0x10>Lt <Nop>
smap <Char-0x10>L1 <Nop>
smap <Char-0x10>LC <Nop>
smap <Char-0x10>L3 <Nop>
smap <Char-0x10>L- <Nop>
smap <Char-0x10>Lz <Nop>
smap <Char-0x10>LR <Nop>
smap <Char-0x10>Ly <Nop>
smap <Char-0x10>Lv <Nop>
smap <Char-0x10>Ls <Nop>
smap <Char-0x10>LD <Nop>
smap <Char-0x10>L! <Nop>
smap <Char-0x10>LE <Nop>
smap <Char-0x10>Lu <Nop>
smap <Char-0x10>LQ <Nop>
smap <Char-0x10>LF <Nop>
smap <Char-0x10>LA <Nop>
smap <Char-0x10>L0 <Nop>
smap <Char-0x10>Lw <Nop>
smap <Char-0x10>Lx <Nop>
smap <Char-0x10>L^ <Nop>
" }}}

" Function keys [Alt + Shift + Super]{{{
smap <Char-0x10>L/ <Nop>
smap <Char-0x10>L* <Nop>
smap <Char-0x10>L? <Nop>
smap <Char-0x10>L& <Nop>
smap <Char-0x10>L< <Nop>
smap <Char-0x10>L> <Nop>
smap <Char-0x10>L( <Nop>
smap <Char-0x10>L) <Nop>
smap <Char-0x10>L[ <Nop>
smap <Char-0x10>L] <Nop>
smap <Char-0x10>L{ <Nop>
smap <Char-0x10>L} <Nop>
smap <Char-0x10>L@ <Nop>
smap <Char-0x10>L% <Nop>
smap <Char-0x10>L$ <Nop>
smap <Char-0x10>L# <Nop>
smap <Char-0x10>LBA <Nop>
smap <Char-0x10>LBB <Nop>
smap <Char-0x10>LBC <Nop>
smap <Char-0x10>LBD <Nop>
smap <Char-0x10>LBE <Nop>
smap <Char-0x10>LBF <Nop>
smap <Char-0x10>LBG <Nop>
smap <Char-0x10>LBH <Nop>
smap <Char-0x10>LBI <Nop>
" }}}

" Modifiers [Alt + Shift + Super]{{{
smap <Char-0x10>L: <Nop>
smap <Char-0x10>L2 <Nop>
smap <Char-0x10>LBc <Nop>
smap <Char-0x10>LBb <Nop>
smap <Char-0x10>LBa <Nop>
smap <Char-0x10>LBd <Nop>
smap <Char-0x10>L= <Nop>
smap <Char-0x10>LBg <Nop>
smap <Char-0x10>LBf <Nop>
smap <Char-0x10>LBe <Nop>
smap <Char-0x10>LBh <Nop>
smap <Char-0x10>L+ <Nop>
" }}}

" Movement [Alt + Shift + Super]{{{
smap <Char-0x10>L6 <Nop>
smap <Char-0x10>L. <Nop>
smap <Char-0x10>L5 <Nop>
smap <Char-0x10>L9 <Nop>
smap <Char-0x10>L8 <Nop>
smap <Char-0x10>L4 <Nop>
smap <Char-0x10>L7 <Nop>
" }}}

" Numpad [Alt + Shift + Super]{{{
smap <Char-0x10>LBJ <Nop>
smap <Char-0x10>LBK <Nop>
smap <Char-0x10>LBL <Nop>
smap <Char-0x10>LBM <Nop>
smap <Char-0x10>LBN <Nop>
smap <Char-0x10>LBO <Nop>
smap <Char-0x10>LBP <Nop>
smap <Char-0x10>LBQ <Nop>
smap <Char-0x10>LBR <Nop>
smap <Char-0x10>LBS <Nop>
smap <Char-0x10>LBX <Nop>
smap <Char-0x10>LBT <Nop>
smap <Char-0x10>LBU <Nop>
smap <Char-0x10>LBY <Nop>
smap <Char-0x10>LBZ <Nop>
smap <Char-0x10>LBV <Nop>
smap <Char-0x10>LBW <Nop>
" }}}
" }}}
" Alt + Ctrl + Shift + Super [L]{{{
" Alphanumerics [Ctrl + Super]{{{
smap <Char-0x10>MS <Nop>
smap <Char-0x10>MT <Nop>
smap <Char-0x10>MU <Nop>
smap <Char-0x10>MV <Nop>
smap <Char-0x10>MW <Nop>
smap <Char-0x10>MX <Nop>
smap <Char-0x10>MY <Nop>
smap <Char-0x10>MZ <Nop>
smap <Char-0x10>Ma <Nop>
smap <Char-0x10>Mb <Nop>
smap <Char-0x10>Mc <Nop>
smap <Char-0x10>Md <Nop>
smap <Char-0x10>Me <Nop>
smap <Char-0x10>Mf <Nop>
smap <Char-0x10>Mg <Nop>
smap <Char-0x10>Mh <Nop>
smap <Char-0x10>Mi <Nop>
smap <Char-0x10>Mj <Nop>
smap <Char-0x10>Mk <Nop>
smap <Char-0x10>Ml <Nop>
smap <Char-0x10>Mm <Nop>
smap <Char-0x10>Mn <Nop>
smap <Char-0x10>Mo <Nop>
smap <Char-0x10>Mp <Nop>
smap <Char-0x10>Mq <Nop>
smap <Char-0x10>Mr <Nop>
smap <Char-0x10>MG <Nop>
smap <Char-0x10>MH <Nop>
smap <Char-0x10>MI <Nop>
smap <Char-0x10>MJ <Nop>
smap <Char-0x10>MK <Nop>
smap <Char-0x10>ML <Nop>
smap <Char-0x10>MM <Nop>
smap <Char-0x10>MN <Nop>
smap <Char-0x10>MO <Nop>
smap <Char-0x10>MP <Nop>
" }}}

" Symbols [Ctrl + Super]{{{
smap <Char-0x10>MB <Nop>
smap <Char-0x10>Mt <Nop>
smap <Char-0x10>M1 <Nop>
smap <Char-0x10>MC <Nop>
smap <Char-0x10>M3 <Nop>
smap <Char-0x10>M- <Nop>
smap <Char-0x10>Mz <Nop>
smap <Char-0x10>MR <Nop>
smap <Char-0x10>My <Nop>
smap <Char-0x10>Mv <Nop>
smap <Char-0x10>Ms <Nop>
smap <Char-0x10>MD <Nop>
smap <Char-0x10>M! <Nop>
smap <Char-0x10>ME <Nop>
smap <Char-0x10>Mu <Nop>
smap <Char-0x10>MQ <Nop>
smap <Char-0x10>MF <Nop>
smap <Char-0x10>MA <Nop>
smap <Char-0x10>M0 <Nop>
smap <Char-0x10>Mw <Nop>
smap <Char-0x10>Mx <Nop>
smap <Char-0x10>M^ <Nop>
" }}}

" Function keys [Ctrl + Super]{{{
smap <Char-0x10>M/ <Nop>
smap <Char-0x10>M* <Nop>
smap <Char-0x10>M? <Nop>
smap <Char-0x10>M& <Nop>
smap <Char-0x10>M< <Nop>
smap <Char-0x10>M> <Nop>
smap <Char-0x10>M( <Nop>
smap <Char-0x10>M) <Nop>
smap <Char-0x10>M[ <Nop>
smap <Char-0x10>M] <Nop>
smap <Char-0x10>M{ <Nop>
smap <Char-0x10>M} <Nop>
smap <Char-0x10>M@ <Nop>
smap <Char-0x10>M% <Nop>
smap <Char-0x10>M$ <Nop>
smap <Char-0x10>M# <Nop>
smap <Char-0x10>MBA <Nop>
smap <Char-0x10>MBB <Nop>
smap <Char-0x10>MBC <Nop>
smap <Char-0x10>MBD <Nop>
smap <Char-0x10>MBE <Nop>
smap <Char-0x10>MBF <Nop>
smap <Char-0x10>MBG <Nop>
smap <Char-0x10>MBH <Nop>
smap <Char-0x10>MBI <Nop>
" }}}

" Modifiers [Ctrl + Super]{{{
smap <Char-0x10>M: <Nop>
smap <Char-0x10>M2 <Nop>
smap <Char-0x10>MBc <Nop>
smap <Char-0x10>MBb <Nop>
smap <Char-0x10>MBa <Nop>
smap <Char-0x10>MBd <Nop>
smap <Char-0x10>M= <Nop>
smap <Char-0x10>MBg <Nop>
smap <Char-0x10>MBf <Nop>
smap <Char-0x10>MBe <Nop>
smap <Char-0x10>MBh <Nop>
smap <Char-0x10>M+ <Nop>
" }}}

" Movement [Ctrl + Super]{{{
smap <Char-0x10>M6 <Nop>
smap <Char-0x10>M. <Nop>
smap <Char-0x10>M5 <Nop>
smap <Char-0x10>M9 <Nop>
smap <Char-0x10>M8 <Nop>
smap <Char-0x10>M4 <Nop>
smap <Char-0x10>M7 <Nop>
" }}}

" Numpad [Ctrl + Super]{{{
smap <Char-0x10>MBJ <Nop>
smap <Char-0x10>MBK <Nop>
smap <Char-0x10>MBL <Nop>
smap <Char-0x10>MBM <Nop>
smap <Char-0x10>MBN <Nop>
smap <Char-0x10>MBO <Nop>
smap <Char-0x10>MBP <Nop>
smap <Char-0x10>MBQ <Nop>
smap <Char-0x10>MBR <Nop>
smap <Char-0x10>MBS <Nop>
smap <Char-0x10>MBX <Nop>
smap <Char-0x10>MBT <Nop>
smap <Char-0x10>MBU <Nop>
smap <Char-0x10>MBY <Nop>
smap <Char-0x10>MBZ <Nop>
smap <Char-0x10>MBV <Nop>
smap <Char-0x10>MBW <Nop>
" }}}
" }}}
" Ctrl + Shift + Super [N]{{{
" Alphanumerics [Ctrl + Shift + Super]{{{
smap <Char-0x10>NS <Nop>
smap <Char-0x10>NT <Nop>
smap <Char-0x10>NU <Nop>
smap <Char-0x10>NV <Nop>
smap <Char-0x10>NW <Nop>
smap <Char-0x10>NX <Nop>
smap <Char-0x10>NY <Nop>
smap <Char-0x10>NZ <Nop>
smap <Char-0x10>Na <Nop>
smap <Char-0x10>Nb <Nop>
smap <Char-0x10>Nc <Nop>
smap <Char-0x10>Nd <Nop>
smap <Char-0x10>Ne <Nop>
smap <Char-0x10>Nf <Nop>
smap <Char-0x10>Ng <Nop>
smap <Char-0x10>Nh <Nop>
smap <Char-0x10>Ni <Nop>
smap <Char-0x10>Nj <Nop>
smap <Char-0x10>Nk <Nop>
smap <Char-0x10>Nl <Nop>
smap <Char-0x10>Nm <Nop>
smap <Char-0x10>Nn <Nop>
smap <Char-0x10>No <Nop>
smap <Char-0x10>Np <Nop>
smap <Char-0x10>Nq <Nop>
smap <Char-0x10>Nr <Nop>
smap <Char-0x10>NG <Nop>
smap <Char-0x10>NH <Nop>
smap <Char-0x10>NI <Nop>
smap <Char-0x10>NJ <Nop>
smap <Char-0x10>NK <Nop>
smap <Char-0x10>NL <Nop>
smap <Char-0x10>NM <Nop>
smap <Char-0x10>NN <Nop>
smap <Char-0x10>NO <Nop>
smap <Char-0x10>NP <Nop>
" }}}

" Symbols [Ctrl + Shift + Super]{{{
smap <Char-0x10>NB <Nop>
smap <Char-0x10>Nt <Nop>
smap <Char-0x10>N1 <Nop>
smap <Char-0x10>NC <Nop>
smap <Char-0x10>N3 <Nop>
smap <Char-0x10>N- <Nop>
smap <Char-0x10>Nz <Nop>
smap <Char-0x10>NR <Nop>
smap <Char-0x10>Ny <Nop>
smap <Char-0x10>Nv <Nop>
smap <Char-0x10>Ns <Nop>
smap <Char-0x10>ND <Nop>
smap <Char-0x10>N! <Nop>
smap <Char-0x10>NE <Nop>
smap <Char-0x10>Nu <Nop>
smap <Char-0x10>NQ <Nop>
smap <Char-0x10>NF <Nop>
smap <Char-0x10>NA <Nop>
smap <Char-0x10>N0 <Nop>
smap <Char-0x10>Nw <Nop>
smap <Char-0x10>Nx <Nop>
smap <Char-0x10>N^ <Nop>
" }}}

" Function keys [Ctrl + Shift + Super]{{{
smap <Char-0x10>N/ <Nop>
smap <Char-0x10>N* <Nop>
smap <Char-0x10>N? <Nop>
smap <Char-0x10>N& <Nop>
smap <Char-0x10>N< <Nop>
smap <Char-0x10>N> <Nop>
smap <Char-0x10>N( <Nop>
smap <Char-0x10>N) <Nop>
smap <Char-0x10>N[ <Nop>
smap <Char-0x10>N] <Nop>
smap <Char-0x10>N{ <Nop>
smap <Char-0x10>N} <Nop>
smap <Char-0x10>N@ <Nop>
smap <Char-0x10>N% <Nop>
smap <Char-0x10>N$ <Nop>
smap <Char-0x10>N# <Nop>
smap <Char-0x10>NBA <Nop>
smap <Char-0x10>NBB <Nop>
smap <Char-0x10>NBC <Nop>
smap <Char-0x10>NBD <Nop>
smap <Char-0x10>NBE <Nop>
smap <Char-0x10>NBF <Nop>
smap <Char-0x10>NBG <Nop>
smap <Char-0x10>NBH <Nop>
smap <Char-0x10>NBI <Nop>
" }}}

" Modifiers [Ctrl + Shift + Super]{{{
smap <Char-0x10>N: <Nop>
smap <Char-0x10>N2 <Nop>
smap <Char-0x10>NBc <Nop>
smap <Char-0x10>NBb <Nop>
smap <Char-0x10>NBa <Nop>
smap <Char-0x10>NBd <Nop>
smap <Char-0x10>N= <Nop>
smap <Char-0x10>NBg <Nop>
smap <Char-0x10>NBf <Nop>
smap <Char-0x10>NBe <Nop>
smap <Char-0x10>NBh <Nop>
smap <Char-0x10>N+ <Nop>
" }}}

" Movement [Ctrl + Shift + Super]{{{
smap <Char-0x10>N6 <Nop>
smap <Char-0x10>N. <Nop>
smap <Char-0x10>N5 <Nop>
smap <Char-0x10>N9 <Nop>
smap <Char-0x10>N8 <Nop>
smap <Char-0x10>N4 <Nop>
smap <Char-0x10>N7 <Nop>
" }}}

" Numpad [Ctrl + Shift + Super]{{{
smap <Char-0x10>NBJ <Nop>
smap <Char-0x10>NBK <Nop>
smap <Char-0x10>NBL <Nop>
smap <Char-0x10>NBM <Nop>
smap <Char-0x10>NBN <Nop>
smap <Char-0x10>NBO <Nop>
smap <Char-0x10>NBP <Nop>
smap <Char-0x10>NBQ <Nop>
smap <Char-0x10>NBR <Nop>
smap <Char-0x10>NBS <Nop>
smap <Char-0x10>NBX <Nop>
smap <Char-0x10>NBT <Nop>
smap <Char-0x10>NBU <Nop>
smap <Char-0x10>NBY <Nop>
smap <Char-0x10>NBZ <Nop>
smap <Char-0x10>NBV <Nop>
smap <Char-0x10>NBW <Nop>
" }}}
" }}}
" Alt + control + Super [O]{{{
" Alphanumerics [Alt + Ctrl + Super]{{{
smap <Char-0x10>OS <Nop>
smap <Char-0x10>OT <Nop>
smap <Char-0x10>OU <Nop>
smap <Char-0x10>OV <Nop>
smap <Char-0x10>OW <Nop>
smap <Char-0x10>OX <Nop>
smap <Char-0x10>OY <Nop>
smap <Char-0x10>OZ <Nop>
smap <Char-0x10>Oa <Nop>
smap <Char-0x10>Ob <Nop>
smap <Char-0x10>Oc <Nop>
smap <Char-0x10>Od <Nop>
smap <Char-0x10>Oe <Nop>
smap <Char-0x10>Of <Nop>
smap <Char-0x10>Og <Nop>
smap <Char-0x10>Oh <Nop>
smap <Char-0x10>Oi <Nop>
smap <Char-0x10>Oj <Nop>
smap <Char-0x10>Ok <Nop>
smap <Char-0x10>Ol <Nop>
smap <Char-0x10>Om <Nop>
smap <Char-0x10>On <Nop>
smap <Char-0x10>Oo <Nop>
smap <Char-0x10>Op <Nop>
smap <Char-0x10>Oq <Nop>
smap <Char-0x10>Or <Nop>
smap <Char-0x10>OG <Nop>
smap <Char-0x10>OH <Nop>
smap <Char-0x10>OI <Nop>
smap <Char-0x10>OJ <Nop>
smap <Char-0x10>OK <Nop>
smap <Char-0x10>OL <Nop>
smap <Char-0x10>OM <Nop>
smap <Char-0x10>ON <Nop>
smap <Char-0x10>OO <Nop>
smap <Char-0x10>OP <Nop>
" }}}

" Symbols [Alt + Ctrl + Super]{{{
smap <Char-0x10>OB <Nop>
smap <Char-0x10>Ot <Nop>
smap <Char-0x10>O1 <Nop>
smap <Char-0x10>OC <Nop>
smap <Char-0x10>O3 <Nop>
smap <Char-0x10>O- <Nop>
smap <Char-0x10>Oz <Nop>
smap <Char-0x10>OR <Nop>
smap <Char-0x10>Oy <Nop>
smap <Char-0x10>Ov <Nop>
smap <Char-0x10>Os <Nop>
smap <Char-0x10>OD <Nop>
smap <Char-0x10>O! <Nop>
smap <Char-0x10>OE <Nop>
smap <Char-0x10>Ou <Nop>
smap <Char-0x10>OQ <Nop>
smap <Char-0x10>OF <Nop>
smap <Char-0x10>OA <Nop>
smap <Char-0x10>O0 <Nop>
smap <Char-0x10>Ow <Nop>
smap <Char-0x10>Ox <Nop>
smap <Char-0x10>O^ <Nop>
" }}}

" Function keys [Alt + Ctrl + Super]{{{
smap <Char-0x10>O/ <Nop>
smap <Char-0x10>O* <Nop>
smap <Char-0x10>O? <Nop>
smap <Char-0x10>O& <Nop>
smap <Char-0x10>O< <Nop>
smap <Char-0x10>O> <Nop>
smap <Char-0x10>O( <Nop>
smap <Char-0x10>O) <Nop>
smap <Char-0x10>O[ <Nop>
smap <Char-0x10>O] <Nop>
smap <Char-0x10>O{ <Nop>
smap <Char-0x10>O} <Nop>
smap <Char-0x10>O@ <Nop>
smap <Char-0x10>O% <Nop>
smap <Char-0x10>O$ <Nop>
smap <Char-0x10>O# <Nop>
smap <Char-0x10>OBA <Nop>
smap <Char-0x10>OBB <Nop>
smap <Char-0x10>OBC <Nop>
smap <Char-0x10>OBD <Nop>
smap <Char-0x10>OBE <Nop>
smap <Char-0x10>OBF <Nop>
smap <Char-0x10>OBG <Nop>
smap <Char-0x10>OBH <Nop>
smap <Char-0x10>OBI <Nop>
" }}}

" Modifiers [Alt + Ctrl + Super]{{{
smap <Char-0x10>O: <Nop>
smap <Char-0x10>O2 <Nop>
smap <Char-0x10>OBc <Nop>
smap <Char-0x10>OBb <Nop>
smap <Char-0x10>OBa <Nop>
smap <Char-0x10>OBd <Nop>
smap <Char-0x10>O= <Nop>
smap <Char-0x10>OBg <Nop>
smap <Char-0x10>OBf <Nop>
smap <Char-0x10>OBe <Nop>
smap <Char-0x10>OBh <Nop>
smap <Char-0x10>O+ <Nop>
" }}}

" Movement [Alt + Ctrl + Super]{{{
smap <Char-0x10>O6 <Nop>
smap <Char-0x10>O. <Nop>
smap <Char-0x10>O5 <Nop>
smap <Char-0x10>O9 <Nop>
smap <Char-0x10>O8 <Nop>
smap <Char-0x10>O4 <Nop>
smap <Char-0x10>O7 <Nop>
" }}}

" Numpad [Alt + Ctrl + Super]{{{
smap <Char-0x10>OBJ <Nop>
smap <Char-0x10>OBK <Nop>
smap <Char-0x10>OBL <Nop>
smap <Char-0x10>OBM <Nop>
smap <Char-0x10>OBN <Nop>
smap <Char-0x10>OBO <Nop>
smap <Char-0x10>OBP <Nop>
smap <Char-0x10>OBQ <Nop>
smap <Char-0x10>OBR <Nop>
smap <Char-0x10>OBS <Nop>
smap <Char-0x10>OBX <Nop>
smap <Char-0x10>OBT <Nop>
smap <Char-0x10>OBU <Nop>
smap <Char-0x10>OBY <Nop>
smap <Char-0x10>OBZ <Nop>
smap <Char-0x10>OBV <Nop>
smap <Char-0x10>OBW <Nop>
" }}}
" }}}
" Alt + control + Shift + Super [P]{{{
" Alphanumerics [Alt + Ctrl + Shift + Super]{{{
smap <Char-0x10>PS <Nop>
smap <Char-0x10>PT <Nop>
smap <Char-0x10>PU <Nop>
smap <Char-0x10>PV <Nop>
smap <Char-0x10>PW <Nop>
smap <Char-0x10>PX <Nop>
smap <Char-0x10>PY <Nop>
smap <Char-0x10>PZ <Nop>
smap <Char-0x10>Pa <Nop>
smap <Char-0x10>Pb <Nop>
smap <Char-0x10>Pc <Nop>
smap <Char-0x10>Pd <Nop>
smap <Char-0x10>Pe <Nop>
smap <Char-0x10>Pf <Nop>
smap <Char-0x10>Pg <Nop>
smap <Char-0x10>Ph <Nop>
smap <Char-0x10>Pi <Nop>
smap <Char-0x10>Pj <Nop>
smap <Char-0x10>Pk <Nop>
smap <Char-0x10>Pl <Nop>
smap <Char-0x10>Pm <Nop>
smap <Char-0x10>Pn <Nop>
smap <Char-0x10>Po <Nop>
smap <Char-0x10>Pp <Nop>
smap <Char-0x10>Pq <Nop>
smap <Char-0x10>Pr <Nop>
smap <Char-0x10>PG <Nop>
smap <Char-0x10>PH <Nop>
smap <Char-0x10>PI <Nop>
smap <Char-0x10>PJ <Nop>
smap <Char-0x10>PK <Nop>
smap <Char-0x10>PL <Nop>
smap <Char-0x10>PM <Nop>
smap <Char-0x10>PN <Nop>
smap <Char-0x10>PO <Nop>
smap <Char-0x10>PP <Nop>
" }}}

" Symbols [Alt + Ctrl + Shift + Super]{{{
smap <Char-0x10>PB <Nop>
smap <Char-0x10>Pt <Nop>
smap <Char-0x10>P1 <Nop>
smap <Char-0x10>PC <Nop>
smap <Char-0x10>P3 <Nop>
smap <Char-0x10>P- <Nop>
smap <Char-0x10>Pz <Nop>
smap <Char-0x10>PR <Nop>
smap <Char-0x10>Py <Nop>
smap <Char-0x10>Pv <Nop>
smap <Char-0x10>Ps <Nop>
smap <Char-0x10>PD <Nop>
smap <Char-0x10>P! <Nop>
smap <Char-0x10>PE <Nop>
smap <Char-0x10>Pu <Nop>
smap <Char-0x10>PQ <Nop>
smap <Char-0x10>PF <Nop>
smap <Char-0x10>PA <Nop>
smap <Char-0x10>P0 <Nop>
smap <Char-0x10>Pw <Nop>
smap <Char-0x10>Px <Nop>
smap <Char-0x10>P^ <Nop>
" }}}

" Function keys [Alt + Ctrl + Shift + Super]{{{
smap <Char-0x10>p/ <Nop>
smap <Char-0x10>p* <Nop>
smap <Char-0x10>p? <Nop>
smap <Char-0x10>p& <Nop>
smap <Char-0x10>p< <Nop>
smap <Char-0x10>p> <Nop>
smap <Char-0x10>p( <Nop>
smap <Char-0x10>p) <Nop>
smap <Char-0x10>p[ <Nop>
smap <Char-0x10>p] <Nop>
smap <Char-0x10>p{ <Nop>
smap <Char-0x10>p} <Nop>
smap <Char-0x10>p@ <Nop>
smap <Char-0x10>p% <Nop>
smap <Char-0x10>p$ <Nop>
smap <Char-0x10>p# <Nop>
smap <Char-0x10>pba <Nop>
smap <Char-0x10>pbb <Nop>
smap <Char-0x10>pbc <Nop>
smap <Char-0x10>pbd <Nop>
smap <Char-0x10>pbe <Nop>
smap <Char-0x10>pbf <Nop>
smap <Char-0x10>pbg <Nop>
smap <Char-0x10>pbh <Nop>
smap <Char-0x10>pbi <Nop>
" }}}

" Modifiers [Alt + Ctrl + Shift + Super]{{{
smap <Char-0x10>P: <Nop>
smap <Char-0x10>P2 <Nop>
smap <Char-0x10>PBc <Nop>
smap <Char-0x10>PBb <Nop>
smap <Char-0x10>PBa <Nop>
smap <Char-0x10>PBd <Nop>
smap <Char-0x10>P= <Nop>
smap <Char-0x10>PBg <Nop>
smap <Char-0x10>PBf <Nop>
smap <Char-0x10>PBe <Nop>
smap <Char-0x10>PBh <Nop>
smap <Char-0x10>P+ <Nop>
" }}}

" Movement [Alt + Ctrl + Shift + Super]{{{
smap <Char-0x10>P6 <Nop>
smap <Char-0x10>P. <Nop>
smap <Char-0x10>P5 <Nop>
smap <Char-0x10>P9 <Nop>
smap <Char-0x10>P8 <Nop>
smap <Char-0x10>P4 <Nop>
smap <Char-0x10>P7 <Nop>
" }}}

" Numpad [Alt + Ctrl + Shift +  Super]{{{
smap <Char-0x10>PBJ <Nop>
smap <Char-0x10>PBK <Nop>
smap <Char-0x10>PBL <Nop>
smap <Char-0x10>PBM <Nop>
smap <Char-0x10>PBN <Nop>
smap <Char-0x10>PBO <Nop>
smap <Char-0x10>PBP <Nop>
smap <Char-0x10>PBQ <Nop>
smap <Char-0x10>PBR <Nop>
smap <Char-0x10>PBS <Nop>
smap <Char-0x10>PBX <Nop>
smap <Char-0x10>PBT <Nop>
smap <Char-0x10>PBU <Nop>
smap <Char-0x10>PBY <Nop>
smap <Char-0x10>PBZ <Nop>
smap <Char-0x10>PBV <Nop>
smap <Char-0x10>PBW <Nop>
" }}}
" }}}
" }}}

" Operator-pending {{{
" Shift - Special keys [B] {{{
omap <Char-0x10>Bz <Nop>
omap <Char-0x10>B1 <Nop>
omap <Char-0x10>By <Nop>
" }}}
" Ctrl - Special keys [E] {{{
omap <Char-0x10>Ez <Nop>
omap <Char-0x10>E1 <Nop>
omap <Char-0x10>Ey <Nop>
omap <Char-0x10>E0 <Nop>
" }}}
" Ctrl + Shift [F]{{{
" Alphanumerics [Ctrl + Shift]{{{
omap <Char-0x10>FS <Nop>
omap <Char-0x10>FT <Nop>
omap <Char-0x10>FU <Nop>
omap <Char-0x10>FV <Nop>
omap <Char-0x10>FW <Nop>
omap <Char-0x10>FX <Nop>
omap <Char-0x10>FY <Nop>
omap <Char-0x10>FZ <Nop>
omap <Char-0x10>Fa <Nop>
omap <Char-0x10>Fb <Nop>
omap <Char-0x10>Fc <Nop>
omap <Char-0x10>Fd <Nop>
omap <Char-0x10>Fe <Nop>
omap <Char-0x10>Ff <Nop>
omap <Char-0x10>Fg <Nop>
omap <Char-0x10>Fh <Nop>
omap <Char-0x10>Fi <Nop>
omap <Char-0x10>Fj <Nop>
omap <Char-0x10>Fk <Nop>
omap <Char-0x10>Fl <Nop>
omap <Char-0x10>Fm <Nop>
omap <Char-0x10>Fn <Nop>
omap <Char-0x10>Fo <Nop>
omap <Char-0x10>Fp <Nop>
omap <Char-0x10>Fq <Nop>
omap <Char-0x10>Fr <Nop>
omap <Char-0x10>FG <Nop>
omap <Char-0x10>FH <Nop>
omap <Char-0x10>FI <Nop>
omap <Char-0x10>FJ <Nop>
omap <Char-0x10>FK <Nop>
omap <Char-0x10>FL <Nop>
omap <Char-0x10>FM <Nop>
omap <Char-0x10>FN <Nop>
omap <Char-0x10>FO <Nop>
omap <Char-0x10>FP <Nop>
" }}}

" Symbols [Ctrl + Shift]{{{
omap <Char-0x10>FB <Nop>
omap <Char-0x10>Ft <Nop>
omap <Char-0x10>F1 <Nop>
omap <Char-0x10>FC <Nop>
omap <Char-0x10>F3 <Nop>
omap <Char-0x10>F- <Nop>
omap <Char-0x10>Fz <Nop>
omap <Char-0x10>FR <Nop>
omap <Char-0x10>Fy <Nop>
omap <Char-0x10>Fv <Nop>
omap <Char-0x10>Fs <Nop>
omap <Char-0x10>FD <Nop>
omap <Char-0x10>F! <Nop>
omap <Char-0x10>FE <Nop>
omap <Char-0x10>Fu <Nop>
omap <Char-0x10>FQ <Nop>
omap <Char-0x10>FF <Nop>
omap <Char-0x10>FA <Nop>
omap <Char-0x10>F0 <Nop>
omap <Char-0x10>Fw <Nop>
omap <Char-0x10>Fx <Nop>
omap <Char-0x10>F^ <Nop>
" }}}

" Function keys [Ctrl + Shift]{{{
omap <Char-0x10>F/ <Nop>
omap <Char-0x10>F* <Nop>
omap <Char-0x10>F? <Nop>
omap <Char-0x10>F& <Nop>
omap <Char-0x10>F< <Nop>
omap <Char-0x10>F> <Nop>
omap <Char-0x10>F( <Nop>
omap <Char-0x10>F) <Nop>
omap <Char-0x10>F[ <Nop>
omap <Char-0x10>F] <Nop>
omap <Char-0x10>F{ <Nop>
omap <Char-0x10>F} <Nop>
omap <Char-0x10>F@ <Nop>
omap <Char-0x10>F% <Nop>
omap <Char-0x10>F$ <Nop>
omap <Char-0x10>F# <Nop>
omap <Char-0x10>FBA <Nop>
omap <Char-0x10>FBB <Nop>
omap <Char-0x10>FBC <Nop>
omap <Char-0x10>FBD <Nop>
omap <Char-0x10>FBE <Nop>
omap <Char-0x10>FBF <Nop>
omap <Char-0x10>FBG <Nop>
omap <Char-0x10>FBH <Nop>
omap <Char-0x10>FBI <Nop>
" }}}

" Modifiers / modes etc [Ctrl + Shift]{{{
omap <Char-0x10>F: <Nop>
omap <Char-0x10>F2 <Nop>
omap <Char-0x10>FBc <Nop>
omap <Char-0x10>FBb <Nop>
omap <Char-0x10>FBa <Nop>
omap <Char-0x10>FBd <Nop>
omap <Char-0x10>F= <Nop>
omap <Char-0x10>FBg <Nop>
omap <Char-0x10>FBf <Nop>
omap <Char-0x10>FBe <Nop>
omap <Char-0x10>FBh <Nop>
omap <Char-0x10>F+ <Nop>
" }}}

" Movement [Ctrl + Shift]{{{
omap <Char-0x10>F6 <Nop>
omap <Char-0x10>F. <Nop>
omap <Char-0x10>F5 <Nop>
omap <Char-0x10>F9 <Nop>
omap <Char-0x10>F8 <Nop>
omap <Char-0x10>F4 <Nop>
omap <Char-0x10>F7 <Nop>
" }}}

" Numpad [Ctrl + Shift]{{{
omap <Char-0x10>FBJ <Nop>
omap <Char-0x10>FBK <Nop>
omap <Char-0x10>FBL <Nop>
omap <Char-0x10>FBM <Nop>
omap <Char-0x10>FBN <Nop>
omap <Char-0x10>FBO <Nop>
omap <Char-0x10>FBP <Nop>
omap <Char-0x10>FBQ <Nop>
omap <Char-0x10>FBR <Nop>
omap <Char-0x10>FBS <Nop>
omap <Char-0x10>FBX <Nop>
omap <Char-0x10>FBT <Nop>
omap <Char-0x10>FBU <Nop>
omap <Char-0x10>FBY <Nop>
omap <Char-0x10>FBZ <Nop>
omap <Char-0x10>FBV <Nop>
omap <Char-0x10>FBW <Nop>
" }}}
" }}}
" Alt + Ctrl [G]{{{
" Alphanumerics [Alt + Ctrl]{{{
omap <Char-0x10>GS <Nop>
omap <Char-0x10>GT <Nop>
omap <Char-0x10>GU <Nop>
omap <Char-0x10>GV <Nop>
omap <Char-0x10>GW <Nop>
omap <Char-0x10>GX <Nop>
omap <Char-0x10>GY <Nop>
omap <Char-0x10>GZ <Nop>
omap <Char-0x10>Ga <Nop>
omap <Char-0x10>Gb <Nop>
omap <Char-0x10>Gc <Nop>
omap <Char-0x10>Gd <Nop>
omap <Char-0x10>Ge <Nop>
omap <Char-0x10>Gf <Nop>
omap <Char-0x10>Gg <Nop>
omap <Char-0x10>Gh <Nop>
omap <Char-0x10>Gi <Nop>
omap <Char-0x10>Gj <Nop>
omap <Char-0x10>Gk <Nop>
omap <Char-0x10>Gl <Nop>
omap <Char-0x10>Gm <Nop>
omap <Char-0x10>Gn <Nop>
omap <Char-0x10>Go <Nop>
omap <Char-0x10>Gp <Nop>
omap <Char-0x10>Gq <Nop>
omap <Char-0x10>Gr <Nop>
omap <Char-0x10>GG <Nop>
omap <Char-0x10>GH <Nop>
omap <Char-0x10>GI <Nop>
omap <Char-0x10>GJ <Nop>
omap <Char-0x10>GK <Nop>
omap <Char-0x10>GL <Nop>
omap <Char-0x10>GM <Nop>
omap <Char-0x10>GN <Nop>
omap <Char-0x10>GO <Nop>
omap <Char-0x10>GP <Nop>
" }}}

" Symbols [Alt + Ctrl]{{{
omap <Char-0x10>GB <Nop>
omap <Char-0x10>Gt <Nop>
omap <Char-0x10>G1 <Nop>
omap <Char-0x10>GC <Nop>
omap <Char-0x10>G3 <Nop>
omap <Char-0x10>G- <Nop>
omap <Char-0x10>Gz <Nop>
omap <Char-0x10>GR <Nop>
omap <Char-0x10>Gy <Nop>
omap <Char-0x10>Gv <Nop>
omap <Char-0x10>Gs <Nop>
omap <Char-0x10>GD <Nop>
omap <Char-0x10>G! <Nop>
omap <Char-0x10>GE <Nop>
omap <Char-0x10>Gu <Nop>
omap <Char-0x10>GQ <Nop>
omap <Char-0x10>GF <Nop>
omap <Char-0x10>GA <Nop>
omap <Char-0x10>G0 <Nop>
omap <Char-0x10>Gw <Nop>
omap <Char-0x10>Gx <Nop>
omap <Char-0x10>G^ <Nop>
" }}}

" Function keys [Alt + Ctrl]{{{
omap <Char-0x10>G/ <Nop>
omap <Char-0x10>G* <Nop>
omap <Char-0x10>G? <Nop>
omap <Char-0x10>G& <Nop>
omap <Char-0x10>G< <Nop>
omap <Char-0x10>G> <Nop>
omap <Char-0x10>G( <Nop>
omap <Char-0x10>G) <Nop>
omap <Char-0x10>G[ <Nop>
omap <Char-0x10>G] <Nop>
omap <Char-0x10>G{ <Nop>
omap <Char-0x10>G} <Nop>
omap <Char-0x10>G@ <Nop>
omap <Char-0x10>G% <Nop>
omap <Char-0x10>G$ <Nop>
omap <Char-0x10>G# <Nop>
omap <Char-0x10>GBA <Nop>
omap <Char-0x10>GBB <Nop>
omap <Char-0x10>GBC <Nop>
omap <Char-0x10>GBD <Nop>
omap <Char-0x10>GBE <Nop>
omap <Char-0x10>GBF <Nop>
omap <Char-0x10>GBG <Nop>
omap <Char-0x10>GBH <Nop>
omap <Char-0x10>GBI <Nop>
" }}}

" Modifiers [Alt + Ctrl]{{{
omap <Char-0x10>G: <Nop>
omap <Char-0x10>G2 <Nop>
omap <Char-0x10>GBc <Nop>
omap <Char-0x10>GBb <Nop>
omap <Char-0x10>GBa <Nop>
omap <Char-0x10>GBd <Nop>
omap <Char-0x10>G= <Nop>
omap <Char-0x10>GBg <Nop>
omap <Char-0x10>GBf <Nop>
omap <Char-0x10>GBe <Nop>
omap <Char-0x10>GBh <Nop>
omap <Char-0x10>G+ <Nop>
" }}}

" Movement [Alt + Ctrl]{{{
omap <Char-0x10>G6 <Nop>
omap <Char-0x10>G. <Nop>
omap <Char-0x10>G5 <Nop>
omap <Char-0x10>G9 <Nop>
omap <Char-0x10>G8 <Nop>
omap <Char-0x10>G4 <Nop>
omap <Char-0x10>G7 <Nop>
" }}}

" Numpad [Alt + Ctrl]{{{
omap <Char-0x10>GBJ <Nop>
omap <Char-0x10>GBK <Nop>
omap <Char-0x10>GBL <Nop>
omap <Char-0x10>GBM <Nop>
omap <Char-0x10>GBN <Nop>
omap <Char-0x10>GBO <Nop>
omap <Char-0x10>GBP <Nop>
omap <Char-0x10>GBQ <Nop>
omap <Char-0x10>GBR <Nop>
omap <Char-0x10>GBS <Nop>
omap <Char-0x10>GBX <Nop>
omap <Char-0x10>GBT <Nop>
omap <Char-0x10>GBU <Nop>
omap <Char-0x10>GBY <Nop>
omap <Char-0x10>GBZ <Nop>
omap <Char-0x10>GBV <Nop>
omap <Char-0x10>GBW <Nop>
" }}}
" }}}
" Alt + Ctrl + Shift [H]{{{
" Alphanumerics [Alt + Ctrl + Shift]{{{
omap <Char-0x10>HS <Nop>
omap <Char-0x10>HT <Nop>
omap <Char-0x10>HU <Nop>
omap <Char-0x10>HV <Nop>
omap <Char-0x10>HW <Nop>
omap <Char-0x10>HX <Nop>
omap <Char-0x10>HY <Nop>
omap <Char-0x10>HZ <Nop>
omap <Char-0x10>Ha <Nop>
omap <Char-0x10>Hb <Nop>
omap <Char-0x10>Hc <Nop>
omap <Char-0x10>Hd <Nop>
omap <Char-0x10>He <Nop>
omap <Char-0x10>Hf <Nop>
omap <Char-0x10>Hg <Nop>
omap <Char-0x10>Hh <Nop>
omap <Char-0x10>Hi <Nop>
omap <Char-0x10>Hj <Nop>
omap <Char-0x10>Hk <Nop>
omap <Char-0x10>Hl <Nop>
omap <Char-0x10>Hm <Nop>
omap <Char-0x10>Hn <Nop>
omap <Char-0x10>Ho <Nop>
omap <Char-0x10>Hp <Nop>
omap <Char-0x10>Hq <Nop>
omap <Char-0x10>Hr <Nop>
omap <Char-0x10>HG <Nop>
omap <Char-0x10>HH <Nop>
omap <Char-0x10>HI <Nop>
omap <Char-0x10>HJ <Nop>
omap <Char-0x10>HK <Nop>
omap <Char-0x10>HL <Nop>
omap <Char-0x10>HM <Nop>
omap <Char-0x10>HN <Nop>
omap <Char-0x10>HO <Nop>
omap <Char-0x10>HP <Nop>
" }}}

" Symbols [Alt + Ctrl + Shift]{{{
omap <Char-0x10>HB <Nop>
omap <Char-0x10>Ht <Nop>
omap <Char-0x10>H1 <Nop>
omap <Char-0x10>HC <Nop>
omap <Char-0x10>H3 <Nop>
omap <Char-0x10>H- <Nop>
omap <Char-0x10>Hz <Nop>
omap <Char-0x10>HR <Nop>
omap <Char-0x10>Hy <Nop>
omap <Char-0x10>Hv <Nop>
omap <Char-0x10>Hs <Nop>
omap <Char-0x10>HD <Nop>
omap <Char-0x10>H! <Nop>
omap <Char-0x10>HE <Nop>
omap <Char-0x10>Hu <Nop>
omap <Char-0x10>HQ <Nop>
omap <Char-0x10>HF <Nop>
omap <Char-0x10>HA <Nop>
omap <Char-0x10>H0 <Nop>
omap <Char-0x10>Hw <Nop>
omap <Char-0x10>Hx <Nop>
omap <Char-0x10>H^ <Nop>
" }}}

" Function keys [Alt + Ctrl + Shift]{{{
omap <Char-0x10>H/ <Nop>
omap <Char-0x10>H* <Nop>
omap <Char-0x10>H? <Nop>
omap <Char-0x10>H& <Nop>
omap <Char-0x10>H< <Nop>
omap <Char-0x10>H> <Nop>
omap <Char-0x10>H( <Nop>
omap <Char-0x10>H) <Nop>
omap <Char-0x10>H[ <Nop>
omap <Char-0x10>H] <Nop>
omap <Char-0x10>H{ <Nop>
omap <Char-0x10>H} <Nop>
omap <Char-0x10>H@ <Nop>
omap <Char-0x10>H% <Nop>
omap <Char-0x10>H$ <Nop>
omap <Char-0x10>H# <Nop>
omap <Char-0x10>HBA <Nop>
omap <Char-0x10>HBB <Nop>
omap <Char-0x10>HBC <Nop>
omap <Char-0x10>HBD <Nop>
omap <Char-0x10>HBE <Nop>
omap <Char-0x10>HBF <Nop>
omap <Char-0x10>HBG <Nop>
omap <Char-0x10>HBH <Nop>
omap <Char-0x10>HBI <Nop>
" }}}

" Modifiers [Alt + Ctrl + Shift]{{{
omap <Char-0x10>H: <Nop>
omap <Char-0x10>H2 <Nop>
omap <Char-0x10>HBc <Nop>
omap <Char-0x10>HBb <Nop>
omap <Char-0x10>HBa <Nop>
omap <Char-0x10>HBd <Nop>
omap <Char-0x10>H= <Nop>
omap <Char-0x10>HBg <Nop>
omap <Char-0x10>HBf <Nop>
omap <Char-0x10>HBe <Nop>
omap <Char-0x10>HBh <Nop>
omap <Char-0x10>H+ <Nop>
" }}}

" Movement [Alt + Ctrl + Shift]{{{
omap <Char-0x10>H6 <Nop>
omap <Char-0x10>H. <Nop>
omap <Char-0x10>H5 <Nop>
omap <Char-0x10>H9 <Nop>
omap <Char-0x10>H8 <Nop>
omap <Char-0x10>H4 <Nop>
omap <Char-0x10>H7 <Nop>
" }}}

" Numpad [Alt + Ctrl + Shift]{{{
omap <Char-0x10>HBJ <Nop>
omap <Char-0x10>HBK <Nop>
omap <Char-0x10>HBL <Nop>
omap <Char-0x10>HBM <Nop>
omap <Char-0x10>HBN <Nop>
omap <Char-0x10>HBO <Nop>
omap <Char-0x10>HBP <Nop>
omap <Char-0x10>HBQ <Nop>
omap <Char-0x10>HBR <Nop>
omap <Char-0x10>HBS <Nop>
omap <Char-0x10>HBX <Nop>
omap <Char-0x10>HBT <Nop>
omap <Char-0x10>HBU <Nop>
omap <Char-0x10>HBY <Nop>
omap <Char-0x10>HBZ <Nop>
omap <Char-0x10>HBV <Nop>
omap <Char-0x10>HBW <Nop>
" }}}
" }}}
" Super [I]{{{
" Alphanumerics [Super]{{{
omap <Char-0x10>IS <Nop>
omap <Char-0x10>IT <Nop>
omap <Char-0x10>IU <Nop>
omap <Char-0x10>IV <Nop>
omap <Char-0x10>IW <Nop>
omap <Char-0x10>IX <Nop>
omap <Char-0x10>IY <Nop>
omap <Char-0x10>IZ <Nop>
omap <Char-0x10>Ia <Nop>
omap <Char-0x10>Ib <Nop>
omap <Char-0x10>Ic <Nop>
omap <Char-0x10>Id <Nop>
omap <Char-0x10>Ie <Nop>
omap <Char-0x10>If <Nop>
omap <Char-0x10>Ig <Nop>
omap <Char-0x10>Ih <Nop>
omap <Char-0x10>Ii <Nop>
omap <Char-0x10>Ij <Nop>
omap <Char-0x10>Ik <Nop>
omap <Char-0x10>Il <Nop>
omap <Char-0x10>Im <Nop>
omap <Char-0x10>In <Nop>
omap <Char-0x10>Io <Nop>
omap <Char-0x10>Ip <Nop>
omap <Char-0x10>Iq <Nop>
omap <Char-0x10>Ir <Nop>
omap <Char-0x10>IG <Nop>
omap <Char-0x10>IH <Nop>
omap <Char-0x10>II <Nop>
omap <Char-0x10>IJ <Nop>
omap <Char-0x10>IK <Nop>
omap <Char-0x10>IL <Nop>
omap <Char-0x10>IM <Nop>
omap <Char-0x10>IN <Nop>
omap <Char-0x10>IO <Nop>
omap <Char-0x10>IP <Nop>
" }}}

" Symbols [Super]{{{
omap <Char-0x10>IB <Nop>
omap <Char-0x10>It <Nop>
omap <Char-0x10>I1 <Nop>
omap <Char-0x10>IC <Nop>
omap <Char-0x10>I3 <Nop>
omap <Char-0x10>I- <Nop>
omap <Char-0x10>Iz <Nop>
omap <Char-0x10>IR <Nop>
omap <Char-0x10>Iy <Nop>
omap <Char-0x10>Iv <Nop>
omap <Char-0x10>Is <Nop>
omap <Char-0x10>ID <Nop>
omap <Char-0x10>I! <Nop>
omap <Char-0x10>IE <Nop>
omap <Char-0x10>Iu <Nop>
omap <Char-0x10>IQ <Nop>
omap <Char-0x10>IF <Nop>
omap <Char-0x10>IA <Nop>
omap <Char-0x10>I0 <Nop>
omap <Char-0x10>Iw <Nop>
omap <Char-0x10>Ix <Nop>
omap <Char-0x10>I^ <Nop>
" }}}

" Function keys [Super]{{{
omap <Char-0x10>I/ <Nop>
omap <Char-0x10>I* <Nop>
omap <Char-0x10>I? <Nop>
omap <Char-0x10>I& <Nop>
omap <Char-0x10>I< <Nop>
omap <Char-0x10>I> <Nop>
omap <Char-0x10>I( <Nop>
omap <Char-0x10>I) <Nop>
omap <Char-0x10>I[ <Nop>
omap <Char-0x10>I] <Nop>
omap <Char-0x10>I{ <Nop>
omap <Char-0x10>I} <Nop>
omap <Char-0x10>I@ <Nop>
omap <Char-0x10>I% <Nop>
omap <Char-0x10>I$ <Nop>
omap <Char-0x10>I# <Nop>
omap <Char-0x10>IBA <Nop>
omap <Char-0x10>IBB <Nop>
omap <Char-0x10>IBC <Nop>
omap <Char-0x10>IBD <Nop>
omap <Char-0x10>IBE <Nop>
omap <Char-0x10>IBF <Nop>
omap <Char-0x10>IBG <Nop>
omap <Char-0x10>IBH <Nop>
omap <Char-0x10>IBI <Nop>
" }}}

" Modifiers [Super]{{{
omap <Char-0x10>I: <Nop>
omap <Char-0x10>I2 <Nop>
omap <Char-0x10>IBc <Nop>
omap <Char-0x10>IBb <Nop>
omap <Char-0x10>IBa <Nop>
omap <Char-0x10>IBd <Nop>
omap <Char-0x10>I= <Nop>
omap <Char-0x10>IBg <Nop>
omap <Char-0x10>IBf <Nop>
omap <Char-0x10>IBe <Nop>
omap <Char-0x10>IBh <Nop>
omap <Char-0x10>I+ <Nop>
" }}}

" Movement [Super]{{{
omap <Char-0x10>I6 <Nop>
omap <Char-0x10>I. <Nop>
omap <Char-0x10>I5 <Nop>
omap <Char-0x10>I9 <Nop>
omap <Char-0x10>I8 <Nop>
omap <Char-0x10>I4 <Nop>
omap <Char-0x10>I7 <Nop>
" }}}

" Numpad [Super]{{{
omap <Char-0x10>IBJ <Nop>
omap <Char-0x10>IBK <Nop>
omap <Char-0x10>IBL <Nop>
omap <Char-0x10>IBM <Nop>
omap <Char-0x10>IBN <Nop>
omap <Char-0x10>IBO <Nop>
omap <Char-0x10>IBP <Nop>
omap <Char-0x10>IBQ <Nop>
omap <Char-0x10>IBR <Nop>
omap <Char-0x10>IBS <Nop>
omap <Char-0x10>IBX <Nop>
omap <Char-0x10>IBT <Nop>
omap <Char-0x10>IBU <Nop>
omap <Char-0x10>IBY <Nop>
omap <Char-0x10>IBZ <Nop>
omap <Char-0x10>IBV <Nop>
omap <Char-0x10>IBW <Nop>
" }}}
" }}}
" Shift + Super [J]{{{
" Alphanumerics [Shift + Super]{{{
omap <Char-0x10>JS <Nop>
omap <Char-0x10>JT <Nop>
omap <Char-0x10>JU <Nop>
omap <Char-0x10>JV <Nop>
omap <Char-0x10>JW <Nop>
omap <Char-0x10>JX <Nop>
omap <Char-0x10>JY <Nop>
omap <Char-0x10>JZ <Nop>
omap <Char-0x10>Ja <Nop>
omap <Char-0x10>Jb <Nop>
omap <Char-0x10>Jc <Nop>
omap <Char-0x10>Jd <Nop>
omap <Char-0x10>Je <Nop>
omap <Char-0x10>Jf <Nop>
omap <Char-0x10>Jg <Nop>
omap <Char-0x10>Jh <Nop>
omap <Char-0x10>Ji <Nop>
omap <Char-0x10>Jj <Nop>
omap <Char-0x10>Jk <Nop>
omap <Char-0x10>Jl <Nop>
omap <Char-0x10>Jm <Nop>
omap <Char-0x10>Jn <Nop>
omap <Char-0x10>Jo <Nop>
omap <Char-0x10>Jp <Nop>
omap <Char-0x10>Jq <Nop>
omap <Char-0x10>Jr <Nop>
omap <Char-0x10>JG <Nop>
omap <Char-0x10>JH <Nop>
omap <Char-0x10>JI <Nop>
omap <Char-0x10>JJ <Nop>
omap <Char-0x10>JK <Nop>
omap <Char-0x10>JL <Nop>
omap <Char-0x10>JM <Nop>
omap <Char-0x10>JN <Nop>
omap <Char-0x10>JO <Nop>
omap <Char-0x10>JP <Nop>
" }}}

" Symbols [Shift + Super]{{{
omap <Char-0x10>JB <Nop>
omap <Char-0x10>Jt <Nop>
omap <Char-0x10>J1 <Nop>
omap <Char-0x10>JC <Nop>
omap <Char-0x10>J3 <Nop>
omap <Char-0x10>J- <Nop>
omap <Char-0x10>Jz <Nop>
omap <Char-0x10>JR <Nop>
omap <Char-0x10>Jy <Nop>
omap <Char-0x10>Jv <Nop>
omap <Char-0x10>Js <Nop>
omap <Char-0x10>JD <Nop>
omap <Char-0x10>J! <Nop>
omap <Char-0x10>JE <Nop>
omap <Char-0x10>Ju <Nop>
omap <Char-0x10>JQ <Nop>
omap <Char-0x10>JF <Nop>
omap <Char-0x10>JA <Nop>
omap <Char-0x10>J0 <Nop>
omap <Char-0x10>Jw <Nop>
omap <Char-0x10>Jx <Nop>
omap <Char-0x10>J^ <Nop>
" }}}

" Function keys [Shift + Super]{{{
omap <Char-0x10>J/ <Nop>
omap <Char-0x10>J* <Nop>
omap <Char-0x10>J? <Nop>
omap <Char-0x10>J& <Nop>
omap <Char-0x10>J< <Nop>
omap <Char-0x10>J> <Nop>
omap <Char-0x10>J( <Nop>
omap <Char-0x10>J) <Nop>
omap <Char-0x10>J[ <Nop>
omap <Char-0x10>J] <Nop>
omap <Char-0x10>J{ <Nop>
omap <Char-0x10>J} <Nop>
omap <Char-0x10>J@ <Nop>
omap <Char-0x10>J% <Nop>
omap <Char-0x10>J$ <Nop>
omap <Char-0x10>J# <Nop>
omap <Char-0x10>JBA <Nop>
omap <Char-0x10>JBB <Nop>
omap <Char-0x10>JBC <Nop>
omap <Char-0x10>JBD <Nop>
omap <Char-0x10>JBE <Nop>
omap <Char-0x10>JBF <Nop>
omap <Char-0x10>JBG <Nop>
omap <Char-0x10>JBH <Nop>
omap <Char-0x10>JBI <Nop>
" }}}

" Modifiers [Shift + Super]{{{
omap <Char-0x10>J: <Nop>
omap <Char-0x10>J2 <Nop>
omap <Char-0x10>JBc <Nop>
omap <Char-0x10>JBb <Nop>
omap <Char-0x10>JBa <Nop>
omap <Char-0x10>JBd <Nop>
omap <Char-0x10>J= <Nop>
omap <Char-0x10>JBg <Nop>
omap <Char-0x10>JBf <Nop>
omap <Char-0x10>JBe <Nop>
omap <Char-0x10>JBh <Nop>
omap <Char-0x10>J+ <Nop>
" }}}

" Movement [Shift + Super]{{{
omap <Char-0x10>J6 <Nop>
omap <Char-0x10>J. <Nop>
omap <Char-0x10>J5 <Nop>
omap <Char-0x10>J9 <Nop>
omap <Char-0x10>J8 <Nop>
omap <Char-0x10>J4 <Nop>
omap <Char-0x10>J7 <Nop>
" }}}

" Numpad [Shift + Super]{{{
omap <Char-0x10>JBJ <Nop>
omap <Char-0x10>JBK <Nop>
omap <Char-0x10>JBL <Nop>
omap <Char-0x10>JBM <Nop>
omap <Char-0x10>JBN <Nop>
omap <Char-0x10>JBO <Nop>
omap <Char-0x10>JBP <Nop>
omap <Char-0x10>JBQ <Nop>
omap <Char-0x10>JBR <Nop>
omap <Char-0x10>JBS <Nop>
omap <Char-0x10>JBX <Nop>
omap <Char-0x10>JBT <Nop>
omap <Char-0x10>JBU <Nop>
omap <Char-0x10>JBY <Nop>
omap <Char-0x10>JBZ <Nop>
omap <Char-0x10>JBV <Nop>
omap <Char-0x10>JBW <Nop>
" }}}
" }}}
" Alt + Super [K]{{{
" Alphanumerics [Alt + Super]{{{
omap <Char-0x10>KS <Nop>
omap <Char-0x10>KT <Nop>
omap <Char-0x10>KU <Nop>
omap <Char-0x10>KV <Nop>
omap <Char-0x10>KW <Nop>
omap <Char-0x10>KX <Nop>
omap <Char-0x10>KY <Nop>
omap <Char-0x10>KZ <Nop>
omap <Char-0x10>Ka <Nop>
omap <Char-0x10>Kb <Nop>
omap <Char-0x10>Kc <Nop>
omap <Char-0x10>Kd <Nop>
omap <Char-0x10>Ke <Nop>
omap <Char-0x10>Kf <Nop>
omap <Char-0x10>Kg <Nop>
omap <Char-0x10>Kh <Nop>
omap <Char-0x10>Ki <Nop>
omap <Char-0x10>Kj <Nop>
omap <Char-0x10>Kk <Nop>
omap <Char-0x10>Kl <Nop>
omap <Char-0x10>Km <Nop>
omap <Char-0x10>Kn <Nop>
omap <Char-0x10>Ko <Nop>
omap <Char-0x10>Kp <Nop>
omap <Char-0x10>Kq <Nop>
omap <Char-0x10>Kr <Nop>
omap <Char-0x10>KG <Nop>
omap <Char-0x10>KH <Nop>
omap <Char-0x10>KI <Nop>
omap <Char-0x10>KJ <Nop>
omap <Char-0x10>KK <Nop>
omap <Char-0x10>KL <Nop>
omap <Char-0x10>KM <Nop>
omap <Char-0x10>KN <Nop>
omap <Char-0x10>KO <Nop>
omap <Char-0x10>KP <Nop>
" }}}

" Symbols [Alt + Super]{{{
omap <Char-0x10>KB <Nop>
omap <Char-0x10>Kt <Nop>
omap <Char-0x10>K1 <Nop>
omap <Char-0x10>KC <Nop>
omap <Char-0x10>K3 <Nop>
omap <Char-0x10>K- <Nop>
omap <Char-0x10>Kz <Nop>
omap <Char-0x10>KR <Nop>
omap <Char-0x10>Ky <Nop>
omap <Char-0x10>Kv <Nop>
omap <Char-0x10>Ks <Nop>
omap <Char-0x10>KD <Nop>
omap <Char-0x10>K! <Nop>
omap <Char-0x10>KE <Nop>
omap <Char-0x10>Ku <Nop>
omap <Char-0x10>KQ <Nop>
omap <Char-0x10>KF <Nop>
omap <Char-0x10>KA <Nop>
omap <Char-0x10>K0 <Nop>
omap <Char-0x10>Kw <Nop>
omap <Char-0x10>Kx <Nop>
omap <Char-0x10>K^ <Nop>
" }}}

" Function keys [Alt + Super]{{{
omap <Char-0x10>K/ <Nop>
omap <Char-0x10>K* <Nop>
omap <Char-0x10>K? <Nop>
omap <Char-0x10>K& <Nop>
omap <Char-0x10>K< <Nop>
omap <Char-0x10>K> <Nop>
omap <Char-0x10>K( <Nop>
omap <Char-0x10>K) <Nop>
omap <Char-0x10>K[ <Nop>
omap <Char-0x10>K] <Nop>
omap <Char-0x10>K{ <Nop>
omap <Char-0x10>K} <Nop>
omap <Char-0x10>K@ <Nop>
omap <Char-0x10>K% <Nop>
omap <Char-0x10>K$ <Nop>
omap <Char-0x10>K# <Nop>
omap <Char-0x10>KBA <Nop>
omap <Char-0x10>KBB <Nop>
omap <Char-0x10>KBC <Nop>
omap <Char-0x10>KBD <Nop>
omap <Char-0x10>KBE <Nop>
omap <Char-0x10>KBF <Nop>
omap <Char-0x10>KBG <Nop>
omap <Char-0x10>KBH <Nop>
omap <Char-0x10>KBI <Nop>
" }}}

" Modifiers [Alt + Super]{{{
omap <Char-0x10>K: <Nop>
omap <Char-0x10>K2 <Nop>
omap <Char-0x10>KBc <Nop>
omap <Char-0x10>KBb <Nop>
omap <Char-0x10>KBa <Nop>
omap <Char-0x10>KBd <Nop>
omap <Char-0x10>K= <Nop>
omap <Char-0x10>KBg <Nop>
omap <Char-0x10>KBf <Nop>
omap <Char-0x10>KBe <Nop>
omap <Char-0x10>KBh <Nop>
omap <Char-0x10>K+ <Nop>
" }}}

" Movement [Alt + Super]{{{
omap <Char-0x10>K6 <Nop>
omap <Char-0x10>K. <Nop>
omap <Char-0x10>K5 <Nop>
omap <Char-0x10>K9 <Nop>
omap <Char-0x10>K8 <Nop>
omap <Char-0x10>K4 <Nop>
omap <Char-0x10>K7 <Nop>
" }}}

" Numpad [Alt + Super]{{{
omap <Char-0x10>KBJ <Nop>
omap <Char-0x10>KBK <Nop>
omap <Char-0x10>KBL <Nop>
omap <Char-0x10>KBM <Nop>
omap <Char-0x10>KBN <Nop>
omap <Char-0x10>KBO <Nop>
omap <Char-0x10>KBP <Nop>
omap <Char-0x10>KBQ <Nop>
omap <Char-0x10>KBR <Nop>
omap <Char-0x10>KBS <Nop>
omap <Char-0x10>KBX <Nop>
omap <Char-0x10>KBT <Nop>
omap <Char-0x10>KBU <Nop>
omap <Char-0x10>KBY <Nop>
omap <Char-0x10>KBZ <Nop>
omap <Char-0x10>KBV <Nop>
omap <Char-0x10>KBW <Nop>
" }}}
" }}}
" Alt + Shift + Super [L]{{{
" Alphanumerics [Alt + Shift + Super]{{{
omap <Char-0x10>LS <Nop>
omap <Char-0x10>LT <Nop>
omap <Char-0x10>LU <Nop>
omap <Char-0x10>LV <Nop>
omap <Char-0x10>LW <Nop>
omap <Char-0x10>LX <Nop>
omap <Char-0x10>LY <Nop>
omap <Char-0x10>LZ <Nop>
omap <Char-0x10>La <Nop>
omap <Char-0x10>Lb <Nop>
omap <Char-0x10>Lc <Nop>
omap <Char-0x10>Ld <Nop>
omap <Char-0x10>Le <Nop>
omap <Char-0x10>Lf <Nop>
omap <Char-0x10>Lg <Nop>
omap <Char-0x10>Lh <Nop>
omap <Char-0x10>Li <Nop>
omap <Char-0x10>Lj <Nop>
omap <Char-0x10>Lk <Nop>
omap <Char-0x10>Ll <Nop>
omap <Char-0x10>Lm <Nop>
omap <Char-0x10>Ln <Nop>
omap <Char-0x10>Lo <Nop>
omap <Char-0x10>Lp <Nop>
omap <Char-0x10>Lq <Nop>
omap <Char-0x10>Lr <Nop>
omap <Char-0x10>LG <Nop>
omap <Char-0x10>LH <Nop>
omap <Char-0x10>LI <Nop>
omap <Char-0x10>LJ <Nop>
omap <Char-0x10>LK <Nop>
omap <Char-0x10>LL <Nop>
omap <Char-0x10>LM <Nop>
omap <Char-0x10>LN <Nop>
omap <Char-0x10>LO <Nop>
omap <Char-0x10>LP <Nop>
" }}}

" Symbols [Alt + Shift  + Super]{{{
omap <Char-0x10>LB <Nop>
omap <Char-0x10>Lt <Nop>
omap <Char-0x10>L1 <Nop>
omap <Char-0x10>LC <Nop>
omap <Char-0x10>L3 <Nop>
omap <Char-0x10>L- <Nop>
omap <Char-0x10>Lz <Nop>
omap <Char-0x10>LR <Nop>
omap <Char-0x10>Ly <Nop>
omap <Char-0x10>Lv <Nop>
omap <Char-0x10>Ls <Nop>
omap <Char-0x10>LD <Nop>
omap <Char-0x10>L! <Nop>
omap <Char-0x10>LE <Nop>
omap <Char-0x10>Lu <Nop>
omap <Char-0x10>LQ <Nop>
omap <Char-0x10>LF <Nop>
omap <Char-0x10>LA <Nop>
omap <Char-0x10>L0 <Nop>
omap <Char-0x10>Lw <Nop>
omap <Char-0x10>Lx <Nop>
omap <Char-0x10>L^ <Nop>
" }}}

" Function keys [Alt + Shift + Super]{{{
omap <Char-0x10>L/ <Nop>
omap <Char-0x10>L* <Nop>
omap <Char-0x10>L? <Nop>
omap <Char-0x10>L& <Nop>
omap <Char-0x10>L< <Nop>
omap <Char-0x10>L> <Nop>
omap <Char-0x10>L( <Nop>
omap <Char-0x10>L) <Nop>
omap <Char-0x10>L[ <Nop>
omap <Char-0x10>L] <Nop>
omap <Char-0x10>L{ <Nop>
omap <Char-0x10>L} <Nop>
omap <Char-0x10>L@ <Nop>
omap <Char-0x10>L% <Nop>
omap <Char-0x10>L$ <Nop>
omap <Char-0x10>L# <Nop>
omap <Char-0x10>LBA <Nop>
omap <Char-0x10>LBB <Nop>
omap <Char-0x10>LBC <Nop>
omap <Char-0x10>LBD <Nop>
omap <Char-0x10>LBE <Nop>
omap <Char-0x10>LBF <Nop>
omap <Char-0x10>LBG <Nop>
omap <Char-0x10>LBH <Nop>
omap <Char-0x10>LBI <Nop>
" }}}

" Modifiers [Alt + Shift + Super]{{{
omap <Char-0x10>L: <Nop>
omap <Char-0x10>L2 <Nop>
omap <Char-0x10>LBc <Nop>
omap <Char-0x10>LBb <Nop>
omap <Char-0x10>LBa <Nop>
omap <Char-0x10>LBd <Nop>
omap <Char-0x10>L= <Nop>
omap <Char-0x10>LBg <Nop>
omap <Char-0x10>LBf <Nop>
omap <Char-0x10>LBe <Nop>
omap <Char-0x10>LBh <Nop>
omap <Char-0x10>L+ <Nop>
" }}}

" Movement [Alt + Shift + Super]{{{
omap <Char-0x10>L6 <Nop>
omap <Char-0x10>L. <Nop>
omap <Char-0x10>L5 <Nop>
omap <Char-0x10>L9 <Nop>
omap <Char-0x10>L8 <Nop>
omap <Char-0x10>L4 <Nop>
omap <Char-0x10>L7 <Nop>
" }}}

" Numpad [Alt + Shift + Super]{{{
omap <Char-0x10>LBJ <Nop>
omap <Char-0x10>LBK <Nop>
omap <Char-0x10>LBL <Nop>
omap <Char-0x10>LBM <Nop>
omap <Char-0x10>LBN <Nop>
omap <Char-0x10>LBO <Nop>
omap <Char-0x10>LBP <Nop>
omap <Char-0x10>LBQ <Nop>
omap <Char-0x10>LBR <Nop>
omap <Char-0x10>LBS <Nop>
omap <Char-0x10>LBX <Nop>
omap <Char-0x10>LBT <Nop>
omap <Char-0x10>LBU <Nop>
omap <Char-0x10>LBY <Nop>
omap <Char-0x10>LBZ <Nop>
omap <Char-0x10>LBV <Nop>
omap <Char-0x10>LBW <Nop>
" }}}
" }}}
" Alt + Ctrl + Shift + Super [L]{{{
" Alphanumerics [Ctrl + Super]{{{
omap <Char-0x10>MS <Nop>
omap <Char-0x10>MT <Nop>
omap <Char-0x10>MU <Nop>
omap <Char-0x10>MV <Nop>
omap <Char-0x10>MW <Nop>
omap <Char-0x10>MX <Nop>
omap <Char-0x10>MY <Nop>
omap <Char-0x10>MZ <Nop>
omap <Char-0x10>Ma <Nop>
omap <Char-0x10>Mb <Nop>
omap <Char-0x10>Mc <Nop>
omap <Char-0x10>Md <Nop>
omap <Char-0x10>Me <Nop>
omap <Char-0x10>Mf <Nop>
omap <Char-0x10>Mg <Nop>
omap <Char-0x10>Mh <Nop>
omap <Char-0x10>Mi <Nop>
omap <Char-0x10>Mj <Nop>
omap <Char-0x10>Mk <Nop>
omap <Char-0x10>Ml <Nop>
omap <Char-0x10>Mm <Nop>
omap <Char-0x10>Mn <Nop>
omap <Char-0x10>Mo <Nop>
omap <Char-0x10>Mp <Nop>
omap <Char-0x10>Mq <Nop>
omap <Char-0x10>Mr <Nop>
omap <Char-0x10>MG <Nop>
omap <Char-0x10>MH <Nop>
omap <Char-0x10>MI <Nop>
omap <Char-0x10>MJ <Nop>
omap <Char-0x10>MK <Nop>
omap <Char-0x10>ML <Nop>
omap <Char-0x10>MM <Nop>
omap <Char-0x10>MN <Nop>
omap <Char-0x10>MO <Nop>
omap <Char-0x10>MP <Nop>
" }}}

" Symbols [Ctrl + Super]{{{
omap <Char-0x10>MB <Nop>
omap <Char-0x10>Mt <Nop>
omap <Char-0x10>M1 <Nop>
omap <Char-0x10>MC <Nop>
omap <Char-0x10>M3 <Nop>
omap <Char-0x10>M- <Nop>
omap <Char-0x10>Mz <Nop>
omap <Char-0x10>MR <Nop>
omap <Char-0x10>My <Nop>
omap <Char-0x10>Mv <Nop>
omap <Char-0x10>Ms <Nop>
omap <Char-0x10>MD <Nop>
omap <Char-0x10>M! <Nop>
omap <Char-0x10>ME <Nop>
omap <Char-0x10>Mu <Nop>
omap <Char-0x10>MQ <Nop>
omap <Char-0x10>MF <Nop>
omap <Char-0x10>MA <Nop>
omap <Char-0x10>M0 <Nop>
omap <Char-0x10>Mw <Nop>
omap <Char-0x10>Mx <Nop>
omap <Char-0x10>M^ <Nop>
" }}}

" Function keys [Ctrl + Super]{{{
omap <Char-0x10>M/ <Nop>
omap <Char-0x10>M* <Nop>
omap <Char-0x10>M? <Nop>
omap <Char-0x10>M& <Nop>
omap <Char-0x10>M< <Nop>
omap <Char-0x10>M> <Nop>
omap <Char-0x10>M( <Nop>
omap <Char-0x10>M) <Nop>
omap <Char-0x10>M[ <Nop>
omap <Char-0x10>M] <Nop>
omap <Char-0x10>M{ <Nop>
omap <Char-0x10>M} <Nop>
omap <Char-0x10>M@ <Nop>
omap <Char-0x10>M% <Nop>
omap <Char-0x10>M$ <Nop>
omap <Char-0x10>M# <Nop>
omap <Char-0x10>MBA <Nop>
omap <Char-0x10>MBB <Nop>
omap <Char-0x10>MBC <Nop>
omap <Char-0x10>MBD <Nop>
omap <Char-0x10>MBE <Nop>
omap <Char-0x10>MBF <Nop>
omap <Char-0x10>MBG <Nop>
omap <Char-0x10>MBH <Nop>
omap <Char-0x10>MBI <Nop>
" }}}

" Modifiers [Ctrl + Super]{{{
omap <Char-0x10>M: <Nop>
omap <Char-0x10>M2 <Nop>
omap <Char-0x10>MBc <Nop>
omap <Char-0x10>MBb <Nop>
omap <Char-0x10>MBa <Nop>
omap <Char-0x10>MBd <Nop>
omap <Char-0x10>M= <Nop>
omap <Char-0x10>MBg <Nop>
omap <Char-0x10>MBf <Nop>
omap <Char-0x10>MBe <Nop>
omap <Char-0x10>MBh <Nop>
omap <Char-0x10>M+ <Nop>
" }}}

" Movement [Ctrl + Super]{{{
omap <Char-0x10>M6 <Nop>
omap <Char-0x10>M. <Nop>
omap <Char-0x10>M5 <Nop>
omap <Char-0x10>M9 <Nop>
omap <Char-0x10>M8 <Nop>
omap <Char-0x10>M4 <Nop>
omap <Char-0x10>M7 <Nop>
" }}}

" Numpad [Ctrl + Super]{{{
omap <Char-0x10>MBJ <Nop>
omap <Char-0x10>MBK <Nop>
omap <Char-0x10>MBL <Nop>
omap <Char-0x10>MBM <Nop>
omap <Char-0x10>MBN <Nop>
omap <Char-0x10>MBO <Nop>
omap <Char-0x10>MBP <Nop>
omap <Char-0x10>MBQ <Nop>
omap <Char-0x10>MBR <Nop>
omap <Char-0x10>MBS <Nop>
omap <Char-0x10>MBX <Nop>
omap <Char-0x10>MBT <Nop>
omap <Char-0x10>MBU <Nop>
omap <Char-0x10>MBY <Nop>
omap <Char-0x10>MBZ <Nop>
omap <Char-0x10>MBV <Nop>
omap <Char-0x10>MBW <Nop>
" }}}
" }}}
" Ctrl + Shift + Super [N]{{{
" Alphanumerics [Ctrl + Shift + Super]{{{
omap <Char-0x10>NS <Nop>
omap <Char-0x10>NT <Nop>
omap <Char-0x10>NU <Nop>
omap <Char-0x10>NV <Nop>
omap <Char-0x10>NW <Nop>
omap <Char-0x10>NX <Nop>
omap <Char-0x10>NY <Nop>
omap <Char-0x10>NZ <Nop>
omap <Char-0x10>Na <Nop>
omap <Char-0x10>Nb <Nop>
omap <Char-0x10>Nc <Nop>
omap <Char-0x10>Nd <Nop>
omap <Char-0x10>Ne <Nop>
omap <Char-0x10>Nf <Nop>
omap <Char-0x10>Ng <Nop>
omap <Char-0x10>Nh <Nop>
omap <Char-0x10>Ni <Nop>
omap <Char-0x10>Nj <Nop>
omap <Char-0x10>Nk <Nop>
omap <Char-0x10>Nl <Nop>
omap <Char-0x10>Nm <Nop>
omap <Char-0x10>Nn <Nop>
omap <Char-0x10>No <Nop>
omap <Char-0x10>Np <Nop>
omap <Char-0x10>Nq <Nop>
omap <Char-0x10>Nr <Nop>
omap <Char-0x10>NG <Nop>
omap <Char-0x10>NH <Nop>
omap <Char-0x10>NI <Nop>
omap <Char-0x10>NJ <Nop>
omap <Char-0x10>NK <Nop>
omap <Char-0x10>NL <Nop>
omap <Char-0x10>NM <Nop>
omap <Char-0x10>NN <Nop>
omap <Char-0x10>NO <Nop>
omap <Char-0x10>NP <Nop>
" }}}

" Symbols [Ctrl + Shift + Super]{{{
omap <Char-0x10>NB <Nop>
omap <Char-0x10>Nt <Nop>
omap <Char-0x10>N1 <Nop>
omap <Char-0x10>NC <Nop>
omap <Char-0x10>N3 <Nop>
omap <Char-0x10>N- <Nop>
omap <Char-0x10>Nz <Nop>
omap <Char-0x10>NR <Nop>
omap <Char-0x10>Ny <Nop>
omap <Char-0x10>Nv <Nop>
omap <Char-0x10>Ns <Nop>
omap <Char-0x10>ND <Nop>
omap <Char-0x10>N! <Nop>
omap <Char-0x10>NE <Nop>
omap <Char-0x10>Nu <Nop>
omap <Char-0x10>NQ <Nop>
omap <Char-0x10>NF <Nop>
omap <Char-0x10>NA <Nop>
omap <Char-0x10>N0 <Nop>
omap <Char-0x10>Nw <Nop>
omap <Char-0x10>Nx <Nop>
omap <Char-0x10>N^ <Nop>
" }}}

" Function keys [Ctrl + Shift + Super]{{{
omap <Char-0x10>N/ <Nop>
omap <Char-0x10>N* <Nop>
omap <Char-0x10>N? <Nop>
omap <Char-0x10>N& <Nop>
omap <Char-0x10>N< <Nop>
omap <Char-0x10>N> <Nop>
omap <Char-0x10>N( <Nop>
omap <Char-0x10>N) <Nop>
omap <Char-0x10>N[ <Nop>
omap <Char-0x10>N] <Nop>
omap <Char-0x10>N{ <Nop>
omap <Char-0x10>N} <Nop>
omap <Char-0x10>N@ <Nop>
omap <Char-0x10>N% <Nop>
omap <Char-0x10>N$ <Nop>
omap <Char-0x10>N# <Nop>
omap <Char-0x10>NBA <Nop>
omap <Char-0x10>NBB <Nop>
omap <Char-0x10>NBC <Nop>
omap <Char-0x10>NBD <Nop>
omap <Char-0x10>NBE <Nop>
omap <Char-0x10>NBF <Nop>
omap <Char-0x10>NBG <Nop>
omap <Char-0x10>NBH <Nop>
omap <Char-0x10>NBI <Nop>
" }}}

" Modifiers [Ctrl + Shift + Super]{{{
omap <Char-0x10>N: <Nop>
omap <Char-0x10>N2 <Nop>
omap <Char-0x10>NBc <Nop>
omap <Char-0x10>NBb <Nop>
omap <Char-0x10>NBa <Nop>
omap <Char-0x10>NBd <Nop>
omap <Char-0x10>N= <Nop>
omap <Char-0x10>NBg <Nop>
omap <Char-0x10>NBf <Nop>
omap <Char-0x10>NBe <Nop>
omap <Char-0x10>NBh <Nop>
omap <Char-0x10>N+ <Nop>
" }}}

" Movement [Ctrl + Shift + Super]{{{
omap <Char-0x10>N6 <Nop>
omap <Char-0x10>N. <Nop>
omap <Char-0x10>N5 <Nop>
omap <Char-0x10>N9 <Nop>
omap <Char-0x10>N8 <Nop>
omap <Char-0x10>N4 <Nop>
omap <Char-0x10>N7 <Nop>
" }}}

" Numpad [Ctrl + Shift + Super]{{{
omap <Char-0x10>NBJ <Nop>
omap <Char-0x10>NBK <Nop>
omap <Char-0x10>NBL <Nop>
omap <Char-0x10>NBM <Nop>
omap <Char-0x10>NBN <Nop>
omap <Char-0x10>NBO <Nop>
omap <Char-0x10>NBP <Nop>
omap <Char-0x10>NBQ <Nop>
omap <Char-0x10>NBR <Nop>
omap <Char-0x10>NBS <Nop>
omap <Char-0x10>NBX <Nop>
omap <Char-0x10>NBT <Nop>
omap <Char-0x10>NBU <Nop>
omap <Char-0x10>NBY <Nop>
omap <Char-0x10>NBZ <Nop>
omap <Char-0x10>NBV <Nop>
omap <Char-0x10>NBW <Nop>
" }}}
" }}}
" Alt + control + Super [O]{{{
" Alphanumerics [Alt + Ctrl + Super]{{{
omap <Char-0x10>OS <Nop>
omap <Char-0x10>OT <Nop>
omap <Char-0x10>OU <Nop>
omap <Char-0x10>OV <Nop>
omap <Char-0x10>OW <Nop>
omap <Char-0x10>OX <Nop>
omap <Char-0x10>OY <Nop>
omap <Char-0x10>OZ <Nop>
omap <Char-0x10>Oa <Nop>
omap <Char-0x10>Ob <Nop>
omap <Char-0x10>Oc <Nop>
omap <Char-0x10>Od <Nop>
omap <Char-0x10>Oe <Nop>
omap <Char-0x10>Of <Nop>
omap <Char-0x10>Og <Nop>
omap <Char-0x10>Oh <Nop>
omap <Char-0x10>Oi <Nop>
omap <Char-0x10>Oj <Nop>
omap <Char-0x10>Ok <Nop>
omap <Char-0x10>Ol <Nop>
omap <Char-0x10>Om <Nop>
omap <Char-0x10>On <Nop>
omap <Char-0x10>Oo <Nop>
omap <Char-0x10>Op <Nop>
omap <Char-0x10>Oq <Nop>
omap <Char-0x10>Or <Nop>
omap <Char-0x10>OG <Nop>
omap <Char-0x10>OH <Nop>
omap <Char-0x10>OI <Nop>
omap <Char-0x10>OJ <Nop>
omap <Char-0x10>OK <Nop>
omap <Char-0x10>OL <Nop>
omap <Char-0x10>OM <Nop>
omap <Char-0x10>ON <Nop>
omap <Char-0x10>OO <Nop>
omap <Char-0x10>OP <Nop>
" }}}

" Symbols [Alt + Ctrl + Super]{{{
omap <Char-0x10>OB <Nop>
omap <Char-0x10>Ot <Nop>
omap <Char-0x10>O1 <Nop>
omap <Char-0x10>OC <Nop>
omap <Char-0x10>O3 <Nop>
omap <Char-0x10>O- <Nop>
omap <Char-0x10>Oz <Nop>
omap <Char-0x10>OR <Nop>
omap <Char-0x10>Oy <Nop>
omap <Char-0x10>Ov <Nop>
omap <Char-0x10>Os <Nop>
omap <Char-0x10>OD <Nop>
omap <Char-0x10>O! <Nop>
omap <Char-0x10>OE <Nop>
omap <Char-0x10>Ou <Nop>
omap <Char-0x10>OQ <Nop>
omap <Char-0x10>OF <Nop>
omap <Char-0x10>OA <Nop>
omap <Char-0x10>O0 <Nop>
omap <Char-0x10>Ow <Nop>
omap <Char-0x10>Ox <Nop>
omap <Char-0x10>O^ <Nop>
" }}}

" Function keys [Alt + Ctrl + Super]{{{
omap <Char-0x10>O/ <Nop>
omap <Char-0x10>O* <Nop>
omap <Char-0x10>O? <Nop>
omap <Char-0x10>O& <Nop>
omap <Char-0x10>O< <Nop>
omap <Char-0x10>O> <Nop>
omap <Char-0x10>O( <Nop>
omap <Char-0x10>O) <Nop>
omap <Char-0x10>O[ <Nop>
omap <Char-0x10>O] <Nop>
omap <Char-0x10>O{ <Nop>
omap <Char-0x10>O} <Nop>
omap <Char-0x10>O@ <Nop>
omap <Char-0x10>O% <Nop>
omap <Char-0x10>O$ <Nop>
omap <Char-0x10>O# <Nop>
omap <Char-0x10>OBA <Nop>
omap <Char-0x10>OBB <Nop>
omap <Char-0x10>OBC <Nop>
omap <Char-0x10>OBD <Nop>
omap <Char-0x10>OBE <Nop>
omap <Char-0x10>OBF <Nop>
omap <Char-0x10>OBG <Nop>
omap <Char-0x10>OBH <Nop>
omap <Char-0x10>OBI <Nop>
" }}}

" Modifiers [Alt + Ctrl + Super]{{{
omap <Char-0x10>O: <Nop>
omap <Char-0x10>O2 <Nop>
omap <Char-0x10>OBc <Nop>
omap <Char-0x10>OBb <Nop>
omap <Char-0x10>OBa <Nop>
omap <Char-0x10>OBd <Nop>
omap <Char-0x10>O= <Nop>
omap <Char-0x10>OBg <Nop>
omap <Char-0x10>OBf <Nop>
omap <Char-0x10>OBe <Nop>
omap <Char-0x10>OBh <Nop>
omap <Char-0x10>O+ <Nop>
" }}}

" Movement [Alt + Ctrl + Super]{{{
omap <Char-0x10>O6 <Nop>
omap <Char-0x10>O. <Nop>
omap <Char-0x10>O5 <Nop>
omap <Char-0x10>O9 <Nop>
omap <Char-0x10>O8 <Nop>
omap <Char-0x10>O4 <Nop>
omap <Char-0x10>O7 <Nop>
" }}}

" Numpad [Alt + Ctrl + Super]{{{
omap <Char-0x10>OBJ <Nop>
omap <Char-0x10>OBK <Nop>
omap <Char-0x10>OBL <Nop>
omap <Char-0x10>OBM <Nop>
omap <Char-0x10>OBN <Nop>
omap <Char-0x10>OBO <Nop>
omap <Char-0x10>OBP <Nop>
omap <Char-0x10>OBQ <Nop>
omap <Char-0x10>OBR <Nop>
omap <Char-0x10>OBS <Nop>
omap <Char-0x10>OBX <Nop>
omap <Char-0x10>OBT <Nop>
omap <Char-0x10>OBU <Nop>
omap <Char-0x10>OBY <Nop>
omap <Char-0x10>OBZ <Nop>
omap <Char-0x10>OBV <Nop>
omap <Char-0x10>OBW <Nop>
" }}}
" }}}
" Alt + control + Shift + Super [P]{{{
" Alphanumerics [Alt + Ctrl + Shift + Super]{{{
omap <Char-0x10>PS <Nop>
omap <Char-0x10>PT <Nop>
omap <Char-0x10>PU <Nop>
omap <Char-0x10>PV <Nop>
omap <Char-0x10>PW <Nop>
omap <Char-0x10>PX <Nop>
omap <Char-0x10>PY <Nop>
omap <Char-0x10>PZ <Nop>
omap <Char-0x10>Pa <Nop>
omap <Char-0x10>Pb <Nop>
omap <Char-0x10>Pc <Nop>
omap <Char-0x10>Pd <Nop>
omap <Char-0x10>Pe <Nop>
omap <Char-0x10>Pf <Nop>
omap <Char-0x10>Pg <Nop>
omap <Char-0x10>Ph <Nop>
omap <Char-0x10>Pi <Nop>
omap <Char-0x10>Pj <Nop>
omap <Char-0x10>Pk <Nop>
omap <Char-0x10>Pl <Nop>
omap <Char-0x10>Pm <Nop>
omap <Char-0x10>Pn <Nop>
omap <Char-0x10>Po <Nop>
omap <Char-0x10>Pp <Nop>
omap <Char-0x10>Pq <Nop>
omap <Char-0x10>Pr <Nop>
omap <Char-0x10>PG <Nop>
omap <Char-0x10>PH <Nop>
omap <Char-0x10>PI <Nop>
omap <Char-0x10>PJ <Nop>
omap <Char-0x10>PK <Nop>
omap <Char-0x10>PL <Nop>
omap <Char-0x10>PM <Nop>
omap <Char-0x10>PN <Nop>
omap <Char-0x10>PO <Nop>
omap <Char-0x10>PP <Nop>
" }}}

" Symbols [Alt + Ctrl + Shift + Super]{{{
omap <Char-0x10>PB <Nop>
omap <Char-0x10>Pt <Nop>
omap <Char-0x10>P1 <Nop>
omap <Char-0x10>PC <Nop>
omap <Char-0x10>P3 <Nop>
omap <Char-0x10>P- <Nop>
omap <Char-0x10>Pz <Nop>
omap <Char-0x10>PR <Nop>
omap <Char-0x10>Py <Nop>
omap <Char-0x10>Pv <Nop>
omap <Char-0x10>Ps <Nop>
omap <Char-0x10>PD <Nop>
omap <Char-0x10>P! <Nop>
omap <Char-0x10>PE <Nop>
omap <Char-0x10>Pu <Nop>
omap <Char-0x10>PQ <Nop>
omap <Char-0x10>PF <Nop>
omap <Char-0x10>PA <Nop>
omap <Char-0x10>P0 <Nop>
omap <Char-0x10>Pw <Nop>
omap <Char-0x10>Px <Nop>
omap <Char-0x10>P^ <Nop>
" }}}

" Function keys [Alt + Ctrl + Shift + Super]{{{
omap <Char-0x10>p/ <Nop>
omap <Char-0x10>p* <Nop>
omap <Char-0x10>p? <Nop>
omap <Char-0x10>p& <Nop>
omap <Char-0x10>p< <Nop>
omap <Char-0x10>p> <Nop>
omap <Char-0x10>p( <Nop>
omap <Char-0x10>p) <Nop>
omap <Char-0x10>p[ <Nop>
omap <Char-0x10>p] <Nop>
omap <Char-0x10>p{ <Nop>
omap <Char-0x10>p} <Nop>
omap <Char-0x10>p@ <Nop>
omap <Char-0x10>p% <Nop>
omap <Char-0x10>p$ <Nop>
omap <Char-0x10>p# <Nop>
omap <Char-0x10>pba <Nop>
omap <Char-0x10>pbb <Nop>
omap <Char-0x10>pbc <Nop>
omap <Char-0x10>pbd <Nop>
omap <Char-0x10>pbe <Nop>
omap <Char-0x10>pbf <Nop>
omap <Char-0x10>pbg <Nop>
omap <Char-0x10>pbh <Nop>
omap <Char-0x10>pbi <Nop>
" }}}

" Modifiers [Alt + Ctrl + Shift + Super]{{{
omap <Char-0x10>P: <Nop>
omap <Char-0x10>P2 <Nop>
omap <Char-0x10>PBc <Nop>
omap <Char-0x10>PBb <Nop>
omap <Char-0x10>PBa <Nop>
omap <Char-0x10>PBd <Nop>
omap <Char-0x10>P= <Nop>
omap <Char-0x10>PBg <Nop>
omap <Char-0x10>PBf <Nop>
omap <Char-0x10>PBe <Nop>
omap <Char-0x10>PBh <Nop>
omap <Char-0x10>P+ <Nop>
" }}}

" Movement [Alt + Ctrl + Shift + Super]{{{
omap <Char-0x10>P6 <Nop>
omap <Char-0x10>P. <Nop>
omap <Char-0x10>P5 <Nop>
omap <Char-0x10>P9 <Nop>
omap <Char-0x10>P8 <Nop>
omap <Char-0x10>P4 <Nop>
omap <Char-0x10>P7 <Nop>
" }}}

" Numpad [Alt + Ctrl + Shift +  Super]{{{
omap <Char-0x10>PBJ <Nop>
omap <Char-0x10>PBK <Nop>
omap <Char-0x10>PBL <Nop>
omap <Char-0x10>PBM <Nop>
omap <Char-0x10>PBN <Nop>
omap <Char-0x10>PBO <Nop>
omap <Char-0x10>PBP <Nop>
omap <Char-0x10>PBQ <Nop>
omap <Char-0x10>PBR <Nop>
omap <Char-0x10>PBS <Nop>
omap <Char-0x10>PBX <Nop>
omap <Char-0x10>PBT <Nop>
omap <Char-0x10>PBU <Nop>
omap <Char-0x10>PBY <Nop>
omap <Char-0x10>PBZ <Nop>
omap <Char-0x10>PBV <Nop>
omap <Char-0x10>PBW <Nop>
" }}}
" }}}
" }}}

" Insert {{{
" Shift - Special keys [B] {{{
imap <Char-0x10>Bz <Nop>
imap <Char-0x10>B1 <Nop>
imap <Char-0x10>By <Nop>
" }}}
" Ctrl - Special keys [E] {{{
imap <Char-0x10>Ez <Nop>
imap <Char-0x10>E1 <Nop>
imap <Char-0x10>Ey <Nop>
"imap <Char-0x10>E0 <Nop>
" Ctrl + Tab : Move tab
" }}}
" Ctrl + Shift [F]{{{
" Alphanumerics [Ctrl + Shift]{{{
imap <Char-0x10>FS <Nop>
imap <Char-0x10>FT <Nop>
imap <Char-0x10>FU <Nop>
imap <Char-0x10>FV <Nop>
imap <Char-0x10>FW <Nop>
imap <Char-0x10>FX <Nop>
imap <Char-0x10>FY <Nop>
imap <Char-0x10>FZ <Nop>
imap <Char-0x10>Fa <Nop>
imap <Char-0x10>Fb <Nop>
imap <Char-0x10>Fc <Nop>
imap <Char-0x10>Fd <Nop>
imap <Char-0x10>Fe <Nop>
imap <Char-0x10>Ff <Nop>
imap <Char-0x10>Fg <Nop>
"imap <Char-0x10>Fh <Nop>
" Ctrl + Shift + p : Paste Mode
imap <Char-0x10>Fi <Nop>
imap <Char-0x10>Fj <Nop>
imap <Char-0x10>Fk <Nop>
imap <Char-0x10>Fl <Nop>
imap <Char-0x10>Fm <Nop>
imap <Char-0x10>Fn <Nop>
imap <Char-0x10>Fo <Nop>
imap <Char-0x10>Fp <Nop>
imap <Char-0x10>Fq <Nop>
imap <Char-0x10>Fr <Nop>
imap <Char-0x10>FG <Nop>
imap <Char-0x10>FH <Nop>
imap <Char-0x10>FI <Nop>
imap <Char-0x10>FJ <Nop>
imap <Char-0x10>FK <Nop>
imap <Char-0x10>FL <Nop>
imap <Char-0x10>FM <Nop>
imap <Char-0x10>FN <Nop>
imap <Char-0x10>FO <Nop>
imap <Char-0x10>FP <Nop>
" }}}

" Symbols [Ctrl + Shift]{{{
imap <Char-0x10>FB <Nop>
imap <Char-0x10>Ft <Nop>
imap <Char-0x10>F1 <Nop>
imap <Char-0x10>FC <Nop>
imap <Char-0x10>F3 <Nop>
imap <Char-0x10>F- <Nop>
imap <Char-0x10>Fz <Nop>
imap <Char-0x10>FR <Nop>
imap <Char-0x10>Fy <Nop>
imap <Char-0x10>Fv <Nop>
imap <Char-0x10>Fs <Nop>
imap <Char-0x10>FD <Nop>
imap <Char-0x10>F! <Nop>
imap <Char-0x10>FE <Nop>
imap <Char-0x10>Fu <Nop>
imap <Char-0x10>FQ <Nop>
imap <Char-0x10>FF <Nop>
imap <Char-0x10>FA <Nop>
"imap <Char-0x10>F0 <Nop>
imap <Char-0x10>Fw <Nop>
imap <Char-0x10>Fx <Nop>
imap <Char-0x10>F^ <Nop>
" }}}

" Function keys [Ctrl + Shift]{{{
imap <Char-0x10>F/ <Nop>
imap <Char-0x10>F* <Nop>
imap <Char-0x10>F? <Nop>
imap <Char-0x10>F& <Nop>
imap <Char-0x10>F< <Nop>
imap <Char-0x10>F> <Nop>
imap <Char-0x10>F( <Nop>
imap <Char-0x10>F) <Nop>
imap <Char-0x10>F[ <Nop>
imap <Char-0x10>F] <Nop>
imap <Char-0x10>F{ <Nop>
imap <Char-0x10>F} <Nop>
imap <Char-0x10>F@ <Nop>
imap <Char-0x10>F% <Nop>
imap <Char-0x10>F$ <Nop>
imap <Char-0x10>F# <Nop>
imap <Char-0x10>FBA <Nop>
imap <Char-0x10>FBB <Nop>
imap <Char-0x10>FBC <Nop>
imap <Char-0x10>FBD <Nop>
imap <Char-0x10>FBE <Nop>
imap <Char-0x10>FBF <Nop>
imap <Char-0x10>FBG <Nop>
imap <Char-0x10>FBH <Nop>
imap <Char-0x10>FBI <Nop>
" }}}

" Modifiers / modes etc [Ctrl + Shift]{{{
imap <Char-0x10>F: <Nop>
imap <Char-0x10>F2 <Nop>
imap <Char-0x10>FBc <Nop>
imap <Char-0x10>FBb <Nop>
imap <Char-0x10>FBa <Nop>
imap <Char-0x10>FBd <Nop>
imap <Char-0x10>F= <Nop>
imap <Char-0x10>FBg <Nop>
imap <Char-0x10>FBf <Nop>
imap <Char-0x10>FBe <Nop>
imap <Char-0x10>FBh <Nop>
imap <Char-0x10>F+ <Nop>
" }}}

" Movement [Ctrl + Shift]{{{
imap <Char-0x10>F6 <Nop>
imap <Char-0x10>F. <Nop>
imap <Char-0x10>F5 <Nop>
imap <Char-0x10>F9 <Nop>
imap <Char-0x10>F8 <Nop>
imap <Char-0x10>F4 <Nop>
imap <Char-0x10>F7 <Nop>
" }}}

" Numpad [Ctrl + Shift]{{{
imap <Char-0x10>FBJ <Nop>
imap <Char-0x10>FBK <Nop>
imap <Char-0x10>FBL <Nop>
imap <Char-0x10>FBM <Nop>
imap <Char-0x10>FBN <Nop>
imap <Char-0x10>FBO <Nop>
imap <Char-0x10>FBP <Nop>
imap <Char-0x10>FBQ <Nop>
imap <Char-0x10>FBR <Nop>
imap <Char-0x10>FBS <Nop>
imap <Char-0x10>FBX <Nop>
imap <Char-0x10>FBT <Nop>
imap <Char-0x10>FBU <Nop>
imap <Char-0x10>FBY <Nop>
imap <Char-0x10>FBZ <Nop>
imap <Char-0x10>FBV <Nop>
imap <Char-0x10>FBW <Nop>
" }}}
" }}}
" Alt + Ctrl [G]{{{
" Alphanumerics [Alt + Ctrl]{{{
imap <Char-0x10>GS <Nop>
imap <Char-0x10>GT <Nop>
imap <Char-0x10>GU <Nop>
imap <Char-0x10>GV <Nop>
imap <Char-0x10>GW <Nop>
imap <Char-0x10>GX <Nop>
imap <Char-0x10>GY <Nop>
imap <Char-0x10>GZ <Nop>
imap <Char-0x10>Ga <Nop>
imap <Char-0x10>Gb <Nop>
imap <Char-0x10>Gc <Nop>
imap <Char-0x10>Gd <Nop>
imap <Char-0x10>Ge <Nop>
imap <Char-0x10>Gf <Nop>
imap <Char-0x10>Gg <Nop>
"imap <Char-0x10>Gh <Nop>
" Ctrl + Alt + p : Paste & jump
imap <Char-0x10>Gi <Nop>
imap <Char-0x10>Gj <Nop>
imap <Char-0x10>Gk <Nop>
imap <Char-0x10>Gl <Nop>
imap <Char-0x10>Gm <Nop>
imap <Char-0x10>Gn <Nop>
imap <Char-0x10>Go <Nop>
imap <Char-0x10>Gp <Nop>
imap <Char-0x10>Gq <Nop>
imap <Char-0x10>Gr <Nop>
imap <Char-0x10>GG <Nop>
imap <Char-0x10>GH <Nop>
imap <Char-0x10>GI <Nop>
imap <Char-0x10>GJ <Nop>
imap <Char-0x10>GK <Nop>
imap <Char-0x10>GL <Nop>
imap <Char-0x10>GM <Nop>
imap <Char-0x10>GN <Nop>
imap <Char-0x10>GO <Nop>
imap <Char-0x10>GP <Nop>
" }}}

" Symbols [Alt + Ctrl]{{{
imap <Char-0x10>GB <Nop>
imap <Char-0x10>Gt <Nop>
imap <Char-0x10>G1 <Nop>
imap <Char-0x10>GC <Nop>
imap <Char-0x10>G3 <Nop>
imap <Char-0x10>G- <Nop>
imap <Char-0x10>Gz <Nop>
imap <Char-0x10>GR <Nop> up/down
" Ctrl + Alt + = : Resize window up/down
imap <Char-0x10>Gy <Nop>
imap <Char-0x10>Gv <Nop>
imap <Char-0x10>Gs <Nop>
imap <Char-0x10>GD <Nop>
" Ctrl + Alt + = : Resize window up/down
imap <Char-0x10>G! <Nop>
imap <Char-0x10>GE <Nop>
imap <Char-0x10>Gu <Nop>
imap <Char-0x10>GQ <Nop>
imap <Char-0x10>GF <Nop>
imap <Char-0x10>GA <Nop>
imap <Char-0x10>G0 <Nop>
imap <Char-0x10>Gw <Nop>
imap <Char-0x10>Gx <Nop>
imap <Char-0x10>G^ <Nop>
" }}}

" Function keys [Alt + Ctrl]{{{
imap <Char-0x10>G/ <Nop>
imap <Char-0x10>G* <Nop>
imap <Char-0x10>G? <Nop>
imap <Char-0x10>G& <Nop>
imap <Char-0x10>G< <Nop>
imap <Char-0x10>G> <Nop>
imap <Char-0x10>G( <Nop>
imap <Char-0x10>G) <Nop>
imap <Char-0x10>G[ <Nop>
imap <Char-0x10>G] <Nop>
imap <Char-0x10>G{ <Nop>
imap <Char-0x10>G} <Nop>
imap <Char-0x10>G@ <Nop>
imap <Char-0x10>G% <Nop>
imap <Char-0x10>G$ <Nop>
imap <Char-0x10>G# <Nop>
imap <Char-0x10>GBA <Nop>
imap <Char-0x10>GBB <Nop>
imap <Char-0x10>GBC <Nop>
imap <Char-0x10>GBD <Nop>
imap <Char-0x10>GBE <Nop>
imap <Char-0x10>GBF <Nop>
imap <Char-0x10>GBG <Nop>
imap <Char-0x10>GBH <Nop>
imap <Char-0x10>GBI <Nop>
" }}}

" Modifiers [Alt + Ctrl]{{{
imap <Char-0x10>G: <Nop>
imap <Char-0x10>G2 <Nop>
imap <Char-0x10>GBc <Nop>
imap <Char-0x10>GBb <Nop>
imap <Char-0x10>GBa <Nop>
imap <Char-0x10>GBd <Nop>
imap <Char-0x10>G= <Nop>
imap <Char-0x10>GBg <Nop>
imap <Char-0x10>GBf <Nop>
imap <Char-0x10>GBe <Nop>
imap <Char-0x10>GBh <Nop>
imap <Char-0x10>G+ <Nop>
" }}}

" Movement [Alt + Ctrl]{{{
imap <Char-0x10>G6 <Nop>
imap <Char-0x10>G. <Nop>
imap <Char-0x10>G5 <Nop>
imap <Char-0x10>G9 <Nop>
imap <Char-0x10>G8 <Nop>
imap <Char-0x10>G4 <Nop>
imap <Char-0x10>G7 <Nop>
" }}}

" Numpad [Alt + Ctrl]{{{
imap <Char-0x10>GBJ <Nop>
imap <Char-0x10>GBK <Nop>
imap <Char-0x10>GBL <Nop>
imap <Char-0x10>GBM <Nop>
imap <Char-0x10>GBN <Nop>
imap <Char-0x10>GBO <Nop>
imap <Char-0x10>GBP <Nop>
imap <Char-0x10>GBQ <Nop>
imap <Char-0x10>GBR <Nop>
imap <Char-0x10>GBS <Nop>
imap <Char-0x10>GBX <Nop>
imap <Char-0x10>GBT <Nop>
imap <Char-0x10>GBU <Nop>
imap <Char-0x10>GBY <Nop>
imap <Char-0x10>GBZ <Nop>
imap <Char-0x10>GBV <Nop>
imap <Char-0x10>GBW <Nop>
" }}}
" }}}
" Alt + Ctrl + Shift [H]{{{
" Alphanumerics [Alt + Ctrl + Shift]{{{
imap <Char-0x10>HS <Nop>
imap <Char-0x10>HT <Nop>
imap <Char-0x10>HU <Nop>
imap <Char-0x10>HV <Nop>
imap <Char-0x10>HW <Nop>
imap <Char-0x10>HX <Nop>
imap <Char-0x10>HY <Nop>
imap <Char-0x10>HZ <Nop>
imap <Char-0x10>Ha <Nop>
imap <Char-0x10>Hb <Nop>
imap <Char-0x10>Hc <Nop>
imap <Char-0x10>Hd <Nop>
imap <Char-0x10>He <Nop>
imap <Char-0x10>Hf <Nop>
imap <Char-0x10>Hg <Nop>
imap <Char-0x10>Hh <Nop>
imap <Char-0x10>Hi <Nop>
imap <Char-0x10>Hj <Nop>
imap <Char-0x10>Hk <Nop>
imap <Char-0x10>Hl <Nop>
imap <Char-0x10>Hm <Nop>
imap <Char-0x10>Hn <Nop>
imap <Char-0x10>Ho <Nop>
imap <Char-0x10>Hp <Nop>
imap <Char-0x10>Hq <Nop>
imap <Char-0x10>Hr <Nop>
imap <Char-0x10>HG <Nop>
imap <Char-0x10>HH <Nop>
imap <Char-0x10>HI <Nop>
imap <Char-0x10>HJ <Nop>
imap <Char-0x10>HK <Nop>
imap <Char-0x10>HL <Nop>
imap <Char-0x10>HM <Nop>
imap <Char-0x10>HN <Nop>
imap <Char-0x10>HO <Nop>
imap <Char-0x10>HP <Nop>
" }}}

" Symbols [Alt + Ctrl + Shift]{{{
imap <Char-0x10>HB <Nop>
imap <Char-0x10>Ht <Nop>
imap <Char-0x10>H1 <Nop>
imap <Char-0x10>HC <Nop>
imap <Char-0x10>H3 <Nop>
imap <Char-0x10>H- <Nop>
imap <Char-0x10>Hz <Nop>
"imap <Char-0x10>HR <Nop>
" Ctrl + Alt + _ : Resize window up/down
imap <Char-0x10>Hy <Nop>
imap <Char-0x10>Hv <Nop>
imap <Char-0x10>Hs <Nop>
"imap <Char-0x10>HD <Nop>
" Ctrl + Alt + + : Resize window up/down
imap <Char-0x10>H! <Nop>
imap <Char-0x10>HE <Nop>
imap <Char-0x10>Hu <Nop>
imap <Char-0x10>HQ <Nop>
imap <Char-0x10>HF <Nop>
imap <Char-0x10>HA <Nop>
imap <Char-0x10>H0 <Nop>
imap <Char-0x10>Hw <Nop>
imap <Char-0x10>Hx <Nop>
imap <Char-0x10>H^ <Nop>
" }}}

" Function keys [Alt + Ctrl + Shift]{{{
imap <Char-0x10>H/ <Nop>
imap <Char-0x10>H* <Nop>
imap <Char-0x10>H? <Nop>
imap <Char-0x10>H& <Nop>
imap <Char-0x10>H< <Nop>
imap <Char-0x10>H> <Nop>
imap <Char-0x10>H( <Nop>
imap <Char-0x10>H) <Nop>
imap <Char-0x10>H[ <Nop>
imap <Char-0x10>H] <Nop>
imap <Char-0x10>H{ <Nop>
imap <Char-0x10>H} <Nop>
imap <Char-0x10>H@ <Nop>
imap <Char-0x10>H% <Nop>
imap <Char-0x10>H$ <Nop>
imap <Char-0x10>H# <Nop>
imap <Char-0x10>HBA <Nop>
imap <Char-0x10>HBB <Nop>
imap <Char-0x10>HBC <Nop>
imap <Char-0x10>HBD <Nop>
imap <Char-0x10>HBE <Nop>
imap <Char-0x10>HBF <Nop>
imap <Char-0x10>HBG <Nop>
imap <Char-0x10>HBH <Nop>
imap <Char-0x10>HBI <Nop>
" }}}

" Modifiers [Alt + Ctrl + Shift]{{{
imap <Char-0x10>H: <Nop>
imap <Char-0x10>H2 <Nop>
imap <Char-0x10>HBc <Nop>
imap <Char-0x10>HBb <Nop>
imap <Char-0x10>HBa <Nop>
imap <Char-0x10>HBd <Nop>
imap <Char-0x10>H= <Nop>
imap <Char-0x10>HBg <Nop>
imap <Char-0x10>HBf <Nop>
imap <Char-0x10>HBe <Nop>
imap <Char-0x10>HBh <Nop>
imap <Char-0x10>H+ <Nop>
" }}}

" Movement [Alt + Ctrl + Shift]{{{
imap <Char-0x10>H6 <Nop>
imap <Char-0x10>H. <Nop>
imap <Char-0x10>H5 <Nop>
imap <Char-0x10>H9 <Nop>
imap <Char-0x10>H8 <Nop>
imap <Char-0x10>H4 <Nop>
imap <Char-0x10>H7 <Nop>
" }}}

" Numpad [Alt + Ctrl + Shift]{{{
imap <Char-0x10>HBJ <Nop>
imap <Char-0x10>HBK <Nop>
imap <Char-0x10>HBL <Nop>
imap <Char-0x10>HBM <Nop>
imap <Char-0x10>HBN <Nop>
imap <Char-0x10>HBO <Nop>
imap <Char-0x10>HBP <Nop>
imap <Char-0x10>HBQ <Nop>
imap <Char-0x10>HBR <Nop>
imap <Char-0x10>HBS <Nop>
imap <Char-0x10>HBX <Nop>
imap <Char-0x10>HBT <Nop>
imap <Char-0x10>HBU <Nop>
imap <Char-0x10>HBY <Nop>
imap <Char-0x10>HBZ <Nop>
imap <Char-0x10>HBV <Nop>
imap <Char-0x10>HBW <Nop>
" }}}
" }}}
" Super [I]{{{
" Alphanumerics [Super]{{{
imap <Char-0x10>IS <Nop>
imap <Char-0x10>IT <Nop>
imap <Char-0x10>IU <Nop>
imap <Char-0x10>IV <Nop>
imap <Char-0x10>IW <Nop>
imap <Char-0x10>IX <Nop>
imap <Char-0x10>IY <Nop>
imap <Char-0x10>IZ <Nop>
imap <Char-0x10>Ia <Nop>
imap <Char-0x10>Ib <Nop>
imap <Char-0x10>Ic <Nop>
imap <Char-0x10>Id <Nop>
imap <Char-0x10>Ie <Nop>
imap <Char-0x10>If <Nop>
imap <Char-0x10>Ig <Nop>
imap <Char-0x10>Ih <Nop>
imap <Char-0x10>Ii <Nop>
imap <Char-0x10>Ij <Nop>
imap <Char-0x10>Ik <Nop>
imap <Char-0x10>Il <Nop>
imap <Char-0x10>Im <Nop>
imap <Char-0x10>In <Nop>
imap <Char-0x10>Io <Nop>
imap <Char-0x10>Ip <Nop>
imap <Char-0x10>Iq <Nop>
imap <Char-0x10>Ir <Nop>
imap <Char-0x10>IG <Nop>
imap <Char-0x10>IH <Nop>
imap <Char-0x10>II <Nop>
imap <Char-0x10>IJ <Nop>
imap <Char-0x10>IK <Nop>
imap <Char-0x10>IL <Nop>
imap <Char-0x10>IM <Nop>
imap <Char-0x10>IN <Nop>
imap <Char-0x10>IO <Nop>
imap <Char-0x10>IP <Nop>
" }}}

" Symbols [Super]{{{
imap <Char-0x10>IB <Nop>
imap <Char-0x10>It <Nop>
imap <Char-0x10>I1 <Nop>
imap <Char-0x10>IC <Nop>
imap <Char-0x10>I3 <Nop>
imap <Char-0x10>I- <Nop>
imap <Char-0x10>Iz <Nop>
imap <Char-0x10>IR <Nop>
imap <Char-0x10>Iy <Nop>
imap <Char-0x10>Iv <Nop>
imap <Char-0x10>Is <Nop>
imap <Char-0x10>ID <Nop>
imap <Char-0x10>I! <Nop>
imap <Char-0x10>IE <Nop>
imap <Char-0x10>Iu <Nop>
imap <Char-0x10>IQ <Nop>
imap <Char-0x10>IF <Nop>
imap <Char-0x10>IA <Nop>
imap <Char-0x10>I0 <Nop>
imap <Char-0x10>Iw <Nop>
imap <Char-0x10>Ix <Nop>
imap <Char-0x10>I^ <Nop>
" }}}

" Function keys [Super]{{{
imap <Char-0x10>I/ <Nop>
imap <Char-0x10>I* <Nop>
imap <Char-0x10>I? <Nop>
imap <Char-0x10>I& <Nop>
imap <Char-0x10>I< <Nop>
imap <Char-0x10>I> <Nop>
imap <Char-0x10>I( <Nop>
imap <Char-0x10>I) <Nop>
imap <Char-0x10>I[ <Nop>
imap <Char-0x10>I] <Nop>
imap <Char-0x10>I{ <Nop>
imap <Char-0x10>I} <Nop>
imap <Char-0x10>I@ <Nop>
imap <Char-0x10>I% <Nop>
imap <Char-0x10>I$ <Nop>
imap <Char-0x10>I# <Nop>
imap <Char-0x10>IBA <Nop>
imap <Char-0x10>IBB <Nop>
imap <Char-0x10>IBC <Nop>
imap <Char-0x10>IBD <Nop>
imap <Char-0x10>IBE <Nop>
imap <Char-0x10>IBF <Nop>
imap <Char-0x10>IBG <Nop>
imap <Char-0x10>IBH <Nop>
imap <Char-0x10>IBI <Nop>
" }}}

" Modifiers [Super]{{{
imap <Char-0x10>I: <Nop>
imap <Char-0x10>I2 <Nop>
imap <Char-0x10>IBc <Nop>
imap <Char-0x10>IBb <Nop>
imap <Char-0x10>IBa <Nop>
imap <Char-0x10>IBd <Nop>
imap <Char-0x10>I= <Nop>
imap <Char-0x10>IBg <Nop>
imap <Char-0x10>IBf <Nop>
imap <Char-0x10>IBe <Nop>
imap <Char-0x10>IBh <Nop>
imap <Char-0x10>I+ <Nop>
" }}}

" Movement [Super]{{{
imap <Char-0x10>I6 <Nop>
imap <Char-0x10>I. <Nop>
imap <Char-0x10>I5 <Nop>
imap <Char-0x10>I9 <Nop>
imap <Char-0x10>I8 <Nop>
imap <Char-0x10>I4 <Nop>
imap <Char-0x10>I7 <Nop>
" }}}

" Numpad [Super]{{{
imap <Char-0x10>IBJ <Nop>
imap <Char-0x10>IBK <Nop>
imap <Char-0x10>IBL <Nop>
imap <Char-0x10>IBM <Nop>
imap <Char-0x10>IBN <Nop>
imap <Char-0x10>IBO <Nop>
imap <Char-0x10>IBP <Nop>
imap <Char-0x10>IBQ <Nop>
imap <Char-0x10>IBR <Nop>
imap <Char-0x10>IBS <Nop>
imap <Char-0x10>IBX <Nop>
imap <Char-0x10>IBT <Nop>
imap <Char-0x10>IBU <Nop>
imap <Char-0x10>IBY <Nop>
imap <Char-0x10>IBZ <Nop>
imap <Char-0x10>IBV <Nop>
imap <Char-0x10>IBW <Nop>
" }}}
" }}}
" Shift + Super [J]{{{
" Alphanumerics [Shift + Super]{{{
imap <Char-0x10>JS <Nop>
imap <Char-0x10>JT <Nop>
imap <Char-0x10>JU <Nop>
imap <Char-0x10>JV <Nop>
imap <Char-0x10>JW <Nop>
imap <Char-0x10>JX <Nop>
imap <Char-0x10>JY <Nop>
imap <Char-0x10>JZ <Nop>
imap <Char-0x10>Ja <Nop>
imap <Char-0x10>Jb <Nop>
imap <Char-0x10>Jc <Nop>
imap <Char-0x10>Jd <Nop>
imap <Char-0x10>Je <Nop>
imap <Char-0x10>Jf <Nop>
imap <Char-0x10>Jg <Nop>
imap <Char-0x10>Jh <Nop>
imap <Char-0x10>Ji <Nop>
imap <Char-0x10>Jj <Nop>
imap <Char-0x10>Jk <Nop>
imap <Char-0x10>Jl <Nop>
imap <Char-0x10>Jm <Nop>
imap <Char-0x10>Jn <Nop>
imap <Char-0x10>Jo <Nop>
imap <Char-0x10>Jp <Nop>
imap <Char-0x10>Jq <Nop>
imap <Char-0x10>Jr <Nop>
imap <Char-0x10>JG <Nop>
imap <Char-0x10>JH <Nop>
imap <Char-0x10>JI <Nop>
imap <Char-0x10>JJ <Nop>
imap <Char-0x10>JK <Nop>
imap <Char-0x10>JL <Nop>
imap <Char-0x10>JM <Nop>
imap <Char-0x10>JN <Nop>
imap <Char-0x10>JO <Nop>
imap <Char-0x10>JP <Nop>
" }}}

" Symbols [Shift + Super]{{{
imap <Char-0x10>JB <Nop>
imap <Char-0x10>Jt <Nop>
imap <Char-0x10>J1 <Nop>
imap <Char-0x10>JC <Nop>
imap <Char-0x10>J3 <Nop>
imap <Char-0x10>J- <Nop>
imap <Char-0x10>Jz <Nop>
imap <Char-0x10>JR <Nop>
imap <Char-0x10>Jy <Nop>
imap <Char-0x10>Jv <Nop>
imap <Char-0x10>Js <Nop>
imap <Char-0x10>JD <Nop>
imap <Char-0x10>J! <Nop>
imap <Char-0x10>JE <Nop>
imap <Char-0x10>Ju <Nop>
imap <Char-0x10>JQ <Nop>
imap <Char-0x10>JF <Nop>
imap <Char-0x10>JA <Nop>
imap <Char-0x10>J0 <Nop>
imap <Char-0x10>Jw <Nop>
imap <Char-0x10>Jx <Nop>
imap <Char-0x10>J^ <Nop>
" }}}

" Function keys [Shift + Super]{{{
imap <Char-0x10>J/ <Nop>
imap <Char-0x10>J* <Nop>
imap <Char-0x10>J? <Nop>
imap <Char-0x10>J& <Nop>
imap <Char-0x10>J< <Nop>
imap <Char-0x10>J> <Nop>
imap <Char-0x10>J( <Nop>
imap <Char-0x10>J) <Nop>
imap <Char-0x10>J[ <Nop>
imap <Char-0x10>J] <Nop>
imap <Char-0x10>J{ <Nop>
imap <Char-0x10>J} <Nop>
imap <Char-0x10>J@ <Nop>
imap <Char-0x10>J% <Nop>
imap <Char-0x10>J$ <Nop>
imap <Char-0x10>J# <Nop>
imap <Char-0x10>JBA <Nop>
imap <Char-0x10>JBB <Nop>
imap <Char-0x10>JBC <Nop>
imap <Char-0x10>JBD <Nop>
imap <Char-0x10>JBE <Nop>
imap <Char-0x10>JBF <Nop>
imap <Char-0x10>JBG <Nop>
imap <Char-0x10>JBH <Nop>
imap <Char-0x10>JBI <Nop>
" }}}

" Modifiers [Shift + Super]{{{
imap <Char-0x10>J: <Nop>
imap <Char-0x10>J2 <Nop>
imap <Char-0x10>JBc <Nop>
imap <Char-0x10>JBb <Nop>
imap <Char-0x10>JBa <Nop>
imap <Char-0x10>JBd <Nop>
imap <Char-0x10>J= <Nop>
imap <Char-0x10>JBg <Nop>
imap <Char-0x10>JBf <Nop>
imap <Char-0x10>JBe <Nop>
imap <Char-0x10>JBh <Nop>
imap <Char-0x10>J+ <Nop>
" }}}

" Movement [Shift + Super]{{{
imap <Char-0x10>J6 <Nop>
imap <Char-0x10>J. <Nop>
imap <Char-0x10>J5 <Nop>
imap <Char-0x10>J9 <Nop>
imap <Char-0x10>J8 <Nop>
imap <Char-0x10>J4 <Nop>
imap <Char-0x10>J7 <Nop>
" }}}

" Numpad [Shift + Super]{{{
imap <Char-0x10>JBJ <Nop>
imap <Char-0x10>JBK <Nop>
imap <Char-0x10>JBL <Nop>
imap <Char-0x10>JBM <Nop>
imap <Char-0x10>JBN <Nop>
imap <Char-0x10>JBO <Nop>
imap <Char-0x10>JBP <Nop>
imap <Char-0x10>JBQ <Nop>
imap <Char-0x10>JBR <Nop>
imap <Char-0x10>JBS <Nop>
imap <Char-0x10>JBX <Nop>
imap <Char-0x10>JBT <Nop>
imap <Char-0x10>JBU <Nop>
imap <Char-0x10>JBY <Nop>
imap <Char-0x10>JBZ <Nop>
imap <Char-0x10>JBV <Nop>
imap <Char-0x10>JBW <Nop>
" }}}
" }}}
" Alt + Super [K]{{{
" Alphanumerics [Alt + Super]{{{
imap <Char-0x10>KS <Nop>
imap <Char-0x10>KT <Nop>
imap <Char-0x10>KU <Nop>
imap <Char-0x10>KV <Nop>
imap <Char-0x10>KW <Nop>
imap <Char-0x10>KX <Nop>
imap <Char-0x10>KY <Nop>
imap <Char-0x10>KZ <Nop>
imap <Char-0x10>Ka <Nop>
imap <Char-0x10>Kb <Nop>
imap <Char-0x10>Kc <Nop>
imap <Char-0x10>Kd <Nop>
imap <Char-0x10>Ke <Nop>
imap <Char-0x10>Kf <Nop>
imap <Char-0x10>Kg <Nop>
imap <Char-0x10>Kh <Nop>
imap <Char-0x10>Ki <Nop>
imap <Char-0x10>Kj <Nop>
imap <Char-0x10>Kk <Nop>
imap <Char-0x10>Kl <Nop>
imap <Char-0x10>Km <Nop>
imap <Char-0x10>Kn <Nop>
imap <Char-0x10>Ko <Nop>
imap <Char-0x10>Kp <Nop>
imap <Char-0x10>Kq <Nop>
imap <Char-0x10>Kr <Nop>
imap <Char-0x10>KG <Nop>
imap <Char-0x10>KH <Nop>
imap <Char-0x10>KI <Nop>
imap <Char-0x10>KJ <Nop>
imap <Char-0x10>KK <Nop>
imap <Char-0x10>KL <Nop>
imap <Char-0x10>KM <Nop>
imap <Char-0x10>KN <Nop>
imap <Char-0x10>KO <Nop>
imap <Char-0x10>KP <Nop>
" }}}

" Symbols [Alt + Super]{{{
imap <Char-0x10>KB <Nop>
imap <Char-0x10>Kt <Nop>
imap <Char-0x10>K1 <Nop>
imap <Char-0x10>KC <Nop>
imap <Char-0x10>K3 <Nop>
imap <Char-0x10>K- <Nop>
imap <Char-0x10>Kz <Nop>
imap <Char-0x10>KR <Nop>
imap <Char-0x10>Ky <Nop>
imap <Char-0x10>Kv <Nop>
imap <Char-0x10>Ks <Nop>
imap <Char-0x10>KD <Nop>
imap <Char-0x10>K! <Nop>
imap <Char-0x10>KE <Nop>
imap <Char-0x10>Ku <Nop>
imap <Char-0x10>KQ <Nop>
imap <Char-0x10>KF <Nop>
imap <Char-0x10>KA <Nop>
imap <Char-0x10>K0 <Nop>
imap <Char-0x10>Kw <Nop>
imap <Char-0x10>Kx <Nop>
imap <Char-0x10>K^ <Nop>
" }}}

" Function keys [Alt + Super]{{{
imap <Char-0x10>K/ <Nop>
imap <Char-0x10>K* <Nop>
imap <Char-0x10>K? <Nop>
imap <Char-0x10>K& <Nop>
imap <Char-0x10>K< <Nop>
imap <Char-0x10>K> <Nop>
imap <Char-0x10>K( <Nop>
imap <Char-0x10>K) <Nop>
imap <Char-0x10>K[ <Nop>
imap <Char-0x10>K] <Nop>
imap <Char-0x10>K{ <Nop>
imap <Char-0x10>K} <Nop>
imap <Char-0x10>K@ <Nop>
imap <Char-0x10>K% <Nop>
imap <Char-0x10>K$ <Nop>
imap <Char-0x10>K# <Nop>
imap <Char-0x10>KBA <Nop>
imap <Char-0x10>KBB <Nop>
imap <Char-0x10>KBC <Nop>
imap <Char-0x10>KBD <Nop>
imap <Char-0x10>KBE <Nop>
imap <Char-0x10>KBF <Nop>
imap <Char-0x10>KBG <Nop>
imap <Char-0x10>KBH <Nop>
imap <Char-0x10>KBI <Nop>
" }}}

" Modifiers [Alt + Super]{{{
imap <Char-0x10>K: <Nop>
imap <Char-0x10>K2 <Nop>
imap <Char-0x10>KBc <Nop>
imap <Char-0x10>KBb <Nop>
imap <Char-0x10>KBa <Nop>
imap <Char-0x10>KBd <Nop>
imap <Char-0x10>K= <Nop>
imap <Char-0x10>KBg <Nop>
imap <Char-0x10>KBf <Nop>
imap <Char-0x10>KBe <Nop>
imap <Char-0x10>KBh <Nop>
imap <Char-0x10>K+ <Nop>
" }}}

" Movement [Alt + Super]{{{
imap <Char-0x10>K6 <Nop>
imap <Char-0x10>K. <Nop>
imap <Char-0x10>K5 <Nop>
imap <Char-0x10>K9 <Nop>
imap <Char-0x10>K8 <Nop>
imap <Char-0x10>K4 <Nop>
imap <Char-0x10>K7 <Nop>
" }}}

" Numpad [Alt + Super]{{{
imap <Char-0x10>KBJ <Nop>
imap <Char-0x10>KBK <Nop>
imap <Char-0x10>KBL <Nop>
imap <Char-0x10>KBM <Nop>
imap <Char-0x10>KBN <Nop>
imap <Char-0x10>KBO <Nop>
imap <Char-0x10>KBP <Nop>
imap <Char-0x10>KBQ <Nop>
imap <Char-0x10>KBR <Nop>
imap <Char-0x10>KBS <Nop>
imap <Char-0x10>KBX <Nop>
imap <Char-0x10>KBT <Nop>
imap <Char-0x10>KBU <Nop>
imap <Char-0x10>KBY <Nop>
imap <Char-0x10>KBZ <Nop>
imap <Char-0x10>KBV <Nop>
imap <Char-0x10>KBW <Nop>
" }}}
" }}}
" Alt + Shift + Super [L]{{{
" Alphanumerics [Alt + Shift + Super]{{{
imap <Char-0x10>LS <Nop>
imap <Char-0x10>LT <Nop>
imap <Char-0x10>LU <Nop>
imap <Char-0x10>LV <Nop>
imap <Char-0x10>LW <Nop>
imap <Char-0x10>LX <Nop>
imap <Char-0x10>LY <Nop>
imap <Char-0x10>LZ <Nop>
imap <Char-0x10>La <Nop>
imap <Char-0x10>Lb <Nop>
imap <Char-0x10>Lc <Nop>
imap <Char-0x10>Ld <Nop>
imap <Char-0x10>Le <Nop>
imap <Char-0x10>Lf <Nop>
imap <Char-0x10>Lg <Nop>
imap <Char-0x10>Lh <Nop>
imap <Char-0x10>Li <Nop>
imap <Char-0x10>Lj <Nop>
imap <Char-0x10>Lk <Nop>
imap <Char-0x10>Ll <Nop>
imap <Char-0x10>Lm <Nop>
imap <Char-0x10>Ln <Nop>
imap <Char-0x10>Lo <Nop>
imap <Char-0x10>Lp <Nop>
imap <Char-0x10>Lq <Nop>
imap <Char-0x10>Lr <Nop>
imap <Char-0x10>LG <Nop>
imap <Char-0x10>LH <Nop>
imap <Char-0x10>LI <Nop>
imap <Char-0x10>LJ <Nop>
imap <Char-0x10>LK <Nop>
imap <Char-0x10>LL <Nop>
imap <Char-0x10>LM <Nop>
imap <Char-0x10>LN <Nop>
imap <Char-0x10>LO <Nop>
imap <Char-0x10>LP <Nop>
" }}}

" Symbols [Alt + Shift  + Super]{{{
imap <Char-0x10>LB <Nop>
imap <Char-0x10>Lt <Nop>
imap <Char-0x10>L1 <Nop>
imap <Char-0x10>LC <Nop>
imap <Char-0x10>L3 <Nop>
imap <Char-0x10>L- <Nop>
imap <Char-0x10>Lz <Nop>
imap <Char-0x10>LR <Nop>
imap <Char-0x10>Ly <Nop>
imap <Char-0x10>Lv <Nop>
imap <Char-0x10>Ls <Nop>
imap <Char-0x10>LD <Nop>
imap <Char-0x10>L! <Nop>
imap <Char-0x10>LE <Nop>
imap <Char-0x10>Lu <Nop>
imap <Char-0x10>LQ <Nop>
imap <Char-0x10>LF <Nop>
imap <Char-0x10>LA <Nop>
imap <Char-0x10>L0 <Nop>
imap <Char-0x10>Lw <Nop>
imap <Char-0x10>Lx <Nop>
imap <Char-0x10>L^ <Nop>
" }}}

" Function keys [Alt + Shift + Super]{{{
imap <Char-0x10>L/ <Nop>
imap <Char-0x10>L* <Nop>
imap <Char-0x10>L? <Nop>
imap <Char-0x10>L& <Nop>
imap <Char-0x10>L< <Nop>
imap <Char-0x10>L> <Nop>
imap <Char-0x10>L( <Nop>
imap <Char-0x10>L) <Nop>
imap <Char-0x10>L[ <Nop>
imap <Char-0x10>L] <Nop>
imap <Char-0x10>L{ <Nop>
imap <Char-0x10>L} <Nop>
imap <Char-0x10>L@ <Nop>
imap <Char-0x10>L% <Nop>
imap <Char-0x10>L$ <Nop>
imap <Char-0x10>L# <Nop>
imap <Char-0x10>LBA <Nop>
imap <Char-0x10>LBB <Nop>
imap <Char-0x10>LBC <Nop>
imap <Char-0x10>LBD <Nop>
imap <Char-0x10>LBE <Nop>
imap <Char-0x10>LBF <Nop>
imap <Char-0x10>LBG <Nop>
imap <Char-0x10>LBH <Nop>
imap <Char-0x10>LBI <Nop>
" }}}

" Modifiers [Alt + Shift + Super]{{{
imap <Char-0x10>L: <Nop>
imap <Char-0x10>L2 <Nop>
imap <Char-0x10>LBc <Nop>
imap <Char-0x10>LBb <Nop>
imap <Char-0x10>LBa <Nop>
imap <Char-0x10>LBd <Nop>
imap <Char-0x10>L= <Nop>
imap <Char-0x10>LBg <Nop>
imap <Char-0x10>LBf <Nop>
imap <Char-0x10>LBe <Nop>
imap <Char-0x10>LBh <Nop>
imap <Char-0x10>L+ <Nop>
" }}}

" Movement [Alt + Shift + Super]{{{
imap <Char-0x10>L6 <Nop>
imap <Char-0x10>L. <Nop>
imap <Char-0x10>L5 <Nop>
imap <Char-0x10>L9 <Nop>
imap <Char-0x10>L8 <Nop>
imap <Char-0x10>L4 <Nop>
imap <Char-0x10>L7 <Nop>
" }}}

" Numpad [Alt + Shift + Super]{{{
imap <Char-0x10>LBJ <Nop>
imap <Char-0x10>LBK <Nop>
imap <Char-0x10>LBL <Nop>
imap <Char-0x10>LBM <Nop>
imap <Char-0x10>LBN <Nop>
imap <Char-0x10>LBO <Nop>
imap <Char-0x10>LBP <Nop>
imap <Char-0x10>LBQ <Nop>
imap <Char-0x10>LBR <Nop>
imap <Char-0x10>LBS <Nop>
imap <Char-0x10>LBX <Nop>
imap <Char-0x10>LBT <Nop>
imap <Char-0x10>LBU <Nop>
imap <Char-0x10>LBY <Nop>
imap <Char-0x10>LBZ <Nop>
imap <Char-0x10>LBV <Nop>
imap <Char-0x10>LBW <Nop>
" }}}
" }}}
" Alt + Ctrl + Shift + Super [L]{{{
" Alphanumerics [Ctrl + Super]{{{
imap <Char-0x10>MS <Nop>
imap <Char-0x10>MT <Nop>
imap <Char-0x10>MU <Nop>
imap <Char-0x10>MV <Nop>
imap <Char-0x10>MW <Nop>
imap <Char-0x10>MX <Nop>
imap <Char-0x10>MY <Nop>
imap <Char-0x10>MZ <Nop>
imap <Char-0x10>Ma <Nop>
imap <Char-0x10>Mb <Nop>
imap <Char-0x10>Mc <Nop>
imap <Char-0x10>Md <Nop>
imap <Char-0x10>Me <Nop>
imap <Char-0x10>Mf <Nop>
imap <Char-0x10>Mg <Nop>
imap <Char-0x10>Mh <Nop>
imap <Char-0x10>Mi <Nop>
imap <Char-0x10>Mj <Nop>
imap <Char-0x10>Mk <Nop>
imap <Char-0x10>Ml <Nop>
imap <Char-0x10>Mm <Nop>
imap <Char-0x10>Mn <Nop>
imap <Char-0x10>Mo <Nop>
imap <Char-0x10>Mp <Nop>
imap <Char-0x10>Mq <Nop>
imap <Char-0x10>Mr <Nop>
imap <Char-0x10>MG <Nop>
imap <Char-0x10>MH <Nop>
imap <Char-0x10>MI <Nop>
imap <Char-0x10>MJ <Nop>
imap <Char-0x10>MK <Nop>
imap <Char-0x10>ML <Nop>
imap <Char-0x10>MM <Nop>
imap <Char-0x10>MN <Nop>
imap <Char-0x10>MO <Nop>
imap <Char-0x10>MP <Nop>
" }}}

" Symbols [Ctrl + Super]{{{
imap <Char-0x10>MB <Nop>
imap <Char-0x10>Mt <Nop>
imap <Char-0x10>M1 <Nop>
imap <Char-0x10>MC <Nop>
imap <Char-0x10>M3 <Nop>
imap <Char-0x10>M- <Nop>
imap <Char-0x10>Mz <Nop>
imap <Char-0x10>MR <Nop>
imap <Char-0x10>My <Nop>
imap <Char-0x10>Mv <Nop>
imap <Char-0x10>Ms <Nop>
imap <Char-0x10>MD <Nop>
imap <Char-0x10>M! <Nop>
imap <Char-0x10>ME <Nop>
imap <Char-0x10>Mu <Nop>
imap <Char-0x10>MQ <Nop>
imap <Char-0x10>MF <Nop>
imap <Char-0x10>MA <Nop>
imap <Char-0x10>M0 <Nop>
imap <Char-0x10>Mw <Nop>
imap <Char-0x10>Mx <Nop>
imap <Char-0x10>M^ <Nop>
" }}}

" Function keys [Ctrl + Super]{{{
imap <Char-0x10>M/ <Nop>
imap <Char-0x10>M* <Nop>
imap <Char-0x10>M? <Nop>
imap <Char-0x10>M& <Nop>
imap <Char-0x10>M< <Nop>
imap <Char-0x10>M> <Nop>
imap <Char-0x10>M( <Nop>
imap <Char-0x10>M) <Nop>
imap <Char-0x10>M[ <Nop>
imap <Char-0x10>M] <Nop>
imap <Char-0x10>M{ <Nop>
imap <Char-0x10>M} <Nop>
imap <Char-0x10>M@ <Nop>
imap <Char-0x10>M% <Nop>
imap <Char-0x10>M$ <Nop>
imap <Char-0x10>M# <Nop>
imap <Char-0x10>MBA <Nop>
imap <Char-0x10>MBB <Nop>
imap <Char-0x10>MBC <Nop>
imap <Char-0x10>MBD <Nop>
imap <Char-0x10>MBE <Nop>
imap <Char-0x10>MBF <Nop>
imap <Char-0x10>MBG <Nop>
imap <Char-0x10>MBH <Nop>
imap <Char-0x10>MBI <Nop>
" }}}

" Modifiers [Ctrl + Super]{{{
imap <Char-0x10>M: <Nop>
imap <Char-0x10>M2 <Nop>
imap <Char-0x10>MBc <Nop>
imap <Char-0x10>MBb <Nop>
imap <Char-0x10>MBa <Nop>
imap <Char-0x10>MBd <Nop>
imap <Char-0x10>M= <Nop>
imap <Char-0x10>MBg <Nop>
imap <Char-0x10>MBf <Nop>
imap <Char-0x10>MBe <Nop>
imap <Char-0x10>MBh <Nop>
imap <Char-0x10>M+ <Nop>
" }}}

" Movement [Ctrl + Super]{{{
imap <Char-0x10>M6 <Nop>
imap <Char-0x10>M. <Nop>
imap <Char-0x10>M5 <Nop>
imap <Char-0x10>M9 <Nop>
imap <Char-0x10>M8 <Nop>
imap <Char-0x10>M4 <Nop>
imap <Char-0x10>M7 <Nop>
" }}}

" Numpad [Ctrl + Super]{{{
imap <Char-0x10>MBJ <Nop>
imap <Char-0x10>MBK <Nop>
imap <Char-0x10>MBL <Nop>
imap <Char-0x10>MBM <Nop>
imap <Char-0x10>MBN <Nop>
imap <Char-0x10>MBO <Nop>
imap <Char-0x10>MBP <Nop>
imap <Char-0x10>MBQ <Nop>
imap <Char-0x10>MBR <Nop>
imap <Char-0x10>MBS <Nop>
imap <Char-0x10>MBX <Nop>
imap <Char-0x10>MBT <Nop>
imap <Char-0x10>MBU <Nop>
imap <Char-0x10>MBY <Nop>
imap <Char-0x10>MBZ <Nop>
imap <Char-0x10>MBV <Nop>
imap <Char-0x10>MBW <Nop>
" }}}
" }}}
" Ctrl + Shift + Super [N]{{{
" Alphanumerics [Ctrl + Shift + Super]{{{
imap <Char-0x10>NS <Nop>
imap <Char-0x10>NT <Nop>
imap <Char-0x10>NU <Nop>
imap <Char-0x10>NV <Nop>
imap <Char-0x10>NW <Nop>
imap <Char-0x10>NX <Nop>
imap <Char-0x10>NY <Nop>
imap <Char-0x10>NZ <Nop>
imap <Char-0x10>Na <Nop>
imap <Char-0x10>Nb <Nop>
imap <Char-0x10>Nc <Nop>
imap <Char-0x10>Nd <Nop>
imap <Char-0x10>Ne <Nop>
imap <Char-0x10>Nf <Nop>
imap <Char-0x10>Ng <Nop>
imap <Char-0x10>Nh <Nop>
imap <Char-0x10>Ni <Nop>
imap <Char-0x10>Nj <Nop>
imap <Char-0x10>Nk <Nop>
imap <Char-0x10>Nl <Nop>
imap <Char-0x10>Nm <Nop>
imap <Char-0x10>Nn <Nop>
imap <Char-0x10>No <Nop>
imap <Char-0x10>Np <Nop>
imap <Char-0x10>Nq <Nop>
imap <Char-0x10>Nr <Nop>
imap <Char-0x10>NG <Nop>
imap <Char-0x10>NH <Nop>
imap <Char-0x10>NI <Nop>
imap <Char-0x10>NJ <Nop>
imap <Char-0x10>NK <Nop>
imap <Char-0x10>NL <Nop>
imap <Char-0x10>NM <Nop>
imap <Char-0x10>NN <Nop>
imap <Char-0x10>NO <Nop>
imap <Char-0x10>NP <Nop>
" }}}

" Symbols [Ctrl + Shift + Super]{{{
imap <Char-0x10>NB <Nop>
imap <Char-0x10>Nt <Nop>
imap <Char-0x10>N1 <Nop>
imap <Char-0x10>NC <Nop>
imap <Char-0x10>N3 <Nop>
imap <Char-0x10>N- <Nop>
imap <Char-0x10>Nz <Nop>
imap <Char-0x10>NR <Nop>
imap <Char-0x10>Ny <Nop>
imap <Char-0x10>Nv <Nop>
imap <Char-0x10>Ns <Nop>
imap <Char-0x10>ND <Nop>
imap <Char-0x10>N! <Nop>
imap <Char-0x10>NE <Nop>
imap <Char-0x10>Nu <Nop>
imap <Char-0x10>NQ <Nop>
imap <Char-0x10>NF <Nop>
imap <Char-0x10>NA <Nop>
imap <Char-0x10>N0 <Nop>
imap <Char-0x10>Nw <Nop>
imap <Char-0x10>Nx <Nop>
imap <Char-0x10>N^ <Nop>
" }}}

" Function keys [Ctrl + Shift + Super]{{{
imap <Char-0x10>N/ <Nop>
imap <Char-0x10>N* <Nop>
imap <Char-0x10>N? <Nop>
imap <Char-0x10>N& <Nop>
imap <Char-0x10>N< <Nop>
imap <Char-0x10>N> <Nop>
imap <Char-0x10>N( <Nop>
imap <Char-0x10>N) <Nop>
imap <Char-0x10>N[ <Nop>
imap <Char-0x10>N] <Nop>
imap <Char-0x10>N{ <Nop>
imap <Char-0x10>N} <Nop>
imap <Char-0x10>N@ <Nop>
imap <Char-0x10>N% <Nop>
imap <Char-0x10>N$ <Nop>
imap <Char-0x10>N# <Nop>
imap <Char-0x10>NBA <Nop>
imap <Char-0x10>NBB <Nop>
imap <Char-0x10>NBC <Nop>
imap <Char-0x10>NBD <Nop>
imap <Char-0x10>NBE <Nop>
imap <Char-0x10>NBF <Nop>
imap <Char-0x10>NBG <Nop>
imap <Char-0x10>NBH <Nop>
imap <Char-0x10>NBI <Nop>
" }}}

" Modifiers [Ctrl + Shift + Super]{{{
imap <Char-0x10>N: <Nop>
imap <Char-0x10>N2 <Nop>
imap <Char-0x10>NBc <Nop>
imap <Char-0x10>NBb <Nop>
imap <Char-0x10>NBa <Nop>
imap <Char-0x10>NBd <Nop>
imap <Char-0x10>N= <Nop>
imap <Char-0x10>NBg <Nop>
imap <Char-0x10>NBf <Nop>
imap <Char-0x10>NBe <Nop>
imap <Char-0x10>NBh <Nop>
imap <Char-0x10>N+ <Nop>
" }}}

" Movement [Ctrl + Shift + Super]{{{
imap <Char-0x10>N6 <Nop>
imap <Char-0x10>N. <Nop>
imap <Char-0x10>N5 <Nop>
imap <Char-0x10>N9 <Nop>
imap <Char-0x10>N8 <Nop>
imap <Char-0x10>N4 <Nop>
imap <Char-0x10>N7 <Nop>
" }}}

" Numpad [Ctrl + Shift + Super]{{{
imap <Char-0x10>NBJ <Nop>
imap <Char-0x10>NBK <Nop>
imap <Char-0x10>NBL <Nop>
imap <Char-0x10>NBM <Nop>
imap <Char-0x10>NBN <Nop>
imap <Char-0x10>NBO <Nop>
imap <Char-0x10>NBP <Nop>
imap <Char-0x10>NBQ <Nop>
imap <Char-0x10>NBR <Nop>
imap <Char-0x10>NBS <Nop>
imap <Char-0x10>NBX <Nop>
imap <Char-0x10>NBT <Nop>
imap <Char-0x10>NBU <Nop>
imap <Char-0x10>NBY <Nop>
imap <Char-0x10>NBZ <Nop>
imap <Char-0x10>NBV <Nop>
imap <Char-0x10>NBW <Nop>
" }}}
" }}}
" Alt + control + Super [O]{{{
" Alphanumerics [Alt + Ctrl + Super]{{{
imap <Char-0x10>OS <Nop>
imap <Char-0x10>OT <Nop>
imap <Char-0x10>OU <Nop>
imap <Char-0x10>OV <Nop>
imap <Char-0x10>OW <Nop>
imap <Char-0x10>OX <Nop>
imap <Char-0x10>OY <Nop>
imap <Char-0x10>OZ <Nop>
imap <Char-0x10>Oa <Nop>
imap <Char-0x10>Ob <Nop>
imap <Char-0x10>Oc <Nop>
imap <Char-0x10>Od <Nop>
imap <Char-0x10>Oe <Nop>
imap <Char-0x10>Of <Nop>
imap <Char-0x10>Og <Nop>
imap <Char-0x10>Oh <Nop>
imap <Char-0x10>Oi <Nop>
imap <Char-0x10>Oj <Nop>
imap <Char-0x10>Ok <Nop>
imap <Char-0x10>Ol <Nop>
imap <Char-0x10>Om <Nop>
imap <Char-0x10>On <Nop>
imap <Char-0x10>Oo <Nop>
imap <Char-0x10>Op <Nop>
imap <Char-0x10>Oq <Nop>
imap <Char-0x10>Or <Nop>
imap <Char-0x10>OG <Nop>
imap <Char-0x10>OH <Nop>
imap <Char-0x10>OI <Nop>
imap <Char-0x10>OJ <Nop>
imap <Char-0x10>OK <Nop>
imap <Char-0x10>OL <Nop>
imap <Char-0x10>OM <Nop>
imap <Char-0x10>ON <Nop>
imap <Char-0x10>OO <Nop>
imap <Char-0x10>OP <Nop>
" }}}

" Symbols [Alt + Ctrl + Super]{{{
imap <Char-0x10>OB <Nop>
imap <Char-0x10>Ot <Nop>
imap <Char-0x10>O1 <Nop>
imap <Char-0x10>OC <Nop>
imap <Char-0x10>O3 <Nop>
imap <Char-0x10>O- <Nop>
imap <Char-0x10>Oz <Nop>
imap <Char-0x10>OR <Nop>
imap <Char-0x10>Oy <Nop>
imap <Char-0x10>Ov <Nop>
imap <Char-0x10>Os <Nop>
imap <Char-0x10>OD <Nop>
imap <Char-0x10>O! <Nop>
imap <Char-0x10>OE <Nop>
imap <Char-0x10>Ou <Nop>
imap <Char-0x10>OQ <Nop>
imap <Char-0x10>OF <Nop>
imap <Char-0x10>OA <Nop>
imap <Char-0x10>O0 <Nop>
imap <Char-0x10>Ow <Nop>
imap <Char-0x10>Ox <Nop>
imap <Char-0x10>O^ <Nop>
" }}}

" Function keys [Alt + Ctrl + Super]{{{
imap <Char-0x10>O/ <Nop>
imap <Char-0x10>O* <Nop>
imap <Char-0x10>O? <Nop>
imap <Char-0x10>O& <Nop>
imap <Char-0x10>O< <Nop>
imap <Char-0x10>O> <Nop>
imap <Char-0x10>O( <Nop>
imap <Char-0x10>O) <Nop>
imap <Char-0x10>O[ <Nop>
imap <Char-0x10>O] <Nop>
imap <Char-0x10>O{ <Nop>
imap <Char-0x10>O} <Nop>
imap <Char-0x10>O@ <Nop>
imap <Char-0x10>O% <Nop>
imap <Char-0x10>O$ <Nop>
imap <Char-0x10>O# <Nop>
imap <Char-0x10>OBA <Nop>
imap <Char-0x10>OBB <Nop>
imap <Char-0x10>OBC <Nop>
imap <Char-0x10>OBD <Nop>
imap <Char-0x10>OBE <Nop>
imap <Char-0x10>OBF <Nop>
imap <Char-0x10>OBG <Nop>
imap <Char-0x10>OBH <Nop>
imap <Char-0x10>OBI <Nop>
" }}}

" Modifiers [Alt + Ctrl + Super]{{{
imap <Char-0x10>O: <Nop>
imap <Char-0x10>O2 <Nop>
imap <Char-0x10>OBc <Nop>
imap <Char-0x10>OBb <Nop>
imap <Char-0x10>OBa <Nop>
imap <Char-0x10>OBd <Nop>
imap <Char-0x10>O= <Nop>
imap <Char-0x10>OBg <Nop>
imap <Char-0x10>OBf <Nop>
imap <Char-0x10>OBe <Nop>
imap <Char-0x10>OBh <Nop>
imap <Char-0x10>O+ <Nop>
" }}}

" Movement [Alt + Ctrl + Super]{{{
imap <Char-0x10>O6 <Nop>
imap <Char-0x10>O. <Nop>
imap <Char-0x10>O5 <Nop>
imap <Char-0x10>O9 <Nop>
imap <Char-0x10>O8 <Nop>
imap <Char-0x10>O4 <Nop>
imap <Char-0x10>O7 <Nop>
" }}}

" Numpad [Alt + Ctrl + Super]{{{
imap <Char-0x10>OBJ <Nop>
imap <Char-0x10>OBK <Nop>
imap <Char-0x10>OBL <Nop>
imap <Char-0x10>OBM <Nop>
imap <Char-0x10>OBN <Nop>
imap <Char-0x10>OBO <Nop>
imap <Char-0x10>OBP <Nop>
imap <Char-0x10>OBQ <Nop>
imap <Char-0x10>OBR <Nop>
imap <Char-0x10>OBS <Nop>
imap <Char-0x10>OBX <Nop>
imap <Char-0x10>OBT <Nop>
imap <Char-0x10>OBU <Nop>
imap <Char-0x10>OBY <Nop>
imap <Char-0x10>OBZ <Nop>
imap <Char-0x10>OBV <Nop>
imap <Char-0x10>OBW <Nop>
" }}}
" }}}
" Alt + control + Shift + Super [P]{{{
" Alphanumerics [Alt + Ctrl + Shift + Super]{{{
imap <Char-0x10>PS <Nop>
imap <Char-0x10>PT <Nop>
imap <Char-0x10>PU <Nop>
imap <Char-0x10>PV <Nop>
imap <Char-0x10>PW <Nop>
imap <Char-0x10>PX <Nop>
imap <Char-0x10>PY <Nop>
imap <Char-0x10>PZ <Nop>
imap <Char-0x10>Pa <Nop>
imap <Char-0x10>Pb <Nop>
imap <Char-0x10>Pc <Nop>
imap <Char-0x10>Pd <Nop>
imap <Char-0x10>Pe <Nop>
imap <Char-0x10>Pf <Nop>
imap <Char-0x10>Pg <Nop>
imap <Char-0x10>Ph <Nop>
imap <Char-0x10>Pi <Nop>
imap <Char-0x10>Pj <Nop>
imap <Char-0x10>Pk <Nop>
imap <Char-0x10>Pl <Nop>
imap <Char-0x10>Pm <Nop>
imap <Char-0x10>Pn <Nop>
imap <Char-0x10>Po <Nop>
imap <Char-0x10>Pp <Nop>
imap <Char-0x10>Pq <Nop>
imap <Char-0x10>Pr <Nop>
imap <Char-0x10>PG <Nop>
imap <Char-0x10>PH <Nop>
imap <Char-0x10>PI <Nop>
imap <Char-0x10>PJ <Nop>
imap <Char-0x10>PK <Nop>
imap <Char-0x10>PL <Nop>
imap <Char-0x10>PM <Nop>
imap <Char-0x10>PN <Nop>
imap <Char-0x10>PO <Nop>
imap <Char-0x10>PP <Nop>
" }}}

" Symbols [Alt + Ctrl + Shift + Super]{{{
imap <Char-0x10>PB <Nop>
imap <Char-0x10>Pt <Nop>
imap <Char-0x10>P1 <Nop>
imap <Char-0x10>PC <Nop>
imap <Char-0x10>P3 <Nop>
imap <Char-0x10>P- <Nop>
imap <Char-0x10>Pz <Nop>
imap <Char-0x10>PR <Nop>
imap <Char-0x10>Py <Nop>
imap <Char-0x10>Pv <Nop>
imap <Char-0x10>Ps <Nop>
imap <Char-0x10>PD <Nop>
imap <Char-0x10>P! <Nop>
imap <Char-0x10>PE <Nop>
imap <Char-0x10>Pu <Nop>
imap <Char-0x10>PQ <Nop>
imap <Char-0x10>PF <Nop>
imap <Char-0x10>PA <Nop>
imap <Char-0x10>P0 <Nop>
imap <Char-0x10>Pw <Nop>
imap <Char-0x10>Px <Nop>
imap <Char-0x10>P^ <Nop>
" }}}

" Function keys [Alt + Ctrl + Shift + Super]{{{
imap <Char-0x10>p/ <Nop>
imap <Char-0x10>p* <Nop>
imap <Char-0x10>p? <Nop>
imap <Char-0x10>p& <Nop>
imap <Char-0x10>p< <Nop>
imap <Char-0x10>p> <Nop>
imap <Char-0x10>p( <Nop>
imap <Char-0x10>p) <Nop>
imap <Char-0x10>p[ <Nop>
imap <Char-0x10>p] <Nop>
imap <Char-0x10>p{ <Nop>
imap <Char-0x10>p} <Nop>
imap <Char-0x10>p@ <Nop>
imap <Char-0x10>p% <Nop>
imap <Char-0x10>p$ <Nop>
imap <Char-0x10>p# <Nop>
imap <Char-0x10>pba <Nop>
imap <Char-0x10>pbb <Nop>
imap <Char-0x10>pbc <Nop>
imap <Char-0x10>pbd <Nop>
imap <Char-0x10>pbe <Nop>
imap <Char-0x10>pbf <Nop>
imap <Char-0x10>pbg <Nop>
imap <Char-0x10>pbh <Nop>
imap <Char-0x10>pbi <Nop>
" }}}

" Modifiers [Alt + Ctrl + Shift + Super]{{{
imap <Char-0x10>P: <Nop>
imap <Char-0x10>P2 <Nop>
imap <Char-0x10>PBc <Nop>
imap <Char-0x10>PBb <Nop>
imap <Char-0x10>PBa <Nop>
imap <Char-0x10>PBd <Nop>
imap <Char-0x10>P= <Nop>
imap <Char-0x10>PBg <Nop>
imap <Char-0x10>PBf <Nop>
imap <Char-0x10>PBe <Nop>
imap <Char-0x10>PBh <Nop>
imap <Char-0x10>P+ <Nop>
" }}}

" Movement [Alt + Ctrl + Shift + Super]{{{
imap <Char-0x10>P6 <Nop>
imap <Char-0x10>P. <Nop>
imap <Char-0x10>P5 <Nop>
imap <Char-0x10>P9 <Nop>
imap <Char-0x10>P8 <Nop>
imap <Char-0x10>P4 <Nop>
imap <Char-0x10>P7 <Nop>
" }}}

" Numpad [Alt + Ctrl + Shift +  Super]{{{
imap <Char-0x10>PBJ <Nop>
imap <Char-0x10>PBK <Nop>
imap <Char-0x10>PBL <Nop>
imap <Char-0x10>PBM <Nop>
imap <Char-0x10>PBN <Nop>
imap <Char-0x10>PBO <Nop>
imap <Char-0x10>PBP <Nop>
imap <Char-0x10>PBQ <Nop>
imap <Char-0x10>PBR <Nop>
imap <Char-0x10>PBS <Nop>
imap <Char-0x10>PBX <Nop>
imap <Char-0x10>PBT <Nop>
imap <Char-0x10>PBU <Nop>
imap <Char-0x10>PBY <Nop>
imap <Char-0x10>PBZ <Nop>
imap <Char-0x10>PBV <Nop>
imap <Char-0x10>PBW <Nop>
" }}}
" }}}
" }}}

" Command-line {{{
" Shift - Special keys [B] {{{
cmap <Char-0x10>Bz <Nop>
cmap <Char-0x10>B1 <Nop>
cmap <Char-0x10>By <Nop>
" }}}
" Ctrl - Special keys [E] {{{
cmap <Char-0x10>Ez <Nop>
cmap <Char-0x10>E1 <Nop>
cmap <Char-0x10>Ey <Nop>
cmap <Char-0x10>E0 <Nop>
" }}}
" Ctrl + Shift [F]{{{
" Alphanumerics [Ctrl + Shift]{{{
cmap <Char-0x10>FS <Nop>
cmap <Char-0x10>FT <Nop>
cmap <Char-0x10>FU <Nop>
cmap <Char-0x10>FV <Nop>
cmap <Char-0x10>FW <Nop>
cmap <Char-0x10>FX <Nop>
cmap <Char-0x10>FY <Nop>
cmap <Char-0x10>FZ <Nop>
cmap <Char-0x10>Fa <Nop>
cmap <Char-0x10>Fb <Nop>
cmap <Char-0x10>Fc <Nop>
cmap <Char-0x10>Fd <Nop>
cmap <Char-0x10>Fe <Nop>
cmap <Char-0x10>Ff <Nop>
cmap <Char-0x10>Fg <Nop>
cmap <Char-0x10>Fh <Nop>
cmap <Char-0x10>Fi <Nop>
cmap <Char-0x10>Fj <Nop>
cmap <Char-0x10>Fk <Nop>
cmap <Char-0x10>Fl <Nop>
cmap <Char-0x10>Fm <Nop>
cmap <Char-0x10>Fn <Nop>
cmap <Char-0x10>Fo <Nop>
cmap <Char-0x10>Fp <Nop>
cmap <Char-0x10>Fq <Nop>
cmap <Char-0x10>Fr <Nop>
cmap <Char-0x10>FG <Nop>
cmap <Char-0x10>FH <Nop>
cmap <Char-0x10>FI <Nop>
cmap <Char-0x10>FJ <Nop>
cmap <Char-0x10>FK <Nop>
cmap <Char-0x10>FL <Nop>
cmap <Char-0x10>FM <Nop>
cmap <Char-0x10>FN <Nop>
cmap <Char-0x10>FO <Nop>
cmap <Char-0x10>FP <Nop>
" }}}

" Symbols [Ctrl + Shift]{{{
cmap <Char-0x10>FB <Nop>
cmap <Char-0x10>Ft <Nop>
cmap <Char-0x10>F1 <Nop>
cmap <Char-0x10>FC <Nop>
cmap <Char-0x10>F3 <Nop>
cmap <Char-0x10>F- <Nop>
cmap <Char-0x10>Fz <Nop>
cmap <Char-0x10>FR <Nop>
cmap <Char-0x10>Fy <Nop>
cmap <Char-0x10>Fv <Nop>
cmap <Char-0x10>Fs <Nop>
cmap <Char-0x10>FD <Nop>
cmap <Char-0x10>F! <Nop>
cmap <Char-0x10>FE <Nop>
cmap <Char-0x10>Fu <Nop>
cmap <Char-0x10>FQ <Nop>
cmap <Char-0x10>FF <Nop>
cmap <Char-0x10>FA <Nop>
cmap <Char-0x10>F0 <Nop>
cmap <Char-0x10>Fw <Nop>
cmap <Char-0x10>Fx <Nop>
cmap <Char-0x10>F^ <Nop>
" }}}

" Function keys [Ctrl + Shift]{{{
cmap <Char-0x10>F/ <Nop>
cmap <Char-0x10>F* <Nop>
cmap <Char-0x10>F? <Nop>
cmap <Char-0x10>F& <Nop>
cmap <Char-0x10>F< <Nop>
cmap <Char-0x10>F> <Nop>
cmap <Char-0x10>F( <Nop>
cmap <Char-0x10>F) <Nop>
cmap <Char-0x10>F[ <Nop>
cmap <Char-0x10>F] <Nop>
cmap <Char-0x10>F{ <Nop>
cmap <Char-0x10>F} <Nop>
cmap <Char-0x10>F@ <Nop>
cmap <Char-0x10>F% <Nop>
cmap <Char-0x10>F$ <Nop>
cmap <Char-0x10>F# <Nop>
cmap <Char-0x10>FBA <Nop>
cmap <Char-0x10>FBB <Nop>
cmap <Char-0x10>FBC <Nop>
cmap <Char-0x10>FBD <Nop>
cmap <Char-0x10>FBE <Nop>
cmap <Char-0x10>FBF <Nop>
cmap <Char-0x10>FBG <Nop>
cmap <Char-0x10>FBH <Nop>
cmap <Char-0x10>FBI <Nop>
" }}}

" Modifiers / modes etc [Ctrl + Shift]{{{
cmap <Char-0x10>F: <Nop>
cmap <Char-0x10>F2 <Nop>
cmap <Char-0x10>FBc <Nop>
cmap <Char-0x10>FBb <Nop>
cmap <Char-0x10>FBa <Nop>
cmap <Char-0x10>FBd <Nop>
cmap <Char-0x10>F= <Nop>
cmap <Char-0x10>FBg <Nop>
cmap <Char-0x10>FBf <Nop>
cmap <Char-0x10>FBe <Nop>
cmap <Char-0x10>FBh <Nop>
cmap <Char-0x10>F+ <Nop>
" }}}

" Movement [Ctrl + Shift]{{{
cmap <Char-0x10>F6 <Nop>
cmap <Char-0x10>F. <Nop>
cmap <Char-0x10>F5 <Nop>
cmap <Char-0x10>F9 <Nop>
cmap <Char-0x10>F8 <Nop>
cmap <Char-0x10>F4 <Nop>
cmap <Char-0x10>F7 <Nop>
" }}}

" Numpad [Ctrl + Shift]{{{
cmap <Char-0x10>FBJ <Nop>
cmap <Char-0x10>FBK <Nop>
cmap <Char-0x10>FBL <Nop>
cmap <Char-0x10>FBM <Nop>
cmap <Char-0x10>FBN <Nop>
cmap <Char-0x10>FBO <Nop>
cmap <Char-0x10>FBP <Nop>
cmap <Char-0x10>FBQ <Nop>
cmap <Char-0x10>FBR <Nop>
cmap <Char-0x10>FBS <Nop>
cmap <Char-0x10>FBX <Nop>
cmap <Char-0x10>FBT <Nop>
cmap <Char-0x10>FBU <Nop>
cmap <Char-0x10>FBY <Nop>
cmap <Char-0x10>FBZ <Nop>
cmap <Char-0x10>FBV <Nop>
cmap <Char-0x10>FBW <Nop>
" }}}
" }}}
" Alt + Ctrl [G]{{{
" Alphanumerics [Alt + Ctrl]{{{
cmap <Char-0x10>GS <Nop>
cmap <Char-0x10>GT <Nop>
cmap <Char-0x10>GU <Nop>
cmap <Char-0x10>GV <Nop>
cmap <Char-0x10>GW <Nop>
cmap <Char-0x10>GX <Nop>
cmap <Char-0x10>GY <Nop>
cmap <Char-0x10>GZ <Nop>
cmap <Char-0x10>Ga <Nop>
cmap <Char-0x10>Gb <Nop>
cmap <Char-0x10>Gc <Nop>
cmap <Char-0x10>Gd <Nop>
cmap <Char-0x10>Ge <Nop>
cmap <Char-0x10>Gf <Nop>
cmap <Char-0x10>Gg <Nop>
cmap <Char-0x10>Gh <Nop>
cmap <Char-0x10>Gi <Nop>
cmap <Char-0x10>Gj <Nop>
cmap <Char-0x10>Gk <Nop>
cmap <Char-0x10>Gl <Nop>
cmap <Char-0x10>Gm <Nop>
cmap <Char-0x10>Gn <Nop>
cmap <Char-0x10>Go <Nop>
cmap <Char-0x10>Gp <Nop>
cmap <Char-0x10>Gq <Nop>
cmap <Char-0x10>Gr <Nop>
cmap <Char-0x10>GG <Nop>
cmap <Char-0x10>GH <Nop>
cmap <Char-0x10>GI <Nop>
cmap <Char-0x10>GJ <Nop>
cmap <Char-0x10>GK <Nop>
cmap <Char-0x10>GL <Nop>
cmap <Char-0x10>GM <Nop>
cmap <Char-0x10>GN <Nop>
cmap <Char-0x10>GO <Nop>
cmap <Char-0x10>GP <Nop>
" }}}

" Symbols [Alt + Ctrl]{{{
cmap <Char-0x10>GB <Nop>
cmap <Char-0x10>Gt <Nop>
cmap <Char-0x10>G1 <Nop>
cmap <Char-0x10>GC <Nop>
cmap <Char-0x10>G3 <Nop>
cmap <Char-0x10>G- <Nop>
cmap <Char-0x10>Gz <Nop>
cmap <Char-0x10>GR <Nop>
cmap <Char-0x10>Gy <Nop>
cmap <Char-0x10>Gv <Nop>
cmap <Char-0x10>Gs <Nop>
cmap <Char-0x10>GD <Nop>
cmap <Char-0x10>G! <Nop>
cmap <Char-0x10>GE <Nop>
cmap <Char-0x10>Gu <Nop>
cmap <Char-0x10>GQ <Nop>
cmap <Char-0x10>GF <Nop>
cmap <Char-0x10>GA <Nop>
cmap <Char-0x10>G0 <Nop>
cmap <Char-0x10>Gw <Nop>
cmap <Char-0x10>Gx <Nop>
cmap <Char-0x10>G^ <Nop>
" }}}

" Function keys [Alt + Ctrl]{{{
cmap <Char-0x10>G/ <Nop>
cmap <Char-0x10>G* <Nop>
cmap <Char-0x10>G? <Nop>
cmap <Char-0x10>G& <Nop>
cmap <Char-0x10>G< <Nop>
cmap <Char-0x10>G> <Nop>
cmap <Char-0x10>G( <Nop>
cmap <Char-0x10>G) <Nop>
cmap <Char-0x10>G[ <Nop>
cmap <Char-0x10>G] <Nop>
cmap <Char-0x10>G{ <Nop>
cmap <Char-0x10>G} <Nop>
cmap <Char-0x10>G@ <Nop>
cmap <Char-0x10>G% <Nop>
cmap <Char-0x10>G$ <Nop>
cmap <Char-0x10>G# <Nop>
cmap <Char-0x10>GBA <Nop>
cmap <Char-0x10>GBB <Nop>
cmap <Char-0x10>GBC <Nop>
cmap <Char-0x10>GBD <Nop>
cmap <Char-0x10>GBE <Nop>
cmap <Char-0x10>GBF <Nop>
cmap <Char-0x10>GBG <Nop>
cmap <Char-0x10>GBH <Nop>
cmap <Char-0x10>GBI <Nop>
" }}}

" Modifiers [Alt + Ctrl]{{{
cmap <Char-0x10>G: <Nop>
cmap <Char-0x10>G2 <Nop>
cmap <Char-0x10>GBc <Nop>
cmap <Char-0x10>GBb <Nop>
cmap <Char-0x10>GBa <Nop>
cmap <Char-0x10>GBd <Nop>
cmap <Char-0x10>G= <Nop>
cmap <Char-0x10>GBg <Nop>
cmap <Char-0x10>GBf <Nop>
cmap <Char-0x10>GBe <Nop>
cmap <Char-0x10>GBh <Nop>
cmap <Char-0x10>G+ <Nop>
" }}}

" Movement [Alt + Ctrl]{{{
cmap <Char-0x10>G6 <Nop>
cmap <Char-0x10>G. <Nop>
cmap <Char-0x10>G5 <Nop>
cmap <Char-0x10>G9 <Nop>
cmap <Char-0x10>G8 <Nop>
cmap <Char-0x10>G4 <Nop>
cmap <Char-0x10>G7 <Nop>
" }}}

" Numpad [Alt + Ctrl]{{{
cmap <Char-0x10>GBJ <Nop>
cmap <Char-0x10>GBK <Nop>
cmap <Char-0x10>GBL <Nop>
cmap <Char-0x10>GBM <Nop>
cmap <Char-0x10>GBN <Nop>
cmap <Char-0x10>GBO <Nop>
cmap <Char-0x10>GBP <Nop>
cmap <Char-0x10>GBQ <Nop>
cmap <Char-0x10>GBR <Nop>
cmap <Char-0x10>GBS <Nop>
cmap <Char-0x10>GBX <Nop>
cmap <Char-0x10>GBT <Nop>
cmap <Char-0x10>GBU <Nop>
cmap <Char-0x10>GBY <Nop>
cmap <Char-0x10>GBZ <Nop>
cmap <Char-0x10>GBV <Nop>
cmap <Char-0x10>GBW <Nop>
" }}}
" }}}
" Alt + Ctrl + Shift [H]{{{
" Alphanumerics [Alt + Ctrl + Shift]{{{
cmap <Char-0x10>HS <Nop>
cmap <Char-0x10>HT <Nop>
cmap <Char-0x10>HU <Nop>
cmap <Char-0x10>HV <Nop>
cmap <Char-0x10>HW <Nop>
cmap <Char-0x10>HX <Nop>
cmap <Char-0x10>HY <Nop>
cmap <Char-0x10>HZ <Nop>
cmap <Char-0x10>Ha <Nop>
cmap <Char-0x10>Hb <Nop>
cmap <Char-0x10>Hc <Nop>
cmap <Char-0x10>Hd <Nop>
cmap <Char-0x10>He <Nop>
cmap <Char-0x10>Hf <Nop>
cmap <Char-0x10>Hg <Nop>
cmap <Char-0x10>Hh <Nop>
cmap <Char-0x10>Hi <Nop>
cmap <Char-0x10>Hj <Nop>
cmap <Char-0x10>Hk <Nop>
cmap <Char-0x10>Hl <Nop>
cmap <Char-0x10>Hm <Nop>
cmap <Char-0x10>Hn <Nop>
cmap <Char-0x10>Ho <Nop>
cmap <Char-0x10>Hp <Nop>
cmap <Char-0x10>Hq <Nop>
cmap <Char-0x10>Hr <Nop>
cmap <Char-0x10>HG <Nop>
cmap <Char-0x10>HH <Nop>
cmap <Char-0x10>HI <Nop>
cmap <Char-0x10>HJ <Nop>
cmap <Char-0x10>HK <Nop>
cmap <Char-0x10>HL <Nop>
cmap <Char-0x10>HM <Nop>
cmap <Char-0x10>HN <Nop>
cmap <Char-0x10>HO <Nop>
cmap <Char-0x10>HP <Nop>
" }}}

" Symbols [Alt + Ctrl + Shift]{{{
cmap <Char-0x10>HB <Nop>
cmap <Char-0x10>Ht <Nop>
cmap <Char-0x10>H1 <Nop>
cmap <Char-0x10>HC <Nop>
cmap <Char-0x10>H3 <Nop>
cmap <Char-0x10>H- <Nop>
cmap <Char-0x10>Hz <Nop>
cmap <Char-0x10>HR <Nop>
cmap <Char-0x10>Hy <Nop>
cmap <Char-0x10>Hv <Nop>
cmap <Char-0x10>Hs <Nop>
cmap <Char-0x10>HD <Nop>
cmap <Char-0x10>H! <Nop>
cmap <Char-0x10>HE <Nop>
cmap <Char-0x10>Hu <Nop>
cmap <Char-0x10>HQ <Nop>
cmap <Char-0x10>HF <Nop>
cmap <Char-0x10>HA <Nop>
cmap <Char-0x10>H0 <Nop>
cmap <Char-0x10>Hw <Nop>
cmap <Char-0x10>Hx <Nop>
cmap <Char-0x10>H^ <Nop>
" }}}

" Function keys [Alt + Ctrl + Shift]{{{
cmap <Char-0x10>H/ <Nop>
cmap <Char-0x10>H* <Nop>
cmap <Char-0x10>H? <Nop>
cmap <Char-0x10>H& <Nop>
cmap <Char-0x10>H< <Nop>
cmap <Char-0x10>H> <Nop>
cmap <Char-0x10>H( <Nop>
cmap <Char-0x10>H) <Nop>
cmap <Char-0x10>H[ <Nop>
cmap <Char-0x10>H] <Nop>
cmap <Char-0x10>H{ <Nop>
cmap <Char-0x10>H} <Nop>
cmap <Char-0x10>H@ <Nop>
cmap <Char-0x10>H% <Nop>
cmap <Char-0x10>H$ <Nop>
cmap <Char-0x10>H# <Nop>
cmap <Char-0x10>HBA <Nop>
cmap <Char-0x10>HBB <Nop>
cmap <Char-0x10>HBC <Nop>
cmap <Char-0x10>HBD <Nop>
cmap <Char-0x10>HBE <Nop>
cmap <Char-0x10>HBF <Nop>
cmap <Char-0x10>HBG <Nop>
cmap <Char-0x10>HBH <Nop>
cmap <Char-0x10>HBI <Nop>
" }}}

" Modifiers [Alt + Ctrl + Shift]{{{
cmap <Char-0x10>H: <Nop>
cmap <Char-0x10>H2 <Nop>
cmap <Char-0x10>HBc <Nop>
cmap <Char-0x10>HBb <Nop>
cmap <Char-0x10>HBa <Nop>
cmap <Char-0x10>HBd <Nop>
cmap <Char-0x10>H= <Nop>
cmap <Char-0x10>HBg <Nop>
cmap <Char-0x10>HBf <Nop>
cmap <Char-0x10>HBe <Nop>
cmap <Char-0x10>HBh <Nop>
cmap <Char-0x10>H+ <Nop>
" }}}

" Movement [Alt + Ctrl + Shift]{{{
cmap <Char-0x10>H6 <Nop>
cmap <Char-0x10>H. <Nop>
cmap <Char-0x10>H5 <Nop>
cmap <Char-0x10>H9 <Nop>
cmap <Char-0x10>H8 <Nop>
cmap <Char-0x10>H4 <Nop>
cmap <Char-0x10>H7 <Nop>
" }}}

" Numpad [Alt + Ctrl + Shift]{{{
cmap <Char-0x10>HBJ <Nop>
cmap <Char-0x10>HBK <Nop>
cmap <Char-0x10>HBL <Nop>
cmap <Char-0x10>HBM <Nop>
cmap <Char-0x10>HBN <Nop>
cmap <Char-0x10>HBO <Nop>
cmap <Char-0x10>HBP <Nop>
cmap <Char-0x10>HBQ <Nop>
cmap <Char-0x10>HBR <Nop>
cmap <Char-0x10>HBS <Nop>
cmap <Char-0x10>HBX <Nop>
cmap <Char-0x10>HBT <Nop>
cmap <Char-0x10>HBU <Nop>
cmap <Char-0x10>HBY <Nop>
cmap <Char-0x10>HBZ <Nop>
cmap <Char-0x10>HBV <Nop>
cmap <Char-0x10>HBW <Nop>
" }}}
" }}}
" Super [I]{{{
" Alphanumerics [Super]{{{
cmap <Char-0x10>IS <Nop>
cmap <Char-0x10>IT <Nop>
cmap <Char-0x10>IU <Nop>
cmap <Char-0x10>IV <Nop>
cmap <Char-0x10>IW <Nop>
cmap <Char-0x10>IX <Nop>
cmap <Char-0x10>IY <Nop>
cmap <Char-0x10>IZ <Nop>
cmap <Char-0x10>Ia <Nop>
cmap <Char-0x10>Ib <Nop>
cmap <Char-0x10>Ic <Nop>
cmap <Char-0x10>Id <Nop>
cmap <Char-0x10>Ie <Nop>
cmap <Char-0x10>If <Nop>
cmap <Char-0x10>Ig <Nop>
cmap <Char-0x10>Ih <Nop>
cmap <Char-0x10>Ii <Nop>
cmap <Char-0x10>Ij <Nop>
cmap <Char-0x10>Ik <Nop>
cmap <Char-0x10>Il <Nop>
cmap <Char-0x10>Im <Nop>
cmap <Char-0x10>In <Nop>
cmap <Char-0x10>Io <Nop>
cmap <Char-0x10>Ip <Nop>
cmap <Char-0x10>Iq <Nop>
cmap <Char-0x10>Ir <Nop>
cmap <Char-0x10>IG <Nop>
cmap <Char-0x10>IH <Nop>
cmap <Char-0x10>II <Nop>
cmap <Char-0x10>IJ <Nop>
cmap <Char-0x10>IK <Nop>
cmap <Char-0x10>IL <Nop>
cmap <Char-0x10>IM <Nop>
cmap <Char-0x10>IN <Nop>
cmap <Char-0x10>IO <Nop>
cmap <Char-0x10>IP <Nop>
" }}}

" Symbols [Super]{{{
cmap <Char-0x10>IB <Nop>
cmap <Char-0x10>It <Nop>
cmap <Char-0x10>I1 <Nop>
cmap <Char-0x10>IC <Nop>
cmap <Char-0x10>I3 <Nop>
cmap <Char-0x10>I- <Nop>
cmap <Char-0x10>Iz <Nop>
cmap <Char-0x10>IR <Nop>
cmap <Char-0x10>Iy <Nop>
cmap <Char-0x10>Iv <Nop>
cmap <Char-0x10>Is <Nop>
cmap <Char-0x10>ID <Nop>
cmap <Char-0x10>I! <Nop>
cmap <Char-0x10>IE <Nop>
cmap <Char-0x10>Iu <Nop>
cmap <Char-0x10>IQ <Nop>
cmap <Char-0x10>IF <Nop>
cmap <Char-0x10>IA <Nop>
cmap <Char-0x10>I0 <Nop>
cmap <Char-0x10>Iw <Nop>
cmap <Char-0x10>Ix <Nop>
cmap <Char-0x10>I^ <Nop>
" }}}

" Function keys [Super]{{{
cmap <Char-0x10>I/ <Nop>
cmap <Char-0x10>I* <Nop>
cmap <Char-0x10>I? <Nop>
cmap <Char-0x10>I& <Nop>
cmap <Char-0x10>I< <Nop>
cmap <Char-0x10>I> <Nop>
cmap <Char-0x10>I( <Nop>
cmap <Char-0x10>I) <Nop>
cmap <Char-0x10>I[ <Nop>
cmap <Char-0x10>I] <Nop>
cmap <Char-0x10>I{ <Nop>
cmap <Char-0x10>I} <Nop>
cmap <Char-0x10>I@ <Nop>
cmap <Char-0x10>I% <Nop>
cmap <Char-0x10>I$ <Nop>
cmap <Char-0x10>I# <Nop>
cmap <Char-0x10>IBA <Nop>
cmap <Char-0x10>IBB <Nop>
cmap <Char-0x10>IBC <Nop>
cmap <Char-0x10>IBD <Nop>
cmap <Char-0x10>IBE <Nop>
cmap <Char-0x10>IBF <Nop>
cmap <Char-0x10>IBG <Nop>
cmap <Char-0x10>IBH <Nop>
cmap <Char-0x10>IBI <Nop>
" }}}

" Modifiers [Super]{{{
cmap <Char-0x10>I: <Nop>
cmap <Char-0x10>I2 <Nop>
cmap <Char-0x10>IBc <Nop>
cmap <Char-0x10>IBb <Nop>
cmap <Char-0x10>IBa <Nop>
cmap <Char-0x10>IBd <Nop>
cmap <Char-0x10>I= <Nop>
cmap <Char-0x10>IBg <Nop>
cmap <Char-0x10>IBf <Nop>
cmap <Char-0x10>IBe <Nop>
cmap <Char-0x10>IBh <Nop>
cmap <Char-0x10>I+ <Nop>
" }}}

" Movement [Super]{{{
cmap <Char-0x10>I6 <Nop>
cmap <Char-0x10>I. <Nop>
cmap <Char-0x10>I5 <Nop>
cmap <Char-0x10>I9 <Nop>
cmap <Char-0x10>I8 <Nop>
cmap <Char-0x10>I4 <Nop>
cmap <Char-0x10>I7 <Nop>
" }}}

" Numpad [Super]{{{
cmap <Char-0x10>IBJ <Nop>
cmap <Char-0x10>IBK <Nop>
cmap <Char-0x10>IBL <Nop>
cmap <Char-0x10>IBM <Nop>
cmap <Char-0x10>IBN <Nop>
cmap <Char-0x10>IBO <Nop>
cmap <Char-0x10>IBP <Nop>
cmap <Char-0x10>IBQ <Nop>
cmap <Char-0x10>IBR <Nop>
cmap <Char-0x10>IBS <Nop>
cmap <Char-0x10>IBX <Nop>
cmap <Char-0x10>IBT <Nop>
cmap <Char-0x10>IBU <Nop>
cmap <Char-0x10>IBY <Nop>
cmap <Char-0x10>IBZ <Nop>
cmap <Char-0x10>IBV <Nop>
cmap <Char-0x10>IBW <Nop>
" }}}
" }}}
" Shift + Super [J]{{{
" Alphanumerics [Shift + Super]{{{
cmap <Char-0x10>JS <Nop>
cmap <Char-0x10>JT <Nop>
cmap <Char-0x10>JU <Nop>
cmap <Char-0x10>JV <Nop>
cmap <Char-0x10>JW <Nop>
cmap <Char-0x10>JX <Nop>
cmap <Char-0x10>JY <Nop>
cmap <Char-0x10>JZ <Nop>
cmap <Char-0x10>Ja <Nop>
cmap <Char-0x10>Jb <Nop>
cmap <Char-0x10>Jc <Nop>
cmap <Char-0x10>Jd <Nop>
cmap <Char-0x10>Je <Nop>
cmap <Char-0x10>Jf <Nop>
cmap <Char-0x10>Jg <Nop>
cmap <Char-0x10>Jh <Nop>
cmap <Char-0x10>Ji <Nop>
cmap <Char-0x10>Jj <Nop>
cmap <Char-0x10>Jk <Nop>
cmap <Char-0x10>Jl <Nop>
cmap <Char-0x10>Jm <Nop>
cmap <Char-0x10>Jn <Nop>
cmap <Char-0x10>Jo <Nop>
cmap <Char-0x10>Jp <Nop>
cmap <Char-0x10>Jq <Nop>
cmap <Char-0x10>Jr <Nop>
cmap <Char-0x10>JG <Nop>
cmap <Char-0x10>JH <Nop>
cmap <Char-0x10>JI <Nop>
cmap <Char-0x10>JJ <Nop>
cmap <Char-0x10>JK <Nop>
cmap <Char-0x10>JL <Nop>
cmap <Char-0x10>JM <Nop>
cmap <Char-0x10>JN <Nop>
cmap <Char-0x10>JO <Nop>
cmap <Char-0x10>JP <Nop>
" }}}

" Symbols [Shift + Super]{{{
cmap <Char-0x10>JB <Nop>
cmap <Char-0x10>Jt <Nop>
cmap <Char-0x10>J1 <Nop>
cmap <Char-0x10>JC <Nop>
cmap <Char-0x10>J3 <Nop>
cmap <Char-0x10>J- <Nop>
cmap <Char-0x10>Jz <Nop>
cmap <Char-0x10>JR <Nop>
cmap <Char-0x10>Jy <Nop>
cmap <Char-0x10>Jv <Nop>
cmap <Char-0x10>Js <Nop>
cmap <Char-0x10>JD <Nop>
cmap <Char-0x10>J! <Nop>
cmap <Char-0x10>JE <Nop>
cmap <Char-0x10>Ju <Nop>
cmap <Char-0x10>JQ <Nop>
cmap <Char-0x10>JF <Nop>
cmap <Char-0x10>JA <Nop>
cmap <Char-0x10>J0 <Nop>
cmap <Char-0x10>Jw <Nop>
cmap <Char-0x10>Jx <Nop>
cmap <Char-0x10>J^ <Nop>
" }}}

" Function keys [Shift + Super]{{{
cmap <Char-0x10>J/ <Nop>
cmap <Char-0x10>J* <Nop>
cmap <Char-0x10>J? <Nop>
cmap <Char-0x10>J& <Nop>
cmap <Char-0x10>J< <Nop>
cmap <Char-0x10>J> <Nop>
cmap <Char-0x10>J( <Nop>
cmap <Char-0x10>J) <Nop>
cmap <Char-0x10>J[ <Nop>
cmap <Char-0x10>J] <Nop>
cmap <Char-0x10>J{ <Nop>
cmap <Char-0x10>J} <Nop>
cmap <Char-0x10>J@ <Nop>
cmap <Char-0x10>J% <Nop>
cmap <Char-0x10>J$ <Nop>
cmap <Char-0x10>J# <Nop>
cmap <Char-0x10>JBA <Nop>
cmap <Char-0x10>JBB <Nop>
cmap <Char-0x10>JBC <Nop>
cmap <Char-0x10>JBD <Nop>
cmap <Char-0x10>JBE <Nop>
cmap <Char-0x10>JBF <Nop>
cmap <Char-0x10>JBG <Nop>
cmap <Char-0x10>JBH <Nop>
cmap <Char-0x10>JBI <Nop>
" }}}

" Modifiers [Shift + Super]{{{
cmap <Char-0x10>J: <Nop>
cmap <Char-0x10>J2 <Nop>
cmap <Char-0x10>JBc <Nop>
cmap <Char-0x10>JBb <Nop>
cmap <Char-0x10>JBa <Nop>
cmap <Char-0x10>JBd <Nop>
cmap <Char-0x10>J= <Nop>
cmap <Char-0x10>JBg <Nop>
cmap <Char-0x10>JBf <Nop>
cmap <Char-0x10>JBe <Nop>
cmap <Char-0x10>JBh <Nop>
cmap <Char-0x10>J+ <Nop>
" }}}

" Movement [Shift + Super]{{{
cmap <Char-0x10>J6 <Nop>
cmap <Char-0x10>J. <Nop>
cmap <Char-0x10>J5 <Nop>
cmap <Char-0x10>J9 <Nop>
cmap <Char-0x10>J8 <Nop>
cmap <Char-0x10>J4 <Nop>
cmap <Char-0x10>J7 <Nop>
" }}}

" Numpad [Shift + Super]{{{
cmap <Char-0x10>JBJ <Nop>
cmap <Char-0x10>JBK <Nop>
cmap <Char-0x10>JBL <Nop>
cmap <Char-0x10>JBM <Nop>
cmap <Char-0x10>JBN <Nop>
cmap <Char-0x10>JBO <Nop>
cmap <Char-0x10>JBP <Nop>
cmap <Char-0x10>JBQ <Nop>
cmap <Char-0x10>JBR <Nop>
cmap <Char-0x10>JBS <Nop>
cmap <Char-0x10>JBX <Nop>
cmap <Char-0x10>JBT <Nop>
cmap <Char-0x10>JBU <Nop>
cmap <Char-0x10>JBY <Nop>
cmap <Char-0x10>JBZ <Nop>
cmap <Char-0x10>JBV <Nop>
cmap <Char-0x10>JBW <Nop>
" }}}
" }}}
" Alt + Super [K]{{{
" Alphanumerics [Alt + Super]{{{
cmap <Char-0x10>KS <Nop>
cmap <Char-0x10>KT <Nop>
cmap <Char-0x10>KU <Nop>
cmap <Char-0x10>KV <Nop>
cmap <Char-0x10>KW <Nop>
cmap <Char-0x10>KX <Nop>
cmap <Char-0x10>KY <Nop>
cmap <Char-0x10>KZ <Nop>
cmap <Char-0x10>Ka <Nop>
cmap <Char-0x10>Kb <Nop>
cmap <Char-0x10>Kc <Nop>
cmap <Char-0x10>Kd <Nop>
cmap <Char-0x10>Ke <Nop>
cmap <Char-0x10>Kf <Nop>
cmap <Char-0x10>Kg <Nop>
cmap <Char-0x10>Kh <Nop>
cmap <Char-0x10>Ki <Nop>
cmap <Char-0x10>Kj <Nop>
cmap <Char-0x10>Kk <Nop>
cmap <Char-0x10>Kl <Nop>
cmap <Char-0x10>Km <Nop>
cmap <Char-0x10>Kn <Nop>
cmap <Char-0x10>Ko <Nop>
cmap <Char-0x10>Kp <Nop>
cmap <Char-0x10>Kq <Nop>
cmap <Char-0x10>Kr <Nop>
cmap <Char-0x10>KG <Nop>
cmap <Char-0x10>KH <Nop>
cmap <Char-0x10>KI <Nop>
cmap <Char-0x10>KJ <Nop>
cmap <Char-0x10>KK <Nop>
cmap <Char-0x10>KL <Nop>
cmap <Char-0x10>KM <Nop>
cmap <Char-0x10>KN <Nop>
cmap <Char-0x10>KO <Nop>
cmap <Char-0x10>KP <Nop>
" }}}

" Symbols [Alt + Super]{{{
cmap <Char-0x10>KB <Nop>
cmap <Char-0x10>Kt <Nop>
cmap <Char-0x10>K1 <Nop>
cmap <Char-0x10>KC <Nop>
cmap <Char-0x10>K3 <Nop>
cmap <Char-0x10>K- <Nop>
cmap <Char-0x10>Kz <Nop>
cmap <Char-0x10>KR <Nop>
cmap <Char-0x10>Ky <Nop>
cmap <Char-0x10>Kv <Nop>
cmap <Char-0x10>Ks <Nop>
cmap <Char-0x10>KD <Nop>
cmap <Char-0x10>K! <Nop>
cmap <Char-0x10>KE <Nop>
cmap <Char-0x10>Ku <Nop>
cmap <Char-0x10>KQ <Nop>
cmap <Char-0x10>KF <Nop>
cmap <Char-0x10>KA <Nop>
cmap <Char-0x10>K0 <Nop>
cmap <Char-0x10>Kw <Nop>
cmap <Char-0x10>Kx <Nop>
cmap <Char-0x10>K^ <Nop>
" }}}

" Function keys [Alt + Super]{{{
cmap <Char-0x10>K/ <Nop>
cmap <Char-0x10>K* <Nop>
cmap <Char-0x10>K? <Nop>
cmap <Char-0x10>K& <Nop>
cmap <Char-0x10>K< <Nop>
cmap <Char-0x10>K> <Nop>
cmap <Char-0x10>K( <Nop>
cmap <Char-0x10>K) <Nop>
cmap <Char-0x10>K[ <Nop>
cmap <Char-0x10>K] <Nop>
cmap <Char-0x10>K{ <Nop>
cmap <Char-0x10>K} <Nop>
cmap <Char-0x10>K@ <Nop>
cmap <Char-0x10>K% <Nop>
cmap <Char-0x10>K$ <Nop>
cmap <Char-0x10>K# <Nop>
cmap <Char-0x10>KBA <Nop>
cmap <Char-0x10>KBB <Nop>
cmap <Char-0x10>KBC <Nop>
cmap <Char-0x10>KBD <Nop>
cmap <Char-0x10>KBE <Nop>
cmap <Char-0x10>KBF <Nop>
cmap <Char-0x10>KBG <Nop>
cmap <Char-0x10>KBH <Nop>
cmap <Char-0x10>KBI <Nop>
" }}}

" Modifiers [Alt + Super]{{{
cmap <Char-0x10>K: <Nop>
cmap <Char-0x10>K2 <Nop>
cmap <Char-0x10>KBc <Nop>
cmap <Char-0x10>KBb <Nop>
cmap <Char-0x10>KBa <Nop>
cmap <Char-0x10>KBd <Nop>
cmap <Char-0x10>K= <Nop>
cmap <Char-0x10>KBg <Nop>
cmap <Char-0x10>KBf <Nop>
cmap <Char-0x10>KBe <Nop>
cmap <Char-0x10>KBh <Nop>
cmap <Char-0x10>K+ <Nop>
" }}}

" Movement [Alt + Super]{{{
cmap <Char-0x10>K6 <Nop>
cmap <Char-0x10>K. <Nop>
cmap <Char-0x10>K5 <Nop>
cmap <Char-0x10>K9 <Nop>
cmap <Char-0x10>K8 <Nop>
cmap <Char-0x10>K4 <Nop>
cmap <Char-0x10>K7 <Nop>
" }}}

" Numpad [Alt + Super]{{{
cmap <Char-0x10>KBJ <Nop>
cmap <Char-0x10>KBK <Nop>
cmap <Char-0x10>KBL <Nop>
cmap <Char-0x10>KBM <Nop>
cmap <Char-0x10>KBN <Nop>
cmap <Char-0x10>KBO <Nop>
cmap <Char-0x10>KBP <Nop>
cmap <Char-0x10>KBQ <Nop>
cmap <Char-0x10>KBR <Nop>
cmap <Char-0x10>KBS <Nop>
cmap <Char-0x10>KBX <Nop>
cmap <Char-0x10>KBT <Nop>
cmap <Char-0x10>KBU <Nop>
cmap <Char-0x10>KBY <Nop>
cmap <Char-0x10>KBZ <Nop>
cmap <Char-0x10>KBV <Nop>
cmap <Char-0x10>KBW <Nop>
" }}}
" }}}
" Alt + Shift + Super [L]{{{
" Alphanumerics [Alt + Shift + Super]{{{
cmap <Char-0x10>LS <Nop>
cmap <Char-0x10>LT <Nop>
cmap <Char-0x10>LU <Nop>
cmap <Char-0x10>LV <Nop>
cmap <Char-0x10>LW <Nop>
cmap <Char-0x10>LX <Nop>
cmap <Char-0x10>LY <Nop>
cmap <Char-0x10>LZ <Nop>
cmap <Char-0x10>La <Nop>
cmap <Char-0x10>Lb <Nop>
cmap <Char-0x10>Lc <Nop>
cmap <Char-0x10>Ld <Nop>
cmap <Char-0x10>Le <Nop>
cmap <Char-0x10>Lf <Nop>
cmap <Char-0x10>Lg <Nop>
cmap <Char-0x10>Lh <Nop>
cmap <Char-0x10>Li <Nop>
cmap <Char-0x10>Lj <Nop>
cmap <Char-0x10>Lk <Nop>
cmap <Char-0x10>Ll <Nop>
cmap <Char-0x10>Lm <Nop>
cmap <Char-0x10>Ln <Nop>
cmap <Char-0x10>Lo <Nop>
cmap <Char-0x10>Lp <Nop>
cmap <Char-0x10>Lq <Nop>
cmap <Char-0x10>Lr <Nop>
cmap <Char-0x10>LG <Nop>
cmap <Char-0x10>LH <Nop>
cmap <Char-0x10>LI <Nop>
cmap <Char-0x10>LJ <Nop>
cmap <Char-0x10>LK <Nop>
cmap <Char-0x10>LL <Nop>
cmap <Char-0x10>LM <Nop>
cmap <Char-0x10>LN <Nop>
cmap <Char-0x10>LO <Nop>
cmap <Char-0x10>LP <Nop>
" }}}

" Symbols [Alt + Shift  + Super]{{{
cmap <Char-0x10>LB <Nop>
cmap <Char-0x10>Lt <Nop>
cmap <Char-0x10>L1 <Nop>
cmap <Char-0x10>LC <Nop>
cmap <Char-0x10>L3 <Nop>
cmap <Char-0x10>L- <Nop>
cmap <Char-0x10>Lz <Nop>
cmap <Char-0x10>LR <Nop>
cmap <Char-0x10>Ly <Nop>
cmap <Char-0x10>Lv <Nop>
cmap <Char-0x10>Ls <Nop>
cmap <Char-0x10>LD <Nop>
cmap <Char-0x10>L! <Nop>
cmap <Char-0x10>LE <Nop>
cmap <Char-0x10>Lu <Nop>
cmap <Char-0x10>LQ <Nop>
cmap <Char-0x10>LF <Nop>
cmap <Char-0x10>LA <Nop>
cmap <Char-0x10>L0 <Nop>
cmap <Char-0x10>Lw <Nop>
cmap <Char-0x10>Lx <Nop>
cmap <Char-0x10>L^ <Nop>
" }}}

" Function keys [Alt + Shift + Super]{{{
cmap <Char-0x10>L/ <Nop>
cmap <Char-0x10>L* <Nop>
cmap <Char-0x10>L? <Nop>
cmap <Char-0x10>L& <Nop>
cmap <Char-0x10>L< <Nop>
cmap <Char-0x10>L> <Nop>
cmap <Char-0x10>L( <Nop>
cmap <Char-0x10>L) <Nop>
cmap <Char-0x10>L[ <Nop>
cmap <Char-0x10>L] <Nop>
cmap <Char-0x10>L{ <Nop>
cmap <Char-0x10>L} <Nop>
cmap <Char-0x10>L@ <Nop>
cmap <Char-0x10>L% <Nop>
cmap <Char-0x10>L$ <Nop>
cmap <Char-0x10>L# <Nop>
cmap <Char-0x10>LBA <Nop>
cmap <Char-0x10>LBB <Nop>
cmap <Char-0x10>LBC <Nop>
cmap <Char-0x10>LBD <Nop>
cmap <Char-0x10>LBE <Nop>
cmap <Char-0x10>LBF <Nop>
cmap <Char-0x10>LBG <Nop>
cmap <Char-0x10>LBH <Nop>
cmap <Char-0x10>LBI <Nop>
" }}}

" Modifiers [Alt + Shift + Super]{{{
cmap <Char-0x10>L: <Nop>
cmap <Char-0x10>L2 <Nop>
cmap <Char-0x10>LBc <Nop>
cmap <Char-0x10>LBb <Nop>
cmap <Char-0x10>LBa <Nop>
cmap <Char-0x10>LBd <Nop>
cmap <Char-0x10>L= <Nop>
cmap <Char-0x10>LBg <Nop>
cmap <Char-0x10>LBf <Nop>
cmap <Char-0x10>LBe <Nop>
cmap <Char-0x10>LBh <Nop>
cmap <Char-0x10>L+ <Nop>
" }}}

" Movement [Alt + Shift + Super]{{{
cmap <Char-0x10>L6 <Nop>
cmap <Char-0x10>L. <Nop>
cmap <Char-0x10>L5 <Nop>
cmap <Char-0x10>L9 <Nop>
cmap <Char-0x10>L8 <Nop>
cmap <Char-0x10>L4 <Nop>
cmap <Char-0x10>L7 <Nop>
" }}}

" Numpad [Alt + Shift + Super]{{{
cmap <Char-0x10>LBJ <Nop>
cmap <Char-0x10>LBK <Nop>
cmap <Char-0x10>LBL <Nop>
cmap <Char-0x10>LBM <Nop>
cmap <Char-0x10>LBN <Nop>
cmap <Char-0x10>LBO <Nop>
cmap <Char-0x10>LBP <Nop>
cmap <Char-0x10>LBQ <Nop>
cmap <Char-0x10>LBR <Nop>
cmap <Char-0x10>LBS <Nop>
cmap <Char-0x10>LBX <Nop>
cmap <Char-0x10>LBT <Nop>
cmap <Char-0x10>LBU <Nop>
cmap <Char-0x10>LBY <Nop>
cmap <Char-0x10>LBZ <Nop>
cmap <Char-0x10>LBV <Nop>
cmap <Char-0x10>LBW <Nop>
" }}}
" }}}
" Alt + Ctrl + Shift + Super [L]{{{
" Alphanumerics [Ctrl + Super]{{{
cmap <Char-0x10>MS <Nop>
cmap <Char-0x10>MT <Nop>
cmap <Char-0x10>MU <Nop>
cmap <Char-0x10>MV <Nop>
cmap <Char-0x10>MW <Nop>
cmap <Char-0x10>MX <Nop>
cmap <Char-0x10>MY <Nop>
cmap <Char-0x10>MZ <Nop>
cmap <Char-0x10>Ma <Nop>
cmap <Char-0x10>Mb <Nop>
cmap <Char-0x10>Mc <Nop>
cmap <Char-0x10>Md <Nop>
cmap <Char-0x10>Me <Nop>
cmap <Char-0x10>Mf <Nop>
cmap <Char-0x10>Mg <Nop>
cmap <Char-0x10>Mh <Nop>
cmap <Char-0x10>Mi <Nop>
cmap <Char-0x10>Mj <Nop>
cmap <Char-0x10>Mk <Nop>
cmap <Char-0x10>Ml <Nop>
cmap <Char-0x10>Mm <Nop>
cmap <Char-0x10>Mn <Nop>
cmap <Char-0x10>Mo <Nop>
cmap <Char-0x10>Mp <Nop>
cmap <Char-0x10>Mq <Nop>
cmap <Char-0x10>Mr <Nop>
cmap <Char-0x10>MG <Nop>
cmap <Char-0x10>MH <Nop>
cmap <Char-0x10>MI <Nop>
cmap <Char-0x10>MJ <Nop>
cmap <Char-0x10>MK <Nop>
cmap <Char-0x10>ML <Nop>
cmap <Char-0x10>MM <Nop>
cmap <Char-0x10>MN <Nop>
cmap <Char-0x10>MO <Nop>
cmap <Char-0x10>MP <Nop>
" }}}

" Symbols [Ctrl + Super]{{{
cmap <Char-0x10>MB <Nop>
cmap <Char-0x10>Mt <Nop>
cmap <Char-0x10>M1 <Nop>
cmap <Char-0x10>MC <Nop>
cmap <Char-0x10>M3 <Nop>
cmap <Char-0x10>M- <Nop>
cmap <Char-0x10>Mz <Nop>
cmap <Char-0x10>MR <Nop>
cmap <Char-0x10>My <Nop>
cmap <Char-0x10>Mv <Nop>
cmap <Char-0x10>Ms <Nop>
cmap <Char-0x10>MD <Nop>
cmap <Char-0x10>M! <Nop>
cmap <Char-0x10>ME <Nop>
cmap <Char-0x10>Mu <Nop>
cmap <Char-0x10>MQ <Nop>
cmap <Char-0x10>MF <Nop>
cmap <Char-0x10>MA <Nop>
cmap <Char-0x10>M0 <Nop>
cmap <Char-0x10>Mw <Nop>
cmap <Char-0x10>Mx <Nop>
cmap <Char-0x10>M^ <Nop>
" }}}

" Function keys [Ctrl + Super]{{{
cmap <Char-0x10>M/ <Nop>
cmap <Char-0x10>M* <Nop>
cmap <Char-0x10>M? <Nop>
cmap <Char-0x10>M& <Nop>
cmap <Char-0x10>M< <Nop>
cmap <Char-0x10>M> <Nop>
cmap <Char-0x10>M( <Nop>
cmap <Char-0x10>M) <Nop>
cmap <Char-0x10>M[ <Nop>
cmap <Char-0x10>M] <Nop>
cmap <Char-0x10>M{ <Nop>
cmap <Char-0x10>M} <Nop>
cmap <Char-0x10>M@ <Nop>
cmap <Char-0x10>M% <Nop>
cmap <Char-0x10>M$ <Nop>
cmap <Char-0x10>M# <Nop>
cmap <Char-0x10>MBA <Nop>
cmap <Char-0x10>MBB <Nop>
cmap <Char-0x10>MBC <Nop>
cmap <Char-0x10>MBD <Nop>
cmap <Char-0x10>MBE <Nop>
cmap <Char-0x10>MBF <Nop>
cmap <Char-0x10>MBG <Nop>
cmap <Char-0x10>MBH <Nop>
cmap <Char-0x10>MBI <Nop>
" }}}

" Modifiers [Ctrl + Super]{{{
cmap <Char-0x10>M: <Nop>
cmap <Char-0x10>M2 <Nop>
cmap <Char-0x10>MBc <Nop>
cmap <Char-0x10>MBb <Nop>
cmap <Char-0x10>MBa <Nop>
cmap <Char-0x10>MBd <Nop>
cmap <Char-0x10>M= <Nop>
cmap <Char-0x10>MBg <Nop>
cmap <Char-0x10>MBf <Nop>
cmap <Char-0x10>MBe <Nop>
cmap <Char-0x10>MBh <Nop>
cmap <Char-0x10>M+ <Nop>
" }}}

" Movement [Ctrl + Super]{{{
cmap <Char-0x10>M6 <Nop>
cmap <Char-0x10>M. <Nop>
cmap <Char-0x10>M5 <Nop>
cmap <Char-0x10>M9 <Nop>
cmap <Char-0x10>M8 <Nop>
cmap <Char-0x10>M4 <Nop>
cmap <Char-0x10>M7 <Nop>
" }}}

" Numpad [Ctrl + Super]{{{
cmap <Char-0x10>MBJ <Nop>
cmap <Char-0x10>MBK <Nop>
cmap <Char-0x10>MBL <Nop>
cmap <Char-0x10>MBM <Nop>
cmap <Char-0x10>MBN <Nop>
cmap <Char-0x10>MBO <Nop>
cmap <Char-0x10>MBP <Nop>
cmap <Char-0x10>MBQ <Nop>
cmap <Char-0x10>MBR <Nop>
cmap <Char-0x10>MBS <Nop>
cmap <Char-0x10>MBX <Nop>
cmap <Char-0x10>MBT <Nop>
cmap <Char-0x10>MBU <Nop>
cmap <Char-0x10>MBY <Nop>
cmap <Char-0x10>MBZ <Nop>
cmap <Char-0x10>MBV <Nop>
cmap <Char-0x10>MBW <Nop>
" }}}
" }}}
" Ctrl + Shift + Super [N]{{{
" Alphanumerics [Ctrl + Shift + Super]{{{
cmap <Char-0x10>NS <Nop>
cmap <Char-0x10>NT <Nop>
cmap <Char-0x10>NU <Nop>
cmap <Char-0x10>NV <Nop>
cmap <Char-0x10>NW <Nop>
cmap <Char-0x10>NX <Nop>
cmap <Char-0x10>NY <Nop>
cmap <Char-0x10>NZ <Nop>
cmap <Char-0x10>Na <Nop>
cmap <Char-0x10>Nb <Nop>
cmap <Char-0x10>Nc <Nop>
cmap <Char-0x10>Nd <Nop>
cmap <Char-0x10>Ne <Nop>
cmap <Char-0x10>Nf <Nop>
cmap <Char-0x10>Ng <Nop>
cmap <Char-0x10>Nh <Nop>
cmap <Char-0x10>Ni <Nop>
cmap <Char-0x10>Nj <Nop>
cmap <Char-0x10>Nk <Nop>
cmap <Char-0x10>Nl <Nop>
cmap <Char-0x10>Nm <Nop>
cmap <Char-0x10>Nn <Nop>
cmap <Char-0x10>No <Nop>
cmap <Char-0x10>Np <Nop>
cmap <Char-0x10>Nq <Nop>
cmap <Char-0x10>Nr <Nop>
cmap <Char-0x10>NG <Nop>
cmap <Char-0x10>NH <Nop>
cmap <Char-0x10>NI <Nop>
cmap <Char-0x10>NJ <Nop>
cmap <Char-0x10>NK <Nop>
cmap <Char-0x10>NL <Nop>
cmap <Char-0x10>NM <Nop>
cmap <Char-0x10>NN <Nop>
cmap <Char-0x10>NO <Nop>
cmap <Char-0x10>NP <Nop>
" }}}

" Symbols [Ctrl + Shift + Super]{{{
cmap <Char-0x10>NB <Nop>
cmap <Char-0x10>Nt <Nop>
cmap <Char-0x10>N1 <Nop>
cmap <Char-0x10>NC <Nop>
cmap <Char-0x10>N3 <Nop>
cmap <Char-0x10>N- <Nop>
cmap <Char-0x10>Nz <Nop>
cmap <Char-0x10>NR <Nop>
cmap <Char-0x10>Ny <Nop>
cmap <Char-0x10>Nv <Nop>
cmap <Char-0x10>Ns <Nop>
cmap <Char-0x10>ND <Nop>
cmap <Char-0x10>N! <Nop>
cmap <Char-0x10>NE <Nop>
cmap <Char-0x10>Nu <Nop>
cmap <Char-0x10>NQ <Nop>
cmap <Char-0x10>NF <Nop>
cmap <Char-0x10>NA <Nop>
cmap <Char-0x10>N0 <Nop>
cmap <Char-0x10>Nw <Nop>
cmap <Char-0x10>Nx <Nop>
cmap <Char-0x10>N^ <Nop>
" }}}

" Function keys [Ctrl + Shift + Super]{{{
cmap <Char-0x10>N/ <Nop>
cmap <Char-0x10>N* <Nop>
cmap <Char-0x10>N? <Nop>
cmap <Char-0x10>N& <Nop>
cmap <Char-0x10>N< <Nop>
cmap <Char-0x10>N> <Nop>
cmap <Char-0x10>N( <Nop>
cmap <Char-0x10>N) <Nop>
cmap <Char-0x10>N[ <Nop>
cmap <Char-0x10>N] <Nop>
cmap <Char-0x10>N{ <Nop>
cmap <Char-0x10>N} <Nop>
cmap <Char-0x10>N@ <Nop>
cmap <Char-0x10>N% <Nop>
cmap <Char-0x10>N$ <Nop>
cmap <Char-0x10>N# <Nop>
cmap <Char-0x10>NBA <Nop>
cmap <Char-0x10>NBB <Nop>
cmap <Char-0x10>NBC <Nop>
cmap <Char-0x10>NBD <Nop>
cmap <Char-0x10>NBE <Nop>
cmap <Char-0x10>NBF <Nop>
cmap <Char-0x10>NBG <Nop>
cmap <Char-0x10>NBH <Nop>
cmap <Char-0x10>NBI <Nop>
" }}}

" Modifiers [Ctrl + Shift + Super]{{{
cmap <Char-0x10>N: <Nop>
cmap <Char-0x10>N2 <Nop>
cmap <Char-0x10>NBc <Nop>
cmap <Char-0x10>NBb <Nop>
cmap <Char-0x10>NBa <Nop>
cmap <Char-0x10>NBd <Nop>
cmap <Char-0x10>N= <Nop>
cmap <Char-0x10>NBg <Nop>
cmap <Char-0x10>NBf <Nop>
cmap <Char-0x10>NBe <Nop>
cmap <Char-0x10>NBh <Nop>
cmap <Char-0x10>N+ <Nop>
" }}}

" Movement [Ctrl + Shift + Super]{{{
cmap <Char-0x10>N6 <Nop>
cmap <Char-0x10>N. <Nop>
cmap <Char-0x10>N5 <Nop>
cmap <Char-0x10>N9 <Nop>
cmap <Char-0x10>N8 <Nop>
cmap <Char-0x10>N4 <Nop>
cmap <Char-0x10>N7 <Nop>
" }}}

" Numpad [Ctrl + Shift + Super]{{{
cmap <Char-0x10>NBJ <Nop>
cmap <Char-0x10>NBK <Nop>
cmap <Char-0x10>NBL <Nop>
cmap <Char-0x10>NBM <Nop>
cmap <Char-0x10>NBN <Nop>
cmap <Char-0x10>NBO <Nop>
cmap <Char-0x10>NBP <Nop>
cmap <Char-0x10>NBQ <Nop>
cmap <Char-0x10>NBR <Nop>
cmap <Char-0x10>NBS <Nop>
cmap <Char-0x10>NBX <Nop>
cmap <Char-0x10>NBT <Nop>
cmap <Char-0x10>NBU <Nop>
cmap <Char-0x10>NBY <Nop>
cmap <Char-0x10>NBZ <Nop>
cmap <Char-0x10>NBV <Nop>
cmap <Char-0x10>NBW <Nop>
" }}}
" }}}
" Alt + control + Super [O]{{{
" Alphanumerics [Alt + Ctrl + Super]{{{
cmap <Char-0x10>OS <Nop>
cmap <Char-0x10>OT <Nop>
cmap <Char-0x10>OU <Nop>
cmap <Char-0x10>OV <Nop>
cmap <Char-0x10>OW <Nop>
cmap <Char-0x10>OX <Nop>
cmap <Char-0x10>OY <Nop>
cmap <Char-0x10>OZ <Nop>
cmap <Char-0x10>Oa <Nop>
cmap <Char-0x10>Ob <Nop>
cmap <Char-0x10>Oc <Nop>
cmap <Char-0x10>Od <Nop>
cmap <Char-0x10>Oe <Nop>
cmap <Char-0x10>Of <Nop>
cmap <Char-0x10>Og <Nop>
cmap <Char-0x10>Oh <Nop>
cmap <Char-0x10>Oi <Nop>
cmap <Char-0x10>Oj <Nop>
cmap <Char-0x10>Ok <Nop>
cmap <Char-0x10>Ol <Nop>
cmap <Char-0x10>Om <Nop>
cmap <Char-0x10>On <Nop>
cmap <Char-0x10>Oo <Nop>
cmap <Char-0x10>Op <Nop>
cmap <Char-0x10>Oq <Nop>
cmap <Char-0x10>Or <Nop>
cmap <Char-0x10>OG <Nop>
cmap <Char-0x10>OH <Nop>
cmap <Char-0x10>OI <Nop>
cmap <Char-0x10>OJ <Nop>
cmap <Char-0x10>OK <Nop>
cmap <Char-0x10>OL <Nop>
cmap <Char-0x10>OM <Nop>
cmap <Char-0x10>ON <Nop>
cmap <Char-0x10>OO <Nop>
cmap <Char-0x10>OP <Nop>
" }}}

" Symbols [Alt + Ctrl + Super]{{{
cmap <Char-0x10>OB <Nop>
cmap <Char-0x10>Ot <Nop>
cmap <Char-0x10>O1 <Nop>
cmap <Char-0x10>OC <Nop>
cmap <Char-0x10>O3 <Nop>
cmap <Char-0x10>O- <Nop>
cmap <Char-0x10>Oz <Nop>
cmap <Char-0x10>OR <Nop>
cmap <Char-0x10>Oy <Nop>
cmap <Char-0x10>Ov <Nop>
cmap <Char-0x10>Os <Nop>
cmap <Char-0x10>OD <Nop>
cmap <Char-0x10>O! <Nop>
cmap <Char-0x10>OE <Nop>
cmap <Char-0x10>Ou <Nop>
cmap <Char-0x10>OQ <Nop>
cmap <Char-0x10>OF <Nop>
cmap <Char-0x10>OA <Nop>
cmap <Char-0x10>O0 <Nop>
cmap <Char-0x10>Ow <Nop>
cmap <Char-0x10>Ox <Nop>
cmap <Char-0x10>O^ <Nop>
" }}}

" Function keys [Alt + Ctrl + Super]{{{
cmap <Char-0x10>O/ <Nop>
cmap <Char-0x10>O* <Nop>
cmap <Char-0x10>O? <Nop>
cmap <Char-0x10>O& <Nop>
cmap <Char-0x10>O< <Nop>
cmap <Char-0x10>O> <Nop>
cmap <Char-0x10>O( <Nop>
cmap <Char-0x10>O) <Nop>
cmap <Char-0x10>O[ <Nop>
cmap <Char-0x10>O] <Nop>
cmap <Char-0x10>O{ <Nop>
cmap <Char-0x10>O} <Nop>
cmap <Char-0x10>O@ <Nop>
cmap <Char-0x10>O% <Nop>
cmap <Char-0x10>O$ <Nop>
cmap <Char-0x10>O# <Nop>
cmap <Char-0x10>OBA <Nop>
cmap <Char-0x10>OBB <Nop>
cmap <Char-0x10>OBC <Nop>
cmap <Char-0x10>OBD <Nop>
cmap <Char-0x10>OBE <Nop>
cmap <Char-0x10>OBF <Nop>
cmap <Char-0x10>OBG <Nop>
cmap <Char-0x10>OBH <Nop>
cmap <Char-0x10>OBI <Nop>
" }}}

" Modifiers [Alt + Ctrl + Super]{{{
cmap <Char-0x10>O: <Nop>
cmap <Char-0x10>O2 <Nop>
cmap <Char-0x10>OBc <Nop>
cmap <Char-0x10>OBb <Nop>
cmap <Char-0x10>OBa <Nop>
cmap <Char-0x10>OBd <Nop>
cmap <Char-0x10>O= <Nop>
cmap <Char-0x10>OBg <Nop>
cmap <Char-0x10>OBf <Nop>
cmap <Char-0x10>OBe <Nop>
cmap <Char-0x10>OBh <Nop>
cmap <Char-0x10>O+ <Nop>
" }}}

" Movement [Alt + Ctrl + Super]{{{
cmap <Char-0x10>O6 <Nop>
cmap <Char-0x10>O. <Nop>
cmap <Char-0x10>O5 <Nop>
cmap <Char-0x10>O9 <Nop>
cmap <Char-0x10>O8 <Nop>
cmap <Char-0x10>O4 <Nop>
cmap <Char-0x10>O7 <Nop>
" }}}

" Numpad [Alt + Ctrl + Super]{{{
cmap <Char-0x10>OBJ <Nop>
cmap <Char-0x10>OBK <Nop>
cmap <Char-0x10>OBL <Nop>
cmap <Char-0x10>OBM <Nop>
cmap <Char-0x10>OBN <Nop>
cmap <Char-0x10>OBO <Nop>
cmap <Char-0x10>OBP <Nop>
cmap <Char-0x10>OBQ <Nop>
cmap <Char-0x10>OBR <Nop>
cmap <Char-0x10>OBS <Nop>
cmap <Char-0x10>OBX <Nop>
cmap <Char-0x10>OBT <Nop>
cmap <Char-0x10>OBU <Nop>
cmap <Char-0x10>OBY <Nop>
cmap <Char-0x10>OBZ <Nop>
cmap <Char-0x10>OBV <Nop>
cmap <Char-0x10>OBW <Nop>
" }}}
" }}}
" Alt + control + Shift + Super [P]{{{
" Alphanumerics [Alt + Ctrl + Shift + Super]{{{
cmap <Char-0x10>PS <Nop>
cmap <Char-0x10>PT <Nop>
cmap <Char-0x10>PU <Nop>
cmap <Char-0x10>PV <Nop>
cmap <Char-0x10>PW <Nop>
cmap <Char-0x10>PX <Nop>
cmap <Char-0x10>PY <Nop>
cmap <Char-0x10>PZ <Nop>
cmap <Char-0x10>Pa <Nop>
cmap <Char-0x10>Pb <Nop>
cmap <Char-0x10>Pc <Nop>
cmap <Char-0x10>Pd <Nop>
cmap <Char-0x10>Pe <Nop>
cmap <Char-0x10>Pf <Nop>
cmap <Char-0x10>Pg <Nop>
cmap <Char-0x10>Ph <Nop>
cmap <Char-0x10>Pi <Nop>
cmap <Char-0x10>Pj <Nop>
cmap <Char-0x10>Pk <Nop>
cmap <Char-0x10>Pl <Nop>
cmap <Char-0x10>Pm <Nop>
cmap <Char-0x10>Pn <Nop>
cmap <Char-0x10>Po <Nop>
cmap <Char-0x10>Pp <Nop>
cmap <Char-0x10>Pq <Nop>
cmap <Char-0x10>Pr <Nop>
cmap <Char-0x10>PG <Nop>
cmap <Char-0x10>PH <Nop>
cmap <Char-0x10>PI <Nop>
cmap <Char-0x10>PJ <Nop>
cmap <Char-0x10>PK <Nop>
cmap <Char-0x10>PL <Nop>
cmap <Char-0x10>PM <Nop>
cmap <Char-0x10>PN <Nop>
cmap <Char-0x10>PO <Nop>
cmap <Char-0x10>PP <Nop>
" }}}

" Symbols [Alt + Ctrl + Shift + Super]{{{
cmap <Char-0x10>PB <Nop>
cmap <Char-0x10>Pt <Nop>
cmap <Char-0x10>P1 <Nop>
cmap <Char-0x10>PC <Nop>
cmap <Char-0x10>P3 <Nop>
cmap <Char-0x10>P- <Nop>
cmap <Char-0x10>Pz <Nop>
cmap <Char-0x10>PR <Nop>
cmap <Char-0x10>Py <Nop>
cmap <Char-0x10>Pv <Nop>
cmap <Char-0x10>Ps <Nop>
cmap <Char-0x10>PD <Nop>
cmap <Char-0x10>P! <Nop>
cmap <Char-0x10>PE <Nop>
cmap <Char-0x10>Pu <Nop>
cmap <Char-0x10>PQ <Nop>
cmap <Char-0x10>PF <Nop>
cmap <Char-0x10>PA <Nop>
cmap <Char-0x10>P0 <Nop>
cmap <Char-0x10>Pw <Nop>
cmap <Char-0x10>Px <Nop>
cmap <Char-0x10>P^ <Nop>
" }}}

" Function keys [Alt + Ctrl + Shift + Super]{{{
cmap <Char-0x10>p/ <Nop>
cmap <Char-0x10>p* <Nop>
cmap <Char-0x10>p? <Nop>
cmap <Char-0x10>p& <Nop>
cmap <Char-0x10>p< <Nop>
cmap <Char-0x10>p> <Nop>
cmap <Char-0x10>p( <Nop>
cmap <Char-0x10>p) <Nop>
cmap <Char-0x10>p[ <Nop>
cmap <Char-0x10>p] <Nop>
cmap <Char-0x10>p{ <Nop>
cmap <Char-0x10>p} <Nop>
cmap <Char-0x10>p@ <Nop>
cmap <Char-0x10>p% <Nop>
cmap <Char-0x10>p$ <Nop>
cmap <Char-0x10>p# <Nop>
cmap <Char-0x10>pba <Nop>
cmap <Char-0x10>pbb <Nop>
cmap <Char-0x10>pbc <Nop>
cmap <Char-0x10>pbd <Nop>
cmap <Char-0x10>pbe <Nop>
cmap <Char-0x10>pbf <Nop>
cmap <Char-0x10>pbg <Nop>
cmap <Char-0x10>pbh <Nop>
cmap <Char-0x10>pbi <Nop>
" }}}

" Modifiers [Alt + Ctrl + Shift + Super]{{{
cmap <Char-0x10>P: <Nop>
cmap <Char-0x10>P2 <Nop>
cmap <Char-0x10>PBc <Nop>
cmap <Char-0x10>PBb <Nop>
cmap <Char-0x10>PBa <Nop>
cmap <Char-0x10>PBd <Nop>
cmap <Char-0x10>P= <Nop>
cmap <Char-0x10>PBg <Nop>
cmap <Char-0x10>PBf <Nop>
cmap <Char-0x10>PBe <Nop>
cmap <Char-0x10>PBh <Nop>
cmap <Char-0x10>P+ <Nop>
" }}}

" Movement [Alt + Ctrl + Shift + Super]{{{
cmap <Char-0x10>P6 <Nop>
cmap <Char-0x10>P. <Nop>
cmap <Char-0x10>P5 <Nop>
cmap <Char-0x10>P9 <Nop>
cmap <Char-0x10>P8 <Nop>
cmap <Char-0x10>P4 <Nop>
cmap <Char-0x10>P7 <Nop>
" }}}

" Numpad [Alt + Ctrl + Shift +  Super]{{{
cmap <Char-0x10>PBJ <Nop>
cmap <Char-0x10>PBK <Nop>
cmap <Char-0x10>PBL <Nop>
cmap <Char-0x10>PBM <Nop>
cmap <Char-0x10>PBN <Nop>
cmap <Char-0x10>PBO <Nop>
cmap <Char-0x10>PBP <Nop>
cmap <Char-0x10>PBQ <Nop>
cmap <Char-0x10>PBR <Nop>
cmap <Char-0x10>PBS <Nop>
cmap <Char-0x10>PBX <Nop>
cmap <Char-0x10>PBT <Nop>
cmap <Char-0x10>PBU <Nop>
cmap <Char-0x10>PBY <Nop>
cmap <Char-0x10>PBZ <Nop>
cmap <Char-0x10>PBV <Nop>
cmap <Char-0x10>PBW <Nop>
" }}}
" }}}
" }}}

" Terminal {{{
" Shift - Special keys [B] {{{
tmap <Char-0x10>Bz <Nop>
tmap <Char-0x10>B1 <Nop>
tmap <Char-0x10>By <Nop>
" }}}
" Ctrl - Special keys [E] {{{
tmap <Char-0x10>Ez <Nop>
tmap <Char-0x10>E1 <Nop>
tmap <Char-0x10>Ey <Nop>
tmap <Char-0x10>E0 <Nop>
" }}}
" Ctrl + Shift [F]{{{
" Alphanumerics [Ctrl + Shift]{{{
tmap <Char-0x10>FS <Nop>
tmap <Char-0x10>FT <Nop>
tmap <Char-0x10>FU <Nop>
tmap <Char-0x10>FV <Nop>
tmap <Char-0x10>FW <Nop>
tmap <Char-0x10>FX <Nop>
tmap <Char-0x10>FY <Nop>
tmap <Char-0x10>FZ <Nop>
tmap <Char-0x10>Fa <Nop>
tmap <Char-0x10>Fb <Nop>
tmap <Char-0x10>Fc <Nop>
tmap <Char-0x10>Fd <Nop>
tmap <Char-0x10>Fe <Nop>
tmap <Char-0x10>Ff <Nop>
tmap <Char-0x10>Fg <Nop>
tmap <Char-0x10>Fh <Nop>
tmap <Char-0x10>Fi <Nop>
tmap <Char-0x10>Fj <Nop>
tmap <Char-0x10>Fk <Nop>
tmap <Char-0x10>Fl <Nop>
tmap <Char-0x10>Fm <Nop>
tmap <Char-0x10>Fn <Nop>
tmap <Char-0x10>Fo <Nop>
tmap <Char-0x10>Fp <Nop>
tmap <Char-0x10>Fq <Nop>
tmap <Char-0x10>Fr <Nop>
tmap <Char-0x10>FG <Nop>
tmap <Char-0x10>FH <Nop>
tmap <Char-0x10>FI <Nop>
tmap <Char-0x10>FJ <Nop>
tmap <Char-0x10>FK <Nop>
tmap <Char-0x10>FL <Nop>
tmap <Char-0x10>FM <Nop>
tmap <Char-0x10>FN <Nop>
tmap <Char-0x10>FO <Nop>
tmap <Char-0x10>FP <Nop>
" }}}

" Symbols [Ctrl + Shift]{{{
tmap <Char-0x10>FB <Nop>
tmap <Char-0x10>Ft <Nop>
tmap <Char-0x10>F1 <Nop>
tmap <Char-0x10>FC <Nop>
tmap <Char-0x10>F3 <Nop>
tmap <Char-0x10>F- <Nop>
tmap <Char-0x10>Fz <Nop>
tmap <Char-0x10>FR <Nop>
tmap <Char-0x10>Fy <Nop>
tmap <Char-0x10>Fv <Nop>
tmap <Char-0x10>Fs <Nop>
tmap <Char-0x10>FD <Nop>
tmap <Char-0x10>F! <Nop>
tmap <Char-0x10>FE <Nop>
tmap <Char-0x10>Fu <Nop>
tmap <Char-0x10>FQ <Nop>
tmap <Char-0x10>FF <Nop>
tmap <Char-0x10>FA <Nop>
tmap <Char-0x10>F0 <Nop>
tmap <Char-0x10>Fw <Nop>
tmap <Char-0x10>Fx <Nop>
tmap <Char-0x10>F^ <Nop>
" }}}

" Function keys [Ctrl + Shift]{{{
tmap <Char-0x10>F/ <Nop>
tmap <Char-0x10>F* <Nop>
tmap <Char-0x10>F? <Nop>
tmap <Char-0x10>F& <Nop>
tmap <Char-0x10>F< <Nop>
tmap <Char-0x10>F> <Nop>
tmap <Char-0x10>F( <Nop>
tmap <Char-0x10>F) <Nop>
tmap <Char-0x10>F[ <Nop>
tmap <Char-0x10>F] <Nop>
tmap <Char-0x10>F{ <Nop>
tmap <Char-0x10>F} <Nop>
tmap <Char-0x10>F@ <Nop>
tmap <Char-0x10>F% <Nop>
tmap <Char-0x10>F$ <Nop>
tmap <Char-0x10>F# <Nop>
tmap <Char-0x10>FBA <Nop>
tmap <Char-0x10>FBB <Nop>
tmap <Char-0x10>FBC <Nop>
tmap <Char-0x10>FBD <Nop>
tmap <Char-0x10>FBE <Nop>
tmap <Char-0x10>FBF <Nop>
tmap <Char-0x10>FBG <Nop>
tmap <Char-0x10>FBH <Nop>
tmap <Char-0x10>FBI <Nop>
" }}}

" Modifiers / modes etc [Ctrl + Shift]{{{
tmap <Char-0x10>F: <Nop>
tmap <Char-0x10>F2 <Nop>
tmap <Char-0x10>FBc <Nop>
tmap <Char-0x10>FBb <Nop>
tmap <Char-0x10>FBa <Nop>
tmap <Char-0x10>FBd <Nop>
tmap <Char-0x10>F= <Nop>
tmap <Char-0x10>FBg <Nop>
tmap <Char-0x10>FBf <Nop>
tmap <Char-0x10>FBe <Nop>
tmap <Char-0x10>FBh <Nop>
tmap <Char-0x10>F+ <Nop>
" }}}

" Movement [Ctrl + Shift]{{{
tmap <Char-0x10>F6 <Nop>
tmap <Char-0x10>F. <Nop>
tmap <Char-0x10>F5 <Nop>
tmap <Char-0x10>F9 <Nop>
tmap <Char-0x10>F8 <Nop>
tmap <Char-0x10>F4 <Nop>
tmap <Char-0x10>F7 <Nop>
" }}}

" Numpad [Ctrl + Shift]{{{
tmap <Char-0x10>FBJ <Nop>
tmap <Char-0x10>FBK <Nop>
tmap <Char-0x10>FBL <Nop>
tmap <Char-0x10>FBM <Nop>
tmap <Char-0x10>FBN <Nop>
tmap <Char-0x10>FBO <Nop>
tmap <Char-0x10>FBP <Nop>
tmap <Char-0x10>FBQ <Nop>
tmap <Char-0x10>FBR <Nop>
tmap <Char-0x10>FBS <Nop>
tmap <Char-0x10>FBX <Nop>
tmap <Char-0x10>FBT <Nop>
tmap <Char-0x10>FBU <Nop>
tmap <Char-0x10>FBY <Nop>
tmap <Char-0x10>FBZ <Nop>
tmap <Char-0x10>FBV <Nop>
tmap <Char-0x10>FBW <Nop>
" }}}
" }}}
" Alt + Ctrl [G]{{{
" Alphanumerics [Alt + Ctrl]{{{
tmap <Char-0x10>GS <Nop>
tmap <Char-0x10>GT <Nop>
tmap <Char-0x10>GU <Nop>
tmap <Char-0x10>GV <Nop>
tmap <Char-0x10>GW <Nop>
tmap <Char-0x10>GX <Nop>
tmap <Char-0x10>GY <Nop>
tmap <Char-0x10>GZ <Nop>
tmap <Char-0x10>Ga <Nop>
tmap <Char-0x10>Gb <Nop>
tmap <Char-0x10>Gc <Nop>
tmap <Char-0x10>Gd <Nop>
tmap <Char-0x10>Ge <Nop>
tmap <Char-0x10>Gf <Nop>
tmap <Char-0x10>Gg <Nop>
tmap <Char-0x10>Gh <Nop>
tmap <Char-0x10>Gi <Nop>
tmap <Char-0x10>Gj <Nop>
tmap <Char-0x10>Gk <Nop>
tmap <Char-0x10>Gl <Nop>
tmap <Char-0x10>Gm <Nop>
tmap <Char-0x10>Gn <Nop>
tmap <Char-0x10>Go <Nop>
tmap <Char-0x10>Gp <Nop>
tmap <Char-0x10>Gq <Nop>
tmap <Char-0x10>Gr <Nop>
tmap <Char-0x10>GG <Nop>
tmap <Char-0x10>GH <Nop>
tmap <Char-0x10>GI <Nop>
tmap <Char-0x10>GJ <Nop>
tmap <Char-0x10>GK <Nop>
tmap <Char-0x10>GL <Nop>
tmap <Char-0x10>GM <Nop>
tmap <Char-0x10>GN <Nop>
tmap <Char-0x10>GO <Nop>
tmap <Char-0x10>GP <Nop>
" }}}

" Symbols [Alt + Ctrl]{{{
tmap <Char-0x10>GB <Nop>
tmap <Char-0x10>Gt <Nop>
tmap <Char-0x10>G1 <Nop>
tmap <Char-0x10>GC <Nop>
tmap <Char-0x10>G3 <Nop>
tmap <Char-0x10>G- <Nop>
tmap <Char-0x10>Gz <Nop>
tmap <Char-0x10>GR <Nop>
tmap <Char-0x10>Gy <Nop>
tmap <Char-0x10>Gv <Nop>
tmap <Char-0x10>Gs <Nop>
tmap <Char-0x10>GD <Nop>
tmap <Char-0x10>G! <Nop>
tmap <Char-0x10>GE <Nop>
tmap <Char-0x10>Gu <Nop>
tmap <Char-0x10>GQ <Nop>
tmap <Char-0x10>GF <Nop>
tmap <Char-0x10>GA <Nop>
tmap <Char-0x10>G0 <Nop>
tmap <Char-0x10>Gw <Nop>
tmap <Char-0x10>Gx <Nop>
tmap <Char-0x10>G^ <Nop>
" }}}

" Function keys [Alt + Ctrl]{{{
tmap <Char-0x10>G/ <Nop>
tmap <Char-0x10>G* <Nop>
tmap <Char-0x10>G? <Nop>
tmap <Char-0x10>G& <Nop>
tmap <Char-0x10>G< <Nop>
tmap <Char-0x10>G> <Nop>
tmap <Char-0x10>G( <Nop>
tmap <Char-0x10>G) <Nop>
tmap <Char-0x10>G[ <Nop>
tmap <Char-0x10>G] <Nop>
tmap <Char-0x10>G{ <Nop>
tmap <Char-0x10>G} <Nop>
tmap <Char-0x10>G@ <Nop>
tmap <Char-0x10>G% <Nop>
tmap <Char-0x10>G$ <Nop>
tmap <Char-0x10>G# <Nop>
tmap <Char-0x10>GBA <Nop>
tmap <Char-0x10>GBB <Nop>
tmap <Char-0x10>GBC <Nop>
tmap <Char-0x10>GBD <Nop>
tmap <Char-0x10>GBE <Nop>
tmap <Char-0x10>GBF <Nop>
tmap <Char-0x10>GBG <Nop>
tmap <Char-0x10>GBH <Nop>
tmap <Char-0x10>GBI <Nop>
" }}}

" Modifiers [Alt + Ctrl]{{{
tmap <Char-0x10>G: <Nop>
tmap <Char-0x10>G2 <Nop>
tmap <Char-0x10>GBc <Nop>
tmap <Char-0x10>GBb <Nop>
tmap <Char-0x10>GBa <Nop>
tmap <Char-0x10>GBd <Nop>
tmap <Char-0x10>G= <Nop>
tmap <Char-0x10>GBg <Nop>
tmap <Char-0x10>GBf <Nop>
tmap <Char-0x10>GBe <Nop>
tmap <Char-0x10>GBh <Nop>
tmap <Char-0x10>G+ <Nop>
" }}}

" Movement [Alt + Ctrl]{{{
tmap <Char-0x10>G6 <Nop>
tmap <Char-0x10>G. <Nop>
tmap <Char-0x10>G5 <Nop>
tmap <Char-0x10>G9 <Nop>
tmap <Char-0x10>G8 <Nop>
tmap <Char-0x10>G4 <Nop>
tmap <Char-0x10>G7 <Nop>
" }}}

" Numpad [Alt + Ctrl]{{{
tmap <Char-0x10>GBJ <Nop>
tmap <Char-0x10>GBK <Nop>
tmap <Char-0x10>GBL <Nop>
tmap <Char-0x10>GBM <Nop>
tmap <Char-0x10>GBN <Nop>
tmap <Char-0x10>GBO <Nop>
tmap <Char-0x10>GBP <Nop>
tmap <Char-0x10>GBQ <Nop>
tmap <Char-0x10>GBR <Nop>
tmap <Char-0x10>GBS <Nop>
tmap <Char-0x10>GBX <Nop>
tmap <Char-0x10>GBT <Nop>
tmap <Char-0x10>GBU <Nop>
tmap <Char-0x10>GBY <Nop>
tmap <Char-0x10>GBZ <Nop>
tmap <Char-0x10>GBV <Nop>
tmap <Char-0x10>GBW <Nop>
" }}}
" }}}
" Alt + Ctrl + Shift [H]{{{
" Alphanumerics [Alt + Ctrl + Shift]{{{
tmap <Char-0x10>HS <Nop>
tmap <Char-0x10>HT <Nop>
tmap <Char-0x10>HU <Nop>
tmap <Char-0x10>HV <Nop>
tmap <Char-0x10>HW <Nop>
tmap <Char-0x10>HX <Nop>
tmap <Char-0x10>HY <Nop>
tmap <Char-0x10>HZ <Nop>
tmap <Char-0x10>Ha <Nop>
tmap <Char-0x10>Hb <Nop>
tmap <Char-0x10>Hc <Nop>
tmap <Char-0x10>Hd <Nop>
tmap <Char-0x10>He <Nop>
tmap <Char-0x10>Hf <Nop>
tmap <Char-0x10>Hg <Nop>
tmap <Char-0x10>Hh <Nop>
tmap <Char-0x10>Hi <Nop>
tmap <Char-0x10>Hj <Nop>
tmap <Char-0x10>Hk <Nop>
tmap <Char-0x10>Hl <Nop>
tmap <Char-0x10>Hm <Nop>
tmap <Char-0x10>Hn <Nop>
tmap <Char-0x10>Ho <Nop>
tmap <Char-0x10>Hp <Nop>
tmap <Char-0x10>Hq <Nop>
tmap <Char-0x10>Hr <Nop>
tmap <Char-0x10>HG <Nop>
tmap <Char-0x10>HH <Nop>
tmap <Char-0x10>HI <Nop>
tmap <Char-0x10>HJ <Nop>
tmap <Char-0x10>HK <Nop>
tmap <Char-0x10>HL <Nop>
tmap <Char-0x10>HM <Nop>
tmap <Char-0x10>HN <Nop>
tmap <Char-0x10>HO <Nop>
tmap <Char-0x10>HP <Nop>
" }}}

" Symbols [Alt + Ctrl + Shift]{{{
tmap <Char-0x10>HB <Nop>
tmap <Char-0x10>Ht <Nop>
tmap <Char-0x10>H1 <Nop>
tmap <Char-0x10>HC <Nop>
tmap <Char-0x10>H3 <Nop>
tmap <Char-0x10>H- <Nop>
tmap <Char-0x10>Hz <Nop>
tmap <Char-0x10>HR <Nop>
tmap <Char-0x10>Hy <Nop>
tmap <Char-0x10>Hv <Nop>
tmap <Char-0x10>Hs <Nop>
tmap <Char-0x10>HD <Nop>
tmap <Char-0x10>H! <Nop>
tmap <Char-0x10>HE <Nop>
tmap <Char-0x10>Hu <Nop>
tmap <Char-0x10>HQ <Nop>
tmap <Char-0x10>HF <Nop>
tmap <Char-0x10>HA <Nop>
tmap <Char-0x10>H0 <Nop>
tmap <Char-0x10>Hw <Nop>
tmap <Char-0x10>Hx <Nop>
tmap <Char-0x10>H^ <Nop>
" }}}

" Function keys [Alt + Ctrl + Shift]{{{
tmap <Char-0x10>H/ <Nop>
tmap <Char-0x10>H* <Nop>
tmap <Char-0x10>H? <Nop>
tmap <Char-0x10>H& <Nop>
tmap <Char-0x10>H< <Nop>
tmap <Char-0x10>H> <Nop>
tmap <Char-0x10>H( <Nop>
tmap <Char-0x10>H) <Nop>
tmap <Char-0x10>H[ <Nop>
tmap <Char-0x10>H] <Nop>
tmap <Char-0x10>H{ <Nop>
tmap <Char-0x10>H} <Nop>
tmap <Char-0x10>H@ <Nop>
tmap <Char-0x10>H% <Nop>
tmap <Char-0x10>H$ <Nop>
tmap <Char-0x10>H# <Nop>
tmap <Char-0x10>HBA <Nop>
tmap <Char-0x10>HBB <Nop>
tmap <Char-0x10>HBC <Nop>
tmap <Char-0x10>HBD <Nop>
tmap <Char-0x10>HBE <Nop>
tmap <Char-0x10>HBF <Nop>
tmap <Char-0x10>HBG <Nop>
tmap <Char-0x10>HBH <Nop>
tmap <Char-0x10>HBI <Nop>
" }}}

" Modifiers [Alt + Ctrl + Shift]{{{
tmap <Char-0x10>H: <Nop>
tmap <Char-0x10>H2 <Nop>
tmap <Char-0x10>HBc <Nop>
tmap <Char-0x10>HBb <Nop>
tmap <Char-0x10>HBa <Nop>
tmap <Char-0x10>HBd <Nop>
tmap <Char-0x10>H= <Nop>
tmap <Char-0x10>HBg <Nop>
tmap <Char-0x10>HBf <Nop>
tmap <Char-0x10>HBe <Nop>
tmap <Char-0x10>HBh <Nop>
tmap <Char-0x10>H+ <Nop>
" }}}

" Movement [Alt + Ctrl + Shift]{{{
tmap <Char-0x10>H6 <Nop>
tmap <Char-0x10>H. <Nop>
tmap <Char-0x10>H5 <Nop>
tmap <Char-0x10>H9 <Nop>
tmap <Char-0x10>H8 <Nop>
tmap <Char-0x10>H4 <Nop>
tmap <Char-0x10>H7 <Nop>
" }}}

" Numpad [Alt + Ctrl + Shift]{{{
tmap <Char-0x10>HBJ <Nop>
tmap <Char-0x10>HBK <Nop>
tmap <Char-0x10>HBL <Nop>
tmap <Char-0x10>HBM <Nop>
tmap <Char-0x10>HBN <Nop>
tmap <Char-0x10>HBO <Nop>
tmap <Char-0x10>HBP <Nop>
tmap <Char-0x10>HBQ <Nop>
tmap <Char-0x10>HBR <Nop>
tmap <Char-0x10>HBS <Nop>
tmap <Char-0x10>HBX <Nop>
tmap <Char-0x10>HBT <Nop>
tmap <Char-0x10>HBU <Nop>
tmap <Char-0x10>HBY <Nop>
tmap <Char-0x10>HBZ <Nop>
tmap <Char-0x10>HBV <Nop>
tmap <Char-0x10>HBW <Nop>
" }}}
" }}}
" Super [I]{{{
" Alphanumerics [Super]{{{
tmap <Char-0x10>IS <Nop>
tmap <Char-0x10>IT <Nop>
tmap <Char-0x10>IU <Nop>
tmap <Char-0x10>IV <Nop>
tmap <Char-0x10>IW <Nop>
tmap <Char-0x10>IX <Nop>
tmap <Char-0x10>IY <Nop>
tmap <Char-0x10>IZ <Nop>
tmap <Char-0x10>Ia <Nop>
tmap <Char-0x10>Ib <Nop>
tmap <Char-0x10>Ic <Nop>
tmap <Char-0x10>Id <Nop>
tmap <Char-0x10>Ie <Nop>
tmap <Char-0x10>If <Nop>
tmap <Char-0x10>Ig <Nop>
tmap <Char-0x10>Ih <Nop>
tmap <Char-0x10>Ii <Nop>
tmap <Char-0x10>Ij <Nop>
tmap <Char-0x10>Ik <Nop>
tmap <Char-0x10>Il <Nop>
tmap <Char-0x10>Im <Nop>
tmap <Char-0x10>In <Nop>
tmap <Char-0x10>Io <Nop>
tmap <Char-0x10>Ip <Nop>
tmap <Char-0x10>Iq <Nop>
tmap <Char-0x10>Ir <Nop>
tmap <Char-0x10>IG <Nop>
tmap <Char-0x10>IH <Nop>
tmap <Char-0x10>II <Nop>
tmap <Char-0x10>IJ <Nop>
tmap <Char-0x10>IK <Nop>
tmap <Char-0x10>IL <Nop>
tmap <Char-0x10>IM <Nop>
tmap <Char-0x10>IN <Nop>
tmap <Char-0x10>IO <Nop>
tmap <Char-0x10>IP <Nop>
" }}}

" Symbols [Super]{{{
tmap <Char-0x10>IB <Nop>
tmap <Char-0x10>It <Nop>
tmap <Char-0x10>I1 <Nop>
tmap <Char-0x10>IC <Nop>
tmap <Char-0x10>I3 <Nop>
tmap <Char-0x10>I- <Nop>
tmap <Char-0x10>Iz <Nop>
tmap <Char-0x10>IR <Nop>
tmap <Char-0x10>Iy <Nop>
tmap <Char-0x10>Iv <Nop>
tmap <Char-0x10>Is <Nop>
tmap <Char-0x10>ID <Nop>
tmap <Char-0x10>I! <Nop>
tmap <Char-0x10>IE <Nop>
tmap <Char-0x10>Iu <Nop>
tmap <Char-0x10>IQ <Nop>
tmap <Char-0x10>IF <Nop>
tmap <Char-0x10>IA <Nop>
tmap <Char-0x10>I0 <Nop>
tmap <Char-0x10>Iw <Nop>
tmap <Char-0x10>Ix <Nop>
tmap <Char-0x10>I^ <Nop>
" }}}

" Function keys [Super]{{{
tmap <Char-0x10>I/ <Nop>
tmap <Char-0x10>I* <Nop>
tmap <Char-0x10>I? <Nop>
tmap <Char-0x10>I& <Nop>
tmap <Char-0x10>I< <Nop>
tmap <Char-0x10>I> <Nop>
tmap <Char-0x10>I( <Nop>
tmap <Char-0x10>I) <Nop>
tmap <Char-0x10>I[ <Nop>
tmap <Char-0x10>I] <Nop>
tmap <Char-0x10>I{ <Nop>
tmap <Char-0x10>I} <Nop>
tmap <Char-0x10>I@ <Nop>
tmap <Char-0x10>I% <Nop>
tmap <Char-0x10>I$ <Nop>
tmap <Char-0x10>I# <Nop>
tmap <Char-0x10>IBA <Nop>
tmap <Char-0x10>IBB <Nop>
tmap <Char-0x10>IBC <Nop>
tmap <Char-0x10>IBD <Nop>
tmap <Char-0x10>IBE <Nop>
tmap <Char-0x10>IBF <Nop>
tmap <Char-0x10>IBG <Nop>
tmap <Char-0x10>IBH <Nop>
tmap <Char-0x10>IBI <Nop>
" }}}

" Modifiers [Super]{{{
tmap <Char-0x10>I: <Nop>
tmap <Char-0x10>I2 <Nop>
tmap <Char-0x10>IBc <Nop>
tmap <Char-0x10>IBb <Nop>
tmap <Char-0x10>IBa <Nop>
tmap <Char-0x10>IBd <Nop>
tmap <Char-0x10>I= <Nop>
tmap <Char-0x10>IBg <Nop>
tmap <Char-0x10>IBf <Nop>
tmap <Char-0x10>IBe <Nop>
tmap <Char-0x10>IBh <Nop>
tmap <Char-0x10>I+ <Nop>
" }}}

" Movement [Super]{{{
tmap <Char-0x10>I6 <Nop>
tmap <Char-0x10>I. <Nop>
tmap <Char-0x10>I5 <Nop>
tmap <Char-0x10>I9 <Nop>
tmap <Char-0x10>I8 <Nop>
tmap <Char-0x10>I4 <Nop>
tmap <Char-0x10>I7 <Nop>
" }}}

" Numpad [Super]{{{
tmap <Char-0x10>IBJ <Nop>
tmap <Char-0x10>IBK <Nop>
tmap <Char-0x10>IBL <Nop>
tmap <Char-0x10>IBM <Nop>
tmap <Char-0x10>IBN <Nop>
tmap <Char-0x10>IBO <Nop>
tmap <Char-0x10>IBP <Nop>
tmap <Char-0x10>IBQ <Nop>
tmap <Char-0x10>IBR <Nop>
tmap <Char-0x10>IBS <Nop>
tmap <Char-0x10>IBX <Nop>
tmap <Char-0x10>IBT <Nop>
tmap <Char-0x10>IBU <Nop>
tmap <Char-0x10>IBY <Nop>
tmap <Char-0x10>IBZ <Nop>
tmap <Char-0x10>IBV <Nop>
tmap <Char-0x10>IBW <Nop>
" }}}
" }}}
" Shift + Super [J]{{{
" Alphanumerics [Shift + Super]{{{
tmap <Char-0x10>JS <Nop>
tmap <Char-0x10>JT <Nop>
tmap <Char-0x10>JU <Nop>
tmap <Char-0x10>JV <Nop>
tmap <Char-0x10>JW <Nop>
tmap <Char-0x10>JX <Nop>
tmap <Char-0x10>JY <Nop>
tmap <Char-0x10>JZ <Nop>
tmap <Char-0x10>Ja <Nop>
tmap <Char-0x10>Jb <Nop>
tmap <Char-0x10>Jc <Nop>
tmap <Char-0x10>Jd <Nop>
tmap <Char-0x10>Je <Nop>
tmap <Char-0x10>Jf <Nop>
tmap <Char-0x10>Jg <Nop>
tmap <Char-0x10>Jh <Nop>
tmap <Char-0x10>Ji <Nop>
tmap <Char-0x10>Jj <Nop>
tmap <Char-0x10>Jk <Nop>
tmap <Char-0x10>Jl <Nop>
tmap <Char-0x10>Jm <Nop>
tmap <Char-0x10>Jn <Nop>
tmap <Char-0x10>Jo <Nop>
tmap <Char-0x10>Jp <Nop>
tmap <Char-0x10>Jq <Nop>
tmap <Char-0x10>Jr <Nop>
tmap <Char-0x10>JG <Nop>
tmap <Char-0x10>JH <Nop>
tmap <Char-0x10>JI <Nop>
tmap <Char-0x10>JJ <Nop>
tmap <Char-0x10>JK <Nop>
tmap <Char-0x10>JL <Nop>
tmap <Char-0x10>JM <Nop>
tmap <Char-0x10>JN <Nop>
tmap <Char-0x10>JO <Nop>
tmap <Char-0x10>JP <Nop>
" }}}

" Symbols [Shift + Super]{{{
tmap <Char-0x10>JB <Nop>
tmap <Char-0x10>Jt <Nop>
tmap <Char-0x10>J1 <Nop>
tmap <Char-0x10>JC <Nop>
tmap <Char-0x10>J3 <Nop>
tmap <Char-0x10>J- <Nop>
tmap <Char-0x10>Jz <Nop>
tmap <Char-0x10>JR <Nop>
tmap <Char-0x10>Jy <Nop>
tmap <Char-0x10>Jv <Nop>
tmap <Char-0x10>Js <Nop>
tmap <Char-0x10>JD <Nop>
tmap <Char-0x10>J! <Nop>
tmap <Char-0x10>JE <Nop>
tmap <Char-0x10>Ju <Nop>
tmap <Char-0x10>JQ <Nop>
tmap <Char-0x10>JF <Nop>
tmap <Char-0x10>JA <Nop>
tmap <Char-0x10>J0 <Nop>
tmap <Char-0x10>Jw <Nop>
tmap <Char-0x10>Jx <Nop>
tmap <Char-0x10>J^ <Nop>
" }}}

" Function keys [Shift + Super]{{{
tmap <Char-0x10>J/ <Nop>
tmap <Char-0x10>J* <Nop>
tmap <Char-0x10>J? <Nop>
tmap <Char-0x10>J& <Nop>
tmap <Char-0x10>J< <Nop>
tmap <Char-0x10>J> <Nop>
tmap <Char-0x10>J( <Nop>
tmap <Char-0x10>J) <Nop>
tmap <Char-0x10>J[ <Nop>
tmap <Char-0x10>J] <Nop>
tmap <Char-0x10>J{ <Nop>
tmap <Char-0x10>J} <Nop>
tmap <Char-0x10>J@ <Nop>
tmap <Char-0x10>J% <Nop>
tmap <Char-0x10>J$ <Nop>
tmap <Char-0x10>J# <Nop>
tmap <Char-0x10>JBA <Nop>
tmap <Char-0x10>JBB <Nop>
tmap <Char-0x10>JBC <Nop>
tmap <Char-0x10>JBD <Nop>
tmap <Char-0x10>JBE <Nop>
tmap <Char-0x10>JBF <Nop>
tmap <Char-0x10>JBG <Nop>
tmap <Char-0x10>JBH <Nop>
tmap <Char-0x10>JBI <Nop>
" }}}

" Modifiers [Shift + Super]{{{
tmap <Char-0x10>J: <Nop>
tmap <Char-0x10>J2 <Nop>
tmap <Char-0x10>JBc <Nop>
tmap <Char-0x10>JBb <Nop>
tmap <Char-0x10>JBa <Nop>
tmap <Char-0x10>JBd <Nop>
tmap <Char-0x10>J= <Nop>
tmap <Char-0x10>JBg <Nop>
tmap <Char-0x10>JBf <Nop>
tmap <Char-0x10>JBe <Nop>
tmap <Char-0x10>JBh <Nop>
tmap <Char-0x10>J+ <Nop>
" }}}

" Movement [Shift + Super]{{{
tmap <Char-0x10>J6 <Nop>
tmap <Char-0x10>J. <Nop>
tmap <Char-0x10>J5 <Nop>
tmap <Char-0x10>J9 <Nop>
tmap <Char-0x10>J8 <Nop>
tmap <Char-0x10>J4 <Nop>
tmap <Char-0x10>J7 <Nop>
" }}}

" Numpad [Shift + Super]{{{
tmap <Char-0x10>JBJ <Nop>
tmap <Char-0x10>JBK <Nop>
tmap <Char-0x10>JBL <Nop>
tmap <Char-0x10>JBM <Nop>
tmap <Char-0x10>JBN <Nop>
tmap <Char-0x10>JBO <Nop>
tmap <Char-0x10>JBP <Nop>
tmap <Char-0x10>JBQ <Nop>
tmap <Char-0x10>JBR <Nop>
tmap <Char-0x10>JBS <Nop>
tmap <Char-0x10>JBX <Nop>
tmap <Char-0x10>JBT <Nop>
tmap <Char-0x10>JBU <Nop>
tmap <Char-0x10>JBY <Nop>
tmap <Char-0x10>JBZ <Nop>
tmap <Char-0x10>JBV <Nop>
tmap <Char-0x10>JBW <Nop>
" }}}
" }}}
" Alt + Super [K]{{{
" Alphanumerics [Alt + Super]{{{
tmap <Char-0x10>KS <Nop>
tmap <Char-0x10>KT <Nop>
tmap <Char-0x10>KU <Nop>
tmap <Char-0x10>KV <Nop>
tmap <Char-0x10>KW <Nop>
tmap <Char-0x10>KX <Nop>
tmap <Char-0x10>KY <Nop>
tmap <Char-0x10>KZ <Nop>
tmap <Char-0x10>Ka <Nop>
tmap <Char-0x10>Kb <Nop>
tmap <Char-0x10>Kc <Nop>
tmap <Char-0x10>Kd <Nop>
tmap <Char-0x10>Ke <Nop>
tmap <Char-0x10>Kf <Nop>
tmap <Char-0x10>Kg <Nop>
tmap <Char-0x10>Kh <Nop>
tmap <Char-0x10>Ki <Nop>
tmap <Char-0x10>Kj <Nop>
tmap <Char-0x10>Kk <Nop>
tmap <Char-0x10>Kl <Nop>
tmap <Char-0x10>Km <Nop>
tmap <Char-0x10>Kn <Nop>
tmap <Char-0x10>Ko <Nop>
tmap <Char-0x10>Kp <Nop>
tmap <Char-0x10>Kq <Nop>
tmap <Char-0x10>Kr <Nop>
tmap <Char-0x10>KG <Nop>
tmap <Char-0x10>KH <Nop>
tmap <Char-0x10>KI <Nop>
tmap <Char-0x10>KJ <Nop>
tmap <Char-0x10>KK <Nop>
tmap <Char-0x10>KL <Nop>
tmap <Char-0x10>KM <Nop>
tmap <Char-0x10>KN <Nop>
tmap <Char-0x10>KO <Nop>
tmap <Char-0x10>KP <Nop>
" }}}

" Symbols [Alt + Super]{{{
tmap <Char-0x10>KB <Nop>
tmap <Char-0x10>Kt <Nop>
tmap <Char-0x10>K1 <Nop>
tmap <Char-0x10>KC <Nop>
tmap <Char-0x10>K3 <Nop>
tmap <Char-0x10>K- <Nop>
tmap <Char-0x10>Kz <Nop>
tmap <Char-0x10>KR <Nop>
tmap <Char-0x10>Ky <Nop>
tmap <Char-0x10>Kv <Nop>
tmap <Char-0x10>Ks <Nop>
tmap <Char-0x10>KD <Nop>
tmap <Char-0x10>K! <Nop>
tmap <Char-0x10>KE <Nop>
tmap <Char-0x10>Ku <Nop>
tmap <Char-0x10>KQ <Nop>
tmap <Char-0x10>KF <Nop>
tmap <Char-0x10>KA <Nop>
tmap <Char-0x10>K0 <Nop>
tmap <Char-0x10>Kw <Nop>
tmap <Char-0x10>Kx <Nop>
tmap <Char-0x10>K^ <Nop>
" }}}

" Function keys [Alt + Super]{{{
tmap <Char-0x10>K/ <Nop>
tmap <Char-0x10>K* <Nop>
tmap <Char-0x10>K? <Nop>
tmap <Char-0x10>K& <Nop>
tmap <Char-0x10>K< <Nop>
tmap <Char-0x10>K> <Nop>
tmap <Char-0x10>K( <Nop>
tmap <Char-0x10>K) <Nop>
tmap <Char-0x10>K[ <Nop>
tmap <Char-0x10>K] <Nop>
tmap <Char-0x10>K{ <Nop>
tmap <Char-0x10>K} <Nop>
tmap <Char-0x10>K@ <Nop>
tmap <Char-0x10>K% <Nop>
tmap <Char-0x10>K$ <Nop>
tmap <Char-0x10>K# <Nop>
tmap <Char-0x10>KBA <Nop>
tmap <Char-0x10>KBB <Nop>
tmap <Char-0x10>KBC <Nop>
tmap <Char-0x10>KBD <Nop>
tmap <Char-0x10>KBE <Nop>
tmap <Char-0x10>KBF <Nop>
tmap <Char-0x10>KBG <Nop>
tmap <Char-0x10>KBH <Nop>
tmap <Char-0x10>KBI <Nop>
" }}}

" Modifiers [Alt + Super]{{{
tmap <Char-0x10>K: <Nop>
tmap <Char-0x10>K2 <Nop>
tmap <Char-0x10>KBc <Nop>
tmap <Char-0x10>KBb <Nop>
tmap <Char-0x10>KBa <Nop>
tmap <Char-0x10>KBd <Nop>
tmap <Char-0x10>K= <Nop>
tmap <Char-0x10>KBg <Nop>
tmap <Char-0x10>KBf <Nop>
tmap <Char-0x10>KBe <Nop>
tmap <Char-0x10>KBh <Nop>
tmap <Char-0x10>K+ <Nop>
" }}}

" Movement [Alt + Super]{{{
tmap <Char-0x10>K6 <Nop>
tmap <Char-0x10>K. <Nop>
tmap <Char-0x10>K5 <Nop>
tmap <Char-0x10>K9 <Nop>
tmap <Char-0x10>K8 <Nop>
tmap <Char-0x10>K4 <Nop>
tmap <Char-0x10>K7 <Nop>
" }}}

" Numpad [Alt + Super]{{{
tmap <Char-0x10>KBJ <Nop>
tmap <Char-0x10>KBK <Nop>
tmap <Char-0x10>KBL <Nop>
tmap <Char-0x10>KBM <Nop>
tmap <Char-0x10>KBN <Nop>
tmap <Char-0x10>KBO <Nop>
tmap <Char-0x10>KBP <Nop>
tmap <Char-0x10>KBQ <Nop>
tmap <Char-0x10>KBR <Nop>
tmap <Char-0x10>KBS <Nop>
tmap <Char-0x10>KBX <Nop>
tmap <Char-0x10>KBT <Nop>
tmap <Char-0x10>KBU <Nop>
tmap <Char-0x10>KBY <Nop>
tmap <Char-0x10>KBZ <Nop>
tmap <Char-0x10>KBV <Nop>
tmap <Char-0x10>KBW <Nop>
" }}}
" }}}
" Alt + Shift + Super [L]{{{
" Alphanumerics [Alt + Shift + Super]{{{
tmap <Char-0x10>LS <Nop>
tmap <Char-0x10>LT <Nop>
tmap <Char-0x10>LU <Nop>
tmap <Char-0x10>LV <Nop>
tmap <Char-0x10>LW <Nop>
tmap <Char-0x10>LX <Nop>
tmap <Char-0x10>LY <Nop>
tmap <Char-0x10>LZ <Nop>
tmap <Char-0x10>La <Nop>
tmap <Char-0x10>Lb <Nop>
tmap <Char-0x10>Lc <Nop>
tmap <Char-0x10>Ld <Nop>
tmap <Char-0x10>Le <Nop>
tmap <Char-0x10>Lf <Nop>
tmap <Char-0x10>Lg <Nop>
tmap <Char-0x10>Lh <Nop>
tmap <Char-0x10>Li <Nop>
tmap <Char-0x10>Lj <Nop>
tmap <Char-0x10>Lk <Nop>
tmap <Char-0x10>Ll <Nop>
tmap <Char-0x10>Lm <Nop>
tmap <Char-0x10>Ln <Nop>
tmap <Char-0x10>Lo <Nop>
tmap <Char-0x10>Lp <Nop>
tmap <Char-0x10>Lq <Nop>
tmap <Char-0x10>Lr <Nop>
tmap <Char-0x10>LG <Nop>
tmap <Char-0x10>LH <Nop>
tmap <Char-0x10>LI <Nop>
tmap <Char-0x10>LJ <Nop>
tmap <Char-0x10>LK <Nop>
tmap <Char-0x10>LL <Nop>
tmap <Char-0x10>LM <Nop>
tmap <Char-0x10>LN <Nop>
tmap <Char-0x10>LO <Nop>
tmap <Char-0x10>LP <Nop>
" }}}

" Symbols [Alt + Shift  + Super]{{{
tmap <Char-0x10>LB <Nop>
tmap <Char-0x10>Lt <Nop>
tmap <Char-0x10>L1 <Nop>
tmap <Char-0x10>LC <Nop>
tmap <Char-0x10>L3 <Nop>
tmap <Char-0x10>L- <Nop>
tmap <Char-0x10>Lz <Nop>
tmap <Char-0x10>LR <Nop>
tmap <Char-0x10>Ly <Nop>
tmap <Char-0x10>Lv <Nop>
tmap <Char-0x10>Ls <Nop>
tmap <Char-0x10>LD <Nop>
tmap <Char-0x10>L! <Nop>
tmap <Char-0x10>LE <Nop>
tmap <Char-0x10>Lu <Nop>
tmap <Char-0x10>LQ <Nop>
tmap <Char-0x10>LF <Nop>
tmap <Char-0x10>LA <Nop>
tmap <Char-0x10>L0 <Nop>
tmap <Char-0x10>Lw <Nop>
tmap <Char-0x10>Lx <Nop>
tmap <Char-0x10>L^ <Nop>
" }}}

" Function keys [Alt + Shift + Super]{{{
tmap <Char-0x10>L/ <Nop>
tmap <Char-0x10>L* <Nop>
tmap <Char-0x10>L? <Nop>
tmap <Char-0x10>L& <Nop>
tmap <Char-0x10>L< <Nop>
tmap <Char-0x10>L> <Nop>
tmap <Char-0x10>L( <Nop>
tmap <Char-0x10>L) <Nop>
tmap <Char-0x10>L[ <Nop>
tmap <Char-0x10>L] <Nop>
tmap <Char-0x10>L{ <Nop>
tmap <Char-0x10>L} <Nop>
tmap <Char-0x10>L@ <Nop>
tmap <Char-0x10>L% <Nop>
tmap <Char-0x10>L$ <Nop>
tmap <Char-0x10>L# <Nop>
tmap <Char-0x10>LBA <Nop>
tmap <Char-0x10>LBB <Nop>
tmap <Char-0x10>LBC <Nop>
tmap <Char-0x10>LBD <Nop>
tmap <Char-0x10>LBE <Nop>
tmap <Char-0x10>LBF <Nop>
tmap <Char-0x10>LBG <Nop>
tmap <Char-0x10>LBH <Nop>
tmap <Char-0x10>LBI <Nop>
" }}}

" Modifiers [Alt + Shift + Super]{{{
tmap <Char-0x10>L: <Nop>
tmap <Char-0x10>L2 <Nop>
tmap <Char-0x10>LBc <Nop>
tmap <Char-0x10>LBb <Nop>
tmap <Char-0x10>LBa <Nop>
tmap <Char-0x10>LBd <Nop>
tmap <Char-0x10>L= <Nop>
tmap <Char-0x10>LBg <Nop>
tmap <Char-0x10>LBf <Nop>
tmap <Char-0x10>LBe <Nop>
tmap <Char-0x10>LBh <Nop>
tmap <Char-0x10>L+ <Nop>
" }}}

" Movement [Alt + Shift + Super]{{{
tmap <Char-0x10>L6 <Nop>
tmap <Char-0x10>L. <Nop>
tmap <Char-0x10>L5 <Nop>
tmap <Char-0x10>L9 <Nop>
tmap <Char-0x10>L8 <Nop>
tmap <Char-0x10>L4 <Nop>
tmap <Char-0x10>L7 <Nop>
" }}}

" Numpad [Alt + Shift + Super]{{{
tmap <Char-0x10>LBJ <Nop>
tmap <Char-0x10>LBK <Nop>
tmap <Char-0x10>LBL <Nop>
tmap <Char-0x10>LBM <Nop>
tmap <Char-0x10>LBN <Nop>
tmap <Char-0x10>LBO <Nop>
tmap <Char-0x10>LBP <Nop>
tmap <Char-0x10>LBQ <Nop>
tmap <Char-0x10>LBR <Nop>
tmap <Char-0x10>LBS <Nop>
tmap <Char-0x10>LBX <Nop>
tmap <Char-0x10>LBT <Nop>
tmap <Char-0x10>LBU <Nop>
tmap <Char-0x10>LBY <Nop>
tmap <Char-0x10>LBZ <Nop>
tmap <Char-0x10>LBV <Nop>
tmap <Char-0x10>LBW <Nop>
" }}}
" }}}
" Alt + Ctrl + Shift + Super [L]{{{
" Alphanumerics [Ctrl + Super]{{{
tmap <Char-0x10>MS <Nop>
tmap <Char-0x10>MT <Nop>
tmap <Char-0x10>MU <Nop>
tmap <Char-0x10>MV <Nop>
tmap <Char-0x10>MW <Nop>
tmap <Char-0x10>MX <Nop>
tmap <Char-0x10>MY <Nop>
tmap <Char-0x10>MZ <Nop>
tmap <Char-0x10>Ma <Nop>
tmap <Char-0x10>Mb <Nop>
tmap <Char-0x10>Mc <Nop>
tmap <Char-0x10>Md <Nop>
tmap <Char-0x10>Me <Nop>
tmap <Char-0x10>Mf <Nop>
tmap <Char-0x10>Mg <Nop>
tmap <Char-0x10>Mh <Nop>
tmap <Char-0x10>Mi <Nop>
tmap <Char-0x10>Mj <Nop>
tmap <Char-0x10>Mk <Nop>
tmap <Char-0x10>Ml <Nop>
tmap <Char-0x10>Mm <Nop>
tmap <Char-0x10>Mn <Nop>
tmap <Char-0x10>Mo <Nop>
tmap <Char-0x10>Mp <Nop>
tmap <Char-0x10>Mq <Nop>
tmap <Char-0x10>Mr <Nop>
tmap <Char-0x10>MG <Nop>
tmap <Char-0x10>MH <Nop>
tmap <Char-0x10>MI <Nop>
tmap <Char-0x10>MJ <Nop>
tmap <Char-0x10>MK <Nop>
tmap <Char-0x10>ML <Nop>
tmap <Char-0x10>MM <Nop>
tmap <Char-0x10>MN <Nop>
tmap <Char-0x10>MO <Nop>
tmap <Char-0x10>MP <Nop>
" }}}

" Symbols [Ctrl + Super]{{{
tmap <Char-0x10>MB <Nop>
tmap <Char-0x10>Mt <Nop>
tmap <Char-0x10>M1 <Nop>
tmap <Char-0x10>MC <Nop>
tmap <Char-0x10>M3 <Nop>
tmap <Char-0x10>M- <Nop>
tmap <Char-0x10>Mz <Nop>
tmap <Char-0x10>MR <Nop>
tmap <Char-0x10>My <Nop>
tmap <Char-0x10>Mv <Nop>
tmap <Char-0x10>Ms <Nop>
tmap <Char-0x10>MD <Nop>
tmap <Char-0x10>M! <Nop>
tmap <Char-0x10>ME <Nop>
tmap <Char-0x10>Mu <Nop>
tmap <Char-0x10>MQ <Nop>
tmap <Char-0x10>MF <Nop>
tmap <Char-0x10>MA <Nop>
tmap <Char-0x10>M0 <Nop>
tmap <Char-0x10>Mw <Nop>
tmap <Char-0x10>Mx <Nop>
tmap <Char-0x10>M^ <Nop>
" }}}

" Function keys [Ctrl + Super]{{{
tmap <Char-0x10>M/ <Nop>
tmap <Char-0x10>M* <Nop>
tmap <Char-0x10>M? <Nop>
tmap <Char-0x10>M& <Nop>
tmap <Char-0x10>M< <Nop>
tmap <Char-0x10>M> <Nop>
tmap <Char-0x10>M( <Nop>
tmap <Char-0x10>M) <Nop>
tmap <Char-0x10>M[ <Nop>
tmap <Char-0x10>M] <Nop>
tmap <Char-0x10>M{ <Nop>
tmap <Char-0x10>M} <Nop>
tmap <Char-0x10>M@ <Nop>
tmap <Char-0x10>M% <Nop>
tmap <Char-0x10>M$ <Nop>
tmap <Char-0x10>M# <Nop>
tmap <Char-0x10>MBA <Nop>
tmap <Char-0x10>MBB <Nop>
tmap <Char-0x10>MBC <Nop>
tmap <Char-0x10>MBD <Nop>
tmap <Char-0x10>MBE <Nop>
tmap <Char-0x10>MBF <Nop>
tmap <Char-0x10>MBG <Nop>
tmap <Char-0x10>MBH <Nop>
tmap <Char-0x10>MBI <Nop>
" }}}

" Modifiers [Ctrl + Super]{{{
tmap <Char-0x10>M: <Nop>
tmap <Char-0x10>M2 <Nop>
tmap <Char-0x10>MBc <Nop>
tmap <Char-0x10>MBb <Nop>
tmap <Char-0x10>MBa <Nop>
tmap <Char-0x10>MBd <Nop>
tmap <Char-0x10>M= <Nop>
tmap <Char-0x10>MBg <Nop>
tmap <Char-0x10>MBf <Nop>
tmap <Char-0x10>MBe <Nop>
tmap <Char-0x10>MBh <Nop>
tmap <Char-0x10>M+ <Nop>
" }}}

" Movement [Ctrl + Super]{{{
tmap <Char-0x10>M6 <Nop>
tmap <Char-0x10>M. <Nop>
tmap <Char-0x10>M5 <Nop>
tmap <Char-0x10>M9 <Nop>
tmap <Char-0x10>M8 <Nop>
tmap <Char-0x10>M4 <Nop>
tmap <Char-0x10>M7 <Nop>
" }}}

" Numpad [Ctrl + Super]{{{
tmap <Char-0x10>MBJ <Nop>
tmap <Char-0x10>MBK <Nop>
tmap <Char-0x10>MBL <Nop>
tmap <Char-0x10>MBM <Nop>
tmap <Char-0x10>MBN <Nop>
tmap <Char-0x10>MBO <Nop>
tmap <Char-0x10>MBP <Nop>
tmap <Char-0x10>MBQ <Nop>
tmap <Char-0x10>MBR <Nop>
tmap <Char-0x10>MBS <Nop>
tmap <Char-0x10>MBX <Nop>
tmap <Char-0x10>MBT <Nop>
tmap <Char-0x10>MBU <Nop>
tmap <Char-0x10>MBY <Nop>
tmap <Char-0x10>MBZ <Nop>
tmap <Char-0x10>MBV <Nop>
tmap <Char-0x10>MBW <Nop>
" }}}
" }}}
" Ctrl + Shift + Super [N]{{{
" Alphanumerics [Ctrl + Shift + Super]{{{
tmap <Char-0x10>NS <Nop>
tmap <Char-0x10>NT <Nop>
tmap <Char-0x10>NU <Nop>
tmap <Char-0x10>NV <Nop>
tmap <Char-0x10>NW <Nop>
tmap <Char-0x10>NX <Nop>
tmap <Char-0x10>NY <Nop>
tmap <Char-0x10>NZ <Nop>
tmap <Char-0x10>Na <Nop>
tmap <Char-0x10>Nb <Nop>
tmap <Char-0x10>Nc <Nop>
tmap <Char-0x10>Nd <Nop>
tmap <Char-0x10>Ne <Nop>
tmap <Char-0x10>Nf <Nop>
tmap <Char-0x10>Ng <Nop>
tmap <Char-0x10>Nh <Nop>
tmap <Char-0x10>Ni <Nop>
tmap <Char-0x10>Nj <Nop>
tmap <Char-0x10>Nk <Nop>
tmap <Char-0x10>Nl <Nop>
tmap <Char-0x10>Nm <Nop>
tmap <Char-0x10>Nn <Nop>
tmap <Char-0x10>No <Nop>
tmap <Char-0x10>Np <Nop>
tmap <Char-0x10>Nq <Nop>
tmap <Char-0x10>Nr <Nop>
tmap <Char-0x10>NG <Nop>
tmap <Char-0x10>NH <Nop>
tmap <Char-0x10>NI <Nop>
tmap <Char-0x10>NJ <Nop>
tmap <Char-0x10>NK <Nop>
tmap <Char-0x10>NL <Nop>
tmap <Char-0x10>NM <Nop>
tmap <Char-0x10>NN <Nop>
tmap <Char-0x10>NO <Nop>
tmap <Char-0x10>NP <Nop>
" }}}

" Symbols [Ctrl + Shift + Super]{{{
tmap <Char-0x10>NB <Nop>
tmap <Char-0x10>Nt <Nop>
tmap <Char-0x10>N1 <Nop>
tmap <Char-0x10>NC <Nop>
tmap <Char-0x10>N3 <Nop>
tmap <Char-0x10>N- <Nop>
tmap <Char-0x10>Nz <Nop>
tmap <Char-0x10>NR <Nop>
tmap <Char-0x10>Ny <Nop>
tmap <Char-0x10>Nv <Nop>
tmap <Char-0x10>Ns <Nop>
tmap <Char-0x10>ND <Nop>
tmap <Char-0x10>N! <Nop>
tmap <Char-0x10>NE <Nop>
tmap <Char-0x10>Nu <Nop>
tmap <Char-0x10>NQ <Nop>
tmap <Char-0x10>NF <Nop>
tmap <Char-0x10>NA <Nop>
tmap <Char-0x10>N0 <Nop>
tmap <Char-0x10>Nw <Nop>
tmap <Char-0x10>Nx <Nop>
tmap <Char-0x10>N^ <Nop>
" }}}

" Function keys [Ctrl + Shift + Super]{{{
tmap <Char-0x10>N/ <Nop>
tmap <Char-0x10>N* <Nop>
tmap <Char-0x10>N? <Nop>
tmap <Char-0x10>N& <Nop>
tmap <Char-0x10>N< <Nop>
tmap <Char-0x10>N> <Nop>
tmap <Char-0x10>N( <Nop>
tmap <Char-0x10>N) <Nop>
tmap <Char-0x10>N[ <Nop>
tmap <Char-0x10>N] <Nop>
tmap <Char-0x10>N{ <Nop>
tmap <Char-0x10>N} <Nop>
tmap <Char-0x10>N@ <Nop>
tmap <Char-0x10>N% <Nop>
tmap <Char-0x10>N$ <Nop>
tmap <Char-0x10>N# <Nop>
tmap <Char-0x10>NBA <Nop>
tmap <Char-0x10>NBB <Nop>
tmap <Char-0x10>NBC <Nop>
tmap <Char-0x10>NBD <Nop>
tmap <Char-0x10>NBE <Nop>
tmap <Char-0x10>NBF <Nop>
tmap <Char-0x10>NBG <Nop>
tmap <Char-0x10>NBH <Nop>
tmap <Char-0x10>NBI <Nop>
" }}}

" Modifiers [Ctrl + Shift + Super]{{{
tmap <Char-0x10>N: <Nop>
tmap <Char-0x10>N2 <Nop>
tmap <Char-0x10>NBc <Nop>
tmap <Char-0x10>NBb <Nop>
tmap <Char-0x10>NBa <Nop>
tmap <Char-0x10>NBd <Nop>
tmap <Char-0x10>N= <Nop>
tmap <Char-0x10>NBg <Nop>
tmap <Char-0x10>NBf <Nop>
tmap <Char-0x10>NBe <Nop>
tmap <Char-0x10>NBh <Nop>
tmap <Char-0x10>N+ <Nop>
" }}}

" Movement [Ctrl + Shift + Super]{{{
tmap <Char-0x10>N6 <Nop>
tmap <Char-0x10>N. <Nop>
tmap <Char-0x10>N5 <Nop>
tmap <Char-0x10>N9 <Nop>
tmap <Char-0x10>N8 <Nop>
tmap <Char-0x10>N4 <Nop>
tmap <Char-0x10>N7 <Nop>
" }}}

" Numpad [Ctrl + Shift + Super]{{{
tmap <Char-0x10>NBJ <Nop>
tmap <Char-0x10>NBK <Nop>
tmap <Char-0x10>NBL <Nop>
tmap <Char-0x10>NBM <Nop>
tmap <Char-0x10>NBN <Nop>
tmap <Char-0x10>NBO <Nop>
tmap <Char-0x10>NBP <Nop>
tmap <Char-0x10>NBQ <Nop>
tmap <Char-0x10>NBR <Nop>
tmap <Char-0x10>NBS <Nop>
tmap <Char-0x10>NBX <Nop>
tmap <Char-0x10>NBT <Nop>
tmap <Char-0x10>NBU <Nop>
tmap <Char-0x10>NBY <Nop>
tmap <Char-0x10>NBZ <Nop>
tmap <Char-0x10>NBV <Nop>
tmap <Char-0x10>NBW <Nop>
" }}}
" }}}
" Alt + control + Super [O]{{{
" Alphanumerics [Alt + Ctrl + Super]{{{
tmap <Char-0x10>OS <Nop>
tmap <Char-0x10>OT <Nop>
tmap <Char-0x10>OU <Nop>
tmap <Char-0x10>OV <Nop>
tmap <Char-0x10>OW <Nop>
tmap <Char-0x10>OX <Nop>
tmap <Char-0x10>OY <Nop>
tmap <Char-0x10>OZ <Nop>
tmap <Char-0x10>Oa <Nop>
tmap <Char-0x10>Ob <Nop>
tmap <Char-0x10>Oc <Nop>
tmap <Char-0x10>Od <Nop>
tmap <Char-0x10>Oe <Nop>
tmap <Char-0x10>Of <Nop>
tmap <Char-0x10>Og <Nop>
tmap <Char-0x10>Oh <Nop>
tmap <Char-0x10>Oi <Nop>
tmap <Char-0x10>Oj <Nop>
tmap <Char-0x10>Ok <Nop>
tmap <Char-0x10>Ol <Nop>
tmap <Char-0x10>Om <Nop>
tmap <Char-0x10>On <Nop>
tmap <Char-0x10>Oo <Nop>
tmap <Char-0x10>Op <Nop>
tmap <Char-0x10>Oq <Nop>
tmap <Char-0x10>Or <Nop>
tmap <Char-0x10>OG <Nop>
tmap <Char-0x10>OH <Nop>
tmap <Char-0x10>OI <Nop>
tmap <Char-0x10>OJ <Nop>
tmap <Char-0x10>OK <Nop>
tmap <Char-0x10>OL <Nop>
tmap <Char-0x10>OM <Nop>
tmap <Char-0x10>ON <Nop>
tmap <Char-0x10>OO <Nop>
tmap <Char-0x10>OP <Nop>
" }}}

" Symbols [Alt + Ctrl + Super]{{{
tmap <Char-0x10>OB <Nop>
tmap <Char-0x10>Ot <Nop>
tmap <Char-0x10>O1 <Nop>
tmap <Char-0x10>OC <Nop>
tmap <Char-0x10>O3 <Nop>
tmap <Char-0x10>O- <Nop>
tmap <Char-0x10>Oz <Nop>
tmap <Char-0x10>OR <Nop>
tmap <Char-0x10>Oy <Nop>
tmap <Char-0x10>Ov <Nop>
tmap <Char-0x10>Os <Nop>
tmap <Char-0x10>OD <Nop>
tmap <Char-0x10>O! <Nop>
tmap <Char-0x10>OE <Nop>
tmap <Char-0x10>Ou <Nop>
tmap <Char-0x10>OQ <Nop>
tmap <Char-0x10>OF <Nop>
tmap <Char-0x10>OA <Nop>
tmap <Char-0x10>O0 <Nop>
tmap <Char-0x10>Ow <Nop>
tmap <Char-0x10>Ox <Nop>
tmap <Char-0x10>O^ <Nop>
" }}}

" Function keys [Alt + Ctrl + Super]{{{
tmap <Char-0x10>O/ <Nop>
tmap <Char-0x10>O* <Nop>
tmap <Char-0x10>O? <Nop>
tmap <Char-0x10>O& <Nop>
tmap <Char-0x10>O< <Nop>
tmap <Char-0x10>O> <Nop>
tmap <Char-0x10>O( <Nop>
tmap <Char-0x10>O) <Nop>
tmap <Char-0x10>O[ <Nop>
tmap <Char-0x10>O] <Nop>
tmap <Char-0x10>O{ <Nop>
tmap <Char-0x10>O} <Nop>
tmap <Char-0x10>O@ <Nop>
tmap <Char-0x10>O% <Nop>
tmap <Char-0x10>O$ <Nop>
tmap <Char-0x10>O# <Nop>
tmap <Char-0x10>OBA <Nop>
tmap <Char-0x10>OBB <Nop>
tmap <Char-0x10>OBC <Nop>
tmap <Char-0x10>OBD <Nop>
tmap <Char-0x10>OBE <Nop>
tmap <Char-0x10>OBF <Nop>
tmap <Char-0x10>OBG <Nop>
tmap <Char-0x10>OBH <Nop>
tmap <Char-0x10>OBI <Nop>
" }}}

" Modifiers [Alt + Ctrl + Super]{{{
tmap <Char-0x10>O: <Nop>
tmap <Char-0x10>O2 <Nop>
tmap <Char-0x10>OBc <Nop>
tmap <Char-0x10>OBb <Nop>
tmap <Char-0x10>OBa <Nop>
tmap <Char-0x10>OBd <Nop>
tmap <Char-0x10>O= <Nop>
tmap <Char-0x10>OBg <Nop>
tmap <Char-0x10>OBf <Nop>
tmap <Char-0x10>OBe <Nop>
tmap <Char-0x10>OBh <Nop>
tmap <Char-0x10>O+ <Nop>
" }}}

" Movement [Alt + Ctrl + Super]{{{
tmap <Char-0x10>O6 <Nop>
tmap <Char-0x10>O. <Nop>
tmap <Char-0x10>O5 <Nop>
tmap <Char-0x10>O9 <Nop>
tmap <Char-0x10>O8 <Nop>
tmap <Char-0x10>O4 <Nop>
tmap <Char-0x10>O7 <Nop>
" }}}

" Numpad [Alt + Ctrl + Super]{{{
tmap <Char-0x10>OBJ <Nop>
tmap <Char-0x10>OBK <Nop>
tmap <Char-0x10>OBL <Nop>
tmap <Char-0x10>OBM <Nop>
tmap <Char-0x10>OBN <Nop>
tmap <Char-0x10>OBO <Nop>
tmap <Char-0x10>OBP <Nop>
tmap <Char-0x10>OBQ <Nop>
tmap <Char-0x10>OBR <Nop>
tmap <Char-0x10>OBS <Nop>
tmap <Char-0x10>OBX <Nop>
tmap <Char-0x10>OBT <Nop>
tmap <Char-0x10>OBU <Nop>
tmap <Char-0x10>OBY <Nop>
tmap <Char-0x10>OBZ <Nop>
tmap <Char-0x10>OBV <Nop>
tmap <Char-0x10>OBW <Nop>
" }}}
" }}}
" Alt + control + Shift + Super [P]{{{
" Alphanumerics [Alt + Ctrl + Shift + Super]{{{
tmap <Char-0x10>PS <Nop>
tmap <Char-0x10>PT <Nop>
tmap <Char-0x10>PU <Nop>
tmap <Char-0x10>PV <Nop>
tmap <Char-0x10>PW <Nop>
tmap <Char-0x10>PX <Nop>
tmap <Char-0x10>PY <Nop>
tmap <Char-0x10>PZ <Nop>
tmap <Char-0x10>Pa <Nop>
tmap <Char-0x10>Pb <Nop>
tmap <Char-0x10>Pc <Nop>
tmap <Char-0x10>Pd <Nop>
tmap <Char-0x10>Pe <Nop>
tmap <Char-0x10>Pf <Nop>
tmap <Char-0x10>Pg <Nop>
tmap <Char-0x10>Ph <Nop>
tmap <Char-0x10>Pi <Nop>
tmap <Char-0x10>Pj <Nop>
tmap <Char-0x10>Pk <Nop>
tmap <Char-0x10>Pl <Nop>
tmap <Char-0x10>Pm <Nop>
tmap <Char-0x10>Pn <Nop>
tmap <Char-0x10>Po <Nop>
tmap <Char-0x10>Pp <Nop>
tmap <Char-0x10>Pq <Nop>
tmap <Char-0x10>Pr <Nop>
tmap <Char-0x10>PG <Nop>
tmap <Char-0x10>PH <Nop>
tmap <Char-0x10>PI <Nop>
tmap <Char-0x10>PJ <Nop>
tmap <Char-0x10>PK <Nop>
tmap <Char-0x10>PL <Nop>
tmap <Char-0x10>PM <Nop>
tmap <Char-0x10>PN <Nop>
tmap <Char-0x10>PO <Nop>
tmap <Char-0x10>PP <Nop>
" }}}

" Symbols [Alt + Ctrl + Shift + Super]{{{
tmap <Char-0x10>PB <Nop>
tmap <Char-0x10>Pt <Nop>
tmap <Char-0x10>P1 <Nop>
tmap <Char-0x10>PC <Nop>
tmap <Char-0x10>P3 <Nop>
tmap <Char-0x10>P- <Nop>
tmap <Char-0x10>Pz <Nop>
tmap <Char-0x10>PR <Nop>
tmap <Char-0x10>Py <Nop>
tmap <Char-0x10>Pv <Nop>
tmap <Char-0x10>Ps <Nop>
tmap <Char-0x10>PD <Nop>
tmap <Char-0x10>P! <Nop>
tmap <Char-0x10>PE <Nop>
tmap <Char-0x10>Pu <Nop>
tmap <Char-0x10>PQ <Nop>
tmap <Char-0x10>PF <Nop>
tmap <Char-0x10>PA <Nop>
tmap <Char-0x10>P0 <Nop>
tmap <Char-0x10>Pw <Nop>
tmap <Char-0x10>Px <Nop>
tmap <Char-0x10>P^ <Nop>
" }}}

" Function keys [Alt + Ctrl + Shift + Super]{{{
tmap <Char-0x10>p/ <Nop>
tmap <Char-0x10>p* <Nop>
tmap <Char-0x10>p? <Nop>
tmap <Char-0x10>p& <Nop>
tmap <Char-0x10>p< <Nop>
tmap <Char-0x10>p> <Nop>
tmap <Char-0x10>p( <Nop>
tmap <Char-0x10>p) <Nop>
tmap <Char-0x10>p[ <Nop>
tmap <Char-0x10>p] <Nop>
tmap <Char-0x10>p{ <Nop>
tmap <Char-0x10>p} <Nop>
tmap <Char-0x10>p@ <Nop>
tmap <Char-0x10>p% <Nop>
tmap <Char-0x10>p$ <Nop>
tmap <Char-0x10>p# <Nop>
tmap <Char-0x10>pba <Nop>
tmap <Char-0x10>pbb <Nop>
tmap <Char-0x10>pbc <Nop>
tmap <Char-0x10>pbd <Nop>
tmap <Char-0x10>pbe <Nop>
tmap <Char-0x10>pbf <Nop>
tmap <Char-0x10>pbg <Nop>
tmap <Char-0x10>pbh <Nop>
tmap <Char-0x10>pbi <Nop>
" }}}

" Modifiers [Alt + Ctrl + Shift + Super]{{{
tmap <Char-0x10>P: <Nop>
tmap <Char-0x10>P2 <Nop>
tmap <Char-0x10>PBc <Nop>
tmap <Char-0x10>PBb <Nop>
tmap <Char-0x10>PBa <Nop>
tmap <Char-0x10>PBd <Nop>
tmap <Char-0x10>P= <Nop>
tmap <Char-0x10>PBg <Nop>
tmap <Char-0x10>PBf <Nop>
tmap <Char-0x10>PBe <Nop>
tmap <Char-0x10>PBh <Nop>
tmap <Char-0x10>P+ <Nop>
" }}}

" Movement [Alt + Ctrl + Shift + Super]{{{
tmap <Char-0x10>P6 <Nop>
tmap <Char-0x10>P. <Nop>
tmap <Char-0x10>P5 <Nop>
tmap <Char-0x10>P9 <Nop>
tmap <Char-0x10>P8 <Nop>
tmap <Char-0x10>P4 <Nop>
tmap <Char-0x10>P7 <Nop>
" }}}

" Numpad [Alt + Ctrl + Shift +  Super]{{{
tmap <Char-0x10>PBJ <Nop>
tmap <Char-0x10>PBK <Nop>
tmap <Char-0x10>PBL <Nop>
tmap <Char-0x10>PBM <Nop>
tmap <Char-0x10>PBN <Nop>
tmap <Char-0x10>PBO <Nop>
tmap <Char-0x10>PBP <Nop>
tmap <Char-0x10>PBQ <Nop>
tmap <Char-0x10>PBR <Nop>
tmap <Char-0x10>PBS <Nop>
tmap <Char-0x10>PBX <Nop>
tmap <Char-0x10>PBT <Nop>
tmap <Char-0x10>PBU <Nop>
tmap <Char-0x10>PBY <Nop>
tmap <Char-0x10>PBZ <Nop>
tmap <Char-0x10>PBV <Nop>
tmap <Char-0x10>PBW <Nop>
" }}}
" }}}
" }}}
" }}}

" vim: set ts=4 sw=4 tw=79 fdm=marker et :
