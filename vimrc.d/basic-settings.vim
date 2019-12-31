"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"                                    Files
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

"add lilypond filetype plugin
"filetype off
"if isdirectory("/usr/share/lilypond/")
"        "set runtimepath+=/usr/share/lilypond/2.18.2/vim/
"endif

syntax on
filetype plugin indent on
set autowrite

" use TEX instead of PLAINTEX by default (:h ft-tex-plugin)
let g:tex_flavor = "latex"

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"                                 Spell Check
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

set spellfile+=~/.vim/spell/en.uft-8.add

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"                            Colorschemes for vim
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

"" Available colorschemes can be found in /usr/share/vim/vim74/colors/
"colorscheme pablo
"colorscheme ron "default
"colorscheme morning
"colorscheme shine
"colorscheme koehler
if has('nvim')
    colorscheme forest-night
else
    " ~~~ gruvbox ~~~ {{{
    if CheckColorsGruvbox()
            let g:gruvbox_italic=1
            let g:gruvbox_italicize_comments=1
            colorscheme gruvbox
            set bg=dark
            "call ToggleBackgroundTime(6,19)
    endif
    " }}}
endif

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"                           Options for indentation
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

set autoindent
set smartindent
" set tabstop=4
set shiftwidth=4
set softtabstop=-1
set expandtab

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"                                  Interface
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

set mouse=a         "Enable mouse support
set relativenumber  "Relative numbering
"set numberwidth=3
set linebreak       "Line wrapping at a character
set showcmd
set wildmenu
set lazyredraw

set nowrap          " prevent annyoing, ugly and confusing line breaks

set sidescroll=5
set sidescrolloff=5

try
    set listchars=eol:¶,tab:>-,space:∙,trail:×,extends:>,precedes:<
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

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"                                   Editor
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

set backspace=2
set splitright
set shiftround

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"                        Settings for auto-completion
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

set ignorecase  " \c -- like ignore case is on, \C -- force matching case
set smartcase
set noinfercase

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"                             Encryption settings
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

"use [:setlocal cm?] to show encryption for the current file
if has('crypt-blowfish2')
        set cryptmethod=blowfish2  "encryption method unknown to gvim portable (for now)
elseif has('crypt-blowfish')
        set cryptmethod=blowfish
endif

