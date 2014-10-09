syntax on
filetype on
filetype plugin on
autocmd FileType *      set formatoptions=tcql nocindent comments&
autocmd FileType c,cpp  set formatoptions=croql cindent comments=sr:/*,mb:*,ex:*/,://

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

" Color long lines.
if exists('+colorcolumn')
  set colorcolumn=80
else
  au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
endif

" Fast saving.
:map <F2> :w
:inoremap  :w

" Remove trailing whitespace.
autocmd BufWritePre * :%s/\s\+$//e

set history=500
set undolevels=300

set ruler
set noguipty

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Bundle 'lukerandall/haskellmode-vim'
au BufEnter *.hs compiler ghc
let g:haddock_browser="/usr/bin/google-chrome"

Bundle 'steffanc/cscopemaps.vim'

call vundle#end()
