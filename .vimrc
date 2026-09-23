" .vimrc

" ============================================================================
" Plugin Manager

let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
    silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" ============================================================================
" Plugin Configurations (Global Variables)

" vim-airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme = 'distinguished'

" nerdcommenter
let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 1
let g:NERDDefaultAlign = 'left'
let g:NERDAltDelims_java = 1
let g:NERDCustomDelimiters = { 'c': { 'left': '/**', 'right': '*/' } }
let g:NERDCommentEmptyLines = 1
let g:NERDTrimTrailingWhitespace = 1
let g:NERDToggleCheckAllLines = 1

" ============================================================================
" Load Plugins

call plug#begin()

Plug 'scrooloose/nerdcommenter'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-scripts/twilight256.vim'

Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'

call plug#end()

" ============================================================================
" Enable Built-in Features & Filetype

" Built-in EditorConfig for Vim 9.0.1799+ / Neovim 0.9+
if has('patch-9.0.1799') || has('nvim-0.9')
    packadd! editorconfig
endif

filetype plugin indent on
syntax on

" ============================================================================
" General Options

set autoread
set background=dark
set colorcolumn=120
set cursorline
set display=lastline
set hidden
set matchtime=1
set mouse=a
set nowrap
set number
set pumheight=10
set showcmd
set showmatch
set showmode
set updatetime=400
set wildmode=longest,list,full

set splitbelow
set splitright

set laststatus=2
set showtabline=2

set hlsearch
set ignorecase
set incsearch
set smartcase

set smartindent
set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4

" Persistent Undo
if has('persistent_undo')
    let s:undo_dir = expand('~/.vim/undo')
    if !isdirectory(s:undo_dir)
        call mkdir(s:undo_dir, 'p')
    endif
    set undodir=~/.vim/undo
    set undofile
endif

" Change cursor shape across modes
if has('vim_starting')
    let &t_EI .= "\e[2 q"
    let &t_SI .= "\e[6 q"
    let &t_SR .= "\e[4 q"
endif

" ============================================================================
" Color Schemes and Highlights

" Keep custom highlights after colorscheme change
augroup ProfileColors
    autocmd!
    autocmd ColorScheme * hi ColorColumn ctermbg=black
    autocmd ColorScheme * hi IncSearch cterm=bold ctermfg=white ctermbg=blue
    autocmd ColorScheme * hi Search cterm=bold ctermfg=white ctermbg=blue
augroup END

colorscheme twilight256

" ============================================================================
" Key Mappings & Autocmds

imap <C-j> <esc>

augroup CustomAutoCmds
    autocmd!
    " Remove trailing whitespace on save without moving cursor
    autocmd BufWritePre * let b:cur_view = winsaveview() | keepjumps %s/\s\+$//e | call winrestview(b:cur_view)

    " Open Quickfix window at the bottom with full width
    autocmd FileType qf wincmd J
    autocmd QuickfixCmdPost make,grep,grepadd,vimgrep copen
augroup END

" ============================================================================
" Custom Commands & Functions

" Execute current line in bash (:ExecBash)
command! ExecBash .w !bash

" Convert file encoding from Shift_JIS (cp932) to UTF-8 (:ConvertSJIS)
command! ConvertSJIS call s:ChangeFileFormatSJIS2UTF8()
function! s:ChangeFileFormatSJIS2UTF8()
    e ++enc=cp932
    set fileencoding=utf-8
    set fileformat=unix
endfunction
