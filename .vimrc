syntax on
filetype on
filetype plugin on
autocmd FileType *      set formatoptions=tcql nocindent comments&
autocmd FileType c,cpp  set formatoptions=croql cindent comments=sr:/*,mb:*,ex:*/,://
autocmd BufRead,BufNewFile *.go set filetype=go

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set autoindent
set autowrite
set expandtab

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

" Move tabs with alt + left|right
nnoremap <silent> <A-Left> :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>
nnoremap <silent> <A-Right> :execute 'silent! tabmove ' . tabpagenr()<CR>

" Hard save.
noremap <Leader>W :w !sudo tee % > /dev/null<CR>

" Color long lines.
if exists('+colorcolumn')
  set colorcolumn=80
else
  au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
endif

map <F2> :w
inoremap  :w

" Remove trailing whitespace.
autocmd BufWritePre * :%s/\s\+$//e

" Go formatting
autocmd BufWritePre *.go GoFmt
autocmd FileType go set noet

" Persistent undo.
if has("persistent_undo")
    set undodir=~/.undodir/
    set undofile
endif

set history=500
set undolevels=300

set ruler
set noguipty

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'fatih/vim-go'
let g:go_fmt_command = "goimports"
let g:go_fmt_fail_silently = 1
let g:go_bin_path = expand("~/.go/bin")

Bundle 'steffanc/cscopemaps.vim'

Bundle 'scrooloose/syntastic'
let g:syntastic_always_populate_loc_list = 1
map <F3> :SyntasticCheck
map <C-k> :lnext
map <C-l> :lprev

Bundle 'kien/ctrlp.vim'
let g:ctrlp_working_path_mode = 0
"let g:ctrlp_cmd = "CtrlPBuffer"

Bundle 'Valloric/YouCompleteMe'

Bundle 'lukerandall/haskellmode-vim'
au BufEnter *.hs compiler ghc
let g:haddock_browser="/usr/bin/google-chrome"

Bundle 'tpope/vim-unimpaired'
Bundle 'tpope/vim-obsession'

Bundle 'tpope/vim-surround'

Bundle 'bendavis78/vim-polymer'

Bundle 'mileszs/ack.vim'

Bundle 'ivalkeen/vim-ctrlp-tjump'
nnoremap <c-]> :CtrlPtjump<cr>
vnoremap <c-]> :CtrlPtjumpVisual<cr>

Bundle 'mbbill/undotree'

call vundle#end()
