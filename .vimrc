"Ghislain's vimrc

set nocompatible

" VIM-Plug {{{
filetype off

if has("win32unix")
    let g:os = "Cygwin"
elseif has("win32") || has("win64")
    let g:os = "Windows"
else
    let g:os = "Unix"
endif

if g:os == "Windows"
    let g:pluggeddir = '%USERPROFILE%/vimfiles/plugged/'
else
    let g:pluggeddir = '~/.vim/plugged'
endif

call plug#begin(g:pluggeddir)

Plug 'tpope/vim-fugitive'

Plug 'pearofducks/ansible-vim'

Plug 'fholgado/minibufexpl.vim'

Plug 'christoomey/vim-tmux-navigator'

Plug 'jgdavey/tslime.vim'
let g:tslime_always_current_session = 1
let g:tslime_always_current_windows = 1

Plug 'editorconfig/editorconfig-vim'

Plug 'crusoexia/vim-monokai'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline_left_sep=''
let g:airline_right_sep=''
let g:airline_theme='badwolf'

Plug 'nvie/vim-flake8', { 'for': 'python' }

Plug 'tmhedberg/SimpylFold'
let g:SimpylFold_docstring_preview=1

Plug 'neomake/neomake'
let g:neomake_lilypond_lilypond_maker = {
    \ 'errorformat': '%f:%l:%v: error: %m',
    \ }
let g:neomake_lilypond_enabled_makers = ['lilypond']

Plug 'jelera/vim-javascript-syntax', { 'for': 'javascript' }

Plug 'pangloss/vim-javascript', { 'for': 'javascript' }

Plug 'fatih/vim-go', { 'for': 'go' }

Plug 'gisraptor/vim-lilypond-integrator'

Plug 'nathangrigg/vim-beancount'

call plug#end()

filetype on
" }}}

" Colors {{{
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
set background=dark             	" set color scheme for dark backgrounds
set termguicolors
colorscheme monokai
" }}}

" Terminal {{{
set title                       	" update terminal title
set ttyfast                     	" fast terminal
"if exists('$TMUX')
"    set term=screen-256color
"endif
" }}}

" NetRW {{{
let g:netrw_banner = 0
let g:netrw_browse_split = 4
let g:netrw_cursor = 2
let g:netrw_fastbrowse = 0
let g:netrw_liststyle = 3
let g:netrw_winsize = 25
" }}}

" General {{{
set modelines=1
set nocompatible                	" use vim defaults
set encoding=utf-8
set fsync                       	" force disk sync when saving
set showcmd
set path+=**
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
set wildmenu                        " Visual autocomplete for command menu
set lazyredraw                      " redraw only when needed
" }}}

" Spaces & Tabs {{{
set tabstop=4                   	" tabs are 4 spaces wide
set softtabstop=4                   	" tabs are 4 spaces wide
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
" }}}

" Keyboard mappings {{{
let mapleader=" "

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

" Tslime
vmap <C-c><C-c> <Plug>SendSelectionToTmux
nmap <C-c><C-c> <Plug>NormalModeSendToTmux
nmap <C-c>r <Plug>SetTmuxVars
nmap <C-c><C-l> maggVG<C-c><C-c>`a
nmap <leader>ms :Tmux mit-scheme<CR>
" }}}

" FileTypes {{{
filetype plugin indent on			" syntax based indenting
syntax on                       	" syntax highlighting

if has("autocmd")
    augroup ansible
        autocmd!
        autocmd FileType yaml setlocal indentkeys-=<:>
        autocmd FileType yaml setlocal tabstop=2
        autocmd FileType yaml setlocal softtabstop=2
        autocmd FileType yaml setlocal shiftwidth=2
        autocmd FileType yaml setlocal keywordprg=ansible-doc
    augroup END

    augroup beancount
        autocmd!
        autocmd FileType beancount let b:beancount_root = fnamemodify(findfile("ledger.beancount", ";"), ":p")
        autocmd FileType beancount let &l:makeprg = "bean-check ".b:beancount_root
    augroup END

    augroup git
        autocmd Filetype gitcommit setlocal spell textwidth=72
    augroup END

    augroup golang
        autocmd!
        autocmd BufNewFile,BufRead *.go setlocal fileformat=unix
        autocmd BufWritePost,BufRead * Neomake
        autocmd FileType go nnoremap <leader>t :GoTest<cr>
    augroup END

    augroup helpfile
        autocmd!
        autocmd FileType helpfile setlocal nonumber      " no line numbers when viewing help
        autocmd FileType helpfile nnoremap <buffer><cr> <c-]>   " Enter selects subject
        autocmd FileType helpfile nnoremap <buffer><bs> <c-T>   " Backspace to go back
    augroup END

    augroup javascript
        autocmd!
        autocmd BufWritePost,BufRead * Neomake
    augroup END

    augroup lilypond
        autocmd!
        autocmd FileType lilypond setlocal tabstop=2
        autocmd FileType lilypond setlocal softtabstop=2
        autocmd FileType lilypond setlocal shiftwidth=2
    augroup END

    augroup neomake
        autocmd!
        autocmd BufWritePost * Neomake
    augroup END

    augroup pythonfile
        autocmd!
        autocmd BufNewFile,BufRead *.py setlocal fileformat=unix
        autocmd BufWinEnter *.py setlocal foldexpr=SimpylFold(v:lnum)
        autocmd BufWinLeave *.py setlocal foldexpr< foldmethod<
        autocmd BufWritePost,BufRead * Neomake
    augroup END

    augroup shellfile
        autocmd!
        autocmd FileType sh setlocal omnifunc=sh
    augroup END

    augroup vimfile
        autocmd!
        autocmd FileType vim setlocal omnifunc=vim
        autocmd FileType vim setlocal foldmethod=marker
    augroup END

endif
" }}}

runtime! ftplugin/man.vim

" vim:foldmethod=marker:foldlevel=0
