set nocompatible
syntax enable

set nowrap
set hidden
set pumheight=10
set ruler
set cmdheight=2
set iskeyword+=-
set mouse=a
set splitbelow
set splitright
set t_Co=256
set tabstop=2
set smarttab
set expandtab
set smartindent
set autoindent
set laststatus=0
set number
set cursorline
set background=dark
set showtabline=2
set nobackup
set nowritebackup
set updatetime=300
set timeoutlen=500
set formatoptions-=cro
set clipboard=unnamedplus

filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/nerdtree.git'
call vundle#end()
filetype plugin indent on