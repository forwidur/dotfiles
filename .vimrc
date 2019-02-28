syntax on
color desertink
filetype on
filetype plugin on
autocmd FileType *      set formatoptions=tcql nocindent comments&
autocmd FileType c,cpp  set formatoptions=croql cindent comments=sr:/*,mb:*,ex:*/,://

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set autoindent
set autowrite

set expandtab
autocmd FileType make setlocal noexpandtab

set backupdir=~/.vim/bak
set directory=~/.vim/bak

ab #d #define
ab #i #include
ab #b /********************************************************
ab #e ********************************************************/
ab #l /*------------------------------------------------------*/
set sw=2
set ts=2

set notextmode
set notextauto

set hlsearch
set incsearch
set showmatch
set showcmd

set wildmenu
set completeopt=longest,menuone

set scrolloff=2
set sidescrolloff=5

set laststatus=2

nmap <F1> <nop>

" Move tabs with alt + left|right
nnoremap <silent> <A-Left> :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>
nnoremap <silent> <A-Right> :execute 'silent! tabmove ' . (tabpagenr()+1)<CR>

" Hard save.
noremap <Leader>W :w !sudo tee % > /dev/null<CR>

" Color long lines.
if exists('+colorcolumn')
  set colorcolumn=80
else
  au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
endif

" Convenience mappings.
map <F2> :w
noremap  :w
inoremap  :w
inoremap jj <Esc>

" Remove trailing whitespace.
autocmd BufWritePre * :%s/\s\+$//e

" Go formatting
autocmd BufWritePre *.go GoFmt

" Persistent undo.
if has("persistent_undo")
    set undodir=~/.vim/undo/
    set undofile
endif

set history=500
set undolevels=300

set ruler
set noguipty

" Matching for block boundaries.
runtime macros/matchit.vim

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'fatih/vim-go'
let g:go_fmt_command = "goimports"
let g:go_fmt_fail_silently = 1
let g:go_bin_path = expand("~/.go/bin")
autocmd FileType go noremap <leader>b :GoBuild<CR>

Bundle 'steffanc/cscopemaps.vim'

Bundle 'scrooloose/syntastic'
let g:syntastic_always_populate_loc_list = 1
map <F3> :SyntasticCheck
map <C-j> :lnext
map <C-k> :lprev
let g:syntastic_go_checkers = ['go', 'golint', 'govet', 'errcheck']
let g:systastic_python_checkers = ['python']
let g:syntastic_python_pylint_exec = ''
"let g:syntastic_python_flake8_exec = 'python3'
"let g:syntastic_python_flake8_args = ['-m', 'flake8']

Bundle 'kien/ctrlp.vim'
let g:ctrlp_working_path_mode = 0
let g:ctrlp_max_files=500000
let g:ctrlp_max_depth=40
let g:ctrlp_custom_ignore='.git$|\tmp$'
"let g:ctrlp_cmd = "CtrlPBuffer"

Bundle 'Valloric/YouCompleteMe'
nnoremap <leader>gd :YcmCompleter GoTo<CR>
nnoremap <leader>gs :YcmCompleter GoToDefinition<CR>
nnoremap <leader>gi :YcmCompleter GoToInclude<CR>
nnoremap <leader>gr :YcmCompleter GoToReferences<CR>
nnoremap <leader>gt :YcmCompleter GetDoc<CR>
nnoremap <leader>gD :split \| YcmCompleter GoToDefinition<CR>
let g:ycm_global_ycm_extra_conf='~/.vim/.ycm_extra_conf.py'
let g:ycm_error_symbol='✗'
let g:ycm_warning_symbol='▲'
let g:ycm_python_binary_path = ''

Plugin 'davidhalter/jedi-vim'

Bundle 'lukerandall/haskellmode-vim'
au BufEnter *.hs compiler ghc
let g:haddock_browser="/usr/bin/google-chrome"

Bundle 'tpope/vim-unimpaired'
Bundle 'tpope/vim-obsession'

Bundle 'tpope/vim-surround'

Bundle 'mileszs/ack.vim'

Bundle 'ivalkeen/vim-ctrlp-tjump'
nnoremap <c-]> :CtrlPtjump<cr>
vnoremap <c-]> :CtrlPtjumpVisual<cr>

Bundle 'mbbill/undotree'

Bundle 'rhysd/vim-clang-format'
let g:clang_format#style_options = {
            \ "AllowShortIfStatementsOnASingleLine" : "true",
            \ "Standard" : "C++11"
            \ }
let g:clang_format#detect_style_file = 1
let g:clang_format#auto_format = 1
let g:clang_format#auto_format_on_insert_leave = 1
" map to <Leader>cf in C++ code
autocmd FileType c,cpp,objc nnoremap <buffer><Leader>cf :<C-u>ClangFormat<CR>
autocmd FileType c,cpp,objc vnoremap <buffer><Leader>cf :ClangFormat<CR>
" Toggle auto formatting:
nmap <Leader>C :ClangFormatAutoToggle<CR>

Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
let g:airline_theme='sol'

Plugin 'justinmk/vim-syntax-extra'

Bundle 'mrtazz/simplenote.vim'
source ~/.simplenoterc

call vundle#end()
