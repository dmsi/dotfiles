syntax on

" Read more
" https://medium.com/@alexeysamoshkin/if-you-redefine-emmet-trigger-key-from-default-c-y-to-comma-in-insert-mode-wouldnt-it-mean-acb9eef59b50
"set notimeout

"read local per-directory settings
"https://medium.com/@dnrvs/per-project-settings-in-nvim-fc8c8877d970
set exrc
set secure

set ttyfast
set lazyredraw

set cursorline

let mapleader=","

"------------------------------------------------------------------------------
" Put backup and swap files to one place
"------------------------------------------------------------------------------

if has("nvim")
  set backupdir=~/.config/nvim/backup//
  set directory=~/.config/nvim/swp//
else
  set backupdir=~/.vim/backup//
  set directory=~/.vim/swp//
endif

"------------------------------------------------------------------------------
" Encoding
"------------------------------------------------------------------------------
set encoding=utf-8

"------------------------------------------------------------------------------
" Vim-Plug
"------------------------------------------------------------------------------
set nocompatible
call plug#begin('~/.config/nvim/plugged')
Plug 'scrooloose/nerdcommenter'
Plug 'kien/ctrlp.vim',                   { 'on': 'CtrlP' }
Plug 'bling/vim-airline'
Plug 'Yggdroot/indentLine'

Plug 'vim-scripts/vcscommand.vim'

Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'junegunn/vim-easy-align'
Plug 'jeetsukumaran/vim-buffergator'

Plug 'prettier/vim-prettier', {
  \ 'do': 'npm install',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'html'] }

" Language specific plugins
Plug 'mustache/vim-mustache-handlebars', { 'for': ['html.handlebars', 'html.mustache'] }
Plug 'mattn/emmet-vim',                  { 'for': ['html', 'css', 'html.handlebars', 'vue'] }
Plug 'pangloss/vim-javascript',          { 'for': 'javascript' }
"Plug 'mxw/vim-jsx',                      { 'for': 'jsx' }
Plug 'posva/vim-vue',                    { 'for': 'vue' }
Plug 'bfrg/vim-cpp-modern',              { 'for': 'cpp' }
Plug 'vim-jp/vim-cpp',                   { 'for': 'cpp' }
"Plug 'rhysd/vim-clang-format',           { 'for': ['c', 'cpp'] }
Plug 'fatih/vim-go',                     { 'do': ':GoUpdateBinaries' }
Plug 'derekwyatt/vim-scala',             { 'for': 'scala' }
Plug 'tikhomirov/vim-glsl',              { 'for': 'glsl' }
Plug 'dmsi/mycpp.vim',                   { 'for': ['c', 'cpp'] }
Plug 'zah/nim.vim'

" Themes
Plug 'rakr/vim-one'
Plug 'morhetz/gruvbox'
Plug 'ayu-theme/ayu-vim'
Plug 'dracula/vim'
Plug 'haishanh/night-owl.vim'
Plug 'arcticicestudio/nord-vim'
Plug 'yuttie/inkstained-vim'
Plug 'NLKNguyen/papercolor-theme'
Plug 'kristijanhusak/vim-hybrid-material'
"Plug 'mhartington/oceanic-next'
Plug 'lifepillar/vim-solarized8'
Plug 'chiendo97/intellij.vim'
Plug 'cormacrelf/vim-colors-github'
Plug 'macguirerintoul/night_owl_light.vim'
Plug 'davidosomething/vim-colors-meh'
Plug 'sainnhe/everforest'
Plug 'EdenEast/nightfox.nvim'
Plug 'savq/melange'
Plug 'folke/tokyonight.nvim'
Plug 'adrian5/oceanic-next-vim'
Plug 'ntpeters/vim-better-whitespace'
call plug#end()

filetype plugin indent on
"------------------------------------------------------------------------------
" End Vim-Plug
"------------------------------------------------------------------------------

let g:is_bash = 1
let ayucolor="mirage"

"-- oceanicnext
"let g:oceanic_next_terminal_italic = 1
"let g:oceanic_next_terminal_bold = 0
"colorscheme OceanicNext

let g:oceanic_bold = 0
let g:oceanic_italic_comments = 1
"colorscheme oceanicnext

"-- everforest
let g:everforest_background = 'hard'
let g:everforest_enable_italic = 1
colorscheme everforest

