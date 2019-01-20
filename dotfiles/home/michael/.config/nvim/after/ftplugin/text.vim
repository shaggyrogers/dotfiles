""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" text.vim
" ========
"
" Description:           Commands for text buffers.
" Author:                Michael De Pasquale <shaggyrogers>
" Creation Date:         2018-05-11
" Modification Date:     2019-01-05
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function! s:UserFtSetUp()
    call rccommon#SetAndSaveBufferOptions({
                \ 'complete': &complete . ',kspell',
                \ 'textwidth': '0',
                \ 'wrapmargin': '0',
                \ })
    call rccommon#SetAndSaveWindowOptions({
                \ 'spell': v:true,
                \ 'linebreak': v:true,
                \ 'concealcursor': 'c',
                \ })
    call rccommon#LoadFiletypeDictionary('markdown')
endfunction

augroup TextFiletypeConfig
    autocmd! * <buffer>
    autocmd BufWinEnter <buffer> call s:UserFtSetUp()
    autocmd BufWrite <buffer>
                \ call rccommon#DeleteTrailingWS()
                \ | call rccommon#UpdateModificationDate()
                \ | retab
augroup end

let b:undo_ftplugin = get(b:, 'undo_ftplugin', '')
            \ . (empty(get(b:, 'undo_ftplugin', '')) ? '' : '| ')
            \ . 'exe "autocmd! TextFiletypeConfig * <buffer>"'

call s:UserFtSetUp()

" vim: set ts=4 sw=4 tw=79 fdm=marker et :
