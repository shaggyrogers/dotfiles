""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" plugins.vim
" ===========
"
" Version:               1.0.0
" Author:                Michael De Pasquale
" Creation Date:         2017-12-02
"
" Description
" -----------
"   All plugin-related options and shortcuts go here.
"
" TODO:
" * [ ] Set Ranger-like enter/exit shortcuts for NERDTree windows
" * [ ] Move mappings and important settngs to configuration
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Configuration                                               "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let s:useEmojis = 0
let s:neovimPath = $HOME.'/.config/nvim'
let s:savedYanksPath = $HOME.'/.config/nvim/temp_data/yankhistory.txt'

" Features
let s:saveYanks = 1

" Details for templates & snippets
let g:username = "Michael De Pasquale"
let g:license = "None"
let g:email = "mickdp1@gmail.com"
let g:github = "None"

" Paths to plugins and plugin patches folders, relative to neovimPath
let s:patchesDir = '/plugin_patches'
let s:pluginsDir = '/plugged'


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin patching                                             "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Note: The layout of the patch files must match the layout of the plugins
" folder for this to work.

function! plugins#applyPluginPatches()
    exec '!cp -r '.s:neovimPath.s:patchesDir.'/* '.s:neovimPath.
        \ s:pluginsDir.'/'
endfunction

function! plugins#removePluginPatches()
    exec '!find '.s:neovimPath.'/ -type f | grep -Po "(?<='.
                \ s:patchesDir.'/).*" | xargs printf "'.
                \ s:neovimPath.s:pluginsDir.'/\%s\n" | xargs rm'
    PlugUpdate
endfunction


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins                                                     "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin($HOME.'/.config/nvim/plugged')

" Required for python plugin support
Plug 'https://github.com/neovim/python-client.git'

" Syntax Highlighting / Linters
Plug 'https://github.com/w0rp/ale.git'
Plug 'https://github.com/ludovicchabant/vim-gutentags.git'
Plug 'https://github.com/nvie/vim-flake8.git'
Plug 'https://github.com/majutsushi/tagbar.git'
Plug 'https://github.com/KeitaNakamura/highlighter.nvim.git'
Plug 'https://github.com/sheerun/vim-polyglot.git'
Plug 'https://github.com/Vimjas/vim-python-pep8-indent.git'
Plug 'https://github.com/okcompute/vim-python-motions.git'
Plug 'https://github.com/okcompute/vim-python-match'
Plug 'https://github.com/vim-python/python-syntax.git'
Plug 'https://github.com/tmhedberg/SimpylFold.git'
Plug 'https://github.com/elzr/vim-json.git'

" Searching / Files
Plug 'https://github.com/scrooloose/nerdtree.git'
Plug 'https://gitlab.com/vim-IDE/vim-nerdtree-tabs'
Plug 'https://github.com/Xuyuanp/nerdtree-git-plugin.git'
Plug 'https://github.com/ctrlpvim/ctrlp.vim'
Plug 'https://github.com/DavidEGx/ctrlp-smarttabs.git'
Plug 'https://github.com/nixprime/cpsm.git'

" Misc. features
Plug 'https://github.com/mhinz/vim-startify.git'
Plug 'https://github.com/mhinz/vim-signify'
Plug 'https://github.com/tpope/vim-repeat.git'
Plug 'https://github.com/aperezdc/vim-template.git'
Plug 'https://github.com/rbgrouleff/bclose.vim.git'
Plug 'https://github.com/tpope/vim-speeddating'
Plug 'https://github.com/chrisbra/unicode.vim.git'
Plug 'https://github.com/artnez/vim-wipeout.git'
Plug 'https://github.com/tpope/vim-fugitive'
Plug 'https://github.com/junegunn/vim-peekaboo'

" UI/Visual Plugins
Plug 'https://github.com/rhysd/vim-gfm-syntax.git'
Plug 'https://github.com/timakro/vim-searchant.git'
Plug 'https://github.com/nathanaelkane/vim-indent-guides.git'
Plug 'https://github.com/luochen1990/rainbow.git'
Plug 'https://github.com/vim-airline/vim-airline.git'
Plug 'https://github.com/vim-airline/vim-airline-themes.git'
Plug 'https://github.com/morhetz/gruvbox.git'
Plug 'https://github.com/junegunn/goyo.vim.git'
Plug 'https://github.com/ryanoasis/vim-devicons.git'
Plug 'https://github.com/Shougo/denite.nvim.git'
Plug 'https://github.com/lambdalisue/neovim-prompt'
Plug 'https://github.com/Shougo/unite.vim.git'
Plug 'https://github.com/amix/vim-zenroom2'
Plug 'https://github.com/kshenoy/vim-signature.git'
Plug 'https://github.com/junegunn/limelight.vim.git'
Plug 'https://github.com/itchyny/vim-cursorword.git'
Plug 'https://github.com/machakann/vim-highlightedyank.git'

" Editing Plugins
Plug 'https://github.com/simnalamburt/vim-mundo.git'
Plug 'https://github.com/tpope/vim-surround.git'
Plug 'https://github.com/gorkunov/smartpairs.vim.git'
Plug 'https://github.com/manasthakur/vim-commentor.git'
Plug 'https://github.com/Shougo/neoyank.vim.git'
Plug 'https://github.com/AndrewRadev/splitjoin.vim'
Plug 'https://github.com/godlygeek/tabular.git'
Plug 'https://github.com/itmammoth/doorboy.vim.git'
Plug 'https://github.com/jeetsukumaran/vim-indentwise.git'
Plug 'https://github.com/dhruvasagar/vim-table-mode.git'

" Snippets
Plug 'https://github.com/Shougo/context_filetype.vim.git'
Plug 'https://github.com/Shougo/neosnippet.vim.git'
Plug 'https://github.com/Shougo/neosnippet-snippets.git'
Plug 'https://github.com/honza/vim-snippets.git'

" Deoplete sources
Plug 'https://github.com/Shougo/neco-vim'
Plug 'https://github.com/Shougo/neocomplete.vim'
Plug 'https://github.com/Shougo/neoinclude.vim.git'
Plug 'https://github.com/Shougo/neco-syntax'
Plug 'https://github.com/eagletmt/neco-ghc'
Plug 'https://github.com/nsf/gocode.git'
Plug 'https://github.com/zchee/deoplete-go'
Plug 'https://github.com/zchee/deoplete-jedi.git',
        \ { 'do': 'git submodule update --init'}
Plug 'https://github.com/c9s/perlomni.vim'
Plug 'https://github.com/tweekmonster/deoplete-clang2'
Plug 'https://github.com/fishbullet/deoplete-ruby'
Plug 'https://github.com/OmniSharp/omnisharp-vim.git'
Plug 'https://github.com/Robzz/deoplete-omnisharp/'

