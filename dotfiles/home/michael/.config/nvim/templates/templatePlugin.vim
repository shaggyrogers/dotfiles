""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" %FILEHEADING%
" %FILEHEADINGULINE%
" Description:           %HERE%
" Author:                %USER% <%GITHUBUSER%>
" Creation Date:         %DATE%
" Modification Date:     %DATE%
" License:               %LICENSE%
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Set this to 1 to disable sanity checks.
let s:debug = get(g:, 'debug_plugin_%FILENAMEVAR%', 0)

" Perform sanity checks "{{{
function! SanityCheck(actual, expected, ...) "{{{
    if a:actual != a:expected && !s:debug
        if a:0 > 0
            echoerr '%FILENAMEVAR%: '.a:1
        endif

        finish
    endif
endf "}}}

"call s:SanityCheck(get(g:, 'loaded_plugin_%FILENAMEVAR%', 0), 0)
"call s:SanityCheck(executable('program'), 1, 'program is required.')
"call s:SanityCheck(has('feature'), 1, 'feature is required.')
 "}}}

" Set option defaults"{{{
let g:%FILENAMEVAR%_option = get(g:, '%FILENAMEVAR%_option', 'default_value')
 "}}}

" Define commands "{{{
command! -bar %FILENAMEVAR%Enable call %FILENAMEVAR%#Enable()
command! -bar %FILENAMEVAR%Disable call %FILENAMEVAR%#Disable()
command! -bar %FILENAMEVAR%Toggle call %FILENAMEVAR%#Toggle()
 "}}}

" Define autocommands "{{{
augroup %FILENAMEVAR%Init
    autocmd!
    autocmd VimEnter * call %FILENAMEVAR%#Initialise()
    autocmd VimLeavePre * call %FILENAMEVAR%#Cleanup()
augroup end
 "}}}

let g:loaded_plugin_%FILENAMEVAR% = 1
" vim: set ts=4 sw=4 tw=79 fdm=marker et :
