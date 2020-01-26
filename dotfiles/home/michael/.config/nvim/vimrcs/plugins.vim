""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" plugins.vim
" ===========

" Description:           All plugin-related options and shortcuts go here.
" Author:                Michael De Pasquale
" Creation Date:         2017-12-02
" Modification Date:     2020-01-25
" License:               MIT
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


let v:errors = []
let s:assert = 0

" Global configuration
let s:useEmojis = 0
let s:neovimPath = $HOME.'/.config/nvim'
let s:savedYanksPath = $HOME.'/.config/nvim/temp_data/yankhistory.txt'
let s:python = get(filter(map(['python3.7', 'python3', 'python'], 'exepath(v:val)'), 'len(v:val)'), 0, '')

" Features
let s:saveYanks = 1

" Details for snippets
let g:username = "Michael De Pasquale"
let g:license = "MIT"
let g:email = ""
let g:github = "shaggyrogers"

" Project root markers{{{
" Directories must end with / for rooter.
let s:project_root_markers = [
            \ '.projectroot',
            \ '.git',
            \ '.git/',
            \ '.hg/',
            \ '.svn/',
            \ '_darcs/',
            \ '_FOSSIL_/',
            \ '.fslckout/',
            \ '.bzr/',
            \ 'CVS/',
            \ '.gitignore',
            \ '.hgignore',
            \ '.travis.yml',
            \ 'pom.xml',
            \ 'tox.ini',
            \ 'build.gradle',
            \ 'rebar.config',
            \ '.scrutinizer.yml',
            \ '.readthedocs.yml',
            \ 'codecov.yml',
            \ 'Gemfile',
            \ 'Pipfile.lock',
            \ 'setup.py',
            \ 'configure.in',
            \ 'configure.ac',
            \ 'CHANGELOG',
            \ 'CHANGELOG.md',
            \ 'CHANGELOG.markdown',
            \ 'CHANGELOG.rst',
            \ 'README',
            \ 'README.md',
            \ 'README.markdown',
            \ 'README.rst',
            \ 'LICENSE',
            \ 'Makefile',
            \ 'CMakeLists.txt',
            \ 'Rakefile',
        \ ] "}}}


" Plugin patching
let s:patchesDir = '/plugin_patches'
let s:pluginsDir = '/plugged'

" Apply patches in plugin_patches directory.
" Layout must match the "plugins" folder.
function! plugins#applyPluginPatches() "{{{
    exec '!cp -r '.s:neovimPath.s:patchesDir.'/* '.s:neovimPath.
        \ s:pluginsDir.'/'
    echom 'Done. You may need to restart vim to apply the patch changes.'
endfunction "}}}

" Remove patched files and retrieve the originals.
function! plugins#removePluginPatches() "{{{
    exec '!find '.s:neovimPath.'/ -type f | grep -Po "(?<='.
                \ s:patchesDir.'/).*" | xargs printf "'.
                \ s:neovimPath.s:pluginsDir.'/\%s\n" | xargs rm'
    PlugUpdate
endfunction "}}}

command! PlugPatchAll call plugins#applyPluginPatches()
command! PlugUnpatchAll call plugins#removePluginPatches()


" Load plugins
call plug#begin($HOME.'/.config/nvim/plugged')

" Python plugin support
Plug 'https://github.com/neovim/python-client.git'

" Autocomplete{{{
Plug 'https://github.com/c9s/perlomni.vim'
Plug 'https://github.com/eagletmt/neco-ghc'
Plug 'https://github.com/fishbullet/deoplete-ruby'
Plug 'https://github.com/nsf/gocode.git'
Plug 'https://github.com/Shougo/deoplete.nvim.git'
Plug 'https://github.com/Shougo/neco-syntax'
Plug 'https://github.com/Shougo/neco-vim'
Plug 'https://github.com/Shougo/neocomplete.vim'
Plug 'https://github.com/Shougo/neoinclude.vim.git'
Plug 'https://github.com/tweekmonster/deoplete-clang2'
Plug 'https://github.com/zchee/deoplete-go'
Plug 'https://github.com/zchee/deoplete-jedi.git',
            \ { 'do': 'git submodule update --init'}
"}}}

" Editing{{{
Plug 'https://github.com/SirVer/ultisnips.git'
Plug 'https://github.com/dhruvasagar/vim-table-mode.git'
Plug 'https://github.com/godlygeek/tabular.git'
Plug 'https://github.com/itmammoth/doorboy.vim.git'
Plug 'https://github.com/kurkale6ka/vim-swap'
Plug 'https://github.com/manasthakur/vim-commentor.git'
Plug 'https://github.com/rhysd/clever-f.vim.git'
Plug 'https://github.com/shaggyrogers/vim-slide.git'
Plug 'https://github.com/tpope/vim-repeat.git'
Plug 'https://github.com/tpope/vim-speeddating'
Plug 'https://github.com/tpope/vim-surround.git'
Plug 'https://github.com/zirrostig/vim-schlepp'
"}}}

" Syntax / other language-specific plugins {{{
Plug 'https://github.com/KeitaNakamura/highlighter.nvim.git'
Plug 'https://github.com/Vimjas/vim-python-pep8-indent.git'
Plug 'https://github.com/elzr/vim-json.git'
Plug 'https://github.com/ludovicchabant/vim-gutentags.git'
Plug 'https://github.com/majutsushi/tagbar.git'
Plug 'https://github.com/okcompute/vim-python-match'
Plug 'https://github.com/okcompute/vim-python-motions.git'
Plug 'https://github.com/rhysd/vim-gfm-syntax.git'
Plug 'https://github.com/tmhedberg/SimpylFold.git'
Plug 'https://github.com/tweekmonster/impsort.vim.git'
Plug 'https://github.com/vim-python/python-syntax.git'
Plug 'https://github.com/w0rp/ale.git'
"}}}

" Files / Buffers / Windows {{{
Plug 'https://github.com/airblade/vim-rooter.git'
Plug 'https://github.com/ctrlpvim/ctrlp.vim'
Plug 'https://github.com/DavidEGx/ctrlp-smarttabs.git'
Plug 'https://github.com/nixprime/cpsm.git'
"}}}

" Version Control {{{
Plug 'https://github.com/simnalamburt/vim-mundo.git'
Plug 'https://github.com/mhinz/vim-signify'
 "}}}

