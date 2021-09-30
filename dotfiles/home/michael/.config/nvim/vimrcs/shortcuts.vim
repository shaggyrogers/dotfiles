""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" shortcuts.vim
" =============
"
" Description:           Contains all non-plugin shortcuts.
" Author:                Michael De Pasquale <shaggyrogers>
" Creation Date:         2017-12-02
" Modification Date:     2020-08-28
" License:               MIT
"
" Note that some key combinations require kitty with a certain configuration.
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


" Commands {{{
" <Leader> + w , <Leader> + W: (W)rite buffer / (W)ith sudo
nnoremap <leader>w <cmd>:up<CR>
command! W w !sudo tee % > /dev/null
nnoremap <leader><s-w> <cmd>:W<CR>

" <Leader> + q, <Leader> + Shift + q : (Q)uit buffer with/without saving
nnoremap <leader>q <cmd>:q<CR>
nnoremap <leader><s-q> <cmd>:q!<CR>

" <Leader> + S : Save (S)ession
nnoremap <leader>SS <cmd>:SSave<CR>

" <Leader> + s : show (S)yntax highight group under the cursor
nnoremap <leader>s <cmd>:echo CursorSynInfo('name')<CR>

" CursorSynInfo : Print syntax information for hte text under the cursor
function! CursorSynInfo(attr) abort  " {{{
    let l:pos = getpos('.')
    let l:c = synIDattr(synIDtrans(synID(pos[1], pos[2], 'TRUE')), a:attr)
    let l:stack = map(synstack(l:pos[1], l:pos[2]), 'synIDattr(v:val, "' . a:attr . '")')
    let l:repls = map(synstack(l:pos[1], l:pos[2]), 'synIDattr(synIDtrans(v:val), "' . a:attr . '")')

    for i in range(len(l:stack))
        if l:stack[i] != l:repls[i]
            let l:stack[i] = l:stack[i].' -> '.l:repls[i]
        endif
    endfor

    return synIDattr(synIDtrans(synID(line('.'), col('.'), 'TRUE')), a:attr) . ' - ' . string(l:stack)
endfunction "}}}
"}}}

" Movement {{{
" j, k : Move screen lines unless a count is given, save  >5 lines as jump
nnoremap <expr> j v:count ? (v:count > 5 ? "m'" . v:count : '') . 'j' : 'gj'
nnoremap <expr> k v:count ? (v:count > 5 ? "m'" . v:count : '') . 'k' : 'gk'
xnoremap <expr> j v:count ? (v:count > 5 ? "m'" . v:count : '') . 'j' : 'gj'
xnoremap <expr> k v:count ? (v:count > 5 ? "m'" . v:count : '') . 'k' : 'gk'

" 0 : Move to the first non-blank character.
noremap 0 ^

" Ctrl + o/p : Go forward/backward in jump list
nnoremap <C-O> <C-o>
nnoremap <C-p> <C-i>

" PageUp / PageDown : Scroll one page up/down
nnoremap <PageDown> <C-d><C-d>
nnoremap <PageUp> <C-u><C-u>
xnoremap <PageDown> <C-d><C-d>
xnoremap <PageUp> <C-u><C-u>

" CTRL + j/k : Jump to the next/previous fold
nnoremap <silent> <C-j> zjzx
nnoremap <silent> <C-k> zkzx
xnoremap <silent> <C-j> zjzx
xnoremap <silent> <C-k> zkzx

" Right / Left : Next / Prev error
nnoremap <Left> <cmd>ALEPrevious<CR>
nnoremap <Right> <cmd>ALENext<CR>

" Up / Down : Next / prev git change
nnoremap <silent> <Up> <cmd>call feedkeys('[c', 't')<CR>
nnoremap <silent> <Down> <cmd>call feedkeys(']c', 't')<CR>

" Ctrl + Up / Ctrl + Down : Up / Down undo tree branch (1 minute)
" Ctrl + Right / Ctrl + Left : Up / Down undo tree branch (5 minutes)
nnoremap <silent> <C-Up> <cmd>earlier 1m<CR>zx
nnoremap <silent> <C-Down> <cmd>later 1m<CR>zx
nnoremap <silent> <C-Left> <cmd>earlier 5m<CR>zx
nnoremap <silent> <C-Right> <cmd>later 5m<CR>zx

