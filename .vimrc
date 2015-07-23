"Ghislain's vimrc

set nocompatible                	" use vim defaults
set nonumber                      	" do not show line numbers by default
set incsearch ignorecase hlsearch	" incremental searches
set ruler                       	" show ruler
set antialias                   	" antialias fonts (only in GUI)
set background=dark             	" set color scheme for dark backgrounds
set fsync                       	" force disk sync when saving
set showmatch                   	" show matching brackets
set statusline=%<%F\ %h%m%r%=%-14.(%l,%c%V%)\ %P        " Status line format
set laststatus=2                	" always show status line
set tabstop=4                   	" tabs are 4 spaces wide
set shiftwidth=4                	" number of spaces for indentation
"set textwidth=78                    " Max line width
set visualbell                  	" use visual bell
set wrap                        	" wrap long lines
set title                       	" update terminal title
set ttyfast                     	" fast terminal
set whichwrap=b,s,h,l,<,>,[,]   	" moves span line wraps
set expandtab						" Replace tab with spaces
set autoindent
set wildchar=<Tab>					" Expand the command line using tab
set foldmethod=marker
set backspace=indent,eol,start
"set mouse=a 						" Enable mouse
set showcmd
set completeopt=menuone,longest

" Press space to clear search highlighting
nnoremap <silent> <Space> :silent noh<Bar>echo<CR>

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
endif

runtime! ftplugin/man.vim

if has('gui_running')
    set guioptions-=T  " no toolbar
endif

" Keyboard mappings
inoremap <left> <nop> 
inoremap <right> <nop> 
inoremap <up> <nop> 
inoremap <down> <nop> 
nnoremap <left> <nop> 
nnoremap <right> <nop> 
nnoremap <up> <nop> 
nnoremap <down> <nop> 

set t_Co=256

colorscheme slate

