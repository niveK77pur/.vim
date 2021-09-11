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

if &t_Co > 255 && $TERM !=# "linux"
    " $TERM ==# 'linux' if it is running in a tty
    if has('termguicolors')
        set termguicolors
    endif
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
" ~~~ everforest ~~~ {{{
" Important!!
" if has('termguicolors')
"     set termguicolors
" endif
" For dark version.
" set background=dark
" For light version.
" set background=light
" Set contrast.
" This configuration option should be placed before `colorscheme everforest`.
" Available values: 'hard', 'medium'(default), 'soft'
" let g:everforest_background = 'hard'
let g:everforest_transparent_background = 1
colorscheme everforest
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

" Defining function to be used for 'foldtext'. {{{
function! MyFoldText()
    let fillchar = "."
    " let folding_sign = '>'
    " let folding_sign = "祉"
    let folding_sign = ""
    " let folding_sign = ""
    " let folding_sign = ""
    " let folding_sign = ""
    let folded_line_num = v:foldend - v:foldstart
    let foldline = {
                \ 'spaces' : substitute(getline(v:foldstart), '^\s*\zs.*', '', ''),
                \ 'text' : substitute(getline(v:foldstart), '^\s*','',''),
                \}
    let line_text_left = foldline['spaces'] . folding_sign .
                \ ' {lvl.' . v:foldlevel . '} ' .
                \ substitute(foldline['text'], '\s*'.split(&foldmarker,',')[0].'\d*\s*', '', '') .
                \ ' '
    let line_text_right = ' [' . folded_line_num . 'L]'
    let fillcharcount = (&textwidth>0 ? &textwidth : 80) - len(line_text_left) - len(line_text_right)
    " Hard-coded value adjustment due to Nerd Font icon character length not
    " being correctly computed.
    let fillcharcount = fillcharcount + 2
    return line_text_left . repeat(fillchar, fillcharcount) . line_text_right
endfunction
set foldtext=MyFoldText()
set fillchars=fold:\ ,vert:\|
" }}}

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"                                   Editor
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

set backspace=2
set splitright
set shiftround
set modeline
set backup
set backupdir=/tmp

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

