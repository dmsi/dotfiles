syntax on

"read local per-directory settings
"https://medium.com/@dnrvs/per-project-settings-in-nvim-fc8c8877d970
set exrc
set secure

set ttyfast
set lazyredraw

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
" Vundle
"------------------------------------------------------------------------------
set nocompatible 
filetype off     " for Vundle
set rtp+=~/.config/nvim/bundle/Vundle.vim
call vundle#begin('~/.config/nvim/bundle')
Plugin 'gmarik/Vundle.vim'
Plugin 'vim-scripts/Conque-GDB'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'vim-scripts/vcscommand.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'octol/vim-cpp-enhanced-highlight'
Plugin 'altercation/vim-colors-solarized'
Plugin 'bling/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
"Plugin 'tpope/vim-fugitive'
Plugin 'tikhomirov/vim-glsl'
Plugin 'sickill/vim-monokai'
Plugin 'yuttie/inkstained-vim'
Plugin 'endel/vim-github-colorscheme'
Plugin 'morhetz/gruvbox'
Plugin 'kristijanhusak/vim-hybrid-material'
Plugin 'rakr/vim-one'
Plugin 'Yggdroot/indentLine'
Plugin 'derekwyatt/vim-scala'
Plugin 'fatih/vim-go'
call vundle#end()
filetype plugin indent on
" To ignore plugin indent changes, use:
"filetype plugin on
"------------------------------------------------------------------------------
" End Vundle
"------------------------------------------------------------------------------

colorscheme one
set background=light

"indentLine
let g:indentLine_char = '·'
let g:indentLine_color_gui = '#d0d0d0'
"let g:indentLine_color_gui = '#585858'

"Airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'

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

"autocmd BufRead *.mat set filetype=yaml
"au BufNewFile,BufRead *.rad,*.mat		setf yaml
autocmd BufNewFile,BufRead *.mat set filetype=yaml

let mapleader=","

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
"set statusline=%<%t\ [%Y%R%W]%1*%{(&modified)?'\ [+]\ ':''}%*%=%c%V,%l\ %L\ %p%% 

" Dont jump when * is pressed for the first time, just highlight all
nnoremap * *N

" Tab navigation
map <Leader>3 :tabnext<cr>
vmap <Leader>3 <esc>:tabnext<cr>
map <Leader>2 :tabprevious<cr>
vmap <Leader>2 <esc> :tabprevious<cr>


" This is totally awesome - remap jj to escape in insert mode.  You'll never type jj anyway, so it's great!
inoremap jj <Esc>
inoremap <Leader><Leader>s <Esc>A {<Esc>o}<Esc>k2==o<Tab>
inoremap <Leader><Leader>q {}<Esc>ha
inoremap <Leader><Leader>b ()<Esc>ha
inoremap <Leader><Leader>if if ()<Esc>ha
inoremap <Leader><Leader>for for ()<Esc>ha
"UU => continue from this line, uu - start new line

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

"------------------------------------------------------------------------------
" Show current function name 
"------------------------------------------------------------------------------
fun! ShowFuncName()
    let lnum = line(".")
    let col = col(".")
    echohl ModeMsg
    echo getline(search("^[^ \t#/]\\{2}.*[^:]\s*$", 'bW'))
    echohl None
    call search("\\%" . lnum . "l" . "\\%" . col . "c")
endfun
map <Leader><Leader>f :call ShowFuncName() <CR>
"------------------------------------------------------------------------------
" End current function name 
"------------------------------------------------------------------------------

"------------------------------------------------------------------------------
" C/C++ find and split 
" Looks for source/header file and does vertical split, so the source file will 
" always be in the right side: headere file left, impl file right.
" TODO: Make my own plugin of it, put into GitHub and use Vundle to install.
"------------------------------------------------------------------------------
function! s:FindFileAndSplitPair(action, source, header)
    let current_filename_ext = expand('%:e')
    let current_filename_base = expand('%:t:r')
    if current_filename_ext == a:header
        let path = findfile(current_filename_base . '.' . a:source, '.**')
        if len(path) > 0
            "execute 'vsplit ' . path
            execute a:action . ' ' . path
            execute 'wincmd r'
            return "true"
        endif        
    elseif current_filename_ext == a:source
        let path = findfile(current_filename_base . '.' . a:header, '.**')
        if len(path) > 0
            "execute 'vsplit ' . path
            execute a:action . ' ' . path
            return "true"
        endif        
    endif
    return "false"
endfunction

