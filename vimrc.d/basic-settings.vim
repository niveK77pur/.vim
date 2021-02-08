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

set spellfile+=~/.vim/spell/en.utf-8.add

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"                            Colorschemes for vim
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

if &t_Co > 255
    set termguicolors
    if !has('nvim')
        let &t_8f = "\<esc>[38;2;%lu;%lu;%lum"
        let &t_8b = "\<esc>[48;2;%lu;%lu;%lum"
    endif
endif

"" Available colorschemes can be found in /usr/share/vim/vimXX/colors/
"colorscheme pablo
"colorscheme ron "default
"colorscheme morning
"colorscheme shine
"colorscheme koehler
let g:forest_night_transparent_background = 1
colorscheme forest-night
" colorscheme salvation
" ~~~ gruvbox ~~~ {{{
" if CheckColorsGruvbox()
"         let g:gruvbox_italic=1
"         let g:gruvbox_italicize_comments=1
"         colorscheme gruvbox
"         set bg=dark
"         "call ToggleBackgroundTime(6,19)
" endif
" }}}

" Additional settings for colorschemes ---------------------------------------
" hi Normal guibg=NONE ctermbg=NONE

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"                           Options for indentation
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

set autoindent
set smartindent
set tabstop=4
set shiftwidth=0
set softtabstop=-1
set expandtab
set breakindent
let &showbreak = '>'

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
set modeline

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