" UI{{{
Plug 'https://github.com/Shougo/denite.nvim.git'
Plug 'https://github.com/Shougo/unite.vim.git'
"Plug 'https://github.com/chrisbra/Colorizer.git'
Plug 'https://github.com/itchyny/vim-cursorword.git'
Plug 'https://github.com/kshenoy/vim-signature.git'
Plug 'https://github.com/lambdalisue/neovim-prompt'
Plug 'https://github.com/luochen1990/rainbow.git'
Plug 'https://github.com/machakann/vim-highlightedyank.git'
Plug 'https://github.com/mhinz/vim-startify.git'
Plug 'https://github.com/nathanaelkane/vim-indent-guides.git'
Plug 'https://github.com/ryanoasis/vim-devicons.git'
Plug 'https://github.com/timakro/vim-searchant.git'
Plug 'https://github.com/vim-airline/vim-airline-themes.git'
Plug 'https://github.com/vim-airline/vim-airline.git'
"}}}

call plug#end()

" Prompt user to install new / clean old plugins
if len(filter(values(g:plugs), '!isdirectory(v:val.dir)')) &&
        \ rccommon#ConfirmYN('New plugin detected, install?')
    PlugInstall --sync | q
    silent UpdateRemotePlugins
endif


" Configure plugins
" Autocomplete{{{

" Deoplete{{{
call assert_true(exists('*deoplete#initialize'))

" General configuration
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_camel_case = 1
let g:deoplete#auto_complete_start_length = 1
let g:deoplete#max_list = 10
let g:deoplete#max_abbr_width = 100
let g:deoplete#max_menu_width = 50
let g:deoplete#auto_complete_delay = 40
let g:deoplete#file#enable_buffer_path = 1

" Configure dictionary
call deoplete#custom#source('dictionary', 'matchers', ['matcher_head'])
call deoplete#custom#source('dictionary', 'min_pattern_length', 3)

" deoplete-jedi [Python]
let g:deoplete#sources#jedi#server_timeout = 10
let g:deoplete#sources#jedi#statement_length = 50
let g:deoplete#sources#jedi#enable_cache = 1
let g:deoplete#sources#jedi#show_docstring = 0
let g:deoplete#sources#jedi#python_path = s:python
let g:deoplete#sources#jedi#debug_server = 0
let g:deoplete#sources#jedi#extra_path =  []
"}}}

" UltiSnips {{{
call assert_true(exists(':UltiSnipsEdit'))

" Configuration
let g:UltiSnipsUsePythonVersion = 3
let g:UltiSnipsEditSplit = 'horizontal'
let g:UltiSnipsSnippetDir = $HOME . '/.config/nvim/UltiSnips'
let g:snips_author = g:username
let g:snips_email = g:email
let g:snips_github = g:github
let g:snips_license = g:license

" Python
let g:ultisnips_python_style = 'numpy'
let g:ultisnips_python_quoting_style = 'single'
let g:ultisnips_python_triple_quoting_style = 'double'

" Key mappings
let g:UltiSnipsExpandTrigger = "<C-k>"
let g:UltiSnipsListSnippets = '<c-j>'
let g:UltiSnipsJumpForwardTrigger = '<c-l>'
let g:UltiSnipsJumpBackwardTrigger = '<c-h>'
" }}}

" neco-ghc [Haskell]
let g:necoghc_enable_detailed_browse = 1
"}}}

" Editing{{{

" clever-f{{{
call assert_true(get(g:, 'loaded_clever_f',0))

let g:clever_f_across_no_line = 1
let g:clever_f_chars_match_any_signs = ''
let g:clever_f_clean_labels_eagerly    = 1
let g:clever_f_fix_key_direction = 0
let g:clever_f_hide_cursor_on_cmdline = 1
let g:clever_f_ignore_case = 0
let g:clever_f_mark_char = 1
let g:clever_f_mark_char_color = 'MatchParen'
let g:clever_f_mark_cursor = 1
let g:clever_f_mark_cursor_color = 'Cursor'
let g:clever_f_repeat_last_char_inputs = ["\<CR>"]
let g:clever_f_show_prompt = 1
let g:clever_f_smart_case = 1
let g:clever_f_timeout_ms = 0
let g:clever_f_use_migemo = 0

nnoremap <Esc> <Cmd>call clever_f#_reset_all()<CR>
"}}}

" doorboy{{{
call assert_true(exists('g:loaded_doorboy'))

" Configure for filetypes
let g:doorboy_additional_quotations = {'coffee': ['/']}
let g:doorboy_nomap_quotations = {'javascript': ['/']}
let g:doorboy_additional_brackets = {'html': ['<>']}
"}}}

" vim-swap {{{
" Alt + u/i : Swap words left / right
nmap <M-u> <Plug>SwapSwapWithL_WORD
nmap <M-i> <Plug>SwapSwapWithR_WORD
"}}}

" schlepp{{{
call assert_true(maparg('<Plug>SchleppUp') != '')

let g:Schlepp#allowSquishingLines = 1
let g:Schlepp#allowSquishingBlocks = 1
let g:Schlepp#reindent = 0
let g:Schlepp#useShiftWidthLines = 1
let g:Schlepp#trimWS = 0

" Mappings
nmap <silent> <Char-0x10>Gc Vzn<Plug>SchleppUp<esc>zNzv
nmap <silent> <Char-0x10>Gb Vzn<Plug>SchleppDown<esc>zNzv
nmap <silent> <Char-0x10>GZ Vzn<Plug>SchleppLeft<esc>zNzv
nmap <silent> <Char-0x10>Gd Vzn<Plug>SchleppRight<esc>zNzv
xmap <silent> <Char-0x10>Gc zn<Plug>SchleppUp<esc>zNzvgv
xmap <silent> <Char-0x10>Gb zn<Plug>SchleppDown<esc>zNzvgv
xmap <silent> <Char-0x10>GZ zn<Plug>SchleppLeft<esc>zNzvgv
xmap <silent> <Char-0x10>Gd zn<Plug>SchleppRight<esc>zNzvgv
"}}}

" Table mode{{{
call assert_true(exists(':TableModeEnable'))

" Configuration
let g:table_mode_corner = '|'
let g:table_mode_separator = '|'
let g:table_mode_fillchar = '-'
let g:table_mode_delimiter = ','
let g:table_mode_corner_corner = '|'
let g:table_mode_align_char = ':'
let g:table_mode_disable_mappings = 1
let g:table_mode_syntax = 0
let g:table_mode_auto_align = 1
let g:table_mode_update_time = 500

