setlocal norelativenumber
setlocal number
setlocal nowrap
setlocal scrollbind

iabbrev <buffer> fe \fermata
iabbrev <buffer> ar \arpeggio
iabbrev <buffer> pa \parenthesize
iabbrev <buffer> ot \ottava
iabbrev <buffer> ss s1 \|

function! MakeOctave(pitch)
        execute ":s#\([abcdefg]\%([ie]\?s\?\)\)#<\1 \1" . a:pitch . ">#g<CR>"
endfunction

function! OctaveUp()
        :s#\([abcdefg]\%([ie]\?s\?\)\)\([',]*\)#<\1\2 \1'>#g<CR>
endfunction

"no wrap
nnoremap <buffer> <LocalLeader><F5> :set wrap!<CR>
"toggle scrollbind
nnoremap <buffer> <LocalLeader>sb :set scrollbind!<CR>

"reload file (withouth messing up scrollbind)
nnoremap <buffer> <LocalLeader>e :setl noscrollbind<CR>:e<CR>:setl scrollbind<CR>

"insert octave up/down
inoremap <buffer> <LocalLeader>ou <ESC>yiwi<<ESC>ea <C-O>p'>
inoremap <buffer> <LocalLeader>od <ESC>yiwi<<ESC>ea <C-O>p,>

"polyphony templates
nnoremap <buffer> <LocalLeader>p\ :.r! sed -n '12p'          ~/.vim/skeletons/Lilypond/lilypond.ly <CR>
inoremap <buffer> <LocalLeader>p\ <ESC>:.r! sed -n '12p'     ~/.vim/skeletons/Lilypond/lilypond.ly <CR>
nnoremap <buffer> <LocalLeader>p/ :.r! sed -n '13,17p'       ~/.vim/skeletons/Lilypond/lilypond.ly <CR> 5kdd
inoremap <buffer> <LocalLeader>p/ <ESC>:.r! sed -n '13,17p'  ~/.vim/skeletons/Lilypond/lilypond.ly <CR> 5kdd
nnoremap <buffer> <LocalLeader>pt :.r! sed -n '3,9p'         ~/.vim/skeletons/Lilypond/lilypond.ly <CR> 7kdd
inoremap <buffer> <LocalLeader>pt <ESC>:.r! sed -n '3,9p'    ~/.vim/skeletons/Lilypond/lilypond.ly <CR> 7kdd

"make octave
nnoremap <buffer> <LocalLeader>mo :s#\s\([abcdefg]\%([ie]\?s\?\)\)\([',]*\)# <\1\2 \1'>#g<CR>
vnoremap <buffer> <LocalLeader>mo v`>a<CR><ESC>`<i<CR><ESC>:s#\s\([abcdefg]\%([ie]\?s\?\)\)\([',]*\)# <\1\2 \1'>#g<CR><UP>JJ
nnoremap <buffer> <LocalLeader>mO :s#\s\([abcdefg]\%([ie]\?s\?\)\)\([',]*\)# <\1\2 \1,>#g<CR>
vnoremap <buffer> <LocalLeader>mO v`>a<CR><ESC>`<i<CR><ESC>:s#\s\([abcdefg]\%([ie]\?s\?\)\)\([',]*\)# <\1\2 \1,>#g<CR><UP>JJ

"remove next/previous pitch ' or ,
nnoremap <buffer> <LocalLeader>rp /[',]<CR>x
inoremap <buffer> <LocalLeader>rp <ESC>/[',]<CR>x
nnoremap <buffer> <LocalLeader>rP ?[',]<CR>x
inoremap <buffer> <LocalLeader>rP <ESC>?[',]<CR>x

"toggle articulations
function! HideArticulations()
        %s#\\\([<>!]\|m\?[pf]\|sfz\?\)#%{\\\1%}#g
        %s#%{\\\([fp]\)%}\(ermata\|artial\)#\\\1\2#g
endfunction

function! ShowArticulations()
        %s#%{\(\\\([<>!]\|m\?[pf]\|sfz\?\)\)%}#\1#g
endfunction

