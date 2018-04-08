" Provides ranger-like movement for NERDTree
"
"call NERDTreeAddKeyMap({
           \ 'key': 'l',
           \ 'callback': "NERDTreeRangerKeysEnter",
           \ 'quickhelpText': 'Enter the given directory or open the given file.'
           \ 'override' : 1})
" Automatically close only on normal open (enter/o)
function! NERDTreeCustomMapsOpenAndClose()
    let n = g:NERDTreeFileNode.GetSelected()

    if n != {} && !n.path.isDirectory
        call n.open()
        NERDTreeClose
        return
    endif

    " Not file, activate directory mode like normal
    call n.activate(0)
endfunction

