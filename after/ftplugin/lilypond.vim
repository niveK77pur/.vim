" have a transparent background to see the underlying PDF
colorscheme ron
redraw!         " automatically redraw screen

setlocal norelativenumber
setlocal number
setlocal nowrap
setlocal scrollbind

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"                              Variables
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

" {{{

let b:template_file = "$HOME/.vim/skeletons/Lilypond/templates.ly"
let b:bar_rest = 's1'

" if !exists("g:key_signature")
"     let g:key_signature = "cM"
" endif
let s:accidentals = ["f", "c", "g", "d", "a", "e", "b"]
"{{{ s:signatures
let s:signatures = {
        \ 'desM': -5, 'besm': -5,
        \ 'aesM': -4, 'fm':   -4,
        \ 'eesM': -3, 'cm':   -3,
        \ 'besM': -2, 'gm':   -2,
        \ 'fM':   -1, 'dm':   -1,
        \ 'cM':    0, 'am':    0,
        \ 'gM':    1, 'em':    1,
        \ 'dM':    2, 'bm':    2,
        \ 'aM':    3, 'fism':  3,
        \ 'eM':    4, 'cism':  4,
        \ 'bM':    5, 'gism':  5,
\ }
"}}}

" }}}

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"                            Abbreviations
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

" {{{

iabbrev <buffer> fe \fermata
iabbrev <buffer> ar \arpeggio
iabbrev <buffer> pa \parenthesize
iabbrev <buffer> ot \ottava
iabbrev <buffer> re \relative

iabbrev 1v \oneVoice
iabbrev v1 \voiceOne
iabbrev v2 \voiceTwo
iabbrev v3 \voiceThree
iabbrev v4 \voiceFour

iabbrev <buffer> ss <c-r>=BarRest()<CR>

iabbrev chl \change Staff = "left"
iabbrev chr \change Staff = "right"

iabbrev hn \hideNotes
iabbrev HN \unHideNotes

iabbrev featherl <c-r>=Feather('l')<CR><c-o>?+<CR><DEL>
iabbrev featherr <c-r>=Feather('r')<CR><c-o>?+<CR><DEL>
iabbrev feather0 \override Beam.grow-direction = #'()

iabbrev ct \clef "treble"
iabbrev cb \clef "bass"

iabbrev ii <c-o>o\bar "\|\|"<CR><ESC>
iabbrev i. <c-o>o\bar "\|."<CR><ESC>

iabbrev p\  <ESC>:call FromTemplate("DoublePoly1")<CR>
iabbrev p\\ <ESC>:call FromTemplate("DoublePoly2")<CR>
iabbrev pt  <ESC>:call FromTemplate("TempPoly")<CR>

"}}}

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"                              Commands
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

" {{{

" command for changing a note into another in the current line (i.e. c --> d)
command! -nargs=+ -range -buffer Switch :call SwitchNotes(<f-args>)

" command for setting key signature
" command! -nargs=1 -bar -buffer KeySignature :let g:key_signature = <q-args>

"}}}

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"                              Functions
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

" make octaves {{{
function! MakeOctave(pitch)
        let match_pattern = "\(\s\+\)\([abcdefg]\%([ie]s\)*\)\([',]*\)\|\ze<.\{-}>\zs"
        let match_pattern = "\\(\\s\\+\\)\\([abcdefg]\\%([ie]s\\)*\\)\\([',]*\\)\\|\\ze<.\\{-}>\\zs"
        execute "s#" . match_pattern . "#\\1<\\2\\3 \\2" . a:pitch . ">#g" | s#<\s*[',]>##ge
endfunction
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

" insert feathered notes {{{
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
 