" Deoplete
Plug 'https://github.com/Shougo/deoplete.nvim.git'

call plug#end()

" Automatically install missing plugins and update remote plugins on startup
" https://github.com/junegunn/vim-plug/wiki/extra
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)')) |
  \ PlugInstall --sync | q | endif |
  \ silent UpdateRemotePlugins


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Airline                                                     "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable and configure extensions
let g:airline#extensions#keymap#enabled = 1
let g:airline#extensions#hunks#enabled = 1
let g:airline#extensions#tagbar#enabled = 1
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#wordcount#enabled = 1
let g:airline#extensions#windowswap = 1
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#show_splits = 0
let g:airline#extensions#tabline#show_tab_type = 0
let g:airline#extensions#tabline#current_first = 0
let g:airline#extensions#tabline#buffer_idx_mode = 0
let g:airline#extensions#tabline#buffer_nr_show = 0
let g:airline#extensions#tabline#fnamemod = ':p:t.'
let g:airline#extensions#tabline#fnamecollapse = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#tabline#tab_min_count = 2
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = ''
let g:airline#extensions#tabline#right_sep = ''
let g:airline#extensions#tabline#right_alt_sep = ''
let g:airline#extensions#tabline#show_close_button = 0

" Enable powerline font glyphs
let g:airline_powerline_fonts=1

" Customise section labels
let g:airline_mode_map = {
                        \'c'    : 'C:_',
                        \'i'    : 'I',
                        \'n'    : 'N',
                        \'R'    : 'R',
                        \''   : 'S󰆵',
                        \'s'    : 'S',
                        \'S'    : 'S󰓡',
                        \'t'    : 'T_',
                        \'v'    : 'V',
                        \'V'    : 'V󰓡',
                        \''   : 'V󰆵',
                        \'__'   : '---',
                        \}

" Customise airline symbols
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

let g:airline_symbols.linenr = ''
let g:airline_symbols.linepercent = ''
let g:airline_symbols.columnnr = ''

if s:useEmojis
    let g:airline_symbols.crypt = '🔐'
    let g:airline_symbols.readonly = '🔏'
    let g:airline_symbols.paste = '📋'
    let g:airline_symbols.modified = '📝'
endif

" Remove Separators
let g:airline_right_sep = ''
let g:airline_left_sep = ''

" Customise line/column number section
let g:airline_section_z = '%#__accent_bold#%{g:airline_symbols.linenr}%#__restore__#%3p% %{g:airline_symbols.linepercent} %{g:airline_symbols.columnnr} %#__accent_bold#% %3v'

let g:airline_section_y = '%{airline#util#wrap(airline#parts#ffenc(),0)} %{gutentags#statusline("󰓸󰁩")}'

" Theme
let g:airline_theme = 'bubblegum'


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ALE                                                         "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable ALE and ALE airline extension
let g:ale_enabled = 1
let g:airline#extensions#ale#enabled = 1


" Completion
let g:ale_completion_delay = 100
let g:ale_completion_enabled = 0
let g:ale_completion_max_suggestions = 50

" Echo error messages
let g:ale_echo_cursor = 1
let g:ale_echo_delay = 10
let g:ale_echo_msg_format = '[%linter%] %severity% %code: %%s'
let g:ale_echo_msg_error_str = 'Error'
let g:ale_echo_msg_info_str = 'Info'
let g:ale_echo_msg_warning_str = 'Warning'

let g:ale_emit_conflict_warnings = 1

" Fixers
let g:ale_fixers = {
  \   'python': [
  \       'add_blank_lines_for_python_control_statements',
  \       'isort',
  \       'yapf',
  \   ],
  \}

let g:ale_fix_on_save = 0
let g:ale_history_enabled = 1
let g:ale_history_log_output = 1
let g:ale_keep_list_window_open = 0
let g:ale_list_window_size = 10

" Linters
let g:ale_lint_delay = 200
let g:ale_lint_on_enter = 1
let g:ale_lint_on_filetype_changed = 1
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 1
let g:ale_lint_on_insert_leave  = 0
let g:ale_linter_aliases = {
            \ 'py': 'pyx',
            \ }
let g:ale_linters  = {}
let g:ale_linters_explicit = 0

let g:ale_loclist_msg_format = g:ale_echo_msg_format
let g:ale_max_buffer_history_size = 20
let g:ale_max_signs = -1
let g:ale_maximum_file_size = 0
let g:ale_open_list = 0
let g:ale_pattern_options = {}
let g:ale_pattern_options_enabled = !empty(g:ale_pattern_options)


let g:ale_set_balloons = has('balloon_eval')
let g:ale_set_highlights = has('syntax')
let g:ale_set_loclist = 1
let g:ale_set_quickfix = 0
let g:ale_set_signs = 1

let g:ale_sign_column_always = 1
let g:ale_sign_offset =  1000000
let g:ale_type_map = {
            \ 'flake8': {'ES': 'WS', 'E': 'W'}
            \ }
let g:ale_virtualenv_dir_names = ['.env', 'env', 've-py3', 've', 'virtualenv', 'venv']
let g:ale_warn_about_trailing_blank_lines = 1
let g:ale_warn_about_trailing_whitespace = 1

let g:ale_writegood_executable = 'writegood'
let g:ale_writegood_options = ''
let g:ale_writegood_use_global = 0

" Appearance
let g:ale_change_sign_column_color = 0

if s:useEmojis
    let g:ale_sign_error = '❗'
    let g:ale_sign_info = '💬'
    let g:ale_sign_warning = '❕'
    let g:ale_sign_style_error = '❓'
    let g:ale_sign_style_warning = '❔'
else
    let g:ale_sign_error = ''
    let g:ale_sign_info = '󲀃'
    let g:ale_sign_warning = ''
    let g:ale_sign_style_error = '󲁰'
    let g:ale_sign_style_warning = '󲁱'
endif

let airline#extensions#ale#error_symbol = g:ale_sign_error
let airline#extensions#ale#warning_symbol = g:ale_sign_warning

hi! link ALESignColumnWithErrors ErrorMsg
hi! link ALESignColumnWithoutErrors LineNr
hi! link ALEErrorSign Error
hi! link ALEWarningSign Warning
hi! link ALEInfoSign Info

"ALEError
"ALEWarning
"ALEInfo
"ALEStyleError
"ALEStyleWarning
"
"ALEErrorSign
"ALEWarningSign
"ALEInfoSign
"ALEStyleErrorSign
"ALEStyleWarningSign


