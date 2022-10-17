" Simple .vimrc for when I break my neovim config and need a backup

" Boostrap plugin manager
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  augroup plug_bootstrap
    autocmd!
    autocmd VimEnter * PlugInstall --sync | quit | source $MYVIMRC
  augroup end
endif

" Update installed plugins when changes are saved to .vimrc
augroup plug_update_on_write
  autocmd!
  autocmd BufWritePost $MYVIMRC  source $MYVIMRC | PlugUpdate --sync | quit | source $MYVIMRC
augroup end

" Plugin Setup
call plug#begin()
  Plug 'ghifarit53/tokyonight-vim'
call plug#end()

" Editor
set mouse=a
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set smartindent
set incsearch
set nohlsearch
set ignorecase
set smartcase
set nowrap
set belloff=all
set relativenumber
set clipboard+=unnamedplus
set splitbelow
set splitright
set scrolloff=12
set sidescrolloff=12

let mapleader = " "
let g:netrw_keepdir = 0
let g:netrw_winsize = 16
let g:netrw_banner = 0
let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'
let g:netrw_localcopydircmd = 'cp -r'

" Theme
set termguicolors
let g:tokyonight_style = 'night'
let g:tokyonight_enable_italic = 1
let g:tokyonight_transparent_background = 1
let g:tokyonight_enable_italic = 0
silent! colorscheme tokyonight

" Normal Mode Keymaps
nn <Leader>e :Lexplore<Cr>

" Insert Mode Keymaps

" Visual Mode Keymaps
vn < <gv
vn > >gv
vn p "_dP