" Mappings
nnoremap <Leader><bar> :TableModeToggle<CR>
xnoremap <Leader><bar> <esc>:TableModeToggle<CR>gv

" Airline status indicator
function! plugins#TableModeStatus()
    if exists(':TableModeEnable') && tablemode#IsActive()
        return printf('%s', g:airline_symbols.tablemode)
    endif

    return ''
endfunction
"}}}

" Tabularize{{{
call assert_true(exists(':Tabularize'))
" Source: spf13, with some modifications
nnoremap <Leader>T&       <cmd>Tabularize /&<CR>
nnoremap <Leader>T,       <cmd>Tabularize /,<CR>
nnoremap <Leader>T,,      <cmd>Tabularize /,\zs<CR>
nnoremap <Leader>T:       <cmd>Tabularize /:<CR>
nnoremap <Leader>T::      <cmd>Tabularize /:\zs<CR>
nnoremap <Leader>T<Bar>   <cmd>Tabularize /<Bar><CR>
nnoremap <Leader>T<Space> <cmd>Tabularize /\S\+<CR>
nnoremap <Leader>T<Tab>   <cmd>Tabularize /\t\+<CR>
nnoremap <Leader>T=       <cmd>Tabularize /^[^=]*\zs=<CR>
nnoremap <Leader>T=>      <cmd>Tabularize /=><CR>
xnoremap <Leader>T&       <cmd>call TabularizeVisual('/&')<CR>
xnoremap <Leader>T,       <cmd>call TabularizeVisual('/,')<CR>
xnoremap <Leader>T,,      <cmd>call TabularizeVisual('/,\zs')<CR>
xnoremap <Leader>T:       <cmd>call TabularizeVisual('/:')<CR>
xnoremap <Leader>T::      <cmd>call TabularizeVisual('/:\zs')<CR>
xnoremap <Leader>T<Bar>   <cmd>call TabularizeVisual('/<Bar>')<CR>
xnoremap <Leader>T<Space> <cmd>call TabularizeVisual('/\S\+')<CR>
xnoremap <Leader>T<Space> <cmd>call TabularizeVisual('/\S\+')<CR>
xnoremap <Leader>T=       <cmd>call TabularizeVisual('/^[^=]*\zs=')<CR>
xnoremap <Leader>T=>      <cmd>call TabularizeVisual('/=>')<CR>

" TODO: Improve this - use iskeyword?
nnoremap <M-Space> <cmd>Tabularize      /[ ][^ ]\+/l0<CR>
xnoremap <M-Space> <cmd>call TabularizeVisual('/[ ][^ ]\+/l0')<CR>

" For Tabularize <cmd> mappings in visual mode. Fixes bug(?) with single lines.
function! TabularizeVisual(pat) abort "{{{
    let l:range = sort([line('v'), line('.')])
    let l:singleLineBackup = ''

    if l:range[0] == l:range[1]
        let l:range[1] = l:range[0] + 1
        let l:singleLineBackup = getline(l:range[1])
    endif

    execute l:range[0] . ',' . l:range[1] . 'Tabularize ' . a:pat

    if l:singleLineBackup != ''
        call setline(l:range[1], l:singleLineBackup)
    endif
endfunction
"}}}

" Vissort
" Alt + s - Sort visual selection
call assert_true(exists(':Vissort'))
xmap <M-s> :Vissort<CR>
"}}}

" }}}

" Syntax{{{

" ALE{{{
call assert_true(exists(':ALELint'))

" Configuration
let g:ale_enabled = 1
let g:airline#extensions#ale#enabled = 1
let g:ale_completion_enabled = 0
let g:ale_cache_executable_check_failures = 0
let g:ale_command_wrapper = ''
let g:ale_echo_cursor = 1
let g:ale_echo_delay = 10
let g:ale_echo_msg_error_str = 'Error'
let g:ale_echo_msg_format = '[%linter%] %severity% %code: %%s'
let g:ale_echo_msg_info_str = 'Info'
let g:ale_echo_msg_warning_str = 'Warning'
let g:ale_emit_conflict_warnings = 1
let g:ale_fix_on_save = 0
let g:ale_fixers = {
            \   'python': [
            \       'add_blank_lines_for_python_control_statements',
            \       'black',
            \   ],
            \   'cpp': [
            \       'clang-format',
            \       'remove_trailing_lines',
            \       'trim_whitespace',
            \   ],
            \}
let g:ale_history_enabled = 1
let g:ale_history_log_output = 1
let g:ale_keep_list_window_open = 0
let g:ale_lint_delay = 200
let g:ale_lint_on_enter = 1
let g:ale_lint_on_filetype_changed = 1
let g:ale_lint_on_insert_leave  = 0
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 1
let g:ale_linter_aliases = { 'py': 'pyx' }
let g:ale_linters  = {
        \ 'python': ['pylint']
        \ }
let g:ale_linters_explicit = 0
let g:ale_list_window_size = 10
let g:ale_loclist_msg_format = g:ale_echo_msg_format
let g:ale_max_buffer_history_size = 20
let g:ale_max_signs = -1
let g:ale_maximum_file_size = 0
let g:ale_open_list = 0
let g:ale_pattern_options = {}
let g:ale_pattern_options_enabled = !empty(g:ale_pattern_options)
let g:ale_set_balloons = has('balloon_eval')
let g:ale_set_highlights = has('syntax')
let g:ale_set_loclist = 0
let g:ale_set_quickfix = 1
let g:ale_set_signs = 1
let g:ale_sign_column_always = 1
let g:ale_sign_offset =  1000000
let g:ale_type_map = { 'flake8': {'ES': 'WS', 'E': 'W'}  }
let g:ale_virtualenv_dir_names = [
            \ '.env',
            \ 'env',
            \ 've-py3',
            \ 've',
            \ 'virtualenv',
            \ 'venv']
let g:ale_warn_about_trailing_blank_lines = 1
let g:ale_warn_about_trailing_whitespace = 1
let g:ale_writegood_executable = 'writegood'
let g:ale_writegood_options = ''
let g:ale_writegood_use_global = 0

" Python
let g:ale_python_flake8_executable = s:python
let g:ale_python_flake8_options = '-m flake8'

" Appearance{{{
let g:ale_change_sign_column_color = 0

if s:useEmojis
    let g:ale_sign_error = '❗'
    let g:ale_sign_info = '💬'
    let g:ale_sign_warning = '⚠️' "❕
    let g:ale_sign_style_error = '❓'
    let g:ale_sign_style_warning = '❔'
