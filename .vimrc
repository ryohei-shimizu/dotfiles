" .vimrc

function! ExecCurrentLineOnBash()
    .w !bash
endfunction

function! ChangeFileFormatSJIS2UTF8()
    e ++enc=cp932
    set fileencoding=utf-8
    set fileformat=unix
endfunction

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

function! s:plugin_markdown()
    packadd vim-markdown
endfunction

function! s:plugin_nerdcommenter()
    packadd nerdcommenter

	" Add spaces after comment delimiters by default
	let g:NERDSpaceDelims = 1
	" Use compact syntax for prettified multi-line comments
	let g:NERDCompactSexyComs = 1
	" Align line-wise comment delimiters flush left instead of following code indentation
	let g:NERDDefaultAlign = 'left'
	" Set a language to use its alternate delimiters by default
	let g:NERDAltDelims_java = 1
	" Add your own custom formats or override the defaults
	let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }
	" Allow commenting and inverting empty lines (useful when commenting a region)
	let g:NERDCommentEmptyLines = 1
	" Enable trimming of trailing whitespace when uncommenting
	let g:NERDTrimTrailingWhitespace = 1
	" Enable NERDCommenterToggle to check all selected lines is commented or not
	let g:NERDToggleCheckAllLines = 1
endfunction

augroup lazy-load
    autocmd!
    autocmd FileType swift call s:plugins_for_swift()
    call s:plugin_airline()
    call s:plugin_fugitive()
    call s:plugin_gitgutter()
    call s:plugin_markdown()
    call s:plugin_nerdcommenter()
augroup END

filetype plugin on

autocmd BufNewFile,BufRead Fastfile    setfiletype ruby
autocmd BufNewFile,BufRead Jenkinsfile setfiletype groovy
autocmd BufWritePre * :%s/\s\+$//e " Remove trailing whitespace on save
autocmd FileType qf wincmd J " push quickfix window always to the bottom
autocmd QuickfixCmdPost make,grep,grepadd,vimgrep copen

imap <C-j> <esc>

syntax on

set autoread
set background=dark
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

set autoindent
set smartindent

set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4

" set foldclose=all
" set foldlevel=0
" set foldmethod=indent

if has('vim_starting')
    let &t_EI .= "\e[2 q"
    let &t_SI .= "\e[6 q"
    let &t_SR .= "\e[4 q"
endif

colorscheme twilight256
hi IncSearch cterm=bold ctermfg=white ctermbg=blue
hi Search    cterm=bold ctermfg=white ctermbg=blue
