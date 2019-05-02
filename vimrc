"" Check out what other interesting things there are to add here
"" http://stackoverflow.com/questions/164847/what-is-in-your-vimrc

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"                               Plugins
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

" hand-made {{{
"set runtimepath+=$HOME/.vim/bundle/nerdtree/
"set runtimepath+=$HOME/.vim/bundle/auto-pairs/
" }}}

" Vundle {{{
if !isdirectory($HOME . "/.vim/bundle/Vundle.vim")
        echom "Setting up ~/.vim/bundle/ directory and Vundle."
        call mkdir($HOME . "/.vim/bundle", "p")
        !git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
endif
set nocompatible        " be iMproved, required
filetype off            " required
set runtimepath+=$HOME/.vim/bundle/Vundle.vim
call vundle#begin()
        " let Vundle manage Vundle
        Plugin 'VundleVim/Vundle.vim'
        Plugin 'scrooloose/nerdtree'
        Plugin 'scrooloose/nerdcommenter'
        Plugin 'jiangmiao/auto-pairs'
        Plugin 'vim-syntastic/syntastic'
        Plugin 'junegunn/goyo.vim'
        Plugin 'tpope/vim-surround'
        Plugin 'suan/vim-instant-markdown'
        Plugin 'thinca/vim-localrc'
        Plugin 'terryma/vim-multiple-cursors'
        Plugin 'keith/swift.vim'
        Plugin 'morhetz/gruvbox'
        "Plugin 'FredKSchott/CoVim'     "requires to be compiled with +python
call vundle#end()
" }}}

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"                              Functions
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" See :h E124

function! ToggleFoldcolumn() "{{{
    if &foldcolumn ==# 0
        set foldcolumn=4
    else
        set foldcolumn=0
    endif
endfunction "}}}


function! ToggleBackground() "{{{
    if &bg == 'dark'
        set bg=light
    else
        set bg=dark
    endif
endfunction
"}}}

function! ToggleBackgroundTime(start, end) "{{{
        " Specify (day)time in which to use light theme
        " During nighttime the dark theme is used
        " a:start and a:end mark the beginning and end of a day
        if !exists("*strftime")
                echoerr "strftime() is not available on this system"
                return
        endif
        let s:time = strftime("%H")
        if s:time > a:start && s:time < a:end
                set background=light
        else
                set background=dark
        endif
endfunction
"}}}

function! CheckColorsGruvbox() "{{{
        " Make sure the terminal support at least 16 colors
        " otherwise do not use gruvbox colorscheme
        let s:colors = system("tput colors")
        if s:colors == 16
                let g:gruvbox_termcolors = 16
        elseif s:colors != 256
                return v:false
        endif
        return v:true
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

function! MakeSection(...) "{{{
        let s:text = join(a:000, " ") . " "
        let s:comment_character = GetCommentCharacter()
        let s:width = &textwidth ? &textwidth : 80
        let banner = repeat('-', s:width - len(s:comment_character) - len(s:text))
        execute "normal o".s:comment_character.s:text.banner
endfunction
"}}}

function! MakeHeader(...) "{{{
        let s:text = join(a:000, ' ')
        let s:comment_character = GetCommentCharacter()
        let s:width = &textwidth ? &textwidth : 80
        let s:space = s:comment_character . repeat(' ', s:width/2 - len(s:text)/2 - len(s:comment_character))
        let s:banner = s:comment_character . repeat('~', s:width - len(s:comment_character))
        set paste
        execute "normal o\r".s:banner."\r".s:space.s:text."\r".s:banner."\r\e"
        set nopaste
endfunction
"}}}