else
    let g:ale_sign_error = ' '
    let g:ale_sign_info = ' '
    let g:ale_sign_warning = ' '
    let g:ale_sign_style_error = ''
    let g:ale_sign_style_warning = ''
endif

let airline#extensions#ale#error_symbol = g:ale_sign_error
let airline#extensions#ale#warning_symbol = g:ale_sign_warning
let airline#extensions#ale#show_line_number = 0

hi! link ALESignColumnWithErrors ErrorMsg
hi! link ALESignColumnWithoutErrors LineNr
hi! link ALEErrorSign Error
hi! link ALEWarningSign Warning
hi! link ALEInfoSign Info
hi! link ALEError SpellBad
hi! link ALEStyleError ALEWarning
hi! link ALEStyleErrorSign ALEWarningSign
hi! link ALEStyleWarning ALEInfo
hi! link ALEStyleWarningSign ALEInfoSign
hi! link ALEWarning Warning
hi! link ALEInfo Info

" Airline Status indicators
function! plugins#ALELintStatus()
    return printf('%s', g:_ale_statusicon)
endfunction
"}}}

" Mappings{{{
" Ctrl + Up / Down : ErrorJump next/prev{{{
nnoremap <silent> <C-Up> <Cmd>ALEPreviousWrap<CR>
nnoremap <silent> <C-Down> <Cmd>ALENextWrap<CR>
"}}}
" F12 : Run ALE fixers{{{
nnoremap <F12> :ALEFix<CR>:echom 'Running ALE fixers...'<CR>
"}}}
"}}}

" Autocommands{{{
let g:_ale_statusicon = ''

" Workaround for 'invalid sign text' apparent bug
" Seems to be caused by emoji signs?
augroup DoALEInvalidSignTextWorkaround
    autocmd!
    autocmd User ALELintPre ++once silent! ALEReset | silent! ALELint
augroup END
"}}}

"}}}

" Gutentags{{{
call assert_true(exists(':GutentagsToggleEnabled'))

" General configuration{{{
let g:gutentags_add_default_project_roots = 0
let g:gutentags_ctags_tagfile = '.tags'
let g:gutentags_define_advanced_commands = 1
let g:gutentags_exclude_project_root = []
let g:gutentags_file_list_command = {
                \ 'markers': {
                    \ '.git': 'git ls-files',
                    \ '.hg': 'hg files',
                    \ '.svn': 'svn list',
                \ },
            \ }
let g:gutentags_project_root_finder = 'FindRootDirectoryGutentagsWrapper'

" Wrapper for FindRootDirectory() that takes (and ignores) variable arguments
function! FindRootDirectoryGutentagsWrapper(...)
    "echom 'Find root dir called, cwd: ' . getcwd() . ' buffer: ' . buffer_name('')
    let l:rootdir = FindRootDirectory()

    if l:rootdir != ''
        return l:rootdir
    endif

    return getcwd()
endfunction

"let g:gutentags_project_root = [
"            \ '.projectroot',
"            \ '.git',
"            \ '.hg',
"            \ '.svn',
"            \ '_darcs',
"            \ '_FOSSIL_',
"            \ '.fslckout',
"            \ '.bzr',
"            \ 'CVS',
"            \ ]
let g:gutentags_resolve_symlinks = 1
"}}}

"}}}

" gfm-syntax{{{
call assert_true(exists('g:loaded_gfm_syntax'))
let g:gfm_syntax_highlight_inline_code = 1
let g:gfm_syntax_highlight_issue_number = 1
let g:gfm_syntax_highlight_mention = 1
let g:gfm_syntax_highlight_strikethrough = 1
let g:gfm_syntax_highlight_table = 1

if s:useEmojis == 1
    let g:gfm_syntax_highlight_emoji = 1
    let g:gfm_syntax_emoji_conceal = 1
endif
"}}}

" highlighter{{{
call assert_true(exists(':HighlighterUpdate'))
let g:highlighter#auto_update = 2
let g:highlighter#project_root_signs = s:project_root_markers
let g:highlighter#syntax_python = [
      \ { 'hlgroup'       : 'HighlighterPythonFunction',
      \   'hlgroup_link'  : 'Function',
      \   'tagkinds'      : 'f',
      \   'syntax_type'   : 'match',
      \   'syntax_suffix' : '(\@=',
      \ },
      \ { 'hlgroup'       : 'HighlighterPythonMethod',
      \   'hlgroup_link'  : 'Function',
      \   'tagkinds'      : 'm',
      \   'syntax_type'   : 'match',
      \   'syntax_prefix' : '\.\@<=',
      \ },
      \ { 'hlgroup'       : 'HighlighterPythonClass',
      \   'hlgroup_link'  : 'Type',
      \   'tagkinds'      : 'c',
     \ }]
" }}}

" python-pep8-indent {{{
let g:python_pep8_indent_searchpair_timeout = 2000
let g:python_pep8_indent_multiline_string = 0
let g:python_pep8_indent_hang_closing = 0
let g:python_pep8_indent_skip_concealed = 0
" }}}

" impsort{{{
let g:impsort_override_formatexpr = 1
let g:impsort_highlight_imported = 1
let g:impsort_method_module = ['depth', 'alpha', 'length']
let g:impsort_method_group = ['alpha', 'length']
let g:impsort_start_nextline = 0
let g:impsort_lines_after_imports = 1

hi IdentifierSpecial ctermfg=14 ctermbg=NONE guifg=#42A5F5 guibg=NONE
hi TypeSpecial ctermfg=121 ctermbg=NONE guifg=#C7A90C guibg=NONE
hi link pythonImportedClassDef TypeSpecial
hi link pythonImportedModule IdentifierSpecial
hi link pythonImportedObject TypeSpecial
" }}}

" python-syntax{{{
let g:python_highlight_all = 1
"}}}

" SimpylFold{{{
call assert_true(exists(':SimpylFoldDocstrings'))
let g:SimpylFold_docstring_preview = 0
let g:SimpylFold_fold_docstring = 1
let g:SimpylFold_fold_import = 1
"}}}

" Tagbar{{{

