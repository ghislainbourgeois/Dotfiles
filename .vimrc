"Ghislain's vimrc

" Vundle {{{
set nocompatible
filetype off

if filereadable('~/.vim/bundle/vundle.vim')

    set rtp+=~/.vim/bundle/Vundle.vim
    call vundle#begin()

    Plugin 'VundleVim/Vundle.vim'

    Plugin 'tpope/vim-fugitive'

endif

filetype on
" }}}

" Colors {{{
set background=dark             	" set color scheme for dark backgrounds
set t_Co=256
colorscheme murphy
" }}}

" Terminal {{{
set title                       	" update terminal title
set ttyfast                     	" fast terminal
" }}}

" General {{{
set modelines=1
set nocompatible                	" use vim defaults
set encoding=utf-8
set fsync                       	" force disk sync when saving
set showcmd
" }}}

" UI Layout {{{
set nonumber                      	" do not show line numbers by default
set ruler                       	" show ruler
set showmatch                   	" show matching brackets
set statusline=%<%F\ %h%m%r%=%-14.(%l,%c%V%)\ %P        " Status line format
set laststatus=2                	" always show status line
set visualbell                  	" use visual bell
set nowrap
set whichwrap=b,s,h,l,<,>,[,]   	" moves span line wraps
set wildmenu  "Visual autocomplete for command menu
set lazyredraw  "redraw only when needed
" }}}

" Spaces & Tabs {{{
set tabstop=4                   	" tabs are 4 spaces wide
set shiftwidth=4                	" number of spaces for indentation
"set textwidth=78                    " Max line width
set expandtab						" Replace tab with spaces
set autoindent

" }}}

" Searching {{{
set incsearch ignorecase smartcase hlsearch	" incremental searches

" }}}
set wildchar=<Tab>					" Expand the command line using tab
set backspace=indent,eol,start
set completeopt=menuone,longest

" Folding {{{
set foldenable
set foldlevelstart=10
set foldnestmax=10
set foldmethod=marker
nnoremap <space> za
" }}}

" Keyboard mappings {{{
let mapleader=","

nnoremap <left> <nop> 
nnoremap <right> <nop> 
nnoremap <up> <nop> 
nnoremap <down> <nop> 

" Move vertically by visual line
nnoremap j gj
nnoremap k gk

" }}}

" FileTypes {{{
filetype plugin indent on			" syntax based indenting
syntax on                       	" syntax highlighting

if has("autocmd")
    " Helpfiles
    autocmd FileType helpfile set nonumber      " no line numbers when viewing help
    autocmd FileType helpfile nnoremap <buffer><cr> <c-]>   " Enter selects subject
    autocmd FileType helpfile nnoremap <buffer><bs> <c-T>   " Backspace to go back

    " Vim files
    autocmd FileType vim set omnifunc=vim

    " Shell files
    autocmd FileType sh set omnifunc=sh
    
    " Python files
    autocmd FileType py syntax on
    autocmd FileType py set autoindent
    autocmd FileType py set smartindent
    autocmd FileType py set textwidth=79
    autocmd FileType py set tabstop=4
    autocmd FileType py set shiftwidth=4
    autocmd FileType py set cursorline
    autocmd FileType py set showmatch
    autocmd FileType py set number
    autocmd FileType py set foldmethod=indent
endif
" }}}

runtime! ftplugin/man.vim


" vim:foldmethod=marker:foldlevel=0
