"" Check out what other interesting things there are to add here
"" http://stackoverflow.com/questions/164847/what-is-in-your-vimrc

let mapleader='é'       "mapleader for <Leader>
let maplocalleader='è'

noremap <Leader><Leader> <Leader>
inoremap <Leader><Leader> <Leader>

noremap <LocalLeader><LocalLeader> <LocalLeader>
inoremap <LocalLeader><LocalLeader> <LocalLeader>

let vimrc_files = [
    \ 'plugins.vim',
    \ 'functions.vim',
    \ 'basic-settings.vim',
    \ 'plugin-settings.vim',
    \ 'mappings.vim',
    \ 'abbreviations.vim',
    \ 'commands.vim',
    \ 'autocommands.vim',
    \ ]

for vfile in vimrc_files
    exec 'source' expand('<sfile>:p:h') . '/vimrc.d/' . vfile
endfor

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"                              Note worthy stuff
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

" au FocusGained * !setxkbmap -option caps:swapescape
" au FocusLost   * !setxkbmap -option
"
" https://github.com/vim-advent-calendar/vimways.org/blob/master/content/2019/vim-and-the-shell/index.md
"
" select text within quotes (also supports nested quotes)
" \(['"]\)\%(\\\?.\)\{-}\1

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"                        Learn Vimscript the Hard Way
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

" Find the book at http://learnvimscriptthehardway.stevelosh.com/ "{{{
" This section is meant to do the exercices in the book
"source $HOME~/.vim/Vimscript_Exercises/List_of_exercises.vim
" open 'Ex_list.vim' where the exercises are sourced
"nnoremap <Leader>e :vsplit $HOME~/.vim/Vimscript_Exercises/List_of_exercises.vim <CR>
"nnoremap <Leader>m :w <CR> :source % <CR>
"}}}
