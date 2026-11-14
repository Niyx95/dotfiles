set nocompatible
set backspace=indent,eol,start
set ai
set viminfo='20,\"50
set history=100
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
set autoindent
set smartindent
set cindent
set number

"tabs"
set tabstop=4
set shiftwidth=4

syntax enable
let c_comment_strings = 1

" Ale plug
" 1. Disable all ALE autocomplete
let g:ale_completion_enabled = 0

" 2. Restrict ALE strictly to your compiler
let g:ale_linters_explicit = 1
let g:ale_linters = {
\   'c': ['gcc'],
\}
" check errors but no fix on save
let g:ale_fix_on_save = 0

" NERDTree
" Start NERDTree and put the cursor back in the other window.
autocmd VimEnter * NERDTree | wincmd p
let g:NERDTreeFileLines = 1
" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | call feedkeys(":quit\<CR>:\<BS>") | endif

" Jump to last cursor position when reopening a file
augroup restore_cursor
  autocmd!
  autocmd BufReadPost *
    \ if line("'\"") >= 1 && line("'\"") <= line("$") && &filetype !~# 'commit'
    \      && index(['xxd', 'gitrebase', 'tutor'], &filetype) == -1
    \      && !&diff
    \ |   execute 'normal! g`"'
    \ | endif
augroup END

" plugins auto download if missing
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs https://githubusercontent.com'
endif

"keybindings - word extend select
nnoremap <C-S-Right> vw
vnoremap <C-S-Right> w
nnoremap <C-S-Left>  vb
vnoremap <C-S-Left>  b
inoremap <C-S-Right> <Esc>vw
inoremap <C-S-Left>  <Esc>vb

"call plugins
call plug#begin()

Plug 'liuchengxu/space-vim-dark'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'airblade/vim-gitgutter'
Plug 'dense-analysis/ale'
Plug 'preservim/nerdtree'
Plug 'morhetz/gruvbox'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'terryma/vim-multiple-cursors'

call plug#end()

" fzf quick file and buffer navigation
nnoremap <C-p> :GFiles<CR>
nnoremap <C-f> :Files<CR>
nnoremap <C-b> :Buffers<CR>

" vim-airline theme
let g:airline_theme='deus theme'
let g:airline#extensions#tabline#enabled = 1


" my colors
" Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
if (empty($TMUX) && getenv('TERM_PROGRAM') != 'Apple_Terminal')
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  if (has("termguicolors"))
    set termguicolors
  endif
endif
" autogroup
augroup my_colors
	autocmd vimenter * ++nested colorscheme gruvbox
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