function! s:FindFileAndSplit(action)
    if s:FindFileAndSplitPair(a:action, "cpp", "h") == "true"
        return "true" 
    elseif s:FindFileAndSplitPair(a:action, "cc", "h") == "true"
        return "true"
    elseif s:FindFileAndSplitPair(a:action, "cpp", "hpp") == "true"
        return "true"
    elseif s:FindFileAndSplitPair(a:action, "cxx", "hxx") == "true"
        return "true"
    elseif s:FindFileAndSplitPair(a:action, "c", "h") == "true"
        return "true"
    else
        return "false"
    endif
endfunction

nmap <silent> <Leader>of :call <SID>FindFileAndSplit('vsplit')<cr>
nmap <silent> <Leader>ot :call <SID>FindFileAndSplit('e')<cr>
nnoremap <silent> <Leader>os :CtrlP<CR>
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ 'jclass': '\v\.(class)$',
  \ }
nnoremap <silent> <Leader>oe :NERDTreeToggle<CR>
" Run interpretators in the ConqueTerm depending on the filetype
augroup CExecute 
  autocmd!
  autocmd FileType python nnoremap <buffer> <Leader>or :exe "ConqueTermSplit python -i " . expand("%")<cr>
augroup END
"------------------------------------------------------------------------------
" End find and split
"------------------------------------------------------------------------------

"------------------------------------------------------------------------------
" Insert one-line-comment style MIT header license text to source file and 
" include guard with random number to .h file.
" Works for .cpp and .h fies.
" TODO: read license from text file
" TODO: does not work anymore :)
"------------------------------------------------------------------------------
function! s:InsertMitHeader(comment)
    let license_text = "\n
       \ This source file is a part of $PROJECT_NAME$\n
       \\n
       \ Copyright (C) $COPYRIGHT$\n
       \\n
       \ Permission is hereby granted, free of charge, to any person obtaining a copy\n
       \ of this software and associated documentation files (the \"Software\"), to deal\n
       \ in the Software without restriction, including without limitation the rights\n
       \ to use, copy, modify, merge, publish, distribute, sublicense, and/or sell\n
       \ copies of the Software, and to permit persons to whom the Software is\n
       \ furnished to do so, subject to the following conditions:\n
       \\n
       \ The above copyright notice and this permission notice shall be included in\n
       \ all copies or substantial portions of the Software.\n
       \\n
       \ THE SOFTWARE IS PROVIDED \"AS IS\", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR\n
       \ IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,\n
       \ FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE\n
       \ AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER\n
       \ LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,\n
       \ OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN\n
       \ THE SOFTWARE.\n
       \"
    let license = substitute(license_text, '^', '\0' . a:comment, 'g')
    let license = substitute(license, '\n', '\r' . a:comment, 'g')
    execute "normal! i" . license
endfunction

" Insert #ifndef guard to header file. Uses MD5 sum of a date to make this unique.
function! s:InsertHeaderGuard()
    let gatename = substitute(toupper(expand("%:t")), "\\.", "_", "g")
    "let random = system('date +"%Y/%m/%d %H:%M:%S %s %N" | md5sum | sed "s/ -$//"')
    "let random = system('uuidgen | sed "s/-/_/g" | sed "s/.*/\U\0/g"')
    let random = system('uuidgen | sed "s/-/_/g"')
    let random = substitute(toupper(random), '\s*\n$', '', '') 
    let gatename = "_" . gatename . "_" . random . "_"
    execute "normal! i#ifndef " . gatename
    execute "normal! o#define " . gatename . " "
    execute "normal! o"
    execute "normal! Go#endif // " . gatename
    normal! k
endfunction

" Insert header and guard depending on the file ext 
function! s:InsertFileHeaders()
    set paste
    let current_filename_ext = expand('%:e')
    let current_filename_base = expand('%:t:r')
    if current_filename_ext == 'h' || current_filename_ext == "hpp" || current_filename_ext == "hxx"
        execute "normal! gg"
        :call <SID>InsertMitHeader("//")
        execute "normal! o"
        execute "normal! o"
        :call <SID>InsertHeaderGuard()
    elseif current_filename_ext == "cpp" || current_filename_ext == "cxx" || current_filename_ext == "cc"
        execute "normal! gg"
        :call <SID>InsertMitHeader("\/\/")
        execute "normal! o"
    endif
    set nopaste
endfunction

nmap <silent> <Leader>ih :call <SID>InsertFileHeaders()<cr>
autocmd BufNewFile *.{h,hpp,hxx,cpp,cxx,cc} call <SID>InsertFileHeaders()
"------------------------------------------------------------------------------
" End autolicense and include guard 
"------------------------------------------------------------------------------
