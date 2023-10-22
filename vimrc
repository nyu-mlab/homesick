" Modeline magic
" vim: set foldmethod=marker foldminlines=5:

set nocompatible                " be iMproved, required

let g:ale_completion_enabled=1  " set this before loading ALE
let g:ale_set_balloons='hover'  " 'hover' or 1 or 0


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  => Vundle packages
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable filetype plugins
filetype plugin indent on  " enable file type detection


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  => Put non-Vundle stuff after this line
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" FZF plugin for fuzzy search
"FIXME: set rtp+=$HOME/.fzf/bin/fzf
"OPTIONAL: packadd! copilot.vim


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  Table of Contents
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" - General
" - VIM user interface
" - Colors and Fonts
" - Files, backups and undo
" - Text, tab and indent related
" - Moving around, tabs, windows and buffers
" - Status line
" - Omni complete functions
" - Custom Mappings
" - Package Configurations
"



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" {{{
" Set how many lines of history VIM has to remember
set history=1024

" Reload file when it's changed from the outside
set autoread  " type ':e' to force reload NOW

" FIXME: GO-SECTION-IS-OUTDATED
" configs 'golint'
" not using GoLang recently
"set rtp+=$GOPATH/src/golang.org/x/lint/misc/vim
" automatically run 'golint' on save

" configs 'goimports'
"set gofmt_command='goimports'

" Set UTF-8 as standard encoding
set encoding=utf-8
scriptencoding utf-8

" Speed up {Insert-mode}-><Esc>->{Normal-mode}
" or else Ctrl-c is needed for faster transition
"set noesckeys  " disables direction keys and home/end
set timeout timeoutlen=1000 ttimeoutlen=50
" }}}



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" {{{
" Turn on the Wild menu
set wildmenu
set wildmode=longest,list

" Ignore compiled files
set wildignore=*.o,*~,*.pyc,*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store

" Shows absolute and relative line numbers (hybrid mode)
set number relativenumber

augroup LineNumberMode
    autocmd!
    autocmd BufEnter,InsertLeave * let &l:relativenumber = &l:number && 1 | setlocal list
    autocmd BufLeave,InsertEnter * let &l:relativenumber = &l:number && 0 | setlocal nolist
augroup END

" Highlight current line, but only in active window
augroup CursorLineOnlyInActiveWindow
    autocmd!
    autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline | setlocal cursorcolumn
    autocmd WinLeave * setlocal nocursorline | set nocursorcolumn
augroup END

" Hides mode message on the last line
set noshowmode

" Automatically set current directory to directory of last opened file
set autochdir

" Confirms file operation
set confirm

" A buffer becomes hidden when it is abandoned
set hidden

set backspace=indent,eol,start

" This setting makes search case-insensitive when all characters in the string
" being searched are lowercase. However, the search becomes case-sensitive if
" it contains any capital letters. This makes searching more convenient.
set ignorecase
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch

" Don't redraw while executing macros (good performance config)
set lazyredraw

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch

" Highlights the textline of the cursor
set cursorline
set cursorcolumn

" Enables mouse mode in Visual and Normal
set mouse=vn  " includes insert mode and other stuff

" Unbind some useless/annoying default key bindings.
" 'Q' in normal mode enters Ex mode. You almost never want this.
nmap Q <Nop>
map <C-a> <Nop>

" Prevents words be split across lines
set linebreak

" Show lines above and below cursor (when possible)
set scrolloff=5

" Highlight trailing whitespace and tabs
highlight ExtraWhitespace ctermbg=red guibg=red
augroup TrailingSpaces
    autocmd!
    autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
    autocmd BufWinEnter * match ExtraWhitespace /\s\+$\| \+\ze\t\+|\t\+\zs \+/
augroup END

" Automatically set current directory to directory of last opened file
set autochdir

" Render tabs and non-breakable spaces
set list
set listchars=tab:>-,space:·,nbsp:~

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" Suppress inserting two spaces between sentences
set nojoinspaces

