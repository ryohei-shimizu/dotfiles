" .vimrc

function! s:plugins_for_swift()
    packadd vim-lsp
    packadd async.vim

    if executable('sourcekit-lsp')
    au User lsp_setup call lsp#register_server({
            \ 'name': 'sourcekit-lsp',
            \ 'cmd': {server_info->['sourcekit-lsp']},
            \ 'whitelist': ['swift'],
            \ })
    endif

    autocmd FileType swift setlocal omnifunc=lsp#complete
endfunction

function! s:plugin_airline()
    let g:airline#extensions#tabline#enabled = 1
    let g:airline_theme='distinguished'
endfunction

function! s:plugin_fugitive()
    packadd vim-fugitive
endfunction

function! s:plugin_gitgutter()
    packadd vim-gitgutter
endfunction

function! s:plugin_nerdtree()
    packadd nerdtree
endfunction

augroup lazy-load
    autocmd!
    autocmd FileType swift call s:plugins_for_swift()
    call s:plugin_airline()
    call s:plugin_fugitive()
    call s:plugin_gitgutter()
    call s:plugin_nerdtree()
augroup END

filetype plugin on

syntax on

set autoread
set background=dark
set cursorline
set display=lastline
set hidden
set matchtime=1
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

set autoindent
set smartindent

set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4

if has('vim_starting')
    let &t_EI .= "\e[2 q"
    let &t_SI .= "\e[6 q"
    let &t_SR .= "\e[4 q"
endif

colorscheme jellybeans