" Misc
let g:ale_cache_executable_check_failures = 0
let g:ale_command_wrapper = ''


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" closetag                                                    "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:closetag_filenames = '*.html,*.xhtml,*.phtml'
let g:closetag_xhtml_filenames = '*.xhtml,*.jsx'
let g:closetag_emptyTags_caseSensitive = 1
let g:closetag_shortcut = '>'
let g:closetag_close_shortcut = '<leader>>'


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CtrlP                                                       "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ctrlp_working_path_mode = 'c'

" Disable ctrlp shortcut
let g:ctrlp_map = '®'

" Match, match window options
let g:ctrlp_match_window = 'bottom, order:btt, min:1, max:20,results:20'

" Configure persistent cache
let g:ctrlp_cache_clear_on_exit = 0
let g:ctrlp_cache_dir = '~/.config/nvim/temp_data/ctrlp_cache'

" Default to entire path, non-regex search.
let g:ctrlp_regexp = 0
let g:ctrlp_by_filename = 0

" Max file limit
let g:ctrlp_max_files = 4096

" Add Perl-style ignore patterns here.
let ctrlpIgnoreList = [
                        \ ".cache",
                        \ ".git",
                        \ ".svn",
                        \ ".hg" ,
                        \ ".DS_Store",
                        \ "**/*.pyc",
                        \ "*.so",
                        \ ]

" Use the silver searcher for faster search, if it is installed
if executable("ag")
    let agCmd = 'ag %s -i --nocolor --nogroup --hidden -g "" '

    for i in ctrlpIgnoreList
        let agCmd = agCmd.'--ignore '.i
    endfor

    let g:ctrp_user_command = agCmd
else " Otherwise use grep as fallback
    let grepCmd = ''
endif

" Switch to buffer if it is already open
let g:ctrlp_switch_buffer = 'ET'

" Extensions
let g:ctrlp_extensions = ['smarttabs']

" smarttabs
let g:ctrlp_smarttabs_exclude_quickfix = 1

" Shortcuts - find all (F)iles, (B)uffers, Most (R)ecent files or (T)ags
nnoremap <leader>f :CtrlPMixed<cr>
nnoremap <leader>b :CtrlPBuffer<cr>
nnoremap <leader>r :CtrlPMRUFiles<cr>
nnoremap <leader>t :CtrlPBufTag<cr>

" Find buffer (TAB)s
nnoremap <leader><Tab> :CtrlPSmartTabs<CR>

" CPSM
" Note: Needs to be installed by running install.sh
let g:ctrlp_match_func = {'match': 'cpsm#CtrlPMatch'}
let g:cpsm_match_empty_query = 0


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Denite                                                      "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Add custom menus
let s:menus = {}
let s:menus.buffer_settings = {
    \ 'description': 'change settings for current buffer',
    \ 'command_candidates': [
        \ [ 'Toggle Relative Line Numbers', 'set invrelativenumber' ],
        \ [ 'Toggle Line Wrapping', 'set invwrap' ],
        \ [ 'Toggle Showing Tabs, Spaces and Newlines', 'set invlist' ],
        \ ],
    \ }
let s:menus.buffer_windows = {
    \ 'description': 'hide/show windows in current tab',
    \ 'command_candidates': [
        \ [ 'Toggle File Browser', 'NERDTreeToggle' ],
        \ [ 'Toggle Undo Tree Explorer', 'MundoToggle' ],
        \ [ 'Toggle Tag Explorer', 'TagbarToggle' ],
        \ ],
    \ }
let s:menus.buffer_commands = {
    \ 'description': 'run command in current buffer',
    \ 'command_candidates': [
        \ [ 'Run ALE Fixers', 'ALEFix' ],
        \ [ 'Delete Trailing Whitespace', 'call DeleteTrailingWS()' ],
        \ [ 'Jump to Change...', 'call DeleteTrailingWS()' ],
        \ ],
    \ }

call denite#custom#var('menu', 'menus', s:menus)

" Mappings
nnoremap <F2> :Denite menu:buffer_commands -auto-resize -mode=normal<CR>
nnoremap <F3> :Denite menu:buffer_windows -auto-resize -mode=normal<CR>
nnoremap <F4> :Denite menu:buffer_settings -auto-resize -mode=normal<CR>
nnoremap <silent> <Leader>c :Denite change -auto-resize -mode=normal<CR>
inoremap <silent> <Leader>c <C-o>:Denite change -auto-resize -mode=normal<CR>
xnoremap <silent> <Leader>c <esc>:Denite change -auto-resize -mode=normal<CR>gv


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Deoplete                                                    "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_camel_case = 1
let g:deoplete#auto_complete_start_length = 1
let g:deoplete#max_list = 10
let g:deoplete#max_abbr_width = 100
let g:deoplete#max_menu_width = 50
let g:deoplete#auto_complete_delay = 40
let g:deoplete#file#enable_buffer_path = 1

" Use exact match from head for dictionary matches
call deoplete#custom#source(
\ 'dictionary', 'matchers', ['matcher_head'])

" Set a minimum match length for dictionary matches
call deoplete#custom#source(
\ 'dictionary', 'min_pattern_length', 3)

" deoplete-jedi - requires jedi to be installed
let g:deoplete#sources#jedi#server_timeout = 10
let g:deoplete#sources#jedi#statement_length = 50
let g:deoplete#sources#jedi#enable_cache = 1
let g:deoplete#sources#jedi#show_docstring = 0
let g:deoplete#sources#jedi#python_path = '/usr/bin/python3.6'
let g:deoplete#sources#jedi#debug_server = 0
let g:deoplete#sources#jedi#extra_path =  []


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" doorboy                                                     "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
inoremap <expr> <CR> (pumvisible() ? "\<C-y>" : "" ) . doorboy#map_cr()
inoremap <expr><BS> neocomplete#smart_close_popup().doorboy#map_backspace()

let g:doorboy_additional_quotations = {
  \ '*': ['@'],
  \ 'coffee': ['/']
  \ }
let g:doorboy_nomap_quotations = {
  \ 'javascript': ['/']
  \ }
let g:doorboy_additional_brackets = {
  \ 'html': ['<>']
  \ }
let g:doorboy_nomap_brackets = {
  \ }


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-devicons                                                "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if s:useEmojis
    let g:WebDevIconsUnicodeDecorateFolderNodesDefaultSymbol = '📁'
    let g:DevIconsDefaultFolderOpenSymbol = '📂'
endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" gfm-syntax                                                  "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:gfm_syntax_highlight_inline_code = 1
let g:gfm_syntax_highlight_mention = 1
let g:gfm_syntax_highlight_strikethrough = 1
let g:gfm_syntax_highlight_issue_number = 1
let g:gfm_syntax_highlight_table = 1

if s:useEmojis == 1
    let g:gfm_syntax_highlight_emoji = 1
    let g:gfm_syntax_emoji_conceal = 1
endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Goyo & Limelight                                            "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:goyo_width = 100
let g:goyo_height = 100
let g:limelight_conceal_guifg = 'DarkGray'
let g:limelight_conceal_guifg = '#777777'
let g:limelight_paragraph_span = 1
let g:limelight_priority = -1

autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

nnoremap <silent> <leader>z :Goyo<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Gutentags                                                   "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Requires universal ctags.
let g:gutentags_enabled = 1
let g:gutentags_generate_on_missing = 1
let g:gutentags_generate_on_new = 1
let g:gutentags_generate_on_write = 1
let g:gutentags_generate_on_empty_buffer = 0
let g:gutentags_background_update = 1
let g:gutentags_define_advanced_commands = 1
let g:gutentags_resolve_symlinks = 1

let g:gutentags_ctags_tagfile = '.tags'
let g:gutentags_ctags_exclude = ['*.md', '*.pyc', '.txt']
let g:gutentags_ctags_exclude_wildignore = 1
let g:gutentags_ctags_auto_set_tags = 1

let g:gutentags_project_root = []
let g:gutentags_add_default_project_roots = 1
let g:gutentags_exclude_project_root = []


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" highlightedyank & searchant                                 "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:highlightedyank_highlight_duration = 600
let g:highlightedyank_max_lines = 10000
let g:highlightedyank_timeout = 500

" Clear searchant highlighting before leaving buffer
augroup SearchantAutoClear
    autocmd!
    autocmd BufLeave * :execute "normal \<Plug>SearchantStop"
augroup end

" Appearance
hi HighlightedyankRegion cterm=bold gui=bold guifg=#51C0E1 guibg=NONE
hi SearchCurrent         cterm=bold gui=bold guifg=#41FF1A guibg=NONE


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" highlighter                                                 "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:highlighter#auto_update = 2
let g:highlighter#project_root_signs = ['.git']
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


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" indentLine                                                  "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_default_mapping = 0
let g:indent_guides_auto_colors = 0
let g:indent_guides_indent_levels = 6   " 16
let g:indent_guides_exclude_filetypes = ['startify', 'nerdtree', 'help']


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-json                                                    "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:vim_json_syntax_conceal = 0


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" matchmaker                                                  "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:matchmaker_enable_startup = 1


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" mundo                                                       "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:mundo_preview_bottom = 1
let g:mundo_preview_height = 25
let g:mundo_auto_preview = 0
let g:mundo_verbose_graph = 0
let g:mundo_playback_delay = 20
let g:mundo_inline_undo = 1

" Use CursorHold to run diffs to avoid diffing every node in the tree
set updatetime=400
augroup mundo_auto_preview
    autocmd!
    autocmd CursorHold __Mundo__ :call feedkeys('r','t')
augroup end


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" neosnippet                                                  "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Disable builtin python snippets. _ is all types.
let g:neosnippet#disable_runtime_snippets = {
        \   'python' : 1,
        \ }
let g:neosnippet#enable_completed_snippet = 1
let g:neosnippet#expand_word_boundary = 1
let g:neosnippet#enable_snipmate_compatibility = 0
let g:neosnippet#snippets_directory = $HOME .
            \ '/.config/nvim/plugged/vim-snippets/snippets'

" Key mappings
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)

" Details
let g:snips_author = g:username
let g:snips_email = g:email
let g:snips_github = g:github
let g:snips_license = g:license


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" neotags                                                     "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Requires universal-ctags
"g:neotags_enabled = 1
"g:neotags_file = './.tags'
"g:neotags_events_update = ['BufWritePost']
"g:neotags_events_highlight = ['BufReadPre', 'BufEnter']
"g:neotags_events_rehighlight = ['Filetype', 'Syntax']
"g:neotags_run_ctags = 1
"g:neotags_highlight = 1
"g:neotags_recursive = 1
"g:neotags_appendpath = 1
"g:neotags_ctags_bin = 'ctags'
"g:neotags_patternlength = 2048
"
"" ctags --list-kinds-full=language
"g:neotags_ctags_args = ['--fields=+l ',
"            \ '--c-kinds=+p ',
"            \ '--c++-kinds=+p ',
"            \ '--python-kinds=+l',
"            \ '--sort=no --extras=+q'
"            \ ]
"g:neotags_ctags_timeout = 16
"g:neotags_silent_timeout = 0
"g:neotags_verbose = 0
"g:neotags_ignore = ['text','nofile','mail','qf' ]
"g:neotags_ft_conv = { 'C++': 'cpp', 'C#': 'cs' }
"g:neotags_global_notin = ['.*String.*',
"            \ '.*Comment.*',
"            \ 'cIncluded',
"            \ 'cCppOut2',
"            \ 'cCppInElse2',
"            \ 'cCppOutIf2',
"            \ 'pythonDocTest',
"            \ 'pythonDocTest2',
"            \ ]
"g:neotags#c#order = 'cgstuedfpm'
"g:neotags#cpp#order = 'cgstuedfpm'
"g:neotags#python#order = 'mfc'
"g:neotags#ruby#order = 'mfc'
"g:neotags#sh#order = 'f'
"g:neotags#java#order = 'cim'
"g:neotags#javascript#order = 'cCfmpo'
"g:neotags#vim#order = 'acf'
"g:neotags#perl#order = 's'
"g:neotags#php#order = 'fc'


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" neoyank                                                     "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:neoyank#limit = 20
let g:neoyank#file = ''
if s:saveYanks
    let g:neoyank#file = s:savedYanksPath
else
    let g:neoyank#disable_write = 1
endif
let g:neoyank#save_registers = ['"']

nnoremap <silent> <M-p> :Denite neoyank -auto-resize -mode=normal<CR>
xnoremap <silent> <M-p> <esc>:Denite neoyank -auto-resize -mode=normal<CR>gv
inoremap <silent> <M-p> <C-o>:Denite neoyank -auto-resize -mode=normal<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NERDTree                                                    "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Apearance
if s:useEmojis
    let g:NERDTreeDirArrowExpandable = '📁'
    let g:NERDTreeDirArrowCollapsible = '📂'
else
    let g:NERDTreeDirArrowExpandable = ''
    let g:NERDTreeDirArrowCollapsible = ''
endif

hi! link NERDTreeOpenable Type
hi! link NERDTreeClosable Type
hi! link NERDTreeBookmark Constant

" Close NERDTree after opening a file
let g:NERDTreeQuitOnOpen = 0

" Sorting options
let g:NERDTreeNaturalSort = 1
let g:NERDTreeSortHiddenFirst = 0

" Show bookmarks and hidden files by default
let g:NERDTreeShowBookmarks = 1
let g:NERDTreeShowHidden = 1
let g:NERDTreeShowLineNumbers = 1

" Set window position & size
let g:NERDTreeWinPos = "left"
let g:NERDTreeWinSize = 35

