set scrolloff=8
set number
set relativenumber
set tabstop=2
set shiftwidth=2
set expandtab
set smartindent
set encoding=utf8
let g:airline_powerline_fonts = 1

call plug#begin("~/.vim/plugged")
Plug 'junegunn/fzf', {'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'pangloss/vim-javascript'
Plug 'peitalin/vim-jsx-typescript'
Plug 'leafgarland/typescript-vim'
Plug 'morhetz/gruvbox'
Plug 'dracula/vim'
Plug 'scrooloose/nerdtree'
Plug 'ryanoasis/vim-devicons'
Plug 'neoclide/coc.nvim', {'branch':'release'}
let g:coc_global_extensions = ['coc-tsserver',
\'coc-python',
\ 'coc-pydocstring',
\ 'coc-json',
\ 'coc-html-css-support',
\ 'coc-css',
\ 'coc-sql',
\ 'coc-yaml']
" Plug 'sheerun/vim-polyglot',
Plug 'preservim/nerdcommenter'
Plug 'jparise/vim-graphql'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" post install (yarn install | npm install) then load plugin only for editing supported files
Plug 'prettier/vim-prettier', {
\ 'do': 'yarn install',
\ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html'] }
call plug#end()

if (has("termguicolors"))
set termguicolors
endif
syntax enable
colorscheme gruvbox

let mapleader = " "
nnoremap <leader>pv :Vex<CR>
nnoremap <leader>pf :Files<CR>
inoremap jk <esc>:w<CR>
nnoremap <C-p> :GFiles<CR>

let g:NERDTreeShowHidden = 1
let g:NERDTreeMinimalUI = 0
let g:NERDTreeIgnore = ['node_modules']
let NERDTreeStatusLine='NERDTree'
" Automaticaly close nvim if NERDTree is only thing left open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" Toggle
nnoremap <silent> <C-a> :NERDTreeToggle<CR>

let g:prettier#autoformat_config_present = 1
let g:prettier#config#config_precedence = 'prefer-file'

