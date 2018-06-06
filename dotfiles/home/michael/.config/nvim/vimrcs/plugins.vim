""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" plugins.vim
" ===========
"
" Author:                Michael De Pasquale
" Creation Date:         2017-12-02
"
" Description
" -----------
"   All plugin-related options and shortcuts go here.
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" TODO:
" * Move mappings and important settngs to configuration

" Global configuration{{{
let s:useEmojis = 0
let s:neovimPath = $HOME.'/.config/nvim'
let s:savedYanksPath = $HOME.'/.config/nvim/temp_data/yankhistory.txt'

" Features
let s:saveYanks = 1

" Details for templates & snippets
let g:username = "Michael De Pasquale"
let g:license = "MIT"
let g:email = "miсkԁρ1 аt ցmаіl ԁоt ⅽօm"
let g:github = "shaggyrogers"

" Paths to plugins and plugin patches folders, relative to neovimPath
let s:patchesDir = '/plugin_patches'
let s:pluginsDir = '/plugged'
"}}}

" Plugin patching{{{
" Note: The layout of the patch files must match the layout of the plugins
" folder for this to work.

function! plugins#applyPluginPatches()
    exec '!cp -r '.s:neovimPath.s:patchesDir.'/* '.s:neovimPath.
        \ s:pluginsDir.'/'
    " TODO: Source patched vim scripts to apply changes
    echom 'Done. You may need to restart vim to apply the patch changes.'
endfunction

function! plugins#removePluginPatches()
    exec '!find '.s:neovimPath.'/ -type f | grep -Po "(?<='.
                \ s:patchesDir.'/).*" | xargs printf "'.
                \ s:neovimPath.s:pluginsDir.'/\%s\n" | xargs rm'
    PlugUpdate
endfunction

command! PlugPatchAll call plugins#applyPluginPatches()
command! PlugUnpatchAll call plugins#removePluginPatches()
"}}}

" Load plugins{{{
call plug#begin($HOME.'/.config/nvim/plugged')

