set background=dark
autocmd BufWinLeave * if @% !='' | mkview
autocmd BufWinEnter * if @% != '' | silent loadview

"   Generic Settings
syntax on
syntax enable
filetype plugin on
filetype indent on
set autoread
set encoding=utf-8
set expandtab
set foldmethod=manual
set ignorecase
set incsearch
set mouse=
set nowrap
set relativenumber
set scrolloff=8
set shiftwidth=4
set smartcase
set smartindent
set tabstop=4 softtabstop=4
set visualbell
set wildmenu

"   Normal Maps
nmap Y y$
nmap L $
nmap H 0
nmap tt :tabnew<CR>
nmap to :browse oldfiles<CR>
nmap te :Texplore<CR>

"   Leader Maps
nmap \q za
" nmap \f :Fern . -drawer -reveal=% -toggle<CR>
nmap \f :NERDTreeToggle<CR>
nmap \s :Files <CR>
nmap \r :Rg <CR>

"   Space Maps
nmap <space>d :DogeGenerate <CR>
nmap <space>m :set wrap! spell spelllang=en_us<CR>
nmap <space>p :MarkdownPreview <CR>
nmap <space>g :Goyo <CR>
nmap <space>v :vsplit <CR>
nmap <space>s :split <CR>
nmap <space>x <C-w>x
nmap <space>z :wqa <CR>
nmap <space>w :wa <CR>
nmap <space>c :ClangFormat<CR>
nmap <space>b :call bible#insert_quote()<CR>
nmap <space>L :w<CR>:!pdflatex "%" && rm "%":r.log && rm "%":r.aux<CR><CR>
nmap <space>P :!zathura --fork "%:r.pdf" &> /dev/null<CR><CR>
nmap <space>b :Black<CR>

"   Maps
map <C-l> :tabn<CR>
map <C-h> :tabp<CR>
nmap <C-k> i$$<ESC>ha
imap <C-k> $$<ESC>ha
map <C-s> :!sleep 2s && grim -g "$(slurp)" -t jpeg<CR>
nmap 'g G
nnoremap <C-c> "+y
vnoremap <C-c> "+y

"   Markdown Settings/Autocmd
autocmd BufWinLeave *.md | :! killall qutebrowser
autocmd BufNewFile,BufRead *.md Goyo
autocmd BufNewFile,BufRead *.md set filetype=markdown
autocmd FileType markdown set cursorline
autocmd FileType markdown set wrap
autocmd FileType markdown set spell spelllang=en_us
autocmd FileType markdown set linebreak
autocmd FileType markdown set expandtab
autocmd FileType markdown set tabstop=2
autocmd FileType markdown set shiftwidth=2
autocmd FileType markdown set scrolloff=12
autocmd FileType markdown set conceallevel=2

"   LaTeX Settings/Autocmd
autocmd BufNewFile,BufRead *.tex Goyo
autocmd BufNewFile,BufRead *.tex set filetype=tex
autocmd FileType tex,latex set cursorline
autocmd FileType tex,latex set wrap
autocmd FileType tex,latex set spell spelllang=en_us
autocmd FileType tex,latex set linebreak
autocmd FileType tex,latex set expandtab
autocmd FileType tex,latex set tabstop=2
autocmd FileType tex,latex set shiftwidth=2
autocmd FileType tex,latex set scrolloff=12
autocmd FileType tex,latex set conceallevel=2