" change a note into another in the current line (i.e. cis --> dis) "{{{
function! SwitchNotes(...)
        if a:0%2 != 0
                echoerr "Invalid number of notes. Missing couple:" a:0 "notes given."
                return 1
        endif

        for i in range(0,a:0-1,2)
                if a:000[i][0] ==# toupper(a:000[i][0])
                        " don't ignore accidentals if first letter is
                        " upper case.  The accidental will be removed.
                        " i.e. SwitchNotes(A,b) : ais --> b
                        let acc = ''
                else
                        " ignore accidentals if first letter is lower
                        " case.  The accidental will be kept.
                        " i.e. SwitchNotes(a,b) : ais --> bis
                        let acc = "\\2"
                endif

                execute 's#[^\\]\<\(<\?\)' . a:000[i] . '\(\a*\)# \1' . tolower(a:000[i+1]) . acc . '#gi'
        endfor
endfunction
"}}}

function! BarRest() "{{{
        return b:bar_rest . ' |'
endfunction
"}}}

" extract key signature from 'global.ly' "{{{
function! GetGlobalKey()
    for line in readfile(expand("%:p:h") . "/global.ly")
        if line =~ '\key'
            return substitute(line, '.*\key \(\w\+\) \\\(minor\|major\).*', '\=submatch(2) ==# "major" ? submatch(1)."M" : submatch(1)."m"', '')
        endif
    endfor
    throw "ERROR_NoKeySignature"
endfunction
"}}}

" add accidentals for different key signatures "{{{
function! AdaptToKey(ignore)
        " key signature must be specified with 
        "               %%Key: <KEY>
        " at the end of a line. If no such 'statement' was found, then it will
        " look up the 'global.ly' file.
        let l:window = winsaveview()
            try
                ?%%Key:\s*\w\+[mM]
                let l:key = substitute(getline('.'), '.*%%Key:\s*\(\w\+[mM]\).*', '\1', 'I')
            catch "E486"
                let l:key = GetGlobalKey()
            endtry
            echo "Key signature is:" l:key
        call winrestview(l:window)
        
        let s:numOfAcc = s:signatures[l:key]
        let matchrest = '\([' . "'" . ',]*\)\(\d*\.\?>\?\)'
        if s:numOfAcc > 0
            for note in s:accidentals[: s:numOfAcc-1]
                exec 's#\<\(<\?' . note . '\)' . matchrest . '\>#\1is\2\3#ge'
            endfor
        elseif s:numOfAcc < 0
            for note in reverse(copy(s:accidentals))[: abs(s:numOfAcc)-1]
                exec 's#\<\(<\?' . note . '\)' . matchrest . '\>#\1es\2\3#ge'
            endfor
        endif
        exec 's#' . a:ignore . '\([abcdefg]\)\>#\1#ge'
endfunction
"}}}

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"                            Autocommands
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

augroup LiliyPond
    au!
    au FocusLost,InsertLeave *.ly :wa
augroup END

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"                              Mappings
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

" miscellaneous {{{

"use a <C-V><SPACE> instead. Prevents extra space when creating slurs
inoremap <buffer> <LocalLeader><SPACE> <c-v><space>

"}}}

" scollbind "{{{
"toggle scrollbind
nnoremap <buffer> <LocalLeader>bt :set scrollbind!<CR>
"reset scroll binding
nnoremap <buffer> <LocalLeader>br :windo setl noscrollbind<CR>:windo normal gg<CR>:windo setl scrollbind<CR>
"}}}

"put a | at the end of a line {{{
inoremap <buffer> <LocalLeader>b <c-o>A \|<ESC>:call AdaptToKey(">")<CR>
nnoremap <buffer> <LocalLeader>bb A \|<ESC>
"}}}

"insert octave up/down in insert mode {{{
inoremap <buffer> <LocalLeader>ou <ESC>yiwi<<ESC>ea <C-O>p'>
inoremap <buffer> <LocalLeader>od <ESC>yiwi<<ESC>ea <C-O>p,>
"}}}

"make octave {{{
nnoremap <LocalLeader>mo :call MakeOctave("'")<CR>
vnoremap <buffer> <LocalLeader>mo v`>a<CR><ESC>`<i<CR><ESC>:call MakeOctave("'")<CR><UP>JJ
nnoremap <buffer> <LocalLeader>mO :call MakeOctave(",")<CR>
vnoremap <buffer> <LocalLeader>mO v`>a<CR><ESC>`<i<CR><ESC>:call MakeOctave(",")<CR><UP>JJ
"}}}

"remove next/previous pitch (' or ,) {{{
nnoremap <buffer> <LocalLeader>rp /[',]<CR>x
inoremap <buffer> <LocalLeader>rp <ESC>/[',]<CR>x
nnoremap <buffer> <LocalLeader>rP ?[',]<CR>x
inoremap <buffer> <LocalLeader>rP <ESC>?[',]<CR>x
"}}}

" hide/unhide the rest of the song {{{
nnoremap <LocalLeader>h O%{}<ESC>
nnoremap <LocalLeader>H /%{}\?<CR>dd
"}}}

" adapt to key "{{{
nnoremap <LocalLeader>k :call AdaptToKey(">")<CR>
"}}}