" Ignore junk
let g:NERDTreeIgnore = [
                        \ '\.pyc$',
                        \ '__pycache__',
                        \ '\.pyc$',
                        \ '\.swp$',
                        \ '\.png$',
                        \ '\.jpg$',
                        \ '\.gif$',
                        \ '\.mp3$',
                        \ '\.flac$',
                        \ '\.ogg$',
                        \ '\.mp4$',
                        \ '\.avi$',
                        \ '.webm$',
                        \ '.mkv$',
                        \ '\.pdf$',
                        \ '\.zip$',
                        \ '\.tar.gz$',
                        \ '\.rar$'
                        \ ]

" Disable these Shortcuts
let g:NERDTreeMapJumpNextSibling = "☻"
let g:NERDTreeMapJumpPrevSibling = "☺"

" Misc
let g:NERDTreeHighlightCursorline = 1
let g:NERDTreeMinimalUI = 1

" Toggle nerdtree sidebar
nmap <Leader>o :NERDTreeToggle<CR>

augroup NERDTreeAutoClose
    autocmd!
    " Automatically close the current tab if NERDTree is the only window
    autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") &&
                                        \ b:NERDTree.isTabTree()) | q | endif
augroup end


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" peekaboo                                                    "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:peekaboo_window = 'vert bo 40new'
let g:peekaboo_delay = 0
let g:peekaboo_compact = 0

" Can't disable these, so just choose a prefix we won't ever press
let g:peekaboo_prefix = 'zpm1'
let g:peekaboo_ins_prefix = 'zpm2'

nnoremap <silent> <Leader>R :call peekaboo#aboo()<CR>
xnoremap <silent> <Leader>R <esc>:call peekaboo#aboo()<CR>gv
inoremap <silent> <Leader>R <C-o>:call peekaboo#aboo()<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" python-syntax                                               "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:python_highlight_all = 1


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Rainbow                                                     "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable by default
let g:rainbow_active = 1
let g:rainbow_conf = {
\   'guifgs': ['#CB4B16', '#DA7E0B', '#B8B41E', '#83BD14',
                \ '#12A65B', '#1C959C', '#2252BF','#782FDA', '#B62072'],
\   'ctermfgs': ['blue',  'blue',    'blue',    'blue',    'blue',
                \ 'blue',  'blue',   'blue',    'blue'],
\   'operators': '_,_',
\   'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold',
                  \ 'start=/{/ end=/}/ fold'],
\   'separately': {
\       '*': {},
\       'tex': {
\           'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/'],
\       },
\       'vim': {
\           'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/',
                        \ 'start=/{/ end=/}/ fold',
                        \ 'start=/(/ end=/)/ containedin=vimFuncBody',
                        \ 'start=/\[/ end=/\]/ containedin=vimFuncBody',
                        \ 'start=/{/ end=/}/ fold containedin=vimFuncBody'],
\       },
\       'html': {
\           'parentheses': ['start=/\v\<((area|base|br|col|embed|hr|img|input|keygen|link|menuitem|meta|param|source|track|wbr)[ >])@!\z([-_:a-zA-Z0-9]+)(\s+[-_:a-zA-Z0-9]+(\=("[^"]*"|'."'".'[^'."'".']*'."'".'|[^ '."'".'"><=`]*))?)*\>/ end=#</\z1># fold'],
\       },
\       'css': 0,
\       'markdown': 0,
\       'startify': 0,
\   }
\}

" Make bold & update colors
func! RainbowSetBold()
    try
        syntax clear rainbow_o1
        syntax clear rainbow_o2
        syntax clear rainbow_o3
        syntax clear rainbow_o4
        syntax clear rainbow_o5
        syntax clear rainbow_o6
        syntax clear rainbow_o7
        syntax clear rainbow_o8
        syntax clear rainbow_o9
    catch
    endtry
    syntax match rainbow_o1 '[\[\](){}:,]' contained containedin=rainbow_r0
    syntax match rainbow_o2 '[\[\](){}:,]' contained containedin=rainbow_r1
    syntax match rainbow_o3 '[\[\](){}:,]' contained containedin=rainbow_r2
    syntax match rainbow_o4 '[\[\](){}:,]' contained containedin=rainbow_r3
    syntax match rainbow_o5 '[\[\](){}:,]' contained containedin=rainbow_r4
    syntax match rainbow_o6 '[\[\](){}:,]' contained containedin=rainbow_r5
    syntax match rainbow_o7 '[\[\](){}:,]' contained containedin=rainbow_r6
    syntax match rainbow_o8 '[\[\](){}:,]' contained containedin=rainbow_r7
    syntax match rainbow_o9 '[\[\](){}:,]' contained containedin=rainbow_r8
    hi rainbow_o1 ctermfg=NONE guifg=#CB4B16 gui=NONE,bold
    hi rainbow_o2 ctermfg=NONE guifg=#DA7E0B gui=NONE,bold
    hi rainbow_o3 ctermfg=NONE guifg=#B8B41E gui=NONE,bold
    hi rainbow_o4 ctermfg=NONE guifg=#83BD14 gui=NONE,bold
    hi rainbow_o5 ctermfg=NONE guifg=#12A65B gui=NONE,bold
    hi rainbow_o6 ctermfg=NONE guifg=#1C959C gui=NONE,bold
    hi rainbow_o7 ctermfg=NONE guifg=#2252BF gui=NONE,bold
    hi rainbow_o8 ctermfg=NONE guifg=#782FDA gui=NONE,bold
    hi rainbow_o9 ctermfg=NONE guifg=#B62072 gui=NONE,bold
endfunc


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Signature                                                   "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:SignatureEnabledAtStartup = 1


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Signify                                                     "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:signify_realtime = 0
let g:signify_vcs_list = ['git' , 'hg', 'svn']
let g:signify_vcs_cmds = {
\ 'git':      'git diff --no-color --no-ext-diff -U0 -- %f',
\ 'hg':       'hg diff --config extensions.color=! --config defaults.diff= --nodates -U0 -- %f',
\ 'svn':      'svn diff --diff-cmd %d -x -U0 -- %f',
\ }
let g:signify_disable_by_default = 0
let g:signify_update_on_bufenter = 1
let g:signify_update_on_focusgained = 1

let g:signify_sign_add               = '󱅅'
let g:signify_sign_delete            = '󱅛'
let g:signify_sign_delete_first_line = '󱅎'
let g:signify_sign_change            = '󱅐'
let g:signify_sign_changedelete      = g:signify_sign_change


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SimpylFold                                                  "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:SimpylFold_docstring_preview = 0
let g:SimpylFold_fold_docstring = 1
let g:SimpylFold_fold_import = 1


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Smartpairs                                                  "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Select word if there are no smartpairs regions
let g:smartpairs_start_from_word = 1

