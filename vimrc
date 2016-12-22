call plug#begin('~/.vim/plugged')
  
Plug 'myusuf3/numbers.vim'
Plug 'morhetz/gruvbox'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdtree'
Plug 'bling/vim-airline'
Plug 'moll/vim-node'
Plug 'tpope/vim-surround'
Plug 'pangloss/vim-javascript'
Plug 'othree/yajs.vim'
Plug 'ternjs/tern_for_vim', { 'do': 'npm install' }
Plug 'othree/javascript-libraries-syntax.vim'
Plug 'mxw/vim-jsx'
Plug 'Shougo/deoplete.nvim'
Plug 'kshenoy/vim-signature' " Adds label in gutter for marks
Plug 'ervandew/supertab'
Plug 'benekastah/neomake'
Plug 'SirVer/ultisnips'

call plug#end()

set incsearch                   " Find as you type search
set hlsearch                    " Highlight search terms
set ignorecase                  " Case insensitive search
set smartcase                   " Case sensitive when uc present

set iskeyword-=.                " '.' is an end of word designator
set iskeyword-=#                " '#' is an end of word designator
set iskeyword-=-                " '-' is an end of word designator
set laststatus=2                " Always show the status bar / Airline

set whichwrap=b,s,h,l,<,>,[,]   " Backspace and cursor keys wrap too

set foldmethod=syntax  " vim-javascript can take advantage of syntax to fold smarter
set nofoldenable " when opening a file, dont start with any folding
set foldnestmax=20

" -----------------------------------------------------
" Displaying text
" -----------------------------------------------------
set backspace=indent,eol,start  " Backspace for dummies
set linespace=0                 " No extra spaces between rows
set nu				                  "putting line numbers on in insert mode"

set scrolljump=1                " Lines to scroll when cursor leaves screen
set scrolloff=10                 " Minimum lines to keep above and below cursor
set nowrap                      " Don't wrap long lines Don't
set nocursorcolumn
set cursorline
let mapleader=' '

" indenting http://tedlogan.com/techblog3.html
set autoindent 
set expandtab "hitting tab insert spaces instead of <Tab>
set tabstop=2
set shiftwidth=2
set softtabstop=2

syntax on
colorscheme gruvbox
set background=dark

noremap <tab> :bn<CR>
noremap <S-tab> :bp<CR>

set hidden "switch buffers without saving

"-----------------------------------------------
" --------------Remapping Keys------------------
"  ---------------------------------------------

nnoremap <Leader>ev :e $MYVIMRC<cr> " vimrc edit 
nnoremap <Leader>sv :source $MYVIMRC<cr> " vimrc source
nnoremap ;; A;<Esc>
nnoremap <c-k> dd<Up><Up>p 
nnoremap <c-j> ddp
nnoremap <Leader>d :bd<Enter>

inoremap jk <Esc>:w<Enter>
inoremap <c-h> <Left>
inoremap <c-l> <Right>
inoremap <c-j> <Down>
inoremap <c-k> <Up>

nnoremap <Space>= za
nnoremap <Space>- zc


" use tab to forward cycle
inoremap <expr> <tab> pumvisible() ? "\<c-n>" : "\<tab>"
" use tab to backward cycle
inoremap <expr> <s-tab> pumvisible() ? "\<c-p>" : "\<c-d>"

"  ---------------------------------------------
"  -------------End Remapping Keys--------------
"  ---------------------------------------------



" -----------------------------------------------------
" PLugin settings
" -----------------------------------------------------
" NERFTree customizations
map <C-n> :exe 'NERDTreeToggle ' . <SID>fzf_root()<CR>
nmap <Leader>nt :NERDTreeFind<CR>

let NERDTreeShowBookmarks=1
let NERDTreeIgnore=['\~$', '\.swp$', '^\.git$','^node_modules$', '^\.DS_Store$']
let NERDTreeChDirMode=0
let NERDTreeQuitOnOpen=1
let NERDTreeMouseMode=2
let NERDTreeShowHidden=1
let NERDTreeKeepTreeInNewTab=1
let g:nerdtree_tabs_open_on_gui_startup=0

" FZF customizations" 
" This is the default extra key bindings
let $FZF_DEFAULT_COMMAND='ag -g ""'
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" Default fzf layout
" - down / up / left / right
" - window (nvim only)
let g:fzf_layout = { 'down': '~20%' }

" For Commits and BCommits to customize the options used by 'git log':
let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'

" Advanced customization using autoload functions
" Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" Normal mode completion
fun! s:fzf_root()
	let path = finddir(".git", expand("%:p:h").";")
	return fnamemodify(substitute(path, ".git", "", ""), ":p:h")
endfun

nnoremap <silent> <Leader>f :exe 'Files ' . <SID>fzf_root()<CR>

" Insert mode completion
imap <C-x><C-f> <plug>(fzf-complete-file-ag)
imap <C-x><C-l> <plug>(fzf-complete-line)

" Advanced customization using autoload functions
inoremap <expr> <c-x><c-k> fzf#vim#complete#word({'left': '15%'})

function! s:fzf_statusline()
  " Override statusline as you like
  highlight fzf1 ctermfg=161 ctermbg=251
  highlight fzf2 ctermfg=23 ctermbg=251
  highlight fzf3 ctermfg=237 ctermbg=251
  setlocal statusline=%#fzf1#\ >\ %#fzf2#fz%#fzf3#f
endfunction

autocmd! User FzfStatusLine call <SID>fzf_statusline()

let g:airline#extensions#tabline#enabled=1

let g:used_javascript_libs = 'underscore,react,chai'
let g:deoplete#enable_at_startup = 1


let g:SuperTabDefaultCompletionType = '<C-j>'
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1

let g:neomake_javascript_enabled_makers = ['eslint']
autocmd! BufWritePost * Neomake
let g:neomake_open_list = 2

" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsListSnippets = "<c-tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
let g:UltiSnipsSnippetDirectories = [$HOME.'/.vim/UltiSnips']


"************************************************************************************************
"**************END PLUGIN SETTINGS***************************************************************
"************************************************************************************************

function! EslintFix()
   let l:winview = winsaveview()
   silent !eslint --fix %
   call winrestview(l:winview)
endfunction
command! EslintFix :call EslintFix()