" Disable folding by default
set nofoldenable
" }}}


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" {{{
" Enable syntax highlighting
"syntax on  overrules my settings
syntax enable  " keeps my settings

" Enable 256 colors palette
" NOTE: UNCOMMENT IF COLOR SCHEME LOOKS WRONG
" NOTE: should be set by env var: TERM
"set t_Co=256

set background=dark
try
    packadd! gruvbox
    let g:gruvbox_contrast_dark='hard'
    colorscheme gruvbox

    "packadd! onedark.vim
    "colorscheme onedark

    "packadd! vim-colors-solarized
    "let g:solarized_termcolors=256
    "colorscheme solarized
catch
endtry

highlight SpellBad cterm=inverse
highlight SpellBad ctermfg=131

" Use Unix as the standard file type
set ffs=unix,dos,mac
" }}}



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" {{{
augroup FileWritebackSettings
    autocmd!
    " Don't write backfile if vim is being called by 'crontab -e'
    autocmd BufWrite /private/tmp/crontab.* set nowritebackup nobackup
    " Don't write backup file if vim is being called by 'chpass'
    autocmd BufWrite /private/etc/pw.* set nowritebackup nobackup
    " Don't save mistakenly overwrite encrypted file with wrong password
    au BufWinEnter * if &key!="" | cnoremap wq if input("Sure of quitting encrypted file? (yes or no)") == "yes"\|wq\|endif|endif

augroup END
" }}}



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" {{{
" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab = 4 spaces
set shiftwidth=4
set tabstop=4
set softtabstop=4

set autoindent
set smartindent
" }}}



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" {{{
augroup RestoreCursorPosition
    autocmd!
    " Return to last edit position when opening files (You want this!)
    " Skips this if I am doing a gitcommit
    autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") && &filetype !=# 'gitcommit' | exe "normal! g'\"" | endif
augroup END
" }}}



"""""""""""""""""""""""""""""""
"  => Status line
"""""""""""""""""""""""""""""""
" {{{
" Always show status line
set laststatus=2
" }}}



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  => Omni complete functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" {{{
set omnifunc=ale#completion#OmniFunc
let g:ale_completion_max_suggestions=10
" }}}



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" {{{
function SignColumn_toggle() abort
    if &l:number
        setlocal signcolumn=auto
    else
        setlocal signcolumn=no
    endif
endfunction
" }}}



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  => Custom Mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" {{{
" Remap leader
"OPTIONAL: let mapleader=";"

" Another route for ESC
inoremap jj <Esc>

" LEARN VIM
noremap <up> <nop>
noremap <down> <nop>
noremap <left> <nop>
noremap <right> <nop>

" Toggle display settings for text-copying
" => NOTE: Toggles line-number column, sign column, and special characters together
" => NOTE: signcolumn settings shadow GitGutter-column settings
nnoremap <C-n> :setlocal number! <bar> let &l:relativenumber = &l:number <bar> call SignColumn_toggle() <CR>

" Enable TAB-completion instead of just C-o/C-n/C-p
inoremap <silent> <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <silent> <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Buffer splitting alias (always creating a new window with it)
" => vertical
nnoremap <C-b>\| :vnew <CR>
" => horizontal
nnoremap <C-b>_ :new <CR>
" => close
nnoremap <C-b>w :bdelete <CR>

" Window splitting alias
" => vertical
nnoremap <C-w>\| :vsplit <CR>
" => horizontal
nnoremap <C-w>_ :split <CR>
" => close
nnoremap <C-w>w :close <CR>

" Move lines up and down (HACK: cannot make the macOS built-in terminal send
" Alt-j/k properly so use special symbols instead to avoid the meta key problem)
nnoremap ∆ :m .+1<CR>==
nnoremap ˚ :m .-2<CR>==

" pkg:: ALE
nnoremap <C-f> :ALEFix <CR>