" Ctrl + Alt + Shift + j/k : Go to definition / Jump to tag
nnoremap <silent> <Char-0x10>Hb <cmd>ptag<CR>
nnoremap <silent> <Char-0x10>Hc gd
"}}}

" Search {{{
" Ctrl + R : Writes a search and (R)eplace command for the current visual selection [V]
vnoremap <C-r> <ESC>:call SearchReplaceVisualSelection()<CR>

" Ctrl + n / Ctrl + Shift + n : Next / Previous match and update folds
nmap <silent> <expr> <C-n> ':<C-u>execute "normal '.v:count1.'nzx"<CR>'
nmap <silent> <expr> <Char-0x10>Ff ':<C-u>execute "normal '.v:count1.'Nzx"<CR>'

" # / * : Search backward / forwards for the current visual selection
" Source: Vim wiki
vnoremap <silent> * :<C-U>
            \ let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
            \ gvy?<C-R><C-R>=substitute(
            \ escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
            \ gV:call setreg('"', old_reg, old_regtype)<CR>

vnoremap <silent> # :<C-U>
            \ let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
            \ gvy?<C-R><C-R>=substitute(
            \ escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
            \ gV:call setreg('"', old_reg, old_regtype)<CR>
"}}}

" Editing {{{
" <Leader> + P/p/y/Y : Put/yank from/to system clipboard
nnoremap <silent> <Leader>y "+y
nnoremap <silent> <Leader>Y V"+y
xnoremap <silent> <Leader>y "+ygv
xnoremap <silent> <Leader>Y "+Ygv
nnoremap <silent> <Leader>p "+p`[
nnoremap <silent> <Leader>P "+P`[
xnoremap <silent> <expr> <Leader>p '"+pgv'
xnoremap <silent> <expr> <Leader>P '"+Pgv'

" y / Y : Keep visual selection when yanking
xnoremap y ygv
xnoremap Y Ygv

" p / P : Put without copying replaced text or moving cursor
" https://stackoverflow.com/a/32488853
" https://stackoverflow.com/a/1587184
noremap p "0p`[
noremap P "0P`[
xnoremap p "0p`[
xnoremap P "0P`[
noremap gp "0p`[
noremap gP "0P`[
xnoremap gp "0p`[
xnoremap gP "0P`[

for s:i in map(range(0, 9), 'string(v:val)')
            \ + map(range(char2nr('a'), char2nr('z')), 'nr2char(v:val)')
            \ + split('"-#=*+_/:.%', '\m\zs')
    execute 'noremap "'.s:i.'p "'.s:i.'p`['
    execute 'noremap "'.s:i.'P "'.s:i.'P`['
    execute 'xnoremap "'.s:i.'p "'.s:i.'p`['
    execute 'xnoremap "'.s:i.'P "'.s:i.'P`['
    execute 'noremap "'.s:i.'gp "'.s:i.'gp`['
    execute 'noremap "'.s:i.'gP "'.s:i.'gP`['
    execute 'xnoremap "'.s:i.'gp "'.s:i.'gp`['
    execute 'xnoremap "'.s:i.'gP "'.s:i.'gP`['
endfor

" x : Delete character / selection without yanking
nnoremap x "_x
xnoremap x "_x

" <, >, = : Fast indent, keep selection when indenting
xnoremap <nowait> < <gv
xnoremap <nowait> > >gv
xnoremap <nowait> = =gv
nnoremap <nowait> < <<
nnoremap <nowait> > >>
nnoremap <nowait> = ==

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

" Enter / Shift + Enter / Ctrl + Enter: Insert newline after / before current line / at cursor
nnoremap <CR> <cmd>put =repeat(nr2char(10), v:count1)<cr>
nnoremap <Char-0x10>Bz :<c-u>put! =repeat(nr2char(10), v:count1)<cr>'[
nnoremap <Char-0x10>Ez i<CR><Esc>

augroup UpdateCRShorcut  "{{{
    autocmd!
    autocmd BufEnter * call UpdateCRShortcut()
augroup end  "}}}

function! UpdateCRShortcut() abort  "{{{
    if getbufvar(bufnr(''), '&modifiable', 0)
        nnoremap <CR> :<c-u>put =repeat(nr2char(10), v:count1)<cr>
        nnoremap <Char-0x10>Bz :<c-u>put! =repeat(nr2char(10), v:count1)<cr>'[
    else
        silent! nunmap <CR>
        silent! nunmap <Char-0x10>Bz
    endif
endfunc  "}}}

" Alt + Enter : Create a copy of the current line below
nnoremap <expr> <M-CR> repeat(":\<C-u>t.\<CR>", v:count1)
inoremap <expr> <M-CR> repeat("\<C-o>:\<C-u>t.\<CR>", v:count1)

" <Leader> + Space : Delete trailing whitespace
nnoremap <Leader><Space> <cmd>:call rccommon#DeleteTrailingWS()<CR>
"
" <Leader> + C + d / <Leader> + C + h : (C)onvert (d)ecimal / (C)onvert (h)ex
nnoremap <Leader>Cd <cmd>Dec2hex<CR>
nnoremap <Leader>Ch <cmd>Hex2dec<CR>

" Dec2hex / Hex2dec
" Source: http://vim.wikia.com/wiki/Convert_between_hex_and_decimal
command! -nargs=? -range Dec2hex call s:Dec2hex(<line1>, <line2>, '<args>')
command! -nargs=? -range Hex2dec call s:Hex2dec(<line1>, <line2>, '<args>')
function! s:Dec2hex(line1, line2, arg) range  "{{{
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
endfunction  "}}}
function! s:Hex2dec(line1, line2, arg) range  "{{{
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
endfunction  "}}}

" c + * / c + # : (c)hange word under cursor forward / backward
" NOTE: press '.' to repeat for next match, n to skip.
" From https://www.reddit.com/r/vim/comments/8k4p6v/what_are_your_best_mappings/
nnoremap c* *``cgn
nnoremap c# #``cgN
" }}}

" Windows / Tabs / Buffers / Folds {{{
nnoremap za <cmd>call <SID>JumpToClosestFold('normal! za')<CR>
nnoremap zA <cmd>call <SID>JumpToClosestFold('normal! zA')<CR>
nnoremap zo <cmd>call <SID>JumpToClosestFold('normal! zo')<CR>
nnoremap zO <cmd>call <SID>JumpToClosestFold('normal! zO')<CR>
nnoremap zc <cmd>call <SID>JumpToClosestFold('normal! zc')<CR>
nnoremap zC <cmd>call <SID>JumpToClosestFold('normal! zC')<CR>

" Improve fold delete behavior
nnoremap zd <cmd>execute RemoveFold()<CR>
xnoremap zd <cmd>execute RemoveFold()<CR>

" Space : Toggle fold (normal) / add fold (visual)
nnoremap <Space> <cmd>call <SID>JumpToClosestFold('normal! za')<CR>
xnoremap <space> <cmd>AddFold<CR>

" Ctrl + Space : Close other folds
" requires terminal configured to send the keys below for ctrl+alt+space
nnoremap <C-Space> <cmd>normal! zx<CR>
inoremap <C-Space> <cmd>normal! zx<CR>
xnoremap <C-Space> <cmd>normal! zx<CR>

" Ctrl + Alt + Space : Toggle folding
nnoremap <Char-0x10>GA <cmd>normal! zi<CR>
inoremap <Char-0x10>GA <cmd>normal! zi<CR>
xnoremap <Char-0x10>GA <cmd>normal! zi<CR>

" Ctrl + Tab / Ctrl + Shift + Tab: Move tab forward/backward
nnoremap <silent> <Char-0x10>E0 <cmd>:silent! tabmove +<CR>
nnoremap <silent> <Char-0x10>F0 <cmd>:silent! tabmove -<CR>
xnoremap <silent> <Char-0x10>E0 <cmd>:silent! tabmove +<CR>
xnoremap <silent> <Char-0x10>F0 <cmd>:silent! tabmove -<CR>
inoremap <silent> <Char-0x10>E0 <cmd>:silent! tabmove -<CR>
inoremap <silent> <Char-0x10>F0 <cmd>:silent! tabmove +<CR>

" CTRL + T : Open a new tab
nnoremap <silent> <C-t> <cmd>:tabe<CR>

" Tab / <count> + Tab / Shift + Tab : Next tab / Jump to tab / Previous tab
nnoremap <Tab> <cmd>execute (v:count >= 1 ? 'tabn '.v:count : 'tabn')<CR>
nnoremap <S-Tab> <cmd>execute 'tabp'<CR>

" Alt + Tab / <count> + Alt + Tab: Previous window / jump to window no.
" NOTE: <count> + <C-w> + <C-w> also changes to a numbered window.
nnoremap <M-Tab> <cmd>execute (v:count >= 1 ? v:count . 'wincmd w' : 'wincmd p')<CR>

" Backspace / <count> + Backspace: Switch to secondary / buffer number
" NOTE: Not sure why this works to switch to a specific buffer..?
nnoremap <BS> <C-^>


" If not within a fold, jump to the closest one.
" Returns the line number of the fold if a jump occurred, 0 if no jump was
" necessary and -1 if no fold was found.
" Accepts a command to execute if successful (i.e. return value >= 0)
function! s:JumpToClosestFold(...) abort "{{{
    if a:0 > 1
        throw 'JumpToClosestFold Error: Expected 0 or 1 arguments, got ' . a:0
    endif

    if foldlevel('.') > 0
        " Execute command if provided
        if a:0 > 0
            execute a:1
        endif

        return 0
    endif

    let l:curpos = getcurpos()

    " Get closest fold above/below cursor line
    keepjumps execute 'normal! zj'
    let l:foldBelow = getcurpos()
    call setpos('.', l:curpos)

    keepjumps execute 'normal! zk'
    let l:foldAbove = getcurpos()
    call setpos('.', l:curpos)

    " Select closest fold
    let l:belowDelta = abs(l:curpos[1] - l:foldBelow[1])
    let l:aboveDelta = abs(l:curpos[1] - l:foldAbove[1])

    " No fold found
    if l:belowDelta == 0 && l:aboveDelta == 0
        return -1
    endif

    if l:belowDelta == 0 || l:aboveDelta == 0
        let l:target = l:belowDelta ? l:foldBelow : l:foldAbove
    else
        let l:target = l:belowDelta > l:aboveDelta ? l:foldAbove : l:foldBelow
    endif

    " Jump to fold
    let l:target[2:4] = l:curpos[2:4]
    execute "normal! m'"
    call setpos('.', l:target)

    " Execute command if provided
    if a:0 > 0
        execute a:1
    endif

    return l:target[1]
endfunction "}}}

" Creates a fold between the given lines. Has added heuristics for markers.
command! -nargs=? -addr=lines -range=2 AddFold
        \ execute <SID>AddFold([str2nr(<q-line1>), str2nr(<q-line2>)],str2nr(<q-range>))

" TODO: check for comment and omit comment marker
function! s:AddFold(range, rangeNr) abort "{{{
    if a:rangeNr == 0
        let l:range = [line('v'), line('.')]
        call sort(l:range, 'n')
    else
        let l:range = a:range
    endif

    if &fdm == 'manual'
        return 'normal! zf'
    endif

    if &fdm != 'marker'
        let v:errmsg = "AddFold Error: Cannot create fold with foldmethod \"" . &fdm . "\""
        call rccommon#Echo(v:errmsg, 'Error')
        return ''
    endif

    " Build foldmarker comments and strip leading/trailing whitespace
    let l:markers = split(&foldmarker, '\V,')

    for l:i in range(2)
        let l:markers[l:i] = trim(
            \ substitute(
                \ synIDattr(
                    \ synIDtrans(
                        \ synID(
                            \ l:range[l:i],
                            \ len(getline(l:range[l:i])),
                            \ 0
                        \ )
                    \ ),
                    \ 'name'
                \ ) =~? 'comment' ? '%s' : &cms,
                \ "%s",
                \ l:markers[l:i],
                \ ""
            \ )
        \ )
    endfor

    " Get text for first/last lines and strip trailing whitespace
    let l:lines = map(
        \ map(copy(l:range), 'substitute(getline(v:val), "[ \t]*$", "", "")'),
        \ 'len(v:val) > 0 ? v:val . " " : v:val'
    \ )

    " Add newline between markers for single lines
    if l:range[0] == l:range[1]
        call append(l:range[0], '')
        let l:lines[1] = ''
        let l:range[1] += 1
    endif

    " Match indentation if either line is blank
    if l:lines[0] =~ '\v^\s*$' && l:lines[1] =~ '\v^\s*$'
        let l:lines[0] = ''
        let l:lines[1] = ''
    elseif xor(l:lines[0] == '', l:lines[1] == '')
        let l:bl = l:lines[0] == '' ? 0 : 1
        let l:indent = repeat(' ', max([indent(l:range[xor(l:bl, 1)]), 0]))
        let l:markers[l:bl] = l:indent . l:markers[l:bl]
    endif

    " Append markers
    let l:view = winsaveview()
    let l:fdm = &fdm
    let l:fen = &fen
    let &fdm = 'manual'
    let &fen = 0
    let l:result = "normal! \<Esc>"
    call setline(l:range[0], l:lines[0] . l:markers[0])

    if (l:range[1] == l:range[0] + 1 && l:lines[1] == '')
        call append(l:range[1], l:markers[1])
        let l:result += (line('.') != l:range[1] ? 'j' : '')
    else
        call setline(l:range[1], l:lines[1] . l:markers[1])
    endif

    let &fen = l:fen
    let &fdm = l:fdm
    call winrestview(l:view)
    return "normal! \<Esc>"
endfunction "}}}

" Delete a fold and remove whitespace prepended to markers.
function! RemoveFold() abort "{{{
    if &fdm != 'marker' && &fdm != 'manual'
        let v:errmsg = "Error: Cannot remove fold with foldmethod \"" . &fdm . "\""
        call rccommon#Echo(v:errmsg, 'Error')
        return ''
    endif

    call s:JumpToClosestFold()

    if &fdm == 'manual'
        return 'normal! zd'
    endif

    let l:curpos = getcurpos()
    let l:fdm = map(split(&foldmarker, '\V,'), '"\\V".v:val')
    let l:lines = map(
        \ ['', 'b'],
        \ 'searchpair(l:fdm[0], "", l:fdm[1], "cnWz".v:val, "", 0, 500)'
    \ )

    if l:lines[0] <= 0 || l:lines[1] <= 0
        return 'normal! zd'
    endif

    execute 'normal! zd'
    call sort(uniq(l:lines), 'n')
    silent execute join(copy(l:lines), ',') . 's/\v\s+$//e'

    if getline(l:lines[-1]) == ''
        silent execute l:lines[-1] . 'd'
        let l:lines[-1] -= 1
    endif

    if l:lines[-1] >= l:lines[0] && getline(l:lines[0]) == ''
        silent execute l:lines[0] . 'd'
    endif

    call setpos('.', l:curpos)
    return ''
endfunction "}}}
"}}}

" Terminal {{{
" Leader+Escape : Exit terminal edit mode
tnoremap <nowait> <Leader><Esc> <C-\><C-n>
"}}}

" Macros {{{
" Alt + q/w/e : Execute (Q)/(W) macros
nnoremap <M-q> @q
nnoremap <M-w> @w
nnoremap <M-e> @e

" Make macros / repeat work for each line in the visual selection
" xnoremap <expr> <M-q> ExecuteMacroOverVisualRange('q')
vnoremap @ <cmd>RangeMacro<CR>
vnoremap . <cmd>:normal . <CR>

" RangeMacro : Executes for lines in the visual selection
" Arguments:
"   * [register]    If provided, assume call is from a mapping.
"                   Must be either empty or a alphanumeric register.
"                   If not empty, use the specified register instead of
"                   prompting the user.
xnoremap <M-q> <cmd>RangeMacro q<CR>
xnoremap <M-w> <cmd>RangeMacro w<CR>
xnoremap <M-e> <cmd>RangeMacro w<CR>
command! -addr=lines -bar -nargs=? -range=2 RangeMacro
        \ call <SID>RangeMacro(
        \       [str2nr(<q-line1>), str2nr(<q-line2>)],
        \       str2nr(<q-range>),
        \       <f-args>
        \ )

function! s:RangeMacro(range, rangeNr, ...) abort "{{{
    if a:0 > 1
        throw 'RangeMacro Error: Too many arguments (got ' . a:0 . ', 0 or 1 expected)'
    endif

    " Get range
    if a:rangeNr == 0
        let l:range = [line('v'), line('.')]
    else
        let l:range = a:range
    endif

    call sort(l:range, 'n')

    " Get register
    if !a:0
        call inputsave()
        echo '@' . getcmdline()
        let l:reg = nr2char(getchar())
        call inputrestore()

        " Abort
        if len(l:reg) == 0 || char2nr(l:reg[0]) < 0x20
            echo 'Aborted.'
            return
        endif
    else
        let l:reg = a:1
    endif

    " Validate register
    if len(l:reg) == 0 || len(l:reg) > 1 || l:reg =~ '[^"a-zA-Z0-9]'
        throw 'RangeMacro Error: Invalid register "' . l:reg . '"'
    endif

    if len(getreg(l:reg)) == 0
        throw 'RangeMacro Error: Register "' . l:reg . '" is empty.'
    endif

    " Backup view and prepend command to jump to cursor column to register
    let l:col = getcurpos()[2]
    let l:view = winsaveview()
    execute 'let l:regBack = @'.l:reg
    execute printf('let @%s = "%d|".@%s', l:reg, l:col, l:reg)

    " Execute macro for each line in range
    execute printf("normal \<Esc>:\<C-U> %d,%dnormal @%s\<CR>", l:range[0], l:range[1], l:reg)

    " Restore register and view
    execute 'let @'.l:reg.' = l:regBack'
    call winrestview(l:view)
endfunction " }}}

" <Leader> + m : Quick (M)acro edit
" Source: https://github.com/mhinz/vim-galore
nnoremap <leader>m  :<c-u><c-r><c-r>='let @'. v:register .' = '.
            \ string(getreg(v:register))<cr><c-f><left>
"}}}

" Miscellaneous {{{
" Disable annoying message on Ctrl+C
" if !len(maparg('<C-c>', '', 0, 1))
"     noremap <C-c> <Nop>
" endif

" Shift + q : NOP - disable ex mode shortcut
if !len(maparg('<S-q>', '', 0, 1))
    noremap <S-q> <Nop>
endif

" <Leader> + ml : Append modeline after last line in buffer.
" Source: http://vim.wikia.com/wiki/Modeline_magic
nnoremap <silent> <Leader>ml <cmd>:call rccommon#AppendModeline()<CR>

" Alt + f : Print working directory and filename
nmap <M-f> <cmd>call PrintBufferInfo()<CR>
imap <M-f> <cmd>call PrintBufferInfo()<CR>
xmap <M-f> <cmd>call PrintBufferInfo()<CR>

function! PrintBufferInfo(...) abort "{{{
    " Ignore non-file buffers
    " if &buftype != '' || &buflisted == 0
    "     return
    " endif

    " Get CWD, buffer file path
    let l:cwd = fnamemodify(getcwd(), ':~')

    if l:cwd[-1:-1] != '/'
        let l:cwd = l:cwd . '/'
    endif

    let l:path = simplify(resolve(expand('%:p')))

    call rccommon#Echo(' ' . l:cwd, 'Directory')

    if l:path == ''
        call rccommon#Echo('   [No Name]', 'Title', 1)
        return
    endif

    " Get info
    let [l:fsize, l:fperm, l:ftime] = [getfsize(l:path), getfperm(l:path),
                                       \ getftime(l:path)]
    let l:info = filter([
            \ l:fsize > 0 ? FormatFileSize(l:fsize) : '',
            \ l:fperm,
            \ l:ftime > 0 ? FormatSeconds(localtime() - l:ftime) . ' ago' : '',
        \ ],
        \ 'v:val != ""'
    \ )

    let l:bufPath = fnamemodify(l:path, ':.:~')

    " Strip CWD from buffer file path
    if stridx(l:bufPath, l:cwd) == 0
        let l:bufPath = strpart(l:bufPath, strlen(l:cwd))
    endif

    call rccommon#Echo('   ' . l:bufPath, 'Title', 1)

    if len(l:info)
        call rccommon#Echo(' ' . join(l:info, ' | '), 'Constant', 1)
    endif
endfunction "}}}

augroup EnterBufferPrintWDAndFile
    autocmd!
    autocmd BufEnter * call timer_start(20, 'PrintBufferInfo')
augroup end
"}}}

" Functions {{{

" SearchReplaceVisualSelection : Search/replace command assistant
function! SearchReplaceVisualSelection()  "{{{
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
endfunction  "}}}

"}}}

" FIXME: <C-p> goes back 2 for auto-complete - use oxad?
" Replace 2xCtrl+P/0x10 with Ctrl+i
nnoremap <Char-0x10><Char-0x10> <C-i>
xnoremap <Char-0x10><Char-0x10> <C-i>
snoremap <Char-0x10><Char-0x10> <C-i>
onoremap <Char-0x10><Char-0x10> <C-i>
inoremap <Char-0x10><Char-0x10> <C-i>
cnoremap <Char-0x10><Char-0x10> <C-i>
tnoremap <Char-0x10><Char-0x10> <C-i>

" vim: set ts=4 sw=4 tw=79 fdm=marker ff=unix fenc=utf-8 et :
