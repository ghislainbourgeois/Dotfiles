"Ghislain's vimrc

" Vundle {{{
set nocompatible
filetype off

if isdirectory(expand('~/.vim/bundle/Vundle.vim'))

    set rtp+=~/.vim/bundle/Vundle.vim
    call vundle#begin()

    Plugin 'VundleVim/Vundle.vim'

    Plugin 'tpope/vim-fugitive'

    Plugin 'pearofducks/ansible-vim'

    Plugin 'fholgado/minibufexpl.vim'
    
    Plugin 'scrooloose/nerdtree'

    Plugin 'solarized'

    Plugin 'nvie/vim-flake8'

    Plugin 'jgdavey/tslime.vim'

    Plugin 'editorconfig/editorconfig-vim'

    Plugin 'christoomey/vim-tmux-navigator'

    call vundle#end()
endif

filetype on
" }}}

" Colors {{{
set background=dark             	" set color scheme for dark backgrounds
set t_Co=256
colorscheme solarized
" }}}

" Terminal {{{
set title                       	" update terminal title
set ttyfast                     	" fast terminal
if exists('$TMUX')
    set term=screen-256color
endif
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
set wrap
set whichwrap=b,s,h,l,<,>,[,]   	" moves span line wraps
set wildmenu  "Visual autocomplete for command menu
set lazyredraw  "redraw only when needed
" }}}

" Spaces & Tabs {{{
set tabstop=4                   	" tabs are 4 spaces wide
set shiftwidth=4                	" number of spaces for indentation
set textwidth=79                    " Max line width
set expandtab						" Replace tab with spaces
set autoindent
set formatoptions=qrn1              " see :h fo-table
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

" Simplify window movements
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

nnoremap <C-n> :NERDTreeToggle<CR>
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

    " YAML files
    autocmd FileType yaml setl indentkeys-=<:>
endif
" }}}

runtime! ftplugin/man.vim


" vim:foldmethod=marker:foldlevel=0