" Configuration
let g:tagbar_foldlevel = 1
let g:tagbar_indent = 1
let g:tagbar_autoclose = 1
let g:tagbar_autofocus = 1
let g:tagbar_compact = 1
let g:tagbar_sort = 0
let g:tagbar_width = 30
let g:tagbar_iconchars = ['▶', '▼']
let g:tagbar_type_css = {
    \ 'ctagstype' : 'Css',
    \ 'kinds'     : [
        \ 'c:classes',
        \ 's:selectors',
        \ 'i:identities'
    \ ]
\ }
let g:tagbar_type_markdown = {
    \ 'ctagstype' : 'markdown',
    \ 'kinds' : [
        \ 'h:Heading_L1',
        \ 'i:Heading_L2',
        \ 'k:Heading_L3'
    \ ]
\ }

" Mappings
nnoremap <silent> <F6> <cmd>Tagbar<CR>

"}}}

" vim-json
let g:vim_json_syntax_conceal = 0
"}}}

" Files / Buffers / Windows {{{

" Rooter{{{
" Change to a non-project file's directory when opening it
let g:rooter_change_directory_for_non_project_files = 'current'
let g:rooter_patterns = s:project_root_markers
"}}}

" CtrlP{{{
call assert_true(exists(':CtrlP'))

let g:ctrlp_by_filename = 1
let g:ctrlp_cache_clear_on_exit = 0
let g:ctrlp_cache_dir = '~/.config/nvim/temp_data/ctrlp_cache'
let g:ctrlp_map = '☺'
let g:ctrlp_match_window = 'bottom, order:btt, min:1, max:20,results:20'
let g:ctrlp_regexp = 0
let g:ctrlp_smarttabs_exclude_quickfix = 1
let g:ctrlp_switch_buffer = 'ET'
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_use_caching = 1

" Use cpsm matcher
let g:ctrlp_match_func = {'match': 'cpsm#CtrlPMatch'}
let g:cpsm_match_empty_query = 1

" List tracked files when in a repo, otherwise use find
let g:ctrlp_user_command = {
    \ 'types': {
    \   1: ['.git', 'cd %s && git ls-files'],
    \   2: ['.hg', 'hg --cwd %s locate -I .'],
    \   3: ['.svn', 'cd %s && svn list'],
    \ },
    \ 'fallback': 'find %s -type f'
\ }

" Use the silver searcher for faster search, fallback to find
" https://github.com/ggreer/the_silver_searcher
if executable("ag")
    let g:ctrlp_user_command['fallback'] =
                \ 'ag %s --files-with-matches --nocolor -g ""'.
                \ ' --ignore "\.git$\|\.hg$\|\.svn$\|\.DS_Store$\|\.cache$"'

    " Disable caching, unless file count is above this limit:
    let g:ctrlp_use_caching = 2048
endif

"Mappings
" Shortcuts - (f)iles, (b)uffers, (r)ecent files or (t)ags
nnoremap <leader>b :CtrlPBuffer<cr>
nnoremap <leader>c :CtrlPChange<cr>
nnoremap <leader>d :CtrlPDir<cr>
nnoremap <leader>D :CtrlPBookmarkDir<cr>
nnoremap <leader><M-D> :CtrlPBookmarkDirAdd<cr>
nnoremap <leader>f :CtrlP<cr>
nnoremap <leader>F :CtrlPMixed<cr>
nnoremap <leader>r :CtrlPMRUFiles<cr>
nnoremap <leader>t :CtrlPBufTag<cr>
nnoremap <leader>T :CtrlPTag<cr>
nnoremap <leader><Tab> :CtrlPSmartTabs<CR>
"}}}

"}}}

" Version Control{{{

" Mundo{{{
call assert_true(exists(':MundoShow'))

let g:mundo_auto_preview = 1
let g:mundo_auto_preview_delay = 250
let g:mundo_close_on_revert = 0
let g:mundo_inline_undo = 0
let g:mundo_enable_inline_delay = 1
let g:mundo_playback_delay = 5
let g:mundo_prefer_python3 = 1
let g:mundo_preview_bottom = 1
let g:mundo_preview_height = 20
let g:mundo_preview_statusline = 'Preview'
let g:mundo_tree_statusline = 'Undo Tree'
let g:mundo_return_on_revert = 0
let g:mundo_verbose_graph = 0
let g:mundo_width = 40

" Changes options
"function! UpdateMundoOptions(...) "{{{
"    let g:mundo_width = (rccommon#BufferColumns() - 41 > &textwidth) ? 40 : 30
"
"    if a:0 > 0 && a:1 != 0
"        call MundoToggleUpdate()
"    endif
"endfunction "}}}
"
"" Updates options and then toggles Mundo
"function! MundoToggleUpdate() "{{{
"    TagbarClose
"    call UpdateMundoOptions()
"    MundoToggle
"endfunction "}}}

" Mappings
nnoremap <silent> <F7> <cmd>MundoToggle<CR>
"}}}

" Signify{{{
call assert_true(exists(':SignifyRefresh'))

" Configuration
let g:signify_realtime = 0
let g:signify_vcs_list = ['git', 'hg', 'svn']
let g:signify_vcs_cmds = {
            \ 'git' : 'git diff --no-color --no-ext-diff -U0 -- %f',
            \ 'hg'  : 'hg diff --config extensions.color=! --config '.
            \ 'defaults.diff= --nodates -U0 -- %f',
            \ 'svn' : 'svn diff --diff-cmd %d -x -U0 -- %f',
        \ }
let g:signify_disable_by_default = 0
let g:signify_update_on_bufenter = 1
let g:signify_update_on_focusgained = 1
let g:signify_sign_show_count = 0
let g:signify_cursorhold_normal = 1

" Appearance
"if s:useEmojis
"    let g:signify_sign_add               = '➕'
"    let g:signify_sign_delete            = '🔺'
"    let g:signify_sign_delete_first_line = '➖'
"    let g:signify_sign_change            = '⚡'
"    let g:signify_sign_changedelete      = '🔔'
"else
let g:signify_line_highlight = 0
let g:signify_sign_add               = ' ' "     -
let g:signify_sign_delete            = ' ' "             -
let g:signify_sign_delete_first_line = ' ' "        -
let g:signify_sign_change            = ' ' "     -
let g:signify_sign_changedelete      = ' ' "       -
"endif
"❓ ❔ ❕ ❗ ❎ ❌ ✅  
"     
"                                    
"                
" 洛樂כֿ ﬦ ﯰ
" 🞣 🞥 🞣 🞤 🞢 🞦 🞧
" 🞬 🞭 🞮
" 🞵 🞶 🞷 🞸 🞹 🞼 🞽 🞾 🟏 🟓 🟒 🟑
"}}}


