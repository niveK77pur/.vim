" have a transparent background to see the underlying PDF
" colorscheme ron
" redraw!         " automatically redraw screen

setlocal norelativenumber
setlocal number
setlocal nowrap
" setlocal scrollbind
setlocal tw=0
setlocal autoread

if exists(':CocDisable')
    silent CocDisable
endif

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"                              Variables
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

" {{{

let b:template_file = "$HOME/.vim/skeletons/Lilypond/templates.ly"
let b:bar_rest = 's1'

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

" either of two values: 'number' or 'sign'
" set by autocommands below
"let g:pitch_mode = "number"

" }}}

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"                            Abbreviations
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

" {{{

" iabbrev <buffer> fe \fermata
" iabbrev <buffer> ar \arpeggio
" iabbrev <buffer> pa \parenthesize
" iabbrev <buffer> ot \ottava
" iabbrev <buffer> re \relative

" iabbrev 1v \oneVoice
" iabbrev v1 \voiceOne
" iabbrev v2 \voiceTwo
" iabbrev v3 \voiceThree
" iabbrev v4 \voiceFour

iabbrev <buffer> ss <c-r>=BarRest()<CR>

" iabbrev chl \change Staff = "left"
" iabbrev chr \change Staff = "right"

" iabbrev hn \hideNotes
" iabbrev HN \unHideNotes

iabbrev featherl <c-r>=Feather('l')<CR><c-o>?+<CR><DEL>
iabbrev featherr <c-r>=Feather('r')<CR><c-o>?+<CR><DEL>
iabbrev feather0 \override Beam.grow-direction = #<C-V>'()

" iabbrev ct \clef "treble"
" iabbrev cb \clef "bass"

iabbrev ii <c-o>o\bar "\|\|"<CR><ESC>
iabbrev i. <c-o>o\bar "\|."<CR><ESC>

" iabbrev p\  <ESC>:call FromTemplate("DoublePoly1")<CR>
" iabbrev p\\ <ESC>:call FromTemplate("DoublePoly2")<CR>
" iabbrev pt  <ESC>:call FromTemplate("TempPoly")<CR>

iabbrev shape \shape #<C-V>'(([>VIM<] . [>VIM<]) ([>VIM<] . [>VIM<]) ([>VIM<] . [>VIM<]) ([>VIM<] . [>VIM<]))

"}}}

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"                              Commands
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

" {{{

" command for changing a note into another in the current line (i.e. c --> d)
command! -nargs=+ -range -buffer Switch :call SwitchNotes(<f-args>)

"}}}

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"                              Functions
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

" {{{ script local functions

" }}}

" make octaves {{{
function! MakeOctave(pitch)
    " if g:pitch_mode == 'sign'
        let match_pattern = '\(\s\+\)\([abcdefg]\%([ie]\?s\)*\)\(['',]*\)\|\ze<.\{-}>\zs'
        execute 's#' . match_pattern . '#\1<\2\3 \2' . a:pitch . '>#g' | s#<\s*[',]>##ge
    " else
    "     let match_pattern = '\(\s\+\)\([abcdefg]\%([ie]\?s\)*\)\%(\({\)\(-\?\d\+\)\(}\)\)\?\|\ze<.\{-}>\zs'
    "     let offset = a:pitch =~ ',' ? -1 : +1
    "     exe 's#' . match_pattern . '#\=submatch(1) . "<" . submatch(2) . submatch(3).submatch(4).submatch(5) . " " . submatch(2) . "{".(submatch(4)+' . offset . ')."}" . ">"#g' | s#<\s*{-\?\d\+}>##ge
    " endif
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
                        let accidental = ''
                else
                        " ignore accidentals if first letter is lower
                        " case.  The accidental will be kept.
                        " i.e. SwitchNotes(a,b) : ais --> bis
                        let accidental = "\\2"
                endif

                execute 's#[^\\]\<\(<\?\)' . a:000[i] . '\(\a*\)# \1' . tolower(a:000[i+1]) . accidental . '#gi'
        endfor
endfunction
"}}}

function! BarRest() "{{{
        return b:bar_rest . ' |'
endfunction
"}}}

" apply key signature accidentals to notes {{{