" Python plugin support "{{{
Plug 'https://github.com/neovim/python-client.git'
"}}}

" Autocomplete{{{
Plug 'https://github.com/c9s/perlomni.vim'
Plug 'https://github.com/eagletmt/neco-ghc'
Plug 'https://github.com/fishbullet/deoplete-ruby'
Plug 'https://github.com/nsf/gocode.git'
Plug 'https://github.com/OmniSharp/omnisharp-vim.git'
Plug 'https://github.com/Robzz/deoplete-omnisharp/'
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
Plug 'https://github.com/AndrewRadev/splitjoin.vim'
Plug 'https://github.com/aperezdc/vim-template.git'
Plug 'https://github.com/chrisbra/unicode.vim.git'
Plug 'https://github.com/dhruvasagar/vim-table-mode.git'
Plug 'https://github.com/godlygeek/tabular.git'
Plug 'https://github.com/gorkunov/smartpairs.vim.git'
Plug 'https://github.com/itmammoth/doorboy.vim.git'
Plug 'https://github.com/manasthakur/vim-commentor.git'
Plug 'https://github.com/Shougo/neoyank.vim.git'
Plug 'https://github.com/SirVer/ultisnips.git'
Plug 'https://github.com/tpope/vim-speeddating'
Plug 'https://github.com/tpope/vim-surround.git'
Plug 'https://github.com/tpope/vim-unimpaired.git'
Plug 'https://github.com/zirrostig/vim-schlepp'
"}}}

" Syntax {{{
" Plug 'https://github.com/c0r73x/neotags.nvim.git' - faster?
Plug 'https://github.com/elzr/vim-json.git'
Plug 'https://github.com/KeitaNakamura/highlighter.nvim.git'
Plug 'https://github.com/ludovicchabant/vim-gutentags.git'
Plug 'https://github.com/majutsushi/tagbar.git'
Plug 'https://github.com/okcompute/vim-python-match'
Plug 'https://github.com/okcompute/vim-python-motions.git'
Plug 'https://github.com/rhysd/vim-gfm-syntax.git'
Plug 'https://github.com/sheerun/vim-polyglot.git'
Plug 'https://github.com/tmhedberg/SimpylFold.git'
Plug 'https://github.com/vim-python/python-syntax.git'
Plug 'https://github.com/Vimjas/vim-python-pep8-indent.git'
Plug 'https://github.com/w0rp/ale.git'
"}}}

" Files / Buffers / Windows {{{
Plug 'https://github.com/airblade/vim-rooter.git'
Plug 'https://github.com/artnez/vim-wipeout.git'
Plug 'https://github.com/ctrlpvim/ctrlp.vim'
Plug 'https://github.com/DavidEGx/ctrlp-smarttabs.git'
Plug 'https://github.com/nixprime/cpsm.git'
Plug 'https://github.com/scrooloose/nerdtree.git'
"}}}

" Version Control "{{{
"Plug 'https://github.com/simnalamburt/vim-mundo.git'
Plug 'https://github.com/shaggyrogers/vim-mundo.git'
Plug 'https://github.com/kshenoy/vim-signature.git'
Plug 'https://github.com/Xuyuanp/nerdtree-git-plugin.git'
Plug 'https://github.com/tpope/vim-fugitive'
Plug 'https://github.com/junegunn/gv.vim.git'
 "}}}

" UI{{{
Plug 'https://github.com/nathanaelkane/vim-indent-guides.git'
Plug 'https://github.com/lambdalisue/neovim-prompt'
Plug 'https://github.com/Shougo/denite.nvim.git'
Plug 'https://github.com/Shougo/unite.vim.git'
Plug 'https://github.com/vim-airline/vim-airline-themes.git'
Plug 'https://github.com/vim-airline/vim-airline.git'
Plug 'https://github.com/mhinz/vim-signify'
Plug 'https://github.com/mhinz/vim-startify.git'
Plug 'https://github.com/itchyny/vim-cursorword.git'
Plug 'https://github.com/chrisbra/Colorizer.git'
Plug 'https://github.com/luochen1990/rainbow.git'
Plug 'https://github.com/machakann/vim-highlightedyank.git'
Plug 'https://github.com/ryanoasis/vim-devicons.git'
Plug 'https://github.com/timakro/vim-searchant.git'
"}}}

" Miscellaneous {{{
Plug 'https://github.com/kana/vim-submode.git'
Plug 'https://github.com/tpope/vim-repeat.git'
"}}}

call plug#end()

" Prompt user to install new / clean old plugins
if len(filter(values(g:plugs), '!isdirectory(v:val.dir)')) &&
        \ rccommon#ConfirmYN('New plugin detected, install?')
    PlugInstall --sync | q
    silent UpdateRemotePlugins
endif

"}}}

" Configure plugins{{{

" Autocomplete{{{
" Deoplete{{{
call assert_true(exists('*deoplete#initialize'))
" General configuration{{{
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_camel_case = 1
let g:deoplete#auto_complete_start_length = 1
let g:deoplete#max_list = 10
let g:deoplete#max_abbr_width = 100
let g:deoplete#max_menu_width = 50
let g:deoplete#auto_complete_delay = 40
let g:deoplete#file#enable_buffer_path = 1
"}}}
" Configure dictionary{{{
call deoplete#custom#source('dictionary', 'matchers', ['matcher_head'])
call deoplete#custom#source('dictionary', 'min_pattern_length', 3)
"}}}
"}}}
" UltiSnips{{{
" Configuration{{{
let g:UltiSnipsUsePythonVersion = 3
let g:UltiSnipsEditSplit = 'horizontal'
let g:UltiSnipsSnippetDir = $HOME . '/.config/nvim/UltiSnips'
let g:snips_author = g:username
let g:snips_email = g:email
let g:snips_github = g:github
let g:snips_license = g:license
"}}}
" Key mappings{{{
let g:UltiSnipsExpandTrigger = "<C-k>"
let g:UltiSnipsListSnippets = '<c-j>'
let g:UltiSnipsJumpForwardTrigger = '<c-l>'
let g:UltiSnipsJumpBackwardTrigger = '<c-h>'
"}}}
"}}}
" neco-ghc [Haskell] "{{{
let g:necoghc_enable_detailed_browse = 1
"}}}
" deoplete-jedi [Python]{{{
let g:deoplete#sources#jedi#server_timeout = 10
let g:deoplete#sources#jedi#statement_length = 50
let g:deoplete#sources#jedi#enable_cache = 1
let g:deoplete#sources#jedi#show_docstring = 0
let g:deoplete#sources#jedi#python_path = '/usr/bin/python3.6'
let g:deoplete#sources#jedi#debug_server = 0
let g:deoplete#sources#jedi#extra_path =  []
"}}}
"}}}

" Editing{{{
" doorboy{{{
call assert_true(exists('g:loaded_doorboy'))
" Configure for filetypes {{{
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
"}}}
"}}}
" neoyank{{{
call assert_true(exists('g:neoyank#limit'))
" Configure{{{
let g:neoyank#limit = 64
let g:neoyank#save_registers = ['0']

if s:saveYanks
    let g:neoyank#file = s:savedYanksPath
else
    let g:neoyank#disable_write = 1
    let g:neoyank#file = ''
endif
"}}}
" Alt + p : paste from yank history{{{
nnoremap <silent> <M-p> :Denite neoyank -auto-resize -mode=normal<CR>
xnoremap <silent> <M-p> <esc>:Denite neoyank -auto-resize -mode=normal<CR>gv
inoremap <silent> <M-p> <C-o>:Denite neoyank -auto-resize -mode=normal<CR>
"}}}
"}}}
" schlepp{{{
" Configuration{{{
let g:Schlepp#allowSquishingLines = 1
let g:Schlepp#allowSquishingBlocks = 1
let g:Schlepp#reindent = 1
let g:Schlepp#useShiftWidthLines = 1
"}}}
" Mappings{{{
nmap <silent> <Char-0x10>Gc Vzv<Plug>SchleppUp
nmap <silent> <Char-0x10>Gb Vzv<Plug>SchleppDown
nmap <silent> <Char-0x10>GZ Vzv<Plug>SchleppLeft
nmap <silent> <Char-0x10>Gd Vzv<Plug>SchleppRight
xmap <silent> <Char-0x10>Gc zv<Plug>SchleppUp
xmap <silent> <Char-0x10>Gb zv<Plug>SchleppDown
xmap <silent> <Char-0x10>GZ zv<Plug>SchleppLeft
xmap <silent> <Char-0x10>Gd zv<Plug>SchleppRight
"}}}
"}}}
" Splitjoin{{{
" Smartpairs{{{
" Configuration{{{
let g:smartpairs_start_from_word = 1
let g:smartpairs_maxdepth = 64
"}}}
" Mappings - Alt + v / Alt + Shift + v : Select word / paragraph{{{
function! SmartPairsN()
    exec 'normal! v' | NextPairs
endfunction
function! SmartPairsV()
    exec 'normal! gv' | NextPairs
endfunction

nnoremap <silent> <M-v> :call SmartPairsN()<CR>
xnoremap <silent> <M-v> <esc>:call SmartPairsV()<CR>
"}}}
"}}}
" Configuration{{{
let g:splitjoin_align = 0
let g:splitjoin_coffee_suffix_if_clause = 1
let g:splitjoin_curly_brace_padding = 0
let g:splitjoin_handlebars_closing_bracket_on_same_line = 0
let g:splitjoin_handlebars_hanging_arguments = 0
let g:splitjoin_html_attributes_bracket_on_new_line = 0
let g:splitjoin_normalize_whitespace = 1
let g:splitjoin_perl_brace_on_same_line = 1
let g:splitjoin_python_brackets_on_separate_lines = 1
let g:splitjoin_ruby_curly_braces = 0
let g:splitjoin_ruby_do_block_split = 1
let g:splitjoin_ruby_hanging_args = 1
let g:splitjoin_ruby_heredoc_type = '<<-'
let g:splitjoin_ruby_trailing_comma = 0
let g:splitjoin_trailing_comma = 0
"}}}
" Mappings{{{
let g:splitjoin_join_mapping = '<M-S>'
let g:splitjoin_split_mapping = '<M-s>'
"}}}
"}}}
" Templates{{{
call assert_true(exists(':Template'))
" Configuration{{{
let g:templates_fuzzy_start = 1
let g:templates_directory = [ $HOME.'/.config/nvim/templates' ]
let g:templates_search_height = 0
let g:templates_global_name_prefix = 'template'
let g:templates_no_builtin_templates = 1
let g:templates_user_variables = [
        \   ['FILEHEADING', 'plugins#TemplateFileHeading'],
        \   ['FILEHEADINGULINE', 'plugins#TemplateFileHeadingUnderline'],
        \   ['GITHUBUSER', 'plugins#TemplateGithubUser'],
        \ ]
"}}}
" Functions{{{
function! plugins#TemplateFileHeading()
    return expand('%:p:t')
endfunction
function! plugins#TemplateFileHeadingUnderline()
    return repeat('=', len(expand('%:p:t')))
endfunction
function! plugins#TemplateGithubUser()
    return g:github
endfunction
"}}}
"}}}
" Table mode{{{
" Configuration{{{
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
"}}}
" Mappings{{{
nnoremap <Leader><bar> :TableModeToggle<CR>
xnoremap <Leader><bar> <esc>:TableModeToggle<CR>gv
"}}}
" Custom status indicator{{{
function! plugins#TableModeStatus()
    if exists(':TableModeEnable') && tablemode#IsActive()
        return printf('%s', g:airline_symbols.tablemode)
    endif
    return ''
endfunction
"}}}
"}}}
" Tabularize{{{
" Mappings {{{
" Source: spf13, with some modifications
nnoremap <Leader>T&       :Tabularize /&<CR>
xnoremap <Leader>T&       :Tabularize /&<CR>
nnoremap <Leader>T=       :Tabularize /^[^=]*\zs=<CR>
xnoremap <Leader>T=       :Tabularize /^[^=]*\zs=<CR>
nnoremap <Leader>T=>      :Tabularize /=><CR>
xnoremap <Leader>T=>      :Tabularize /=><CR>
nnoremap <Leader>T:       :Tabularize /:<CR>
xnoremap <Leader>T:       :Tabularize /:<CR>
nnoremap <Leader>T::      :Tabularize /:\zs<CR>
xnoremap <Leader>T::      :Tabularize /:\zs<CR>
nnoremap <Leader>T,       :Tabularize /,<CR>
xnoremap <Leader>T,       :Tabularize /,<CR>
nnoremap <Leader>T,,      :Tabularize /,\zs<CR>
xnoremap <Leader>T,,      :Tabularize /,\zs<CR>
nnoremap <Leader>T<Bar>   :Tabularize /<Bar><CR>
xnoremap <Leader>T<Bar>   :Tabularize /<Bar><CR>
nnoremap <Leader>T<Space> :Tabularize /\S\+<CR>
xnoremap <Leader>T<Space> :Tabularize /\S\+<CR>
xnoremap <Leader>T<Space> :Tabularize /\S\+<CR>

" TODO: Improve this - use iskeyword
nnoremap <M-Space>        :Tabularize /[              ][^ ]\+/l0<CR>
xnoremap <M-Space>        :Tabularize /[              ][^ ]\+/l0<CR>gv
"}}}
"}}}
" Vissort{{{
" Alt + s - Sort visual selection
xmap <M-s> :Vissort<CR>
"}}}
"}}}

" Syntax{{{
" ALE{{{
call assert_true(exists(':ALELint'))
let g:ale_enabled = 1
let g:airline#extensions#ale#enabled = 1
let g:ale_completion_enabled = 0
" Configuration{{{
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
            \       'isort',
            \       'yapf',
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
let g:ale_linters  = {}
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
let g:ale_virtualenv_dir_names = ['.env', 'env', 've-py3', 've', 'virtualenv',  'venv']
let g:ale_warn_about_trailing_blank_lines = 1
let g:ale_warn_about_trailing_whitespace = 1
let g:ale_writegood_executable = 'writegood'
let g:ale_writegood_options = ''
let g:ale_writegood_use_global = 0
"}}}
" Appearance{{{
let g:ale_change_sign_column_color = 0

if s:useEmojis
    let g:ale_sign_error = '❗'
    let g:ale_sign_info = '💬'
    let g:ale_sign_warning = '⚠' "❕
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

function! plugins#ALEJumpStatus()
    if exists("*submode#current") && submode#current() == 'errorjump'
        return printf('%s', g:airline_symbols.errorjump)
    endif
    return ''
endfunction
"}}}
" Error submode{{{
function! ErrJmpCmd(cmd)
    try | execute a:cmd | catch /.*/ | endtry
endfunction

call submode#enter_with('errorjump', 'n', '', '<M-e>', ':cw<CR>')
call submode#map('errorjump', 'n', '', 'h', ':silent cfirst<CR>zx')
call submode#map('errorjump', 'n', '', 'j',
            \ ':silent call ErrJmpCmd("cnext")<CR>zx')
call submode#map('errorjump', 'n', '', '<Tab>',
            \ ':silent call ErrJmpCmd("cnext")<CR>zx')
call submode#map('errorjump', 'n', '', '<Space>',
            \ ':silent call ErrJmpCmd("cnext")<CR>zx')
call submode#map('errorjump', 'n', '', '<CR>',
            \ ':silent call ErrJmpCmd("cnext")<CR>zx')
call submode#map('errorjump', 'n', '', 'k',
            \ ':silent call ErrJmpCmd("cprevious")<CR>zx')
call submode#map('errorjump', 'n', '', '<BS>',
            \ ':silent call ErrJmpCmd("cprevious")<CR>zx')
call submode#map('errorjump', 'n', '', 'l', ':silent clast<CR>zx')

" Other keys exit mode and close quickfix window. List is not exhaustive.
let qfexitkeys = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'q', 'w',
            \ 'e', 'r', 't', 'y', 'u', 'i', 'o', 'p', '[', ']', 'a', 's',
            \ 'd', 'f', 'g', 'z', 'x', 'c', 'v', 'b', 'm',
            \ '<Esc>', '<Bslash>', '<Bar>', '<lt>', '<gt>', ';',
            \ '/', "'", '-', '=', '`', '<Delete>']

for i in qfexitkeys
    call submode#map('errorjump', 'n', '', i,
                \ '<esc>:silent call submode#restore_options()<CR>:ccl<CR>')
endfor

function! QuickfixFilterBuffer(bufno)
    let qflist = getqflist() | let newlist = []

    for i in qflist
        if i.bufno == a:bufno | newlist = newlist + [i] | endif
    endfor

    call setqflist(qflist)
endfunction
"}}}
" Mappings{{{
" Ctrl + Alt + Shift + h/l : ErrorJump next/prev{{{
" Requires terminal configured to send corresponding keys
nnoremap <silent> <Char-0x10>HZ :ALEPreviousWrap<CR>
nnoremap <silent> <Char-0x10>Hd :ALENextWrap<CR>
"}}}
" F12 : Run ALE fixers{{{
nnoremap <F12> :ALEFix<CR>:echom 'Running ALE fixers...'<CR>
"}}}
"}}}
" Autocommands{{{
let g:_ale_statusicon = ''
"}}}
"}}}
" Gutentags{{{
call assert_true(exists('GutentagsToggleEnabled'))
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
let g:gutentags_project_root = ['.git', '.hg', '.svn']
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
call assert_true(exists('HighlighterUpdate'))
let g:highlighter#auto_update = 2
let g:highlighter#project_root_signs =  g:gutentags_project_root
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
" python-syntax{{{
let g:python_highlight_all = 1
"}}}
" SimpylFold{{{
call assert_true(exists('*SimpylFoldDocstrings'))
let g:SimpylFold_docstring_preview = 0
let g:SimpylFold_fold_docstring = 1
let g:SimpylFold_fold_import = 1
"}}}
" Tagbar{{{
" Configuration{{{
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
"}}}
" Mappings{{{
nnoremap <silent> <F6> :call TagbarToggleUpdate()<CR>
"}}}
" Functions{{{
" UpdateTagbarOptions : Update tagbar settings{{{
function! UpdateTagbarOptions(...)
    if a:0 > 0 && a:1 != 0
        call TagbarToggleUpdate() | wincmd h | return
    endif
    if rccommon#BufferColumns() - g:tagbar_width - 1 > &textwidth
        let g:tagbar_autoclose = 0 | let g:tagbar_width = 30
    else
        let g:tagbar_autoclose = 1 | let g:tagbar_width = 25
    endif
endfunction
"}}}
" TagbarToggleUpdate : Updates options and then toggles tagbar{{{
function! TagbarToggleUpdate(...)
    if &ft == 'tagbar' | TagbarClose
    else
        NERDTreeClose
        MundoHide
        call UpdateTagbarOptions()
        TagbarOpen fj
    endif
endfunction
"}}}
"}}}
"}}}
" vim-json{{{
let g:vim_json_syntax_conceal = 0
"}}}
"}}}

" Files / Buffers / Windows {{{
" Rooter{{{
" Change to a non-project file's directory when opening it
let g:rooter_change_directory_for_non_project_files = 'current'
"}}}
" CtrlP{{{
call assert_true(exists(':CtrlP'))
" Configuration{{{
let g:ctrlp_by_filename = 1
let g:ctrlp_cache_clear_on_exit = 0
let g:ctrlp_cache_dir = '~/.config/nvim/temp_data/ctrlp_cache'
"let g:ctrlp_extensions = ['smarttabs']
let g:ctrlp_map = '☺'
let g:ctrlp_match_window = 'bottom, order:btt, min:1, max:20,results:20'
"let g:ctrlp_max_files = 4096
"let g:ctrlp_mruf_max = 512
let g:ctrlp_regexp = 0
let g:ctrlp_smarttabs_exclude_quickfix = 1
let g:ctrlp_switch_buffer = 'ET'
let g:ctrlp_working_path_mode = 'ra'

let g:ctrlp_use_caching = 1

"let ctrlpIgnoreList = [".cache", ".git", ".svn", ".hg" , ".DS_Store",
"            \ "**/*.pyc",  "*.so"]

"}}}

" Use cpsm matcher
let g:ctrlp_match_func = {'match': 'cpsm#CtrlPMatch'}
let g:cpsm_match_empty_query = 1

" List tracked files when in a repo, otherwise use find
let g:ctrlp_user_command = {
\ 'types': {
    \ 1: ['.git', 'cd %s && git ls-files'],
    \ 2: ['.hg', 'hg --cwd %s locate -I .'],
    \ },
\ 'fallback': 'find %s -type f'
\ }

" Use the silver searcher for faster search, fallback to grep{{{
" https://github.com/ggreer/the_silver_searcher
if executable("ag")
    let g:ctrlp_user_command['fallback'] =
                \ 'ag %s --files-with-matches --nocolor -g ""'.
                \ ' --ignore "\.git$\|\.hg$\|\.svn$\|\.DS_Store$\|\.cache$"'
    let g:ctrlp_use_caching = 512
endif
"}}}
"Mappings{{{
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
" NERDTree{{{
call assert_true(exists('*NERDTreeToggle'))
" Configuration{{{
let g:NERDTreeNaturalSort = 1
let g:NERDTreeQuitOnOpen = 0
let g:NERDTreeShowBookmarks = 1
let g:NERDTreeShowHidden = 1
let g:NERDTreeShowLineNumbers = 1
let g:NERDTreeSortHiddenFirst = 0
let g:NERDTreeWinPos = "left"
let g:NERDTreeWinSize = 35
let g:NERDTreeIgnore = ['\.pyc$','__pycache__','\.pyc$','\.swp$','\.png$',
            \ '\.jpg$','\.gif$','\.mp3$','\.flac$','\.ogg$','\.mp4$',
            \ '\.avi$','.webm$','.mkv$','\.pdf$','\.zip$','\.tar.gz$','\.rar$']

" Disable these Shortcuts
let g:NERDTreeMapJumpNextSibling = "<NOP>"
let g:NERDTreeMapJumpPrevSibling = "<NOP>"
"}}}
" Apearance{{{
let g:NERDTreeHighlightCursorline = 1
let g:NERDTreeMinimalUI = 1

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
"}}}
" <Leader> + o : Toggle nerdtree sidebar{{{
nnoremap <Leader>o :call NerdTreeUpdateToggle()<CR>
nnoremap <silent> <F5> :call NerdTreeUpdateToggle()<CR>
"}}}
" Autocommands{{{
"}}}
function! NerdTreeUpdateToggle()
    MundoHide
    NERDTreeToggle
endfunction
"}}}
" Wipeout{{{
" <Leader> + Esc + Esc : Clear background buffers
nnoremap <leader><Esc><Esc> :Wipeout<CR>
"}}}
"}}}

" Version Control{{{
" Mundo{{{
call assert_true(exists('*MundoShow'))

" General configuration{{{
let g:mundo_auto_preview = 1
let g:mundo_auto_preview_delay = 250
let g:mundo_close_on_revert = 0
let g:mundo_inline_undo = 1
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
"}}}
" UpdateMundoOptions : Changes options{{{
function! UpdateMundoOptions(...)
    if rccommon#BufferColumns() - 41 > &textwidth
        let g:mundo_width = 40 | else | let g:mundo_width = 30
    endif
    if a:0 > 0 && a:1 != 0 | call MundoToggleUpdate() | endif
endfunction
"}}}
" MundoToggleUpdate : Updates options and then toggles Mundo{{{
function! MundoToggleUpdate()
    NERDTreeClose
    TagbarClose
    call UpdateMundoOptions()
    MundoToggle
endfunction
"}}}
" Mappings{{{
nnoremap <silent> <F7> :call MundoToggleUpdate()<CR>
"}}}
"}}}
" gv{{{
call assert_true(exists('*GV'))
nnoremap <F8> :GV!<CR>
"}}}
" Signature{{{
call assert_true(exists('*SignatureRefresh'))
" Configuration{{{
" TODO: Set markers 🚩🔖󲁦🔧🚧📌📍⭐󰄿󰅂
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
"}}}
" Ctrl + Shift + h/j/k/l : Jump to next marked position{{{
" Requires terminal configured to send terminal F11 escape code
map <silent> <Char-0x10>FZ m[=zx
map <silent> <Char-0x10>Fb m]`zx
map <silent> <Char-0x10>Fc m[`zx
map <silent> <Char-0x10>Fd m]=zx
"}}}
" Appearance{{{
hi SignatureMarkText ctermfg=166 ctermbg=NONE guifg=#51FF4C guibg=NONE
            \ guisp=NONE cterm=bold gui=bold
hi SignatureMarkerText ctermfg=166 ctermbg=NONE guifg=#4CFFE2 guibg=NONE
            \ guisp=NONE cterm=bold gui=bold
"}}}
"}}}
 "}}}

" UI{{{
" Airline{{{
call assert_true(exists(':AirlineRefresh'))
let g:airline_skip_empty_sections = 1

" Enable and configure extensions{{{
let g:airline#extensions#keymap#enabled = 0
let g:airline#extensions#hunks#enabled = 1
let g:airline#extensions#tagbar#enabled = 1
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#wordcount#enabled = 1
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#bufferline#enabled = 0
let airline#extensions#wordcount#formatter#default#fmt_short = 1
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
"}}}

" Appearance{{{
let g:airline_powerline_fonts = 1
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
if !exists('g:airline_symbols') | let g:airline_symbols = {} | endif
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_symbols.linenr = ''
let g:airline_symbols.linepercent = ''
let g:airline_symbols.columnnr = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.notexists = ' 󰝐'
let g:airline_symbols.spell = '󲃤󱗊'
let g:airline_symbols.tablemode = '󰓯'
let g:airline_symbols.errorjump = '󱡯󱗊'
let g:airline_symbols.errorlistload = '󰓥᪽᪻‹›󱗊'
let g:airline_symbols.tagsload = '󰓥󱕎'

if s:useEmojis
    let g:airline_symbols.crypt = '🔐'
    let g:airline_symbols.readonly = '🔏'
    let g:airline_symbols.paste = '📋'
    let g:airline_symbols.modified = '📝'
else
    let g:airline_symbols.crypt = '󰌽'
    let g:airline_symbols.readonly = '󰏮'
    let g:airline_symbols.paste = '󰆑'
    let g:airline_symbols.modified = '󰏪'
endif

" Load theme
let g:airline_theme = 'bubblegum'
"}}}

" Configure sections{{{
let g:airline_section_a =
            \ '%{airline#util#wrap(airline#parts#mode(),0)}' .
            \ '%{airline#util#append(airline#parts#crypt(),0)}' .
            \ '%{airline#util#append(plugins#PasteModeStatus(),0)}' .
            \ '%{airline#util#append(airline#extensions#keymap#status(),0)}' .
            \ '%{airline#util#append(airline#parts#spell(),0)}' .
            \ '%{airline#util#append("",0)}%{airline#util#append("",0)}' .
            \ '%{airline#util#append(airline#parts#iminsert(),0)}' .
            \ '%{airline#util#append(plugins#TableModeStatus(),0)}' .
            \ '%{airline#util#append(plugins#ALEJumpStatus(),0)}' .
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

" 'Paste mode' indicator
function! plugins#PasteModeStatus()
    if get(g:, '_paste_mode', 0)
        return g:airline_symbols.paste
    endif

    return ''
endfunction

" Group gutentags / ALE indicators
function! plugins#AirlineCustomLoadIndicators()
    let l:out = gutentags#statusline(g:airline_symbols.tagsload)

    if l:out != ''
        let l:out = l:out . ' '
    endif

    let l:out = l:out . plugins#ALELintStatus()
    return l:out
endfunction
"}}}
"}}}
" Colorizer {{{
let g:colorizer_auto_filetype = 'css,html'
let g:colorizer_skip_comments = 1
let g:colorizer_colornames = 0
let g:colorizer_hex_pattern = ['#', '\%(\x\{3}\|\x\{6}\)', '']
let g:colorizer_x11_names = 0
nnoremap <Leader>C :ColorToggle<CR>
"}}}
" Denite{{{
call assert_true(exists(':Denite'))
" Add custom menus{{{
function! UpdateFunctionMenus()
    let s:menus = {}
    let s:menus.main_menu = {
        \ 'description': 'misc',
        \ 'command_candidates': [
            \ [ '[<M-p>] Put From Yank History... ',
                \ 'Denite neoyank -auto-resize -mode=normal' ],
                \ [ '[<M-r>] Put From Register...',
                \ 'Denite register -mode=normal' ],
            \ [ '[<M-c>] Jump to Change...',
                \ 'Denite change -auto-resize -mode=normal' ],
            \ ],
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
            \ [ '[<F5> ] Toggle File Browser', 'call NerdTreeUpdateToggle()' ],
            \ [ '[<F6> ] Toggle Tag Explorer', 'call TagbarToggleUpdate()' ],
            \ [ '[<F7> ] Toggle Undo Tree Explorer',
                \ 'call MundoToggleUpdate()' ],
            \ [ '[<F8> ] Open Git Commit Browser', ':GV!' ],
            \ [ '[<F12>] Edit Snippets...', 'UltiSnipsEdit' ],
            \ ],
        \ }
    let s:menus.buffer_commands = {
        \ 'description': 'commands',
        \ 'command_candidates': [
            \ [ '[           ] Expand template for filename',
                \ 'Template '.expand('%') ],
            \ [ '[           ] Unicode table (Note: Search with :UnicodeSearch!,'
                \ .' autocomplete with Ctrl+x Ctrl+z)', ':UnicodeTable' ],
            \ [ '[           ] Digraph table (Note: Autocomplete with Ctrl+x '
                \.'Ctrl+z)', ':Digraphs' ],
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
    let l:left = {'main_menu' : 'main_menu',
                \ 'buffer_commands' : 'buffer_windows',
                \ 'buffer_windows' : 'buffer_settings',
                \ 'buffer_settings' : 'main_menu'}
    let l:right = { 'main_menu' : 'buffer_settings',
                \'buffer_commands' : 'buffer_commands' ,
                \ 'buffer_windows' : 'buffer_commands',
                \ 'buffer_settings' : 'buffer_windows'}
    let l:args = {'main_menu' : ' -auto-resize -mode=normal',
                \ 'buffer_commands' : ' -auto-resize -mode=normal' ,
                \ 'buffer_windows' : ' -auto-resize -mode=normal',
                \ 'buffer_settings' : ' -auto-resize -mode=normal'}
    call denite#custom#map('menu', 'h',
                \ "\<Esc>:call FunctionMenu(" . l:left[a:cmd] . ")", 'noremap')
    call denite#custom#map('menu', 'l',
                \ "\<Esc>:call FunctionMenu(" . l:right[a:cmd] . ")", 'noremap')
    execute 'Denite menu:' . a:cmd  . args[a:cmd]
endfunction
"}}}
" Mappings{{{
nnoremap <F1> :call FunctionMenu('main_menu')<CR>
nnoremap <F2> :call FunctionMenu('buffer_commands')<CR>
nnoremap <F3> :call FunctionMenu('buffer_windows')<CR>
nnoremap <F4> :call FunctionMenu('buffer_settings')<CR>
nnoremap <silent> <M-c> :Denite change -auto-resize -mode=normal<CR>
nnoremap <silent> <M-r> :Denite register -mode=normal<CR>
"}}}
"}}}
" devicons{{{
call assert_true(exists('*webdevicons#version'))
" General configuration{{{
if s:useEmojis
    let g:WebDevIconsUnicodeDecorateFolderNodesDefaultSymbol = '📁'
    let g:DevIconsDefaultFolderOpenSymbol = '📂'
endif
"}}}
"}}}
" highlightedyank{{{
call assert_true(exists('*HighlightedyankOn'))
" General configuration{{{
let g:highlightedyank_highlight_duration = 600
let g:highlightedyank_max_lines = 10000
let g:highlightedyank_timeout = 500
"}}}
"}}}
" indent-guides{{{
call assert_true(exists('*IndentGuidesEnable'))
" General configuration{{{
let g:indent_guides_auto_colors = 0
let g:indent_guides_default_mapping = 0
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_exclude_filetypes = ['qf', 'tagbar', 'startify',
            \ 'nerdtree', 'help', 'Mundo']
let g:indent_guides_guide_size = 1
let g:indent_guides_indent_levels = 6   " 16
let g:indent_guides_start_level = 2
"}}}
"}}}
" Rainbow{{{
call assert_true(exists('*RainbowToggle'))
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
"func! RainbowSetBold()
"    try
"        syntax clear rainbow_o1
"        syntax clear rainbow_o2
"        syntax clear rainbow_o3
"        syntax clear rainbow_o4
"        syntax clear rainbow_o5
"        syntax clear rainbow_o6
"        syntax clear rainbow_o7
"        syntax clear rainbow_o8
"        syntax clear rainbow_o9
"    catch
"    endtry
"    syntax match rainbow_o1 '[\[\](){}:,]' contained containedin=rainbow_r0
"    syntax match rainbow_o2 '[\[\](){}:,]' contained containedin=rainbow_r1
"    syntax match rainbow_o3 '[\[\](){}:,]' contained containedin=rainbow_r2
"    syntax match rainbow_o4 '[\[\](){}:,]' contained containedin=rainbow_r3
"    syntax match rainbow_o5 '[\[\](){}:,]' contained containedin=rainbow_r4
"    syntax match rainbow_o6 '[\[\](){}:,]' contained containedin=rainbow_r5
"    syntax match rainbow_o7 '[\[\](){}:,]' contained containedin=rainbow_r6
"    syntax match rainbow_o8 '[\[\](){}:,]' contained containedin=rainbow_r7
"    syntax match rainbow_o9 '[\[\](){}:,]' contained containedin=rainbow_r8
"endfunc
"}}}
" Signify{{{
call assert_true(exists('*SignifyRefresh'))
" Configuration{{{
let g:signify_realtime = 0
let g:signify_vcs_list = ['git' , 'hg', 'svn']
let g:signify_vcs_cmds = {
                \ 'git' : 'git diff --no-color --no-ext-diff -U0 -- %f',
                \ 'hg'  : 'hg diff --config extensions.color=! --config '.
                \ 'defaults.diff= --nodates -U0 -- %f',
                \ 'svn' : 'svn diff --diff-cmd %d -x -U0 -- %f',
            \ }
let g:signify_disable_by_default = 0
let g:signify_update_on_bufenter = 1
let g:signify_update_on_focusgained = 1
"}}}
" Appearance{{{
let g:signify_sign_add               = '󱅅'
let g:signify_sign_delete            = '󱅛'
let g:signify_sign_delete_first_line = '󱅎'
let g:signify_sign_change            = '󱅐'
let g:signify_sign_changedelete      = g:signify_sign_change
"}}}
"}}}
" Startify{{{
" Rebind Ctrl+T to open Startify
"map <C-t> :tabnew ./<CR>:Startify<cr>

let g:startify_list_order = [
            \ ['   Recently used files:'], 'files',
            \ ['   Recently used files from the current directory:'], 'dir',
            \ ['   Previous sessions: (:SDelete - delete, :SClose - close,' .
            \ '<Leader>+SS - save'], 'sessions',
            \ ['   Bookmarks:'], 'bookmarks',
            \ ['   Commands:'], 'commands',
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
let g:startify_files_number = 12
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
"}}}
"}}}

" Miscellaneous {{{
" Submode{{{
let g:submode_timeout = 0
let g:submode_always_show_submode = 0
"}}}
"}}}

"}}}

" Plugin Autocommands{{{
augroup VimrcPlugins
    autocmd!
    " Clear marks / markers upon loading buffer
    autocmd BufWinEnter *
                \ if exists(':SignatureRefresh') &&
                \ exists('g:SignatureDeleteConfirmation') |
                    \ try |
                        \ let DelConfirmBack = g:SignatureDeleteConfirmation |
                        \ let PurgeConfirmBack = g:SignaturePurgeConfirmation |
                        \ let g:SignatureDeleteConfirmation = 0 |
                        \ let g:SignaturePurgeConfirmation = 0 |
                        \ call signature#mark#Purge('all') |
                        \ call signature#marker#Purge() |
                        \ let g:SignatureDeleteConfirmation = DelConfirmBack |
                        \ let g:SignaturePurgeConfirmation = PurgeConfirmBack |
                    \ catch |
                        \ echo 'err' v:exception |
                    \ endtry |
                \ endif

    " Automatically close the current tab if NERDTree is the only window
    autocmd BufEnter *
                \ if (winnr("$") == 1 && exists("b:NERDTree") &&
                \ b:NERDTree.isTabTree()) |
                    \ q |
                \ endif

    " Clear search highlighting when leaving buffers
    autocmd BufLeave * execute "normal \<Plug>SearchantStop"

    " Filter quickfix output from other buffers
    autocmd QuickfixCmdPost make call QuickfixFilterBuffer()

    " ALE status indicator
    autocmd User ALELintPost let g:_ale_statusicon = '' | AirlineRefresh
    autocmd User ALELintPre
                \ let g:_ale_statusicon = g:airline_symbols.errorlistload |
                \ AirlineRefresh
augroup end

"}}}

" vim: set ts=4 sw=4 tw=79 fdm=marker et :
