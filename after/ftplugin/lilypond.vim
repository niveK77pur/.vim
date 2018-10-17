set norelativenumber
set number
set nowrap
set scrollbind

iabbrev fe \fermata
iabbrev ar \arpeggio

function! MakeOctave(pitch)
        execute ":s#\([abcdefg]\%([ie]\?s\?\)\)#<\1 \1" . a:pitch . ">#g<CR>"
endfunction

function! OctaveUp()
        :s#\([abcdefg]\%([ie]\?s\?\)\)\([',]*\)#<\1\2 \1'>#g<CR>
endfunction

"no wrap
nnoremap <LocalLeader><F5> :set wrap!<CR>

"insert octave up/down
inoremap <LocalLeader>ou <ESC>yiwi<<ESC>ea <C-O>p'>
inoremap <LocalLeader>od <ESC>yiwi<<ESC>ea <C-O>p,>

"polyphony templates
nnoremap <LocalLeader>p\ :.r! sed -n '12p'          ~/.vim/skeletons/Lilypond/lilypond.ly <CR>
inoremap <LocalLeader>p\ <ESC>:.r! sed -n '12p'     ~/.vim/skeletons/Lilypond/lilypond.ly <CR>
nnoremap <LocalLeader>p/ :.r! sed -n '13,17p'       ~/.vim/skeletons/Lilypond/lilypond.ly <CR> 5kdd
inoremap <LocalLeader>p/ <ESC>:.r! sed -n '13,17p'  ~/.vim/skeletons/Lilypond/lilypond.ly <CR> 5kdd
nnoremap <LocalLeader>pt :.r! sed -n '3,9p'         ~/.vim/skeletons/Lilypond/lilypond.ly <CR> 7kdd
inoremap <LocalLeader>pt <ESC>:.r! sed -n '3,9p'    ~/.vim/skeletons/Lilypond/lilypond.ly <CR> 7kdd

"make octave
nnoremap <LocalLeader>mo :s#\s\([abcdefg]\%([ie]\?s\?\)\)\([',]*\)# <\1\2 \1'>#g<CR>
vnoremap <LocalLeader>mo v`>a<CR><ESC>`<i<CR><ESC>:s#\s\([abcdefg]\%([ie]\?s\?\)\)\([',]*\)# <\1\2 \1'>#g<CR><UP>JJ
nnoremap <LocalLeader>mO :s#\s\([abcdefg]\%([ie]\?s\?\)\)\([',]*\)# <\1\2 \1,>#g<CR>
vnoremap <LocalLeader>mO v`>a<CR><ESC>`<i<CR><ESC>:s#\s\([abcdefg]\%([ie]\?s\?\)\)\([',]*\)# <\1\2 \1,>#g<CR><UP>JJ

"remove next/previous pitch ' or ,
nnoremap <LocalLeader>rp /[',]<CR>x
inoremap <LocalLeader>rp <ESC>/[',]<CR>x
nnoremap <LocalLeader>rP ?[',]<CR>x
inoremap <LocalLeader>rP <ESC>?[',]<CR>x

"toggle articulations
function! HideArticulations()
        %s#\\\([<>!]\|m\?[pf]\|sfz\?\)#%{\\\1%}#g
        %s#%{\\\([fp]\)%}\(ermata\|artial\)#\\\1\2#g
endfunction

function! ShowArticulations()
        %s#%{\(\\\([<>!]\|m\?[pf]\|sfz\?\)\)%}#\1#g
endfunction

