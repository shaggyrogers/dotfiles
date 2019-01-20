""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" init.vim
" ========
"
" Author:                Michael De Pasquale
" Creation Date:         2017-12-06
"
" Description
" -----------
" Loads vimrcs and creates an autocommand to relead them automatically.
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Configuration{{{
" Folders
let g:vim_dir = resolve(expand('~/.config/nvim'))
let g:vim_dir_tmp = resolve(g:vim_dir.'/temp_data')
let g:vim_dir_rc = resolve(g:vim_dir . '/vimrcs')

" vimrc files and order of execution
let g:vimrcs = [
            \ 'rccommon.vim',
            \ 'options.vim',
            \ 'shortcuts.vim',
            \ 'plugins.vim',
            \ 'SpeedSyntax.vim',
            \ ]
"}}}

" Initialise vim{{{
execute 'set runtimepath+=' . escape(g:vim_dir, ' ",*|[')
execute 'set runtimepath+=' . escape($VIMRUNTIME, ' ",*|[')
let s:errs = []

for cs in g:vimrcs
    try
        exec 'source ' . escape(g:vim_dir_rc, ' ",*|[') . '/'
                    \ . escape(cs, ' ",*|[')
    catch
        call add(s:errs,'Error "'.v:exception.'" during reload of '.cs)
    endtry
endfor

" Display error message if any errors occured
let numErrs = len(s:errs)

if numErrs > 0
    echo numErrs.' error'(numErrs==1?'':'s').' occured while executing .vimrc:'

    for sn in s:errs
        echomsg '➜ '.sn
    endfor
endif
"}}}

" Autocommands{{{
augroup ReloadVimScript
    autocmd!
    autocmd BufWritePost */*.vim
                \ call ReloadVimScript(resolve(expand("<amatch>")))
augroup end
"}}}

function! GetLoadedScripts() " {{{
    let [l:scriptnames_output, l:scripts] = ['', []]

    redir => scriptnames_output
        silent scriptnames
    redir end

    for line in split(scriptnames_output, "\n")
        let nr = matchstr(line, '\d\+')
        let name = substitute(line, '.\+:\s*', '', '')
        let scripts += [resolve(expand(name))]
    endfor

    return scripts
endfunction " }}}

function! IsLoadedVimScript(str) " {{{
    let l:str = resolve(expand(a:str))
    let l:scriptList = GetLoadedScripts()
    return index(l:scriptList, l:str) != -1
endfunc " }}}

if exists('*ReloadVimScript')
    finish
endif

function! ReloadVimScript(path) " {{{
    if IsLoadedVimScript(a:path)
        try
            execute 'source ' . escape(a:path, ' ",*|[')
        catch
            echoerr 'Failed to reload ' . a:path . ': ' . v:exception
            return
        endtry

        redraw
        echom 'Reloaded ' . a:path
    endif
endfunction " }}}

" vim: set ts=4 sw=4 tw=79 fdm=marker et :
