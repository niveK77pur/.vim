"" Check what other interesting things there are to add here
"" http://stackoverflow.com/questions/164847/what-is-in-your-vimrc

"~~~~~~~~~~~~~~~~~~
"     Plugins      
"~~~~~~~~~~~~~~~~~~
" hand-made {{{
"set runtimepath+=$HOME/.vim/bundle/nerdtree/
"set runtimepath+=$HOME/.vim/bundle/auto-pairs/
" }}}

" Vundle {{{
set nocompatible        " be iMproved, required
filetype off            " required
set runtimepath+=$HOME/.vim/bundle/Vundle.vim
call vundle#begin()
  " let Vundle manage Vundle
Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'jiangmiao/auto-pairs'
Plugin 'vim-syntastic/syntastic'
Plugin 'junegunn/goyo.vim'
call vundle#end()
" }}}

" Pathogen"{{{
"source ~/.vim/autoload/vim-pathogen/autoload/pathogen.vim
"execute pathogen#infect()
" }}}



" Basic Settings {{{1

"~~~~~~~~~~~~~~~~
"     Files      {{{
"~~~~~~~~~~~~~~~~
syntax on
filetype plugin indent on
set autowrite
"}}}

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"     Colorschemes for vim      {{{
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"" Available colorschemes can be found in /usr/share/vim/vim74/colors/
"colorscheme pablo
colorscheme ron "default
"colorscheme morning
"colorscheme shine
"colorscheme koehler
"}}}

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"     Options for indentation      {{{
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
set autoindent
"set tabstop=4
set shiftwidth=0
set softtabstop=-1
set expandtab
"}}}

"~~~~~~~~~~~~~~~~~~~~
"     Interface      {{{
"~~~~~~~~~~~~~~~~~~~~
set mouse=a         "Enable mouse support
set relativenumber  "Relative numbering
"set numberwidth=3
set linebreak       "Line wrapping at a character
set showcmd
set wildmenu
set listchars=eol:¶,tab:>-,space:∙,trail:˛,extends:>,precedes:§
" status line set up {{{
" see :h stl
set laststatus=2        " show statusline: always
set statusline=%<       " truncate long lines
set stl+=%F             " Name of the file
set stl+=%=             " left and right side
set stl+=\ %m           " modified flag
set stl+=\ %Y           " FileType in the buffer
set stl+=\ %03l/%L      " current line and total lines
set stl+=,%02c          " column number
set stl+=%V             " Virtual column number (not displayed if equal to %c)
set stl+=\ %P
" }}}
"}}}

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"     Settings for auto-completion      {{{
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
set ignorecase  " \c -- like ignore case is on, \C -- force matching case
set noinfercase
"}}}

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"     Encryption settings      {{{
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"use [:setlocal cm?] to show encryption for the current file
setlocal cm=blowfish2  "encryption method unknown to gvim portable (for now)
"}}}

"}}}1

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"     Custom shortcuts keys      
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" use <option>! to toggle (if boolean)
" Mappings {{{
let mapleader='ö'       "mapleader for <Leader>
let maplocalleader='ü'

"Toggle NERDTree {{{
nnoremap <leader>nn :NERDTreeToggle <CR>
nnoremap <leader>nb :NERDTreeFocus <CR> :BookmarkToRoot 
" }}}

" Quickly edit vimrc file"{{{
"vimrc: edit
nnoremap <leader>ve :vsplit $MYVIMRC<CR>
"vimrc: source (immediately take effect of changes)
nnoremap <leader>vs :w<CR>:source $MYVIMRC<CR>
"}}}

"Toggle highlighting stuff"{{{
noremap <Leader>hs :set hlsearch! hlsearch? <CR>
noremap <Leader>hl :set cursorline! cursorline? <CR>
noremap <Leader>hc :set cursorcolumn! cursorcolumn? <CR>
function! ToggleFoldcolumn() "{{{ See :h E124
    if &foldcolumn ==# 0
        set foldcolumn=4
    else
        set foldcolumn=0
    endif
endfunction "}}}
noremap <Leader>hf :call ToggleFoldcolumn() <CR>
"}}}

"Toggle number and relativenumber
noremap <F3> :set relativenumber! number! relativenumber? <CR><ESC>

"Toggle line wrapping
noremap <F5> :set wrap! wrap? <CR>

" exit insert mode more comfortably
inoremap jk <Left><esc> 

" see tabs, spaces and what have you
nnoremap <Leader>l :set list! list? <CR>
inoremap <Leader>l <ESC>:set list! list? <CR>a

noremap <F6> :echo "\\°O°/" <CR>

"}}}

"~~~~~~~~~~~~~~~~~~~~~~~~
"     abbreviations     
"~~~~~~~~~~~~~~~~~~~~~~~~
" Command-line mode
cabbrev Wq wq
cabbrev W w
cabbrev Q q
" Insert mode
"for local abbreviations see
" :h :abbreviate-local


"~~~~~~~~~~~~~~~~~~~~~~~
"     autocommands      
"~~~~~~~~~~~~~~~~~~~~~~~
" Vimscript file settings ---------------------- {{{
augroup filetype_vim
        autocmd!
        autocmd FileType vim setlocal foldmethod=marker
augroup END
" }}}

" compiling source code "{{{
function! RunMessage()
        !$HOME/bin/draw_center_text.sh "Running program"
endfunction
augroup compile_source
        au!
        au FileType,BufEnter * nnoremap <Leader>m :make<CR>
        au FileType python nnoremap <buffer> <LocalLeader>r :!python3 % <CR>
        au FileType bash   nnoremap <buffer> <LocalLeader>r :.% <CR>
        au FileType pascal nnoremap <buffer> <LocalLeader>r :!fpc -ovimPasEXE % ; echo -e "\e[44m Running program ...\e(B\e[m"; ./vimPasEXE <CR>
        au FileType tex    nnoremap <buffer> <LocalLeader>r :!pdflatex %; evince %:s?\.tex?\.pdf? <CR>
        au FileType markdown nnoremap <buffer> <LocalLeader>r :!retext --preview %<CR>
        au FileType cpp    nnoremap <buffer> <LocalLeader>r :!g++ -o vim-a.out % ; draw_center_text.sh "Running program"; ./*.out<CR>
        "au FileType cpp    nnoremap <buffer> <LocalLeader>r :!g++ -o a.out % ; draw_center_text.sh "Running program"; ./*.out<CR>
        au FileType sh     nnoremap <buffer> <LocalLeader>r :!./%<CR>
augroup END
"}}}
" clean up "{{{
augroup clean_compiled_source
        au!
        au BufEnter *.cpp let cpp_opened = 1
        au BufEnter *.pas let pas_opened = 1
        
        au VimLeave * call CleanCompiledSource()
        "au VimLeave * if exists("pas_opened") | !rm vimPasEXE | endif
        "au VimLeave * if exists("cpp_opened") | !rm vim-a.out | endif
augroup END

function! CleanCompiledSource() 
        if exists("pas_opened") == 0
                !rm vimPasEXE
        endif
        if exists("cpp_opened") == 0
                !rm vim-a.out
        endif
endfunction
" }}}"

" FileType-Specific Settings"{{{
" also see the '.vim/ftplugin' and the '.vim/after/ftplugin' directories
" filetype commenting {{{
augroup ft_commenting
        au!
        au FileType python nnoremap <buffer> <LocalLeader>c I#<ESC> 
        au FileType bash   nnoremap <buffer> <LocalLeader>c I#<ESC> 
        au FileType pascal nnoremap <buffer> <LocalLeader>c I//<ESC> 
        au FileType vim    nnoremap <buffer> <LocalLeader>c I"<ESC>
        au FileType tex    nnoremap <buffer> <LocalLeader>c I%<ESC>
        au FileType cpp    nnoremap <buffer> <LocalLeader>c I//<ESC>
augroup END
"}}}

" colons {{{
augroup put_semicolon
        autocmd!
        au FileType,BufRead pascal,cpp inoremap <buffer> <LocalLeader>, <ESC>A;
        au FileType,BufRead pascal,cpp nnoremap <buffer> <LocalLeader>, <ESC>A;<ESC>
augroup END
" }}}

" print me!{{{
augroup print_me
        au!
        au FileType python nnoremap <buffer> <LocalLeader>p Iprint(<ESC>A)<ESC>
        au FileType python inoremap <buffer> <LocalLeader>p <ESC>Iprint(<ESC>A)
augroup END
" }}}

" templates "{{{
augroup script_templates
        "insert templete on :new *.filetype
        autocmd!
        au BufNewFile *.pas 0r $HOME/.vim/skeletons/Pascal/
        au BufNewFile *.py  0r $HOME/.vim/skeletons/Python/
augroup END
"}}}

" }}}


"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"     Learn Vimscript the Hard Way      
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" Find the book at http://learnvimscriptthehardway.stevelosh.com/
" This section is meant to do the exercices in the book
"source $HOME/.vim/Vimscript_Exercises/List_of_exercises.vim
" open 'Ex_list.vim' where the exercises are sourced
"nnoremap <Leader>e :vsplit $HOME/.vim/Vimscript_Exercises/List_of_exercises.vim <CR>
"nnoremap <Leader>m :w <CR> :source % <CR>
