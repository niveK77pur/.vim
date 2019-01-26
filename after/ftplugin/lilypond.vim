setlocal norelativenumber
setlocal number
setlocal nowrap
setlocal scrollbind

iabbrev <buffer> fe \fermata
iabbrev <buffer> ar \arpeggio
iabbrev <buffer> pa \parenthesize
iabbrev <buffer> ot \ottava
iabbrev <buffer> re \relative

iabbrev <buffer> ss s1 \|
iabbrev <buffer> ,, ~

iabbrev chl \change Staff = "left"
iabbrev chr \change Staff = "right"

iabbrev featherl <c-r>=Feather('l')<CR><c-o>?+<CR><DEL>
iabbrev featherr <c-r>=Feather('r')<CR><c-o>?+<CR><DEL>
iabbrev feather0 \override Beam.grow-direction = #'()

iabbrev ct \clef "treble"
iabbrev cb \clef "bass"

" function for inserting feathered notes {{{
function! Feather(side)
        if a:side == 'l'
            let dir="LEFT"
        elseif a:side == 'r'
            let dir="RIGHT"
        endif
        let beam ="\\override Beam.grow-direction = #" . dir
        let dur  ="\\featherDurations #(ly:make-moment+)"
        " The + a place holder \ottava be replaced with the duration ratio
        return " " . beam . ' ' . dur . "\r\t{ [>VIM<] } "
endfunction
"}}}

" miscellaneous {{{
"no wrap
nnoremap <buffer> <LocalLeader><F5> :set wrap!<CR>
"toggle scrollbind
nnoremap <buffer> <LocalLeader>bt :set scrollbind!<CR>
"reset scroll binding
nnoremap <buffer> <LocalLeader>br :windo setl noscrollbind<CR>:windo normal gg<CR>:windo setl scrollbind<CR>
"use a <C-V><SPACE> instead. Prevents extra space when creating slurs
inoremap <buffer> <LocalLeader><SPACE> <c-v><space>
"}}}

" abbreviations for inserting polyphonies {{{
iabbrev p\  <ESC>:.r! sed -n '12p'     ~/.vim/skeletons/Lilypond/lilypond.ly <CR>
iabbrev p\\ <ESC>:.r! sed -n '13,17p'  ~/.vim/skeletons/Lilypond/lilypond.ly <CR> 5kdd
iabbrev pt  <ESC>:.r! sed -n '3,9p'    ~/.vim/skeletons/Lilypond/lilypond.ly <CR> 7kdd
"}}}

" make octaves {{{
function! MakeOctave(pitch)
        execute ":s#\([abcdefg]\%([ie]\?s\?\)\)#<\1 \1" . a:pitch . ">#g<CR>"
endfunction
function! OctaveUp()
        :s#\([abcdefg]\%([ie]\?s\?\)\)\([',]*\)#<\1\2 \1'>#g<CR>
endfunction
"}}}

"put a | at the end of a line {{{
inoremap <buffer> <LocalLeader>b <c-o>A \|<ESC>
nnoremap <buffer> <LocalLeader>bb A \|<ESC>
"}}}

"insert octave up/down {{{
inoremap <buffer> <LocalLeader>ou <ESC>yiwi<<ESC>ea <C-O>p'>
inoremap <buffer> <LocalLeader>od <ESC>yiwi<<ESC>ea <C-O>p,>
"}}}

"polyphony templates {{{
nnoremap <buffer> <LocalLeader>p\ :.r! sed -n '12p'          ~/.vim/skeletons/Lilypond/lilypond.ly <CR>
inoremap <buffer> <LocalLeader>p\ <ESC>:.r! sed -n '12p'     ~/.vim/skeletons/Lilypond/lilypond.ly <CR>
nnoremap <buffer> <LocalLeader>p/ :.r! sed -n '13,17p'       ~/.vim/skeletons/Lilypond/lilypond.ly <CR> 5kdd
inoremap <buffer> <LocalLeader>p/ <ESC>:.r! sed -n '13,17p'  ~/.vim/skeletons/Lilypond/lilypond.ly <CR> 5kdd
nnoremap <buffer> <LocalLeader>pt :.r! sed -n '3,9p'         ~/.vim/skeletons/Lilypond/lilypond.ly <CR> 7kdd
inoremap <buffer> <LocalLeader>pt <ESC>:.r! sed -n '3,9p'    ~/.vim/skeletons/Lilypond/lilypond.ly <CR> 7kdd
"}}}

"make octave {{{
nnoremap <buffer> <LocalLeader>mo :s#\s\([abcdefg]\%([ie]\?s\?\)\)\([',]*\)# <\1\2 \1'>#g<CR>
vnoremap <buffer> <LocalLeader>mo v`>a<CR><ESC>`<i<CR><ESC>:s#\s\([abcdefg]\%([ie]\?s\?\)\)\([',]*\)# <\1\2 \1'>#g<CR><UP>JJ
nnoremap <buffer> <LocalLeader>mO :s#\s\([abcdefg]\%([ie]\?s\?\)\)\([',]*\)# <\1\2 \1,>#g<CR>
vnoremap <buffer> <LocalLeader>mO v`>a<CR><ESC>`<i<CR><ESC>:s#\s\([abcdefg]\%([ie]\?s\?\)\)\([',]*\)# <\1\2 \1,>#g<CR><UP>JJ
"}}}

"remove next/previous pitch ' or , {{{
nnoremap <buffer> <LocalLeader>rp /[',]<CR>x
inoremap <buffer> <LocalLeader>rp <ESC>/[',]<CR>x
nnoremap <buffer> <LocalLeader>rP ?[',]<CR>x
inoremap <buffer> <LocalLeader>rP <ESC>?[',]<CR>x
"}}}

"toggle articulations {{{
function! HideArticulations()
        %s#\\\([<>!]\|m\?[pf]\|sfz\?\)#%{\\\1%}#g
        %s#%{\\\([fp]\)%}\(ermata\|artial\)#\\\1\2#g
endfunction
function! ShowArticulations()
        %s#%{\(\\\([<>!]\|m\?[pf]\|sfz\?\)\)%}#\1#g
endfunction
"}}}

" hide/unhide out the rest of the song {{{
nnoremap <LocalLeader>h O%{}<ESC>
nnoremap <LocalLeader>H /%{}\?<CR>dd
"}}}

