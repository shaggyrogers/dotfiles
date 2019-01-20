""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" i3.vim
" ======
"
" Description:           Configuration for i3 config files
" Author:                Michael De Pasquale
" Creation Date:         2018-02-19
" Modification Date:     2019-01-04
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function! s:UserFtSetUp()
    call rccommon#SetAndSaveBufferOptions({
                \ 'textwidth': '0',
                \ 'wrapmargin': '0',
                \ })
    call rccommon#UpdateTagbarOptions()
endfunction

augroup i3FiletypeConfig
    autocmd! * <buffer>
    autocmd BufWinEnter <buffer> call s:UserFtSetUp()
    autocmd BufWrite <buffer>
                \ call rccommon#DeleteTrailingWS()
                \ | call rccommon#UpdateModificationDate()
                \ | retab
    autocmd BufWritePost <buffer>
                \ if rccommon#ConfirmYN('Restart i3?', 2, 0, 0, 'Warning')
                \ | silent execute '!i3-msg restart'
                \ | silent execute "!sleep 0.5; i3-msg [title='nvim '] focus"
                \ | endif
    autocmd VimResized <buffer>
                \ call rccommon#UpdateTagbarOptions()
augroup end

let b:undo_ftplugin = get(b:, 'undo_ftplugin', '')
            \ . (empty(get(b:, 'undo_ftplugin', '')) ? '' : '| ')
            \ . 'exe "autocmd! i3FiletypeConfig * <buffer>"'

call s:UserFtSetUp()

" vim: set ts=4 sw=4 tw=79 fdm=marker et :
