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
if !isdirectory($HOME . "/.vim/bundle/Vundle.vim")
        echom "Setting up ~/.vim/bundle/ directory and Vundle."
        !mkdir -p $HOME/.vim/bundle
        !git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
endif
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
        Plugin 'tpope/vim-surround'
        "Plugin 'suan/vim-instant-markdown'
        Plugin 'thinca/vim-localrc'
        Plugin 'terryma/vim-multiple-cursors'
call vundle#end()
" }}}

" Pathogen"{{{
"source ~/.vim/autoload/vim-pathogen/autoload/pathogen.vim
"execute pathogen#infect()
" }}}


"~~~~~~~~~~~~~~~~~~~~~~~~
"     Basic Settings
"~~~~~~~~~~~~~~~~~~~~~~~~

" ~~~ Files ~~~ "{{{
"add lilypond filetype plugin
filetype off
set runtimepath+=/usr/share/lilypond/2.18.2/vim/

syntax on
filetype plugin indent on
set autowrite
"}}}

" ~~~ Spell Check ~~~ {{{
set spellfile+=~/.vim/spell/en.uft-8.add
"}}}

" ~~~ Cholorschemes for vim ~~~ {{{
"" Available colorschemes can be found in /usr/share/vim/vim74/colors/
"colorscheme pablo
colorscheme ron "default
"colorscheme morning
"colorscheme shine
"colorscheme koehler
"}}}

" ~~~ Options for indentation ~~~ {{{
set autoindent
"set tabstop=4
set shiftwidth=0
set softtabstop=-1
set expandtab
"}}}

" ~~~ Interface ~~~ {{{
set mouse=a         "Enable mouse support
set relativenumber  "Relative numbering
"set numberwidth=3
set linebreak       "Line wrapping at a character
set showcmd
set wildmenu
try
        set listchars=eol:¶,tab:>-,space:∙,trail:˛,extends:>,precedes:§
catch /^Vim\%((\a\+)\)\=:E474/
endtry
 
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

" ~~~ Settings for auto-completion ~~~ {{{
set ignorecase  " \c -- like ignore case is on, \C -- force matching case
set noinfercase
"}}}

" ~~~ Encryption settings ~~~ {{{
"use [:setlocal cm?] to show encryption for the current file
if has('crypt-blowfish2')
        set cryptmethod=blowfish2  "encryption method unknown to gvim portable (for now)
elseif has('crypt-blowfish')
        set cryptmethod=blowfish
endif
"}}}

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"     Custom shortcuts keys      
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" use <option>! to toggle (if boolean)
" Mappings {{{
let mapleader='é'       "mapleader for <Leader>
let maplocalleader='è'

"Toggle NERDTree {{{
nnoremap <leader>nn :NERDTreeToggle <CR>
nnoremap <leader>nb :NERDTreeFocus <CR> :BookmarkToRoot 
" }}}

" Quickly edit vimrc file"{{{
"vimrc: edit
nnoremap <leader>ve :vsplit $MYVIMRC<CR>
"vimrc: source (immediately take effect of changes)
nnoremap <leader>vs :w<CR>:source $MYVIMRC<CR>
"nnoremap <Leader>vm :source $MYVIMRC<CR>
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

" save and reload files
inoremap <Leader>s <c-o>:wa<CR>
nnoremap <Leader>s :wa<CR>
inoremap <Leader>e <c-o>:e<CR>
nnoremap <Leader>e :e<CR>
" source vim files
inoremap <Leader>S <ESC>:wa<CR>:source %<CR>
nnoremap <Leader>S :wa<CR>:source %<CR>
 
" jump to next [>VIM<] tag
inoremap <Leader><space> <ESC>/\[>VIM<\]<CR>v//e<CR>s
nnoremap <Leader><space> /\[>VIM<\]<CR>v//e<CR>s

" insert a [>VIM<] to jump to
inoremap <Leader>j [>VIM<]

" toggle Syntastic 
nnoremap <F4> :SyntasticToggleMode<CR>

noremap <F6> :echo "\\°O°/" <CR>

"}}}

"~~~~~~~~~~~~~~~~~~~~~~~~
"     abbreviations     
"~~~~~~~~~~~~~~~~~~~~~~~~
" Command-line mode
cabbrev Wq wq
cabbrev WQ wq
cabbrev W w
cabbrev Q q
" Insert mode
"for local abbreviations see
" :h :abbreviate-local

"~~~~~~~~~~~~~~~~~~~
"     commands      
"~~~~~~~~~~~~~~~~~~~

" set the b:comment_character variable below in the 
" below variables used in respective functions
" you can also specify a buffer local variable with b:
let g:padding_amt = 5
let g:header_symbol = '~'
command! -nargs=1 MakeHeader  call MakeHeader(<args>)
command! -nargs=1 MakeSection call MakeSection(<args>)
command! -nargs=+ MakeTextAbbrevs call MakeTextAbbrevs(<f-args>)

"~~~~~~~~~~~~~~~~~~~~
"     functions     
"~~~~~~~~~~~~~~~~~~~~

function! VerifyPaddingSymbol() "{{{
        " function to be used for the below header making functions
        " checks if a buffer local version exists
        let pad_sym = [g:padding_amt, g:header_symbol]
        if exists("b:padding_amt")
                let pad_sym[0] = b:padding_amt
        endif
        if exists("b:header_symbol")
                let pad_sym[1] = b:header_symbol
        endif
        return pad_sym
endfunction
"}}}

function! GetCommentCharacter() "{{{
        if exists("b:comment_character")
                return b:comment_character
        else
                return ""
        endif
endfunction
"}}}

function! MakeHeader(text) "{{{
        let length  = strlen(a:text)
        let pad_sym = VerifyPaddingSymbol()
        let space   = ""
        let s:comment_character = GetCommentCharacter()
        let banner  = s:comment_character
        for i in range(pad_sym[0])
                let space .= " "
        endfor
        for i in range(length+2*pad_sym[0])
                let banner .= pad_sym[1]
        endfor
	set paste
        execute "normal o".banner."\r".s:comment_character.space.a:text."\r".banner."\r\e"
	set nopaste
endfunction
"}}}

function! MakeSection(text) "{{{
        let pad_sym = VerifyPaddingSymbol()
        let s:comment_character = GetCommentCharacter()
        let banner = ""
        for i in range(pad_sym[0]-2)
                let banner .= pad_sym[1]
        endfor
        execute "normal o".s:comment_character." ".banner." ".a:text." ".banner
endfunction
"}}}

" read templates from b:template_file "{{{
function! FromTemplate(tag_name)
        let line=line(".")
        echom b:template_file a:tag_name b:comment_character
        echom ".-1r! bash $HOME/.vim/scripts/FromTemplate.sh" b:template_file a:tag_name "\\" . b:comment_character
        exec  ".-1r! bash $HOME/.vim/scripts/FromTemplate.sh" b:template_file a:tag_name "\\" . b:comment_character
        call cursor(line, 0)
endfunction
"}}}

function! MakeTextAbbrevs(abbrev, ...) "{{{
        let s:abbrev = tolower(a:abbrev)
        let s:text   = tolower(join(a:000))
        let s:ABBREV = toupper(a:abbrev)
        let s:TEXT   = substitute(s:text, '\<.', '\u&', 'g')
        let s:Abbrev = substitute(s:abbrev, '\<.', '\u&', '')
        let s:Text   = substitute(s:text, '\<.', '\u&', '')
        exe "iabbrev" s:ABBREV s:TEXT
        exe "iabbrev" s:abbrev s:text
        exe "iabbrev" s:Abbrev s:Text
endfunction
"}}}

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
        
        "au VimLeave * call CleanCompiledSource()
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

" comment character for filetypes (b:comment_character) "{{{
augroup comment_char
        autocmd!
        au FileType python,bash,sh,ruby,yaml  let b:comment_character = '#'
        au FileType pascal,cpp                let b:comment_character = '//'
        au FileType vim                       let b:comment_character = '"'
        au FileType tex,plaintex,lilypond     let b:comment_character = '%'
        au FileType text,md                   let b:comment_character = ''
augroup END
"}}}

" filetype commenting {{{
augroup ft_commenting
        au!
        au FileType python,bash,ruby,yaml  nnoremap <buffer> <LocalLeader>c I#<ESC> 
        au FileType pascal,cpp             nnoremap <buffer> <LocalLeader>c I//<ESC> 
        au FileType vim                    nnoremap <buffer> <LocalLeader>c I"<ESC>
        au FileType tex,plaintex,lilypond  nnoremap <buffer> <LocalLeader>c I%<ESC>
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

"" Create a new lilypond project {{{
"function! NewLilypond()
"        let lv = system("lilypond --version | head -n 1 | awk '{ print $3 }'")
"        silent !cp $HOME/.vim/skeletons/Lilypond/newfile/* .
"        for f in systemlist("ls $HOME/.vim/skeletons/Lilypond/newfile/")
"                execute 'silent !sed "1s/\(.\+\s\).*/\1\"hello\"/"' f '>' f
"        endfor
"        unlet lv
"endfunction
"" }}}

" templates/new files "{{{
augroup script_templates
        "insert templete on :new *.filetype
        autocmd!
        au BufNewFile *.pas 0r $HOME/.vim/skeletons/Pascal/template_consoleApp.pas
        au BufNewFile *.py  0r $HOME/.vim/skeletons/Python/HashBang.py
        au BufNewFile *.sh  0r $HOME/.vim/skeletons/Bash/HashBang.sh
        au BufNewFile *.yml 0r $HOME/.vim/skeletons/Yaml/new.yml
        au BufNewFile *.tex 0r $HOME/.vim/skeletons/Latex/new.tex
        "au BufNewFile *.ly  call NewLilypond()
augroup END
"}}}

" use TEX instead of PLAINTEX by default (:h ft-tex-plugin)
let g:tex_flavor = "latex"

" }}}


"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"     Learn Vimscript the Hard Way      
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

" Find the book at http://learnvimscriptthehardway.stevelosh.com/ "{{{
" This section is meant to do the exercices in the book
"source $HOME/.vim/Vimscript_Exercises/List_of_exercises.vim
" open 'Ex_list.vim' where the exercises are sourced
"nnoremap <Leader>e :vsplit $HOME/.vim/Vimscript_Exercises/List_of_exercises.vim <CR>
"nnoremap <Leader>m :w <CR> :source % <CR>
"}}}