" Extend the range of smartpairs to most of the screen
let g:smartpairs_maxdepth = 40


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Splitjoin                                                   "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:splitjoin_split_mapping = '<M-s>'
let g:splitjoin_join_mapping = '<M-S>'
let g:splitjoin_normalize_whitespace = 1
let g:splitjoin_align = 0
let g:splitjoin_curly_brace_padding = 0
let g:splitjoin_trailing_comma = 0
let g:splitjoin_ruby_curly_braces = 0
let g:splitjoin_ruby_trailing_comma = 0
let g:splitjoin_ruby_hanging_args = 1
let g:splitjoin_ruby_do_block_split = 1
let g:splitjoin_coffee_suffix_if_clause = 1
let g:splitjoin_perl_brace_on_same_line = 1
let g:splitjoin_ruby_heredoc_type = '<<-'
let g:splitjoin_python_brackets_on_separate_lines = 1
let g:splitjoin_handlebars_closing_bracket_on_same_line = 0
let g:splitjoin_handlebars_hanging_arguments = 0
let g:splitjoin_html_attributes_bracket_on_new_line = 0


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Startify                                                    "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Rebind Ctrl+T to open Startify
map <C-t> :tabnew ./<CR>:Startify<cr>

" Set cursorline and locally remap q to close window
augroup StartifyInit
    autocmd!
    autocmd Filetype startify setlocal cursorline
augroup end

let g:startify_list_order = [
            \ ['   Recently used files:'],
            \ 'files',
            \ ['   Recently used files from the current directory:'],
            \ 'dir',
            \ ['   Previous sessions: (:SDelete - delete, :SClose - close, <Leader>+SS - save'],
            \ 'sessions',
            \ ['   Bookmarks:'],
            \ 'bookmarks',
            \ ['   Commands:'],
            \ 'commands',
            \ ]
let g:startify_list_order = ['sessions', 'files', 'dir', 'bookmarks', 'commands']
let g:startify_session_dir = '~/.config/nvim/sessions'
let g:startify_update_oldfiles = 1
let g:startify_change_to_dir = 1
let g:startify_custom_indices = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
                                \ 'w', 'r', 'y', 'u', 'i', 'o', 'p', 'a', 's','d',
                                \ 'f', 'g', 'z', 'x', 'c', 'v', 'b', 'n', 'm',
                                \ '<F2>', '<F3>', '<F4>', '<F5>', '<F6>',
                                \ '<F7>', '<F8>', '<F9>', '<F10>', '<F11>',
                                \ '<F12>']
