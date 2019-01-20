""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" markdown.vim
" ============
"
" Description:           Commands for markdown syntax buffers.
" Author:                Michael De Pasquale <shaggyrogers>
" Creation Date:         2018-02-19
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
    call rccommon#LoadFiletypeDictionary()

    if exists(':TableModeEnable')
        silent exec 'TableModeEnable'
    endif
endfunction

augroup MarkdownFiletypeConfig
    autocmd! * <buffer>
    autocmd BufWinEnter <buffer> call s:UserFtSetUp()
    autocmd BufEnter *.md
                \ hi! link Conceal Identifier
                \ | if exists(':TableModeEnable')
                    \ | silent exec 'TableModeEnable'
                \ | endif
    autocmd BufLeave *.md
                \ if exists(':TableModeDisable')
                    \ | silent exec 'TableModeDisable'
                \ | endif
    autocmd BufWrite *.md
                \ call rccommon#DeleteTrailingWS()
                \ | call rccommon#UpdateModificationDate()
                \ | retab
augroup end

let b:undo_ftplugin = get(b:, 'undo_ftplugin', '')
            \ . (empty(get(b:, 'undo_ftplugin', '')) ? '' : '| ')
            \ . 'exe "autocmd! MarkdownFiletypeConfig * <buffer>"'
            \ . ' | if exists(":TableModeEnable")'
            \ . ' | silent exec "TableModeEnable"'
            \ . ' | endif'

call s:UserFtSetUp()

" vim: set ts=4 sw=4 tw=79 fdm=marker et :