"-- nightfox
"colorscheme nightfox
"let g:airline_theme = 'everforest'


"colorscheme night-owl
"let g:airline_theme = 'ayu'


"colorscheme nord

"let ayucolor="dark"
"colorscheme ayu
"set background=light
"let g:one_allow_italics=1
"colorscheme one
"let g:oceanic_next_terminal_bold=0
"let g:oceanic_next_terminal_italic=1
"colorscheme OceanicNext


"indentLine
"let g:indentLine_char = '·'
let g:indentLine_char = '¦'
let g:indentLine_color_gui = '#444444'
let g:indentLine_enabled = 0
let g:vim_json_syntax_conceal = 0
imap <Leader>i :IndentLinesToggle<cr>
nmap <Leader>i :IndentLinesToggle<cr>

"Airline
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#show_splits = 0
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline_symbols.branch = '⎇'

let g:prettier#autoformat = 1
let g:prettier#autoformat_require_pragma = 0

"mycpp
nmap <Leader><Leader>f :call ShowFuncName() <CR>
nmap <silent><Leader>of :call FindFileAndSplit('vsplit')<CR>
nmap <silent><Leader>ot :call FindFileAndSplit('e')<CR>

" ctrlp
nnoremap <silent> <Leader>os :CtrlP<CR>
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\.git$\|\.yardoc\|node_modules\|log\|build$\|deps$',
  \ 'file': '\.so$\|\.dat$|\.DS_Store$|\.dll$|\.exe$',
  \ 'jclass': '\v\.(class)$',
  \ }

" clang format
"let g:clang_format#auto_format=1

"vim-go
let g:go_imports_autosave = 1
let g:go_fmt_autosave = 1
let g:go_fmt_command = "goimports"
let g:go_imports_mode = "goimports"
let g:go_highlight_extra_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_parameters = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_format_strings = 1
let g:go_highlight_variable_declarations = 1


" Disable annoying screen flashing
set visualbell
set t_vb=

if has('termguicolors')
  set termguicolors
elseif has('nvim')
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

" Set indent, layout and tabs to spaces mode
set tabstop=2
set shiftwidth=2
set softtabstop=2
autocmd Filetype python setlocal ts=4 sts=4 sw=4
autocmd Filetype go setlocal ts=4 sts=4 sw=4
autocmd Filetype cpp setlocal ts=4 sts=4 sw=4
"autocmd Filetype javascript setlocal ts=4 sts=4 sw=4
"autocmd Filetype html,css setlocal ts=4 sts=4 sw=4

autocmd BufNewFile,BufRead *.mat set filetype=yaml


set expandtab
set number     " Show  line numbers
set showcmd
set nohidden   " When I close a tab I want to remove the buffer
set nowrap     " Disable lines wrapping
set backup     " Create backup files (filename~)
set autoindent " Autoindent (depends on file's type)
set sidescroll=5 "
set listchars+=precedes:<,extends:> "
set ignorecase "
set incsearch  "
set hlsearch   "

" Set status line status
set wildmenu
set laststatus=2

" Dont jump when * is pressed for the first time, just highlight all
nnoremap * *N


" Tab navigation
map <Leader>3 :tabnext<cr>
map <Leader>2 :tabprevious<cr>


" jj back to normal mode ('Control + c' works too)
inoremap jj <Esc>
inoremap <C-c> <Esc>


" EasyAlign
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

"------------------------------------------------------------------------------
"Auto-complete by tab
"------------------------------------------------------------------------------
function! InsertTabWrapper()
  let col = col('.') - 1
  if !col || getline('.')[col-1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
imap <tab> <c-r>=InsertTabWrapper()<cr>

" Set autocompleteon from
set complete=""
set complete+=. "current buffer
set complete+=k "dictonary
set complete+=b "other buffers
set complete+=t "tags
"------------------------------------------------------------------------------
" End auto-complete by tab
"------------------------------------------------------------------------------

" I would prefer emmet-vim on tab completion working with the tab completion
" above but... This is the less painful method to remap it to something else.
"imap ,, <C-y>,
imap <C-l> <C-y>,

" Buffergator (to replace that tab workflow)
nmap <C-b> :BuffergatorOpen<CR>
let g:buffergator_show_full_directory_path = 0