" read templates from b:template_file "{{{
function! FromTemplate(tag_name)
    " import snippet from a template file. Snippets are marked with tags
    let line=line(".")
    echom b:template_file a:tag_name b:comment_character
    echom ".-1r! bash $HOME/.vim/scripts/FromTemplate.sh" b:template_file a:tag_name "\\" . b:comment_character
    exec  ".-1r! bash $HOME/.vim/scripts/FromTemplate.sh" b:template_file a:tag_name "\\" . b:comment_character
    call cursor(line, 0)
endfunction
"}}}


function! MakeTextAbbrevs(abbrev, ...) "{{{
    " create abbreviations with various casings for terms i.e.:
    " MakeTextAbbrevs(HMW, Hello My World) create these abbrevs
    "   1. hmw -> hello my world
    "   2. HMW -> Hello My World
    "   3. Hmw -> Hello my world
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


function! SubstituteList(list, pat, sub, flag) "{{{
    " same as substitue() but do substitution on every item in a list
    let s:result = []
    for item in a:list
        call add(s:result, substitute(item, a:pat, a:sub, a:flag))
    endfor
    return s:result
endfunction
"}}}

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"                           Basic Settings
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

" ~~~ Files ~~~ "{{{
"add lilypond filetype plugin
filetype off
if isdirectory("/usr/share/lilypond/")
        set runtimepath+=/usr/share/lilypond/2.18.2/vim/
endif

syntax on
filetype plugin indent on
set autowrite
"}}}

" ~~~ Spell Check ~~~ {{{
set spellfile+=~/.vim/spell/en.uft-8.add
"}}}

" ~~~ Cholorschemes for vim ~~~ {{{1
"" Available colorschemes can be found in /usr/share/vim/vim74/colors/
"colorscheme pablo
"colorscheme ron "default
"colorscheme morning
"colorscheme shine
"colorscheme koehler

" ~~~ gruvbox ~~~ {{{2
if CheckColorsGruvbox()
        let g:gruvbox_italic=1
        "let g:gruvbox_italicize_comments=1
        colorscheme gruvbox
        call ToggleBackgroundTime(6,19)
endif
"}}}1

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
catch "E474"
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

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"                           Plugin Settings
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

" ~~~ NERDCommenter ~~~ {{{
let g:NERDSpaceDelims = 1
let g:NERDCustomDelimiters = {
    \ 'swift': { 'left': '//', 'leftAlt': '/*', 'right': '', 'rightAlt': '*/' } 
\ }
"}}}

" ~~~ CoVim ~~~ {{{
let CoVim_default_name = "kevim"
let CoVim_default_port = "8080"
" }}}

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"                              Mappings
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

" use <option>! to toggle (if boolean)
let mapleader='é'       "mapleader for <Leader>
let maplocalleader='è'

" {{{ Map definitions

"Toggle NERDTree {{{
nnoremap <leader>nn :NERDTreeToggle<CR>
nnoremap <leader>nb :NERDTreeFocus<CR> :BookmarkToRoot 
nnoremap <Leader>N  :NERDTreeFocus<CR>
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
noremap <Leader>hf :call ToggleFoldcolumn() <CR>
"}}}

"Toggle number and relativenumber
noremap <F3> :set relativenumber! number! relativenumber? <CR><ESC>

"Toggle line wrapping
noremap <F5> :set wrap! wrap? <CR>

"Toggle 'paste' option
noremap <Leader>p :set paste! paste? <CR>

" exit insert mode more comfortably
inoremap jk <Left><esc> 

" see tabs, spaces and what have you "{{{
nnoremap <Leader>l :set list! list? <CR>
inoremap <Leader>l <ESC>:set list! list? <CR>a
"}}}

" save and reload files "{{{
inoremap <Leader>s <c-o>:wa<CR>
nnoremap <Leader>s :wa<CR>
inoremap <Leader>e <c-o>:e<CR>
nnoremap <Leader>e :e<CR>
"}}}

" source vim files "{{{
autocmd FileType vim inoremap <buffer> <Leader>S <ESC>:wa<CR>:source %<CR>
autocmd FileType vim nnoremap <buffer> <Leader>S :wa<CR>:source %<CR>
"}}}

" jump to next [>VIM<] tag "{{{
inoremap <Leader><space> <ESC>/\[>VIM<\]<CR>v//e<CR>s
nnoremap <Leader><space> /\[>VIM<\]<CR>v//e<CR>s
"}}}

" insert a [>VIM<] to jump to
inoremap <Leader>j [>VIM<]

" toggle Syntastic 
nnoremap <F4> :SyntasticToggleMode<CR>

" toggle 'background' between light and dark
nnoremap <F6> :call ToggleBackground()<CR>

" toggle Goyo
nnoremap <F10> :Goyo<CR>

noremap <F12> :echo "\\°O°/" <CR>

"}}}

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"                            Abbreviations
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

" Command-line mode "{{{
cabbrev Wq wq
cabbrev WQ wq
cabbrev W w
cabbrev Q q
"}}}

" Insert mode "{{{
"for local abbreviations see
" :h :abbreviate-local
"}}}

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"                              Commands
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

"{{{
" set the b:comment_character variable below in the FileTpye-Specific
" Settings for the following commands
command! -nargs=+ MakeHeader  call MakeHeader(<f-args>)
command! -nargs=+ MakeSection call MakeSection(<f-args>)

command! -nargs=+ MakeTextAbbrevs call MakeTextAbbrevs(<f-args>)
"}}}

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"                            Autocommands
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

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
        au FileType bash   nnoremap <buffer> <LocalLeader>r :!bash %<CR>
        au FileType pascal nnoremap <buffer> <LocalLeader>r :!fpc -ovimPasEXE % ; echo -e "\e[44m Running program ...\e(B\e[m"; ./vimPasEXE <CR>
        au FileType tex    nnoremap <buffer> <LocalLeader>r :!pdflatex %; evince %:s?\.tex?\.pdf? <CR>
        au FileType markdown nnoremap <buffer> <LocalLeader>r :!retext --preview %<CR>
        au FileType cpp    nnoremap <buffer> <LocalLeader>r :!g++ -o vim-a.out % ; draw_center_text.sh "Running program"; ./*.out<CR>
        "au FileType cpp    nnoremap <buffer> <LocalLeader>r :!g++ -o a.out % ; draw_center_text.sh "Running program"; ./*.out<CR>
        au FileType sh     nnoremap <buffer> <LocalLeader>r :!./%<CR>
        au FileType swift  nnoremap <buffer> <LocalLeader>r :call RunMessage() \| !swift % <CR>
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
        au FileType pascal,cpp,swift          let b:comment_character = '//'
        au FileType vim                       let b:comment_character = '"'
        au FileType tex,plaintex,lilypond     let b:comment_character = '%'
        au FileType text,md                   let b:comment_character = ''
augroup END
"}}}

" filetype commenting {{{
" switched to NERDCommenter Plugin
" see ':h NERCommenter'
"augroup ft_commenting
"        au!
"        au FileType python,bash,ruby,yaml  nnoremap <buffer> <LocalLeader>c I#<ESC> 
"        au FileType pascal,cpp,swift       nnoremap <buffer> <LocalLeader>c I//<ESC> 
"        au FileType vim                    nnoremap <buffer> <LocalLeader>c I"<ESC>
"        au FileType tex,plaintex,lilypond  nnoremap <buffer> <LocalLeader>c I%<ESC>
"augroup END
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

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"                    Learn Vimscript the Hard Way
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

" Find the book at http://learnvimscriptthehardway.stevelosh.com/ "{{{
" This section is meant to do the exercices in the book
"source $HOME/.vim/Vimscript_Exercises/List_of_exercises.vim
" open 'Ex_list.vim' where the exercises are sourced
"nnoremap <Leader>e :vsplit $HOME/.vim/Vimscript_Exercises/List_of_exercises.vim <CR>
"nnoremap <Leader>m :w <CR> :source % <CR>
"}}}