" extract key signature from a line "{{{
function! GetKeySignature(line)
    return substitute(a:line, '.*\key \(\w\+\) \\\(minor\|major\).*', '\=submatch(2) ==# "major" ? submatch(1)."M" : submatch(1)."m"', '')
endfunction
"}}}

" extract key signature from 'global.ly' "{{{
function! GetGlobalKey()
    for line in readfile(expand("%:p:h") . "/global.ly")
        if line =~ '\key'
            return GetKeySignature(line)
        endif
    endfor
    throw "ERROR_NoKeySignature"
endfunction
"}}}

" add accidentals for different key signatures "{{{
function! AdaptToKey(ignore)
        let l:key = GetKeySignature(getline(search('\\key', 'bWn')))
        if l:key == ''
            let l:key = GetGlobalKey()
        endif
        echo "Key signature is:" l:key
        
        let s:numOfAcc = s:signatures[l:key]
        let matchrest = '\(['',]*\|{\d\+}\)\(\d*\.\?>\?\d*\.\?\)'
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

" }}}

" transform pitch indications into numbers (i.e. ,,, --> {-3}) {{{

function! AbsolutePitch2Number(pitch)
    return a:pitch =~ "," ? "{-" . len(a:pitch) . "}" : "{" . len(a:pitch) . "}"
endfunction

function! AbsolutePitch2Sign(pitch)
    let l:count = substitute(a:pitch, '{-\?\(\d\+\)}', '\1', '')
    return a:pitch =~ "-" ? repeat(",", l:count) : repeat("'", l:count)
endfunction

function! AbsolutePitchTransform2Number() range
    exe a:firstline . "," . a:lastline . 's/[[:digit:]s.abcdefg]\zs[,'']\+/\=AbsolutePitch2Number(submatch(0))/ge'
endfunction

function! AbsolutePitchTransform2Sign() range
    exe a:firstline . "," . a:lastline . 's#{-\?\d\+}#\=AbsolutePitch2Sign(submatch(0))#ge'
endfunction

function! AbsolutePitchTransformTo(type)
    let window = winsaveview()
    if a:type == 'number'
        %call AbsolutePitchTransform2Number()
    elseif a:type == 'sign'
        %call AbsolutePitchTransform2Sign()
    endif
    call winrestview(window)
endfunction

" }}}

" reset scrollbind if it happens to get messed up "{{{
function! ResetScrollBind()
    let l:view = winsaveview()
    set noscrollbind
    windo normal gg
    set scrollbind
    call winrestview(l:view)
endfunction
"}}}

" reload all open lilpond files "{{{
if !exists('*ReloadLiliypond')
    function! ReloadLiliypond()
        if expand('%:e') ==? 'ly'
            edit
            echom "Reloading" expand('%:t')
        endif
    endfunction
endif
"}}}

" get least number of lines in open files in  window "{{{
function! GetLowestLineNumberInWindows()
    let l:lineNumbers = []
    windo call add(l:lineNumbers, line("$"))
    return min(l:lineNumbers)
endfunction
"}}}

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"                            Autocommands
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

augroup LiliyPond "{{{
    au!
    " au FocusLost *.ly                       :wa | e
    " au BufWritePre *.ly                     :silent call AbsolutePitchTransformTo("sign") | let g:pitch_mode = "sign"
    " au BufRead,BufEnter,BufWritePost *.ly   :silent call AbsolutePitchTransformTo("number") | let g:pitch_mode = "number"
    " au FileChangedShell *.ly                :if input("File changed. Reload? (y/n)  ") == 'y' | edit | endif
augroup END
"}}}

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"                              Mappings
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

" miscellaneous {{{

"use a <C-V><SPACE> instead. Prevents extra space when creating slurs
inoremap <buffer> <LocalLeader><SPACE> <c-v><space>

" reload all lilypond files
nnoremap <LocalLeader><c-r> :bufdo call ReloadLiliypond()<CR>

" reload all files in the current window
nnoremap <LocalLeader>e :let lilypond_window_view = winsaveview() <BAR> windo edit <BAR> call winrestview(lilypond_window_view)<CR>:unlet lilypond_window_view<CR>

"}}}

" scollbind "{{{
"toggle scrollbind
nnoremap <buffer> <LocalLeader>bt :set scrollbind!<CR>
"reset scroll binding
nnoremap <buffer> <LocalLeader>br :call ResetScrollBind()<CR>
"}}}

" Align windows on current line number "{{{
nnoremap <LocalLeader>zt :exe 'silent windo' min([line("."),GetLowestLineNumberInWindows()]) '<BAR> normal zt'<CR>
nnoremap <LocalLeader>zz :exe 'silent windo' min([line("."),GetLowestLineNumberInWindows()]) '<BAR> normal zz'<CR>
nnoremap <LocalLeader>zb :exe 'silent windo' min([line("."),GetLowestLineNumberInWindows()]) '<BAR> normal zb'<CR>
"}}}

"put a | at the end of a line {{{
inoremap <buffer> <LocalLeader>b <c-o>A \|<ESC>
nnoremap <buffer> <LocalLeader>bb A \|<ESC>
"}}}

"make octave {{{
nnoremap <buffer> <LocalLeader>mo :call MakeOctave("'")<CR>
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