" pkg:: FZF.vim
" => [ Find in this File ]: Search text in the current buffer
nnoremap <Leader>ff       :BLines   <CR>
" => [ Find All ]: Search everything in every file
nnoremap <Leader>fa       :Rg       <CR>
" => [ ls ]: File name search
nnoremap <Leader>ls       :Files    <CR>
" => [ Git history in this File ]: Git commits in the current buffer
nnoremap <Leader>gf       :BCommits <CR>
" => [ Git history of All files ]: Git commits
nnoremap <Leader>ga       :Commits  <CR>
" command! -bar GitStatus :GFiles?

" pkg:: NERDTree
nnoremap <C-t> :NERDTreeToggle <CR>

" pkg:: Tagbar
nnoremap <C-o> :TagbarToggle <CR>

" pkg:: UndoTree
nnoremap <C-u> :UndotreeToggle<CR>
" }}}



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  => Package Configurations
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" {{{
""""""""""""""""""""""""""""
"  pkg:: Airline
""""""""""""""""""""""""""""
" {{{
" FIXME: let g:airline_extensions = []
let g:airline_theme='dark'
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts=($TERM_PROGRAM ==# 'iTerm.app')
" BUG: FIXME: default section_z setting is acting weird
" %3p%% %#__accent_bold#%{g:airline_symbols.linenr}%4l%#__restore__#%#__accent_bold#/%L%{g:airline_symbols.maxlinenr}%#__restore__# :%3v
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_symbols.linenr    = '  '
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.colnr     = '  :'
" }}}


""""""""""""""""""""""""""""
"  pkg:: GitGutter
""""""""""""""""""""""""""""
" {{{
" Set gutter update frequency
set updatetime=200

" Disable all key mappings
let g:gitgutter_map_keys=0
" }}}


""""""""""""""""""""""""""""
"  pkg:: Tagbar
""""""""""""""""""""""""""""
" {{{
" Sort tags according to position in file
let g:tagbar_sort=0
" }}}


""""""""""""""""""""""""""""
"  pkg:: NerdTree
""""""""""""""""""""""""""""
" {{{
augroup NerdTree_AutoCloseNerdTreeIfIsLastWindow
    " Close the tab if NERDTree is the only window remaining in it.
    autocmd!
    autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
augroup END
" Single click will open directories, double click to open files
let NERDTreeIgnore=['\.pyc$', '__pycache__', '.DS_Store']
let NERDTreeMouseMode=2
let NERDTreeShowHidden=1
let NERDTreeWinSize=24
" }}}


""""""""""""""""""""""""""""
"  pkg:: NerdCommenter
""""""""""""""""""""""""""""
" {{{
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims=1
" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs=1

" USAGE:
"--------------------------
" while default <leader> is '\'
"
" COMMENT:      cc
"   use '[number of lines]<leader>cc' to comment the current line
"
" SEXY COMMENT: cs
"   use '[number of lines]<leader>cs' for pretty formatted comments
"
" UNCOMMENT:    cu
"   use '[number of lines]<leader>cu' to uncomment the selected lines
"
" TOGGLE:       ci
"   use '[number of lines]<leader>ci' to toggle individual line comment state
" }}}


""""""""""""""""""""""""""""
"  pkg:: vim-go
""""""""""""""""""""""""""""


""""""""""""""""""""""""""""
"  pkg:: vim-fugitive
""""""""""""""""""""""""""""
set tags^=.git/tags;~


""""""""""""""""""""""""""""
"  pkg:: ALE
""""""""""""""""""""""""""""
" {{{
let g:ale_sign_column_always=0

let g:ale_sign_info='+'
let g:ale_sign_error='X'
let g:ale_sign_warning='Δ'
let g:ale_sign_style_warning='∅'
let g:ale_sign_style_error='⊗'

" set default height of the error window
let g:ale_list_window_size=3

" ALE:AirLine integration
let g:airline#extensions#ale#enabled = 1

" ALE:Linter Settings
" FIXME: 'cc' for c and cpp does not work well with embedded-system
" cross-compiling projects
let g:ale_linters={
\   'c':      ['cc', 'clangd', 'clangtidy'],
\   'cpp':    ['cc', 'clangd', 'clangtidy', 'clangcheck'],
\   'cuda':   ['clangd'],
\   'go':     ['gofmt', 'golint', 'gopls', 'govet', 'gobuild', 'gotype'],
\   'python': ['pylint', 'mypy', 'pyre'],
\   'rust':   ['analyzer', 'rustc', 'cargo'],
\   'swift':  ['sourcekitlsp', 'apple-swift-format'],
\   'verilog':['verilator'],
\}

" lang:GO: `gofmt`, `golint` and `go vet` are enabled at default
" TODO: enable gotype

" ALE:Fixer Settings
"   NOTE: evaluation: maps to filetype name, runs all, from left to right
let g:ale_fixers={
\   'bzl': ['buildifier'],
\   'c':     ['clangtidy', 'clang-format'],
\   'cpp':   ['clang-format'],
\   'css':   ['prettier'],
\   'cuda':  ['clang-format'],
\   'go':    ['goimports', 'gofmt'],
\   'html':  ['prettier'],
\   'javascript': ['eslint'],
\   'javascriptreact': ['eslint'],
\   'typescript': ['eslint'],
\   'typescriptreact': ['eslint'],
\   'json':  ['prettier'],
\   'python':['yapf'],
\   'rust':  ['rustfmt'],
\   'swift': ['apple-swift-format'],
\}

" C/C++ settings

" project
let g:ale_c_build_dir_names=['.', 'build']
let g:ale_c_parse_compile_commands=1
let g:ale_c_parse_makefile=0

" compiler
let g:ale_c_cc_executable   ='clang'
let g:ale_cpp_cc_executable ='clang++'
let g:ale_c_cc_options   ='-std=c17   -Wall -Wextra -pedantic'
let g:ale_cpp_cc_options ='-std=c++17 -Wall -Wextra -pedantic'

" clangd
" TODO: decide whether to install the entire llvm suite and change this to a
" homebrew path
let g:ale_c_clangd_executable   =system("which clangd | tr -d '\n'")
let g:ale_cpp_clangd_executable =system("which clangd | tr -d '\n'")
let g:ale_c_clangd_options   ='--clang-tidy'
let g:ale_cpp_clangd_options ='--clang-tidy'

" clang-format
let g:ale_c_clangformat_executable =system("which clang-format | tr -d '\n'")
"let g:ale_c_clangformat_options   =''

" clang-tidy
" TODO: CHECK IF MAC_CLANGD COVERS CLANG-TIDY FUNCTIONS:
let g:ale_c_clangtidy_executable   =system("which clang-tidy | tr -d '\n'")
" TODO: CHECK IF MAC_CLANGD COVERS CLANG-TIDY FUNCTIONS:
let g:ale_cpp_clangtidy_executable =system("which clang-tidy | tr -d '\n'")
"let g:ale_c_clangtidy_checks   =[]
"let g:ale_cpp_clangtidy_checks =[]
"let g:ale_c_clangtidy_options   =''
"let g:ale_cpp_clangtidy_options =''
"let g:ale_c_clangtidy_extra_options   =''
"let g:ale_cpp_clangtidy_extra_options =''
let g:ale_c_clangtidy_fix_errors   =0
let g:ale_cpp_clangtidy_fix_errors =0

" go
let g:ale_go_golint_executable ='$GOPATH/bin/golint'
"g:ale_go_golint_options
let g:ale_go_gopls_executable  ='$GOPATH/bin/gopls'
"g:ale_go_gopls_options
let g:ale_go_goimports_executable  ='$GOPATH/bin/goimports'
"ale_go_goimports_options

" swift
let g:ale_sourcekit_lsp_executable =system("which sourcekit-lsp | tr -d '\n'")

" rust
let g:ale_rust_analyzer_executable =system("rustup which --toolchain stable rust-analyzer | tr -d '\n'")
" }}}


""""""""""""""""""""""""""""
"  pkg:: vim-wakatime
""""""""""""""""""""""""""""



" }}}
let g:gruvbox_improved_warnings=1
