syntax on

"read local per-directory settings
"https://medium.com/@dnrvs/per-project-settings-in-nvim-fc8c8877d970
set exrc
set secure

set ttyfast
set lazyredraw

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
Plug 'vim-scripts/Conque-GDB',           { 'for': ['c', 'cpp'] }
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'kien/ctrlp.vim',                   { 'on': 'CtrtP' }
Plug 'bling/vim-airline'
Plug 'Yggdroot/indentLine'

Plug 'vim-scripts/vcscommand.vim'
Plug 'tpope/vim-fugitive'

Plug 'octol/vim-cpp-enhanced-highlight', { 'for': 'cpp' }
Plug 'fatih/vim-go',                     { 'for': 'go' }
Plug 'derekwyatt/vim-scala',             { 'for': 'scala' }
Plug 'tikhomirov/vim-glsl',              { 'for': 'glsl' }

Plug 'dmsi/mycpp.vim',                   { 'for': ['c', 'cpp'] }

Plug 'rakr/vim-one'
Plug 'morhetz/gruvbox'

Plug 'yuttie/inkstained-vim'
Plug 'kristijanhusak/vim-hybrid-material'
Plug 'endel/vim-github-colorscheme'
Plug 'lifepillar/vim-solarized8'
Plug 'junegunn/seoul256.vim'
Plug 'nanotech/jellybeans.vim' "Kind of does not work with true color
call plug#end()

filetype plugin indent on
"------------------------------------------------------------------------------
" End Vim-Plug
"------------------------------------------------------------------------------

colorscheme one
set background=light

"indentLine
let g:indentLine_char = '·'
let g:indentLine_color_gui = '#d0d0d0'
"let g:indentLine_color_gui = '#585858'

"Airline
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline_symbols.branch = '⎇'

"mycpp
nmap <Leader><Leader>f :call ShowFuncName() <CR>
nmap <silent><Leader>of :call FindFileAndSplit('vsplit')<CR>
nmap <silent><Leader>ot :call FindFileAndSplit('e')<CR>

" ctrlp
nnoremap <silent> <Leader>os :CtrlP<CR>
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ 'jclass': '\v\.(class)$',
  \ }

" NerdTree
nnoremap <silent> <Leader>oe :NERDTreeToggle<CR>


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
"autocmd Filetype scala setlocal ts=4 sts=4 sw=4

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


" Run interpretators in the ConqueTerm depending on the filetype
augroup CExecute 
  autocmd!
  autocmd FileType python nnoremap <buffer> <Leader>or :exe "ConqueTermSplit python -i " . expand("%")<cr>
augroup END
