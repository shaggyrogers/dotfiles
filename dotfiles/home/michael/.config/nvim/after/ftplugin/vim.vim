""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim.vim
" =======
"
" Description:           Configuration for vim syntax buffers
" Author:                Michael De Pasquale
" Creation Date:         2018-02-18
" Modification Date:     2019-10-28
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function! s:UserFtSetUp()
    hi! link vimNiceComment Comment
    hi! link Conceal Operator
    call rccommon#UpdateTagbarOptions()
    call rccommon#LoadFiletypeDictionary()
    call rccommon#SetAndSaveWindowOptions({
                \ 'foldmethod': 'marker',
                \ 'foldcolumn': '2',
                \ })
                " \ 'autoindent': v:true,
                " \ 'smrtindent': '',
                " \ 'cindent': v:true,
                " \ 'indentexpr': '',

                " \ 'indentkeys': '0{,0},:,0#,!^F,o,O,e,=end,=else,=cat,=fina,=END,0\\',
                " 'linebreak'
                " 'wrapmargin'

                " \ 'breakindent': v:true,
                " \ 'breakat':
                " \ 'breakindentopt': 'min:20,shift:4,sbr',
                " \ 'cinkeys': v:true,
                " \ 'cinoptions': '',
                " \ 'cinwords': '',
                " \ 'copyindent': '',
                " \ 'preserveindent': '',
                " \ 'cop': '',
    call rccommon#HighlightTextWidth()

    " Update indentation
    let g:vim_indent_cont = 2 * &sw
endfunction

augroup VimscriptFiletypeConfig
    autocmd! * <buffer>
    "autocmd BufWinEnter <buffer> call s:UserFtSetUp()
    autocmd BufEnter <buffer> call s:UserFtSetUp()
    "autocmd BufEnter <buffer> hi! link Conceal Operator
    autocmd BufWrite <buffer>
                \ call rccommon#DeleteTrailingWS()
                \ | call rccommon#UpdateModificationDate()
                \ | retab
    autocmd VimResized <buffer> call rccommon#UpdateTagbarOptions()
augroup end

" Undo
let b:undo_ftplugin = get(b:, 'undo_ftplugin', '')
            \ . (empty(get(b:, 'undo_ftplugin', '')) ? '' : '| ')
            \ . 'execute "autocmd! VimscriptFiletypeConfig * <buffer>"'

" Need this for window setup in some cases
call s:UserFtSetUp()

" vim: set ts=4 sw=4 tw=79 fdm=marker et :