"}}}

" UI{{{

" Airline{{{
call assert_true(exists(':AirlineRefresh'))
let g:airline_skip_empty_sections = 1

" Enable and configure extensions
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#bufferline#enabled = 0
let g:airline#extensions#hunks#enabled = 1
let g:airline#extensions#keymap#enabled = 0
let g:airline#extensions#tabline#buffer_idx_mode = 0
let g:airline#extensions#tabline#buffer_nr_show = 0
let g:airline#extensions#tabline#current_first = 0
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamecollapse = 1
let g:airline#extensions#tabline#fnamemod = ':p:t.'
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#tabline#left_alt_sep = ''
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#right_alt_sep = ''
let g:airline#extensions#tabline#right_sep = ''
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#show_close_button = 0
let g:airline#extensions#tabline#show_splits = 0
let g:airline#extensions#tabline#show_tab_type = 0
let g:airline#extensions#tabline#tab_min_count = 2
let g:airline#extensions#tagbar#enabled = 1
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#wordcount#enabled = 1
let g:airline#extensions#wordcount#formatter#default#fmt_short = 1

" Appearance
let g:airline_powerline_fonts = 1
let g:airline_mode_map = {
                        \'c'    : 'C:▁',
                        \'i'    : 'I ',
                        \'n'    : 'N ',
                        \'R'    : 'R ',
                        \''   : 'S ',
                        \'s'    : 'S ',
                        \'S'    : 'S ',
                        \'t'    : 'T ',
                        \'v'    : 'V ',
                        \'V'    : 'V ',
                        \''   : 'V ',
                        \'__'   : '---',
                        \}

" Customise airline symbols
if !exists('g:airline_symbols') | let g:airline_symbols = {} | endif
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_symbols.linenr = ''
let g:airline_symbols.linepercent = ''
let g:airline_symbols.columnnr = ''
let g:airline_symbols.branch = ''
"let g:airline_symbols.notexists = '+'
let g:airline_symbols.notexists = ''
let g:airline_symbols.spell = ' '
"let g:airline_symbols.tablemode = '璘 '
let g:airline_symbols.tablemode = '璘'
"let g:airline_symbols.errorlistload = '‹›󱗊'
let g:airline_symbols.errorlistload = '  '
let g:airline_symbols.tagsload = '  '

" 

if s:useEmojis
    let g:airline_symbols.crypt = '🔐'
    let g:airline_symbols.readonly = '🔏'
    let g:airline_symbols.paste = '📋'
    let g:airline_symbols.modified = '📝'
else
    let g:airline_symbols.crypt = ''
    let g:airline_symbols.readonly = ' '
    let g:airline_symbols.paste = ' '
    let g:airline_symbols.modified = ' '
endif

" Load theme
let g:airline_theme = 'bubblegum'

