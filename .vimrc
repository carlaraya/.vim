set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'slim-template/vim-slim.git'
Plugin 'qpkorr/vim-bufkill'

call vundle#end()
filetype plugin indent on 

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file (restore to previous version)
  set undofile		" keep an undo file (undo changes after closing)
endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  " autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") >= 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

if has('langmap') && exists('+langnoremap')
  " Prevent that the langmap option applies to characters that result from a
  " mapping.  If unset (default), this may break plugins (but it's backward
  " compatible).
  set langnoremap
endif


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""MY STUFF""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has('win32') || has('win64')
    au GUIEnter * simalt ~x                            " Start vim on fullscreen
endif
"set number                                                   " Add line numbers
set backupdir=~/.tmp                                         " Set backup folder
set undodir=~/.tmp                                             " Set undo folder
set linebreak           " use 'breakat' characters instead of just the last char

set tabstop=4                                              " Set Tab to 4 spaces
set shiftwidth=4                                " Protip: enter :retab to change
set expandtab                                " tab to 4 spaces in current buffer

set splitright                           " Set new split to right when doing :sp
"set visualbell                        " Use visual error notifs instead of beep
"set noerrorbells                                                   " Don't beep
let g:netrw_sort_options = "i"                  " Netrw case-insensitive sorting

set laststatus=2 
set statusline=%F%m%r%h%w\ [CHAR=\%03.3b\|0x\%02.2B]\
            \[POS=%04l,%04v,%p%%]\[LEN=%L]       " Useful info on the statur bar
"\ [FRMT=%{&ff}]\[TYP=%Y]\                   " might be useful later but not now

set autochdir   " Automatically set working directory to be same as current file

"autocmd vimenter * NERDTree
autocmd VimEnter * if argc() | wincmd p | endif

autocmd FileType ruby setlocal shiftwidth=2 tabstop=2
autocmd FileType eruby setlocal shiftwidth=2 tabstop=2
autocmd FileType haml setlocal shiftwidth=2 tabstop=2
"autocmd FileType slim setlocal shiftwidth=2 tabstop=2
autocmd FileType html setlocal shiftwidth=2 tabstop=2

let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""MY REMAPS"""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Switch to prev and next buffer
nnoremap <silent> <Tab> :bnext<Enter>
nnoremap <silent> <S-Tab> :bprevious<Enter>

" Just do i<c-c>293+618<enter>, for example hehe (and type :help function-list
" to get help with your functions
inoremap <silent> <C-C> <C-R>=string(eval(input("Calculate: ")))<CR>

" Use comma as mapleader instead of backward slash
let mapleader = ","
noremap \ ,
noremap , \

" j and k no longer jump wrapped lines
nnoremap j gj
nnoremap k gk

" Easy window navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Remove the red highlights
nmap <silent> <leader>/ :nohlsearch<CR>

" Arrow keys to change window size
nnoremap <up>    <C-W>+
nnoremap <down>  <C-W>-
nnoremap <left>  <C-W><
nnoremap <right> <C-W>>

" Enter makes a new empty line
nnoremap <silent> <CR> o<Esc>

" Ctrl left/right selects prev/next tab
nnoremap <C-Left> :tabprevious<CR>
nnoremap <C-Right> :tabnext<CR>

" Alt left/right moves curr tab left/right
nnoremap <silent> <A-Left> :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>
nnoremap <silent> <A-Right> :execute 'silent! tabmove ' . tabpagenr()<CR>

" Move to nerdtree (assuming it's in leftmost)
"nnoremap <silent> <leader><Space> <C-w>50h

" https://github.com/qpkorr/vim-bufkill
nnoremap :BD <leader>bd