"   Plugins
"   If vim plug not installed
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
    Plug 'godlygeek/tabular' | Plug 'plasticboy/vim-markdown'
    Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
    Plug 'junegunn/goyo.vim'
    Plug 'lambdalisue/fern.vim'
    Plug 'preservim/nerdtree'
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
    Plug 'dbeniamine/todo.txt-vim'
    Plug 'robertrosman/vim-bible'
    Plug 'dmerejkowsky/vim-ale'
    Plug 'rhysd/vim-clang-format'
    Plug 'psf/black'
    Plug 'kkoomen/vim-doge', { 'do': { -> doge#install() } }
    Plug 'fadein/vim-FIGlet'
    Plug 'morhetz/gruvbox'
    Plug 'lervag/vimtex'
    Plug 'sainnhe/gruvbox-material'
    Plug 'yuttie/comfortable-motion.vim'
    Plug 'dpelle/vim-LanguageTool'
    Plug 'kien/ctrlp.vim'
    Plug 'tpope/vim-fugitive'
    Plug 'direnv/direnv.vim'
    Plug 'stevearc/vim-arduino'
call plug#end()

"Markdown Plugin Stuff
"let g:mkdp_browser = 'qutebrowser'
let g:mkdp_browser = 'firefox'
let g:mkdp_auto_close = 1
let g:vim_markdown_folding_disabled = 1
let g:mkdp_preview_options = {
    \ 'mkit': {},
    \ 'katex': {},
    \ 'uml': {},
    \ 'maid': {},
    \ 'disable_sync_scroll': 0,
    \ 'sync_scroll_type': 'middle',
    \ 'hide_yaml_meta': 1,
    \ 'sequence_diagrams': {},
    \ 'flowchart_diagrams': {},
    \ 'content_editable': v:false,
    \ 'disable_filename': 0
    \ }

"   fzf Maps
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit' }

"   Fern Maps
function! s:init_fern() abort
  nmap <buffer> o <Plug>(fern-action-open)
  nmap <buffer> t <Plug>(fern-action-open:tabedit)gT
  nmap <buffer> S <Plug>(fern-action-open:split)
  nmap <buffer> V <Plug>(fern-action-open:vsplit)
  nmap <buffer> n <Plug>(fern-action-new-path)
  nmap <buffer> dd <Plug>(fern-action-remove)
  nmap <buffer> m <Plug>(fern-action-move)
  nmap <buffer> c <Plug>(fern-action-copy)
endfunction

augroup fern-custom
  autocmd! *
  autocmd FileType fern call s:init_fern()
augroup END

"   Todo Settings/Autocmd
let g:TodoTxtForceDoneName='done.txt'
autocmd BufNewFile,BufRead in.todo.txt set filetype=todo
autocmd BufNewFile,BufRead projects.todo.txt set filetype=todo
autocmd BufNewFile,BufRead next-actions.todo.txt set filetype=todo
autocmd BufNewFile,BufRead waiting.todo.txt set filetype=todo
autocmd BufNewFile,BufRead *.project.todo.txt set filetype=todo
autocmd BufNewFile,BufRead *.todo.txt set filetype=todo
autocmd FileType todo Goyo
autocmd FileType todo set cursorline
autocmd FileType todo set wrap
autocmd FileType todo set spell spelllang=en_us
autocmd FileType todo set linebreak
autocmd FileType todo set expandtab
autocmd FileType todo set tabstop=2
autocmd FileType todo set shiftwidth=2
autocmd FileType todo set scrolloff=12
autocmd FileType todo set conceallevel=2
"autocmd BufNewFile,BufRead todo.txt Goyo

"   Bible Plugin
let g:BibleTranslation = "NASB"

"   VimTex Plugin
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode=0
set conceallevel=1
let g:tex_conceal='abdmg'

"   Gruvbox Plugin
"let g:gruvbox_guisp_fallback = "bg"
let g:gruvbox_italic=1
let g:gruvbox_bold=1
let g:gruvbox_underline=1
let g:gruvbox_italicize_strings=1
let g:gruvbox_improved_warnings=1

let g:clang_format#auto_format = 1
let g:clang_format#code_style = 'google'
let g:clang_format#style_options = {
    \ "IndentWidth" : 4,
    \ "TabWidth" : 4}

let g:python_indent = '    '
let g:python_style = 'google'

" ale
let g:ale_fix_on_save = 1
let g:ale_linters_explicit = 1
"let g:ale_lint_on_text_changed = 'never'
let g:ale_fixers = {
\   'python': ['black', 'isort'],
\   'c': ['clang-format'],
\   'cpp': ['clang-format'],
\}

let g:ale_linters = {
\   'c': ['gcc'],
\   'python': ['pylint'],
\}

let g:ale_c_clangformat_options = "IndentWidth: 4"

let g:doge_doc_standard_python = 'sphinx'

colorscheme gruvbox

set term=xterm-256color

" fixes background disappearing when scrolling
let &t_ut=''