" Configure sections "{{{
let g:airline_section_a =
            \ '%{airline#util#wrap(airline#parts#mode(),0)}' .
            \ '%{airline#util#append(airline#parts#crypt(),0)}' .
            \ '%{airline#util#append(airline#extensions#keymap#status(),0)}' .
            \ '%{airline#util#append(airline#parts#spell(),0)}' .
            \ '%{airline#util#append("",0)}%{airline#util#append("",0)}' .
            \ '%{airline#util#append(airline#parts#iminsert(),0)}' .
            \ '%{airline#util#append(plugins#TableModeStatus(),0)}' .
            \ '%{airline#util#append(airline#parts#paste(),0)}'
let g:airline_section_b =
            \ '%{airline#util#wrap(airline#extensions#branch#get_head(),0)} ' .
            \ '%{airline#util#wrap(airline#extensions#hunks#get_hunks(),0)}'
let g:airline_section_z =
            \ '%{airline#util#prepend(plugins#AirlineCustomLoadIndicators(),0)}' .
            \ '%3p% %{g:airline_symbols.linepercent} ' .
            \ '%{g:airline_symbols.linenr}%4l%  ' .
            \ '%{g:airline_symbols.columnnr}%3v% '
let g:airline_section_x =
            \ '%{airline#util#append(' .
            \ 'airline#extensions#tagbar#currenttag(),0)}% ' .
            \ '%{airline#util#append(airline#parts#filetype(),0)}'
"}}}

" Group gutentags / ALE indicators
function! plugins#AirlineCustomLoadIndicators() "{{{
    let l:out = gutentags#statusline(g:airline_symbols.tagsload)

    if l:out != ''
        let l:out = l:out . ' '
    endif

    let l:out = l:out . plugins#ALELintStatus()
    return l:out
endfunction "}}}

augroup AirlineRefreshAutocommands "{{{
    autocmd!

    autocmd User GutentagsUpdating AirlineRefresh
    autocmd User GutentagsUpdated AirlineRefresh

    " ALE status indicator
    autocmd User ALELintPost let g:_ale_statusicon = '' | AirlineRefresh
    autocmd User ALELintPre let g:_ale_statusicon = g:airline_symbols.errorlistload | AirlineRefresh
augroup END "}}}

"}}}

" Denite{{{
call assert_true(exists(':Denite'))

" Add custom menus{{{
function! UpdateFunctionMenus()
    let s:menus = {}
                "\ 'Denite register -mode=normal' ],
    let s:menus.main_menu = {
        \ 'description': 'misc',
        \ 'command_candidates': [
                \ [ '[<M-r>] Put From Register...',
                \ 'Denite register' ],
            \ [ '[<M-c>] Jump to Change...',
                \ 'Denite change -auto-resize' ],
            \ ]
        \ }
    let s:menus.buffer_settings = {
        \ 'description': 'settings',
        \ 'command_candidates': [
        \ [ 'Toggle Relative Line Numbers [' .
            \ {0:'OFF',1:'ON'}[&relativenumber] .']',
            \ 'set invrelativenumber | call UpdateFunctionMenus() | '
            \ .'Denite -resume' ],
        \ [ 'Toggle Line Wrapping ' . '[' .
        \ {0:'OFF',1:'ON'}[&wrap] .']',
        \ 'set invwrap' ],
        \ [ 'Toggle Showing Tabs, Spaces and Newlines ' . '[' .
            \ {0:'OFF',1:'ON'}[&list] .']', 'set invlist' ],
        \ [ 'Toggle Spell Checking ' . '[' . {0:'OFF',1:'ON'}[&spell] .']',
            \ 'set invspell' ],
        \ ],
        \ }
    let s:menus.buffer_windows = {
        \ 'description': 'windows',
        \ 'command_candidates': [
            \ [ '[<F6> ] Toggle Tag Explorer', 'Tagbar' ],
            \ [ '[<F7> ] Toggle Undo Tree Explorer', 'MundoToggle' ],
            \ [ '[<F12>] Edit Snippets...', 'UltiSnipsEdit' ],
            \ ],
        \ }
    let s:menus.buffer_commands = {
        \ 'description': 'commands',
        \ 'command_candidates': [
            \ [ '[    <F12>  ] Run ALE Fixers', 'ALEFix' ],
            \ [ '[ \ + Space ] Fix Trailing Spaces',
                \ 'call rccommon#DeleteTrailingWS()' ],
            \ [ '[           ] Fix Incorrect Indent Characters', 'retab' ],
            \ [ '[           ] Clear saved nvim data (shada)', 'wshada!' ],
            \ ],
        \ }

    call denite#custom#var('menu', 'menus', s:menus)
endfunction

function! FunctionMenu(cmd)
    call UpdateFunctionMenus()
    let l:left = {
                \ 'main_menu' : 'main_menu',
                \ 'buffer_commands' : 'buffer_windows',
                \ 'buffer_windows' : 'buffer_settings',
                \ 'buffer_settings' : 'main_menu'
                \ }
    let l:right = {
                \ 'main_menu' : 'buffer_settings',
                \ 'buffer_commands' : 'buffer_commands' ,
                \ 'buffer_windows' : 'buffer_commands',
                \ 'buffer_settings' : 'buffer_windows'
                \ }
    let l:args = {
                \ 'main_menu' : ' -auto-resize',
                \ 'buffer_commands' : ' -auto-resize' ,
                \ 'buffer_windows' : ' -auto-resize',
                \ 'buffer_settings' : ' -auto-resize'
                \ }

    execute 'Denite menu:' . a:cmd  . args[a:cmd]
    execute 'nnoremap <buffer> h <cmd>call FunctionMenu("' . l:left[a:cmd] . '")<CR>'
    execute 'nnoremap <buffer> l <cmd>call FunctionMenu("' . l:right[a:cmd] . '")<CR>'
    nnoremap <buffer> <Esc> <cmd>q<CR>
endfunction
"}}}

" Mappings
nnoremap <F1> <cmd>call FunctionMenu('main_menu')<CR>
nnoremap <F2> <cmd>call FunctionMenu('buffer_commands')<CR>
nnoremap <F3> <cmd>call FunctionMenu('buffer_windows')<CR>
nnoremap <F4> <cmd>call FunctionMenu('buffer_settings')<CR>
nnoremap <silent> <M-c> <cmd>Denite change -auto-resize<CR>
nnoremap <silent> <M-r> <cmd>Denite register<CR>
"}}}

" devicons{{{
call assert_true(exists('*webdevicons#version'))

" General configuration
let g:webdevicons_enable = 1
let g:webdevicons_enable_unite = 1
let g:webdevicons_enable_airline_tabline = 1
let g:webdevicons_enable_airline_statusline = 1
let g:webdevicons_enable_ctrlp = 1
let g:WebDevIconsUnicodeDecorateFileNodes = 1
let g:webdevicons_enable_denite = 1

if s:useEmojis
    let g:WebDevIconsUnicodeDecorateFolderNodesDefaultSymbol = '📁'
    let g:DevIconsDefaultFolderOpenSymbol = '📂'
endif
"}}}

" highlightedyank{{{
call assert_true(exists(':HighlightedyankOn'))

" General configuration
let g:highlightedyank_highlight_duration = 600
let g:highlightedyank_max_lines = 10000
let g:highlightedyank_timeout = 500
"}}}

" indent-guides{{{
call assert_true(exists(':IndentGuidesEnable'))

let g:indent_guides_auto_colors = 0
let g:indent_guides_default_mapping = 0
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_exclude_filetypes = ['qf', 'tagbar', 'startify', 'nerdtree', 'help', 'Mundo']
let g:indent_guides_guide_size = 1
let g:indent_guides_indent_levels = 6   " 16
let g:indent_guides_start_level = 2
"}}}

" Rainbow{{{
call assert_true(exists(':RainbowToggle'))
" Enable by default
let g:rainbow_active = 1
let g:rainbow_conf = {
\   'guifgs': [
\       '#CB4B16',
\       '#DA7E0B',
\       '#B8B41E',
\       '#83BD14',
\       '#12A65B',
\       '#1C959C',
\       '#2252BF',
\       '#782FDA',
\       '#B62072',
\   ],
\   'ctermfgs': map(range(9), '"blue"'),
\   'operators': '_,_',
\   'parentheses': [
\       'start=/(/ end=/)/ fold',
\       'start=/\[/ end=/\]/ fold',
\       'start=/{/ end=/}/ fold'
\   ],
\   'separately': {
\       '*': {},
\       'tex': {
\           'parentheses': [
\               'start=/(/ end=/)/',
\               'start=/\[/ end=/\]/',
\           ],
\       },
\       'vim': {
\           'parentheses': [
\               'start=/(/ end=/)/',
\               'start=/\[/ end=/\]/',
\               'start=/{/ end=/}/ fold',
\               'start=/(/ end=/)/ containedin=vimFuncBody',
\               'start=/\[/ end=/\]/ containedin=vimFuncBody',
\               'start=/{/ end=/}/ fold containedin=vimFuncBody',
\           ],
\       },
\       'html': {
\           'parentheses': [
\               'start=/\v\<((area|base|br|col|embed|hr|img|input|keygen|link|menuitem|meta|param|source|track|wbr)[ >])@!\z([-_:a-zA-Z0-9]+)(\s+[-_:a-zA-Z0-9]+(\=("[^"]*"|'."'".'[^'."'".']*'."'".'|[^ '."'".'"><=`]*))?)*\>/ end=#</\z1># fold'
\           ],
\       },
\       'css': 0,
\       'markdown': 0,
\       'startify': 0,
\   }
\}
"}}}

" Signature{{{
call assert_true(exists(':SignatureRefresh'))

" Configuration
" TODO: Set markers 🚩🔖🔧🚧📌📍⭐
let g:SignatureEnabledAtStartup = 1
let g:SignatureWrapJumps = 0
let g:SignatureForceRemoveGlobal = 1
let g:SignatureIncludeMarkers = ')!@#$%^&*('
let g:SignatureDeleteConfirmation = 1
let g:SignaturePurgeConfirmation = 1
let g:SignatureMap = {
            \ 'Leader'             :  "m",
            \ 'PlaceNextMark'      :  "☺",
            \ 'ToggleMarkAtLine'   :  "mm",
            \ 'PurgeMarksAtLine'   :  "☺",
            \ 'DeleteMark'         :  "dm",
            \ 'PurgeMarks'         :  "m<Space>",
            \ 'PurgeMarkers'       :  "m<BS>",
            \ 'GotoNextLineAlpha'  :  "☺",
            \ 'GotoPrevLineAlpha'  :  "☺",
            \ 'GotoNextSpotAlpha'  :  "☺",
            \ 'GotoPrevSpotAlpha'  :  "☺",
            \ 'GotoNextLineByPos'  :  "☺",
            \ 'GotoPrevLineByPos'  :  "☺",
            \ 'GotoNextSpotByPos'  :  "m]`",
            \ 'GotoPrevSpotByPos'  :  "m[`",
            \ 'GotoNextMarker'     :  "m]-",
            \ 'GotoPrevMarker'     :  "m[-",
            \ 'GotoNextMarkerAny'  :  "m]=",
            \ 'GotoPrevMarkerAny'  :  "m[=",
            \ 'ListBufferMarks'    :  "m/",
            \ 'ListBufferMarkers'  :  "m?"
            \ }

" Ctrl + Shift + h/j/k/l : Jump to next marked position
" Requires terminal configured to send terminal F11 escape code
map <silent> <Char-0x10>FZ m[=zx
map <silent> <Char-0x10>Fb m]`zx
map <silent> <Char-0x10>Fc m[`zx
map <silent> <Char-0x10>Fd m]=zx

" Appearance
hi SignatureMarkText ctermfg=166 ctermbg=NONE guifg=#51FF4C guibg=NONE
            \ guisp=NONE cterm=bold gui=bold
hi SignatureMarkerText ctermfg=166 ctermbg=NONE guifg=#4CFFE2 guibg=NONE
            \ guisp=NONE cterm=bold gui=bold

"}}}

" Startify{{{
let g:startify_list_order = [
            \ ['   Recently used files:'], 'files',
            \ ['   Recently used files from the current directory:'], 'dir',
            \ ['   Previous sessions:'], 'sessions',
            \ ['   Bookmarks:'], 'bookmarks',
            \ ['   Commands:'], 'commands',
        \ ]
let g:startify_list_order = ['sessions', 'files', 'dir', 'bookmarks', 'commands']
let g:startify_session_dir = '~/.config/nvim/sessions'
let g:startify_update_oldfiles = 1
let g:startify_change_to_dir = 1
let g:startify_custom_indices = [
            \ '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'w', 'r', 'y',
            \ 'u', 'o', 'p', 'a', 'd', 'f', 'g', 'z', 'x', 'c', 'n', 'm',
            \ '<F2>', '<F3>', '<F4>', '<F5>', '<F6>', '<F7>', '<F8>', '<F9>',
            \ '<F10>', '<F11>', '<F12>'
        \ ]
let g:startify_files_number = 12
let g:startify_skiplist = [
            \ 'COMMIT_EDITMSG',
            \ escape(fnamemodify(resolve($VIMRUNTIME), ':p'), '\') .'doc',
            \ 'bundle/.*/doc',
        \ ]

let s:neovim_ascii = [
 \ '                                        ▟▙            ',
 \ '                                        ▝▘            ',
 \ '██▃▅▇█▆▖  ▗▟████▙▖   ▄████▄   ██▄  ▄██  ██  ▗▟█▆▄▄▆█▙▖',
 \ '██▛▔ ▝██  ██▄▄▄▄██  ██▛▔▔▜██  ▝██  ██▘  ██  ██▛▜██▛▜██',
 \ '██    ██  ██▀▀▀▀▀▘  ██▖  ▗██   ▜█▙▟█▛   ██  ██  ██  ██',
 \ '██    ██  ▜█▙▄▄▄▟▊  ▀██▙▟██▀   ▝████▘   ██  ██  ██  ██',
 \ '▀▀    ▀▀   ▝▀▀▀▀▀     ▀▀▀▀       ▀▀     ▀▀  ▀▀  ▀▀  ▀▀',
 \ '',
 \]
let g:startify_custom_header = map(s:neovim_ascii + startify#fortune#quote(),'"   ".v:val')
let g:startify_custom_footer = map(['', obliqueStrategies#Get()], '"   ".v:val')
"}}}

" tasklist
nnoremap <silent> <M-t> <cmd>:TODOList<CR>
xnoremap <silent> <M-t> <cmd>:TODOList<CR>
"}}}


" Plugin-related autocommands
augroup VimrcPlugins "{{{
    autocmd!

    " Clear marks / markers upon loading buffer
    autocmd BufWinEnter *
                \ if exists(':SignatureRefresh') && exists('g:SignatureDeleteConfirmation')
                \ |     try
                \ |         let DelConfirmBack = g:SignatureDeleteConfirmation
                \ |         let PurgeConfirmBack = g:SignaturePurgeConfirmation
                \ |         let g:SignatureDeleteConfirmation = 0
                \ |         let g:SignaturePurgeConfirmation = 0
                \ |         call signature#mark#Purge('all')
                \ |         call signature#marker#Purge()
                \ |         let g:SignatureDeleteConfirmation = DelConfirmBack
                \ |         let g:SignaturePurgeConfirmation = PurgeConfirmBack
                \ |         unlet DelConfirmBack
                \ |         unlet PurgeConfirmBack
                \ |     catch
                \ |         echo 'err' v:exception
                \ |     endtry
                \ | endif

    " Clear search highlighting when leaving buffers
    autocmd BufLeave * execute "normal \<Plug>SearchantStop"

    " Filter quickfix output from other buffers
    autocmd QuickfixCmdPost make call QuickfixFilterBuffer()

    " ALE status indicator
    autocmd User ALELintPost let g:_ale_statusicon = '' | AirlineRefresh

    autocmd User ALELintPre
                \ let g:_ale_statusicon = g:airline_symbols.errorlistload
                \ | AirlineRefresh
augroup end "}}}


if s:assert && len(v:errors)
    for e in v:errors
        echomsg e
    endfor

    throw 'Error: ' . len(v:errors) . ' assert failures while loading ' . expand('%')
endif

" vim: set ts=4 sw=4 tw=79 fdm=marker et :