let g:startify_files_number = 20
let g:startify_skiplist = [
        \ 'COMMIT_EDITMSG',
        \ escape(fnamemodify(resolve($VIMRUNTIME), ':p'), '\') .'doc',
        \ 'bundle/.*/doc',
        \ ]

let s:startify_ascii_header = [
 \ '                                        ▟▙            ',
 \ '                                        ▝▘            ',
 \ '██▃▅▇█▆▖  ▗▟████▙▖   ▄████▄   ██▄  ▄██  ██  ▗▟█▆▄▄▆█▙▖',
 \ '██▛▔ ▝██  ██▄▄▄▄██  ██▛▔▔▜██  ▝██  ██▘  ██  ██▛▜██▛▜██',
 \ '██    ██  ██▀▀▀▀▀▘  ██▖  ▗██   ▜█▙▟█▛   ██  ██  ██  ██',
 \ '██    ██  ▜█▙▄▄▄▟▊  ▀██▙▟██▀   ▝████▘   ██  ██  ██  ██',
 \ '▀▀    ▀▀   ▝▀▀▀▀▀     ▀▀▀▀       ▀▀     ▀▀  ▀▀  ▀▀  ▀▀',
 \ '',
 \ 'Press a key, or use t then <CR> to select and then open entries in tabs.',
 \ ''
 \]
let g:startify_custom_header = map(s:startify_ascii_header +
                                    \ startify#fortune#quote(),'"   ".v:val')

" Misc. quotes/aphorisms/'oblique strategies' from
" * Oblique Strategies, 4th Edition, with modifications
" * Unofficial 'oblique strategies' from a variety of sources
" * Phrases about common programming-related problems
" * https://github.com/RobBlackwell/oblique-strategies-for-programmers
" * Programming-related 'Oblique Strategies' by Kevin Lawler
let g:all_oblique_strategies = [
    \ "Steal a solution.",
    \ "List the qualities it has. List those you'd like.",
    \ "How would you explain this to:\r - your parents?\r - a child?",
    \ "Back up a few steps. What else could you have done?",
    \ "Who is it for?",
    \ "What do you do best?",
    \ "What most recently impressed you? How is it similar? What can you learn"
        \ ." from it? What could you take from it?",
    \ "Take away as much mystery as possible. What is left?",
    \ "Pay attention to distractions",
    \ "Commit to the next thing that occurs to you.",
    \ "Resurrect a dead idea",
    \ "Don't be afraid to repeat yourself.",
    \ "Follow the path of least resistance",
    \ "Enjoy the absence of a clear solution.",
    \ "If in doubt, improvise.",
    \ "Never run if you can walk.",
    \ "Abandon it, but come back to it later",
    \ "Quality thought is a result of quality time.",
    \ "Second guess your doubts, triple guess your initial thoughts.",
    \ "What is the least important thing right now?",
    \ "Avoid repetition at all costs.",
    \ "Cut your losses.",
    \ "If you can't walk, try running.",
    \ "Break it down into smaller parts.",
    \ "If all you have is a hammer, everything looks like a nail.",
    \ "Research.",
    \ "Look for an old or new solution.",
    \ "Are you using the best tool for the job?",
    \ "Think about what you really feel like doing, then do it.",
    \ "Spend some time looking at art or listening to music and don't think ".
        \ "about it.",
    \ "Form a few different hypotheses and test them.",
    \ "Evaluate your goals.",
    \ "Evaluate your progress. Look for ways to improve.",
    \ "Trim the fat.",
    \ "Do something unnecessary.",
    \ "Take a quick nap.",
    \ "Try something completely new.",
    \ "Make it up as you go.",
    \ "Meditate for a while.",
    \ "Abandon normal instructions",
    \ "Accept advice",
    \ "Adding on",
    \ "Always the first steps",
    \ "Ask your body",
    \ "Be dirty",
    \ "Be extravagant",
    \ "Be less critical",
    \ "Breathe more deeply",
    \ "Bridges\r - build\r - burn",
    \ "Change ambiguities to specifics",
    \ "Change nothing and continue consistently",
    \ "Change specifics to ambiguities",
    \ "Consider transitions",
    \ "Discard an axiom",
    \ "Disciplined self-indulgence",
    \ "Discover your formulas and abandon them",
    \ "Display your talent",
    \ "Do nothing for as long as possible",
    \ "Don't avoid what is easy",
    \ "Don't stress one thing more than another",
    \ "Do something boring",
    \ "Do something sudden, destructive and unpredictable",
    \ "Do the last thing first",
    \ "Do the words need changing?",
    \ "Emphasize differences",
    \ "Emphasize the flaws",
    \ "Faced with a choice, do both",
    \ "Find a safe part and use it as an anchor",
    \ "Give the game away",
    \ "Go outside. Shut the door.",
    \ "Go to an extreme, come part way back",
    \ "How would someone else do it?",
    \ "How would you have done it?",
    \ "Is it finished?",
    \ "Is something missing?",
    \ "Is the style right?",
    \ "It is simply a matter of work",
    \ "Just carry on",
    \ "Listen to the quiet voice",
    \ "Look at the order in which you do things",
    \ "Magnify the most difficult details",
    \ "Make what's perfect more human",
    \ "Move towards the unimportant",
    \ "Not building a wall; making a brick",
    \ "Once the search has begun, something will be found",
    \ "Only a part, not the whole",
    \ "Only one element of each kind",
    \ "Openly resist change",
    \ "Remove a restriction",
    \ "Repetition is a form of change",
    \ "Retrace your steps",
    \ "Slow preparation, fast execution",
    \ "State the problem as clearly as possible",
    \ "Take a break",
    \ "Take away the important parts",
    \ "The most easily forgotten thing is the most important",
    \ "Think\r - inside the work \r - outside the work",
    \ "Tidy up",
    \ "Try faking it",
    \ "Turn it upside down",
    \ "Use an old idea",
    \ "Use something nearby as a model",
    \ "Use your own ideas",
    \ "Voice your suspicions",
    \ "What context would look right?",
    \ "What is the simplest solution?",
    \ "What mistakes did you make last time?",
    \ "What to increase? What to reduce? What to maintain?",
    \ "What were you really thinking about just now?",
    \ "What wouldn't you do?",
    \ "What would your closest friend do?",
    \ "When is it for?",
    \ "Where is the edge?",
    \ "Which parts can be grouped?",
    \ "Work at a different speed",
    \ "Would anyone want it?",
    \ "Your mistake was a hidden intention",
    \ "Look for a hack. Cut corners.",
    \ "Relax the problem wherever possible.",
    \ "Look for a good enough approximation.",
    \ "Use a novel combination of high-level strategies.",
    \ "Forget about optimizing your code. You can always leave a TODO and fix".
        \ " it later.",
    \ "Solve the problem directly.",
    \ "The lazy man lifts more than he can safely carry, to save the trouble ".
        \ "of coming a second time.",
    \ "Take as much time as you need to study the problem and design the ".
        \"solution.",
    \ "Get red and green right before mixing yellow.",
    \ "A blink lasts 300 milliseconds.",
    \ "Add constraints.",
    \ "Verify your fears, explicitly.",
    \ "If you see ten troubles coming down the road, you can be sure that ".
        \ "nine will run into the ditch before they reach you.",
    \ "Take a closer look.",
    \ "Is it the bug you think it is?",
    \ "Is it a typo? Did you copy and paste?",
    \ "Stop and think it through first.",
    \ "If you lack motivation, find the most interesting thing in the ".
        \"project, start on that, and branch from there.",
    \ "Don't worry about mistakes, you can clean it up later.",
    \ "Change your mind.",
    \ "Look for ways to chain tools.",
    \ "Backtrack. If an avenue appears exhausted, your assumption must be wrong.",
    \ "You cannot dig a hole in a different place by digging the same hole deeper.",
    \ "Flip the problem around. Look at it from a different perspective.",
    \ "Work forward from where the unfinished part of the code suggests you ".
        \"should.",
    \ "List dependencies to determine the order of completion.",
    \ "Try the naive method first.",
    \ "Implementing both solutions can be faster than theorising over which is best.",
    \ "Verify your assumptions.",
    \ "Get water flowing through the pipe. Connect the system end-to-end, ".
        \ "using dummy sections where necessary. The pieces that are finished".
        \ " yield testable output.",
    \ "Write down everything you know about the problem.",
    \ "If you're stuck, finish some remaining piece. Then go back and check ".
        \ "to see what new possibilities opened up. Repeat.",
    \ "It is often better to guess wrong and check than to sit pondering what".
        \ " might be correct.",
    \ "Have goals and subdivide them.",
    \ "...truth will sooner come out of error than from confusion.",
    \ "Do something - inaction won't solve the problem.",
    \ "Work on something else.",
    \ "Make an exhaustive list of everything you might do next.",
    \ "Remember that models don't necessarily correspond with reality.",
    \ "Generate alternative solutions and pick the best.",
    \ "Can you make this program do one thing instead of two?",
    \ "Is this abstraction delivering enough benefit?",
    \ "Are you solving the right problem?",
    \ "Can you automate this?",
    \ "If it doesn't work, it doesn't matter how fast it doesn't work.",
    \ "Are you clear about what you are trying to build?",
    \ "Could the documentation be wrong?",
    \ "Does the code actually do what the comments say it should?",
    \ "Can you build something to help you understand the problem?",
    \ "Before software can be reusable it first has to be usable.",
    \ "First, solve the problem. Then, write the code.",
    \ "Deleted code is debugged code.",
    \ "Is it broken by design?",
    \ "Sit quietly and think.",
    \ "KISS: Keep It Short and Simple. Keep It Simple Stupid!",
    \ "What would be the implications of ignoring this problem and doing ".
        \"nothing about it for the time being?",
    \ "The simplest explanation is most likely the correct one.",
    \ "Can you get more information?",
    \ "Is there a test or simulation that you could run?",
    \ "Is this really necessary?",
    \ "Can I simplify the problem somehow?",
    \ "Only change one thing at a time. Try to predict what will happen with ".
        \"each change.",
    \ "Stop guessing and look at the facts.",
    \ "Are you fooling yourself?",
    \ "Write some more unit tests.",
    \ "Keep a written log of every change and any results.",
    \ "Is there a better algorithm? Consult the literature.",
    \ "Idly thumb through The Gang of Four Design Patterns book.",
    \ "Idly thumb through The Art of Computer Science by Donald Knuth.",
    \ "Designing the right data structure is often more important than ".
        \"designing the right code.",
    \ "How could you go about formally proving this code to be correct?",
    \ "Is this code part of a design pattern? What's its name?",
    \ "Get away from your desk.",
    \ "Collect all the information, notes, scribbles and diagrams.",
    \ "Tidy up your work area.",
    \ "Are you looking in the right place?",
    \ "Is this a symptom or a cause?",
    \ "Take a break",
    \ "Try recreating this section from scratch.",
    \ "Try to write a small, reproducible code sample with just the salient ".
        \ "parts and all other complexity removed.",
    \ "Is this a numerical problem? Think about rounding, division by zero, ".
        \ "overflow and floating point errors.",
    \ "Is there a standard approach to this?",
    \ "If you had time to refactor this code, what would you change?",
    \ "Can you pair program it?",
    \ "How did they do it without computers?",
    \ "Don't assume that the bug was caused by somebody else.",
    \ "Build expertise in your project's domain. Talk to expert users. Read ".
        \ "industry papers, academic reports, brochures etc.",
    \ "Read a book on the subject.",
    \ "Take a smoke break, even if you don't actually smoke.",
    \ "Make a cup of tea or coffee.",
    \ "Don't invent another data format.",
    \ "Go outside and get some fresh air.",
    \ "Stand in front of a big blank whiteboard with a pen. Start writing.",
    \ "What's the simplest thing that could possibly work?",
    \ "Think about what is going on at the lowest possible level and work ".
        \ "your way up.",
    \ "Read it slowly, carefully and deliberately. What does it actually say?",
    \ "Write down a clear statement of the problem on paper.",
    \ "Can you find some similar code in an open source project and study it?",
    \ "Go and talk to somebody who isn't a programmer.",
    \ "Switch off your monitor and sit at your desk quietly for a while.",
    \ "Go and get something to eat.",
    \ "Google it.",
    \ "Can you reuse an old idea or code from an earlier project?",
    \ "Sleep on it. Things will look different tomorrow.",
    \ "Imagine what the world would look like if you had already solved the problem.",
    \ "Are you using the right tools for the job?",
    \ "Do your names and abstractions correspond with the real world? Is ".
        \ "your code model driven?",
    \ "Do it manually.",
    \ "Every problem has a perfectly reasonable explanation.",
    \ "Can you use a tool to get a better idea what's happening?",
    \ "Don't reinvent the wheel. If there's a library, use it.",
    \ "Can you adapt something that you already have?",
    \ "Read the documentation thoroughly. Read it again.",
    \ "Imagine you had unlimited resources. What would you do?",
    \ "Have you seen it with your own eyes?",
    \ "Is it worth the effort? What else could you be doing?",
    \ "Quickly weigh the costs and benefits, then decide.",
    \ "What is true of one part may not be true of the whole.",
    \ "What is true of the whole may not be true of one part.",
    \ "What goals do you have right now? How long will they take?",
    \ "The first 90 percent of the code accounts for the first 90 percent ".
        \ "of the development time. The remaining 10 percent of the code ".
        \ "accounts for the other 90 percent of the development time.",
    \ "Perfect is the enemy of good.",
    \ "Do one thing well, not many things poorly.",
    \ "Don't hesitate to start again if necessary. It will probably save ".
        \ "you time.",
    \ "Good programmers know what to write. Great ones know what to rewrite ".
        \ "and reuse.",
    \ "Perfection in design is achieved when there is nothing more to take ".
        \ "away.",
    \ "Commit early and often.",
    \ "It is better to have a system omit certain anomalous features and ".
        \ "improvements, but to reflect one set of design ideas, than to ".
        \ "have one that contains many good but independent and ".
        \ "uncoordinated ideas"
    \ ]

" Source: Startify
function! plugins#getRandomStartifyFooter() abort
    let offset = str2nr(matchstr(reltimestr(reltime()), '\.\zs\d\+')[1:]) %
                \ len(g:all_oblique_strategies)
  return g:all_oblique_strategies[offset]
endfunction

let g:startify_custom_footer = map(['', plugins#getRandomStartifyFooter()],
            \ '"   ".v:val')

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Tabularize                                                  "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" from spf13, modified
nmap  <Leader>T&         :Tabularize   /&<CR>
vmap  <Leader>T&         :Tabularize   /&<CR>
nmap  <Leader>T=         :Tabularize   /^[^=]*\zs=<CR>
vmap  <Leader>T=         :Tabularize   /^[^=]*\zs=<CR>
nmap  <Leader>T=>        :Tabularize   /=><CR>
vmap  <Leader>T=>        :Tabularize   /=><CR>
nmap  <Leader>T:         :Tabularize   /:<CR>
vmap  <Leader>T:         :Tabularize   /:<CR>
nmap  <Leader>T::        :Tabularize   /:\zs<CR>
vmap  <Leader>T::        :Tabularize   /:\zs<CR>
nmap  <Leader>T,         :Tabularize   /,<CR>
vmap  <Leader>T,         :Tabularize   /,<CR>
nmap  <Leader>T,,        :Tabularize   /,\zs<CR>
vmap  <Leader>T,,        :Tabularize   /,\zs<CR>
nmap  <Leader>T<Bar>     :Tabularize   /<Bar><CR>
vmap  <Leader>T<Bar>     :Tabularize   /<Bar><CR>
nmap  <Leader>T<Space>   :Tabularize   /\S\+<CR>
vmap  <Leader>T<Space>   :Tabularize   /\S\+<CR>

nmap <M-Space> :Tabularize /[    ][^     ]\+/<CR>
vmap <M-Space> :Tabularize /[    ][^     ]\+/<CR>gv

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-table-mode                                              "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enabled for markdown only, see filetypes.vim
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


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Tagbar                                                      "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:tagbar_width = 30
let g:tagbar_autoclose = 1
let g:tagbar_autofocus = 1
let g:tagbar_sort = 0
let g:tagbar_compact = 1
let g:tagbar_indent = 1
let g:tagbar_show_visibility = 1
let g:tagbar_show_linenumbers = 0
let g:tagbar_expand = 1
let g:tagbar_foldlevel = 1
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

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Templates                                                   "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:templates_fuzzy_start = 1
let g:templates_directory = [ $HOME.'/.config/nvim/templates' ]
let g:templates_search_height = 0
let g:templates_global_name_prefix = 'template'
let g:templates_no_builtin_templates = 1
let g:templates_user_variables = [
        \   ['FILEHEADING', 'TemplateFileHeading'],
        \   ['FILEHEADINGULINE', 'TemplateFileHeadingUnderline'],
        \ ]

" User-defined template variables
function! TemplateFileHeading()
    return expand('%:p:t')
endfunction

function! TemplateFileHeadingUnderline()
    return repeat('=', len(expand('%:p:t')))
endfunction


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Function keys
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <F5> :NERDTreeToggle<CR>
nnoremap <F6> :TagbarToggle<CR>
nnoremap <F7> :MundoToggle<CR>
nnoremap <F12> :ALEFix<CR>:echom 'Running ALE fixers...'<CR>
