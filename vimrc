set nocompatible
set backspace=indent,eol,start
set ai
set viminfo='20,\"50
set history=50
set ruler
set showcmd
set wildmenu
set ttimeout
set ttimeoutlen=100
set display=truncate
set scrolloff=5
set incsearch
set nrformats-=octal
set hlsearch

syntax on
let c_comment_strings = 1

"Jump to last cursor position when reopening a file
augroup restore_cursor
  autocmd!
  autocmd BufReadPost *
    \ let line = line("'\"")
    \ | if line >= 1 && line <= line("$") && &filetype !~# 'commit'
    \      && index(['xxd', 'gitrebase', 'tutor'], &filetype) == -1
    \      && !&diff
    \ |   execute "normal! g`\""
    \ | endif
augroup END

"plugins auto download if missing
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

"call plugins
call plug#begin()

Plug 'liuchengxu/space-vim-dark'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'airblade/vim-gitgutter'

call plug#end()

"colorscheme
let g:space_vim_dark_background = 233

augroup my_colors
  autocmd!
  autocmd ColorScheme space-vim-dark hi Comment guifg=#5C6370 gui=italic
  autocmd ColorScheme space-vim-dark hi LineNr guibg=NONE
  autocmd ColorScheme space-vim-dark hi Normal guibg=#000000
augroup END

color space-vim-dark
set termguicolors

filetype plugin on

"Diff current buffer against the file it was loaded from
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_
    \ | wincmd p | diffthis
endif

if has('langmap') && exists('+langremap')
  set nolangremap
endif

"Don't blink the cursor
let &guicursor = &guicursor . ",a:blinkon0"
