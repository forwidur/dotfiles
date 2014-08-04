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


" set textwidth=80


" fast saving
:map <F2> :w
:inoremap  :w

set history=500
set undolevels=300

set ruler
set noguipty

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Bundle 'lukerandall/haskellmode-vim'
au BufEnter *.hs compiler ghc
let g:haddock_browser="/usr/bin/google-chrome"

call vundle#end()
