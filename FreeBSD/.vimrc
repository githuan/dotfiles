" vim: fdm=marker:
"
" @author: Viktor Alex Brynjarsson
" My .vimrc

" {{{ Vundle (plugin management)

"Get Vundle up and running
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" let Vundle manage Vundle
Plugin 'gmarik/Vundle.vim'

" Misc Plugins
Plugin 'bling/vim-airline'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-speeddating'

" Language specific
Plugin 'groenewege/vim-less'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-markdown'
Plugin 'jnwhiteh/vim-golang'
Plugin 'exu/pgsql.vim'
Plugin 'Glench/Vim-Jinja2-Syntax'
Plugin 'vim-ruby/vim-ruby'
Plugin 'slim-template/vim-slim'

" Python
Plugin 'nvie/vim-flake8'
Plugin 'hynek/vim-python-pep8-indent'
Plugin 'hdima/python-syntax'

" Unite
Plugin 'Shougo/unite.vim'
Plugin 'Shougo/vimproc.vim'
Plugin 'ujihisa/unite-colorscheme'

" Colorschemes
Plugin 'MaxSt/FlatColor'
Plugin 'Tomorrow-Night'

call vundle#end()

" }}}

" Syntax highlighting
syntax enable
" Load filetype plugins and indentation
filetype plugin indent on

" {{{ UI Configuration

if has("gui_running")
  " Font option depends on platform
  if has("win32")
    set guifont=Andale\ Mono:h10:cDEFAULT
  else
    set guifont=Envy\ Code\ R\ for\ Powerline\ 12
  endif

  " set guioptions
  set guioptions=a "Autoselect
  set guioptions+=c "Console dialog instead of popup
  set guioptions+=h "Limit horizontal scrollbar to cursor line length
  set guioptions+=e "Add gui tab pages when needed
  set guioptions+=g "Gray non-active menu items
  set guioptions+=i "Use the Vim icon
  set guioptions+=r "Right hand scrollbar always present
  set guioptions+=L "Left hand scrollbar when needed
  set guioptions+=m "Menu bar is present

  " Use anti-aliasing
  set antialias
end

" Using putty I get the wrong t_Co value
if (&term == "xterm")
  set t_Co=256
elseif (&term == "screen-bce")
  set t_Co=256
endif

" colorscheme (works in both gvim and vim)
colorscheme Tomorrow-Night 

" Status line
set laststatus=2

" Highlight Cursor
set cursorline

" }}}

" {{{ Keyboard Configuration

" Change ESC to ENTER
" inoremap <CR> <ESC>`^
" vnoremap <CR> <ESC>
" jj is now ENTER in insert mode
" inoremap jj <C-J>

" reselect visual block after indent
vnoremap < <gv
vnoremap > >gv

" when moving between searches, center the selected line
" nnoremap n nzz
" nnoremap N Nzz

" Easy split navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Make Y behave like other Capitals (C, D, etc.)
" noremap Y y$

" Map Q to repeat the last recorded macro
" noremap Q @@

" Use space to toggle folds in normal mode
nnoremap <silent> <Space> za
" Create a fold using space in visual mode
vnoremap <silent> <Space> zf"

" Change :W to :w in command line
" cnoreabbrev W t

" The button which will be refered to as <Leader> from here on out
let mapleader = ","

" Clear search results
nnoremap <Leader><Space> :nohlsearch<CR>

" Select all
noremap <Leader>a ggVG

" Open last buffer
noremap <Leader><Leader> <C-^>

" Do the splits
noremap <Leader>s :split<CR>
noremap <Leader>v :vsplit<CR>

" Change directory to current file dir
nnoremap <Leader>cd :cd %:p:h<CR>:pwd<CR>

" Toggle paste mode
set pastetoggle=<Leader>p

" Disable wierd Alt+Spacebar Character
inoremap <A-Space> <Space>

" Save without permission
noremap <Leader>w :w !sudo tee %<CR>

" }}}

" {{{ Options

set nocompatible

" No backup, no swap
set nobackup
set noswapfile

" Custom invisibles
set list
set listchars=tab:▸\ ,trail:⋅,extends:❯,precedes:❮
set showbreak=↲

" Show line numbers
set number
set relativenumber

" "Scrolling"
set scrolloff=5

" Splitting habits
set splitright splitbelow

" Do tabbing correctly
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
" Tab settings for specific filetypes are described in TabSettings

" Sjarrappa youuu
set noerrorbells
set novisualbell
set t_vb=

" Show me what I'll do
set showcmd

" Highlight search results
set hlsearch

" }}}

" {{{ Autocommands

" Static line numbers in insert mode
augroup TabSettings
  au!
  autocmd Filetype python setlocal tabstop=4
  autocmd Filetype python setlocal shiftwidth=4
  autocmd Filetype python setlocal softtabstop=4
  autocmd Filetype xml,html,xhtml setlocal tabstop=2
  autocmd Filetype xml,html,xhtml setlocal shiftwidth=2
  autocmd Filetype xml,html,xhtml setlocal softtabstop=2
augroup END

" Stupid slim template syntax not turning on the syntax in *.slim files
autocmd BufRead,BufNewFile,BufEnter *.slim set filetype=slim

" }}}

" {{{ Plugin Configuration

nnoremap <Leader>8 :call Flake8()<CR>

""" Unite

" do fuzzy matching
"call unite#custom#source('file,file/new,buffer,file_rec', 'matchers', 'matcher_fuzzy')
call unite#custom#source('file_rec,file_rec/async,file_mru,file,buffer,grep',
      \ 'ignore_pattern', join([
      \ '\.git/',
      \ ], '\|'))
call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#filters#sorter_default#use(['sorter_rank'])

" allow searching of yank history
let g:unite_source_history_yank_enable = 1

" don't split, show auto preview, start in insert mode
nnoremap <Leader>b :Unite -no-split buffer<CR>
nnoremap <Leader>f :Unite -no-split file<CR>
nnoremap <Leader>d :Unite -no-split file_rec/async:!<CR>
nnoremap <Leader>y :Unite -buffer-name=yank history/yank<CR>

" Up and down with C-[jk] in insert mode in Unite
autocmd FileType unite call s:unite_settings()
function! s:unite_settings()
  imap <buffer> <C-j>   <Plug>(unite_select_next_line)
  imap <buffer> <C-k>   <Plug>(unite_select_previous_line)
endfunction

""" Airline
let g:airline_powerline_fonts = 1

" }}}
