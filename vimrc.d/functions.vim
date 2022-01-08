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
        let l:time = strftime("%H")
        if l:time > a:start && l:time < a:end
                set background=light
        else
                set background=dark
        endif
endfunction
"}}}

function! CheckColorsGruvbox() "{{{
        " Make sure the terminal supports at least 16 colors
        " otherwise do not use gruvbox colorscheme
        let l:colors = system("tput colors")
        if l:colors == 16
                let g:gruvbox_termcolors = 16
        elseif l:colors != 256
                return v:false
        endif
        return v:true
endfunction
"}}}


function! GetCommentCharacter() "{{{
    " try
    "     return g:NERDDelimiterMap[&filetype]['left']
    " catch /^Vim\%((\a\+)\)\=:E716/
        " if exists("b:comment_character")
        "     return b:comment_character
        " else
        "     return ""
        " endif
    " endtry
    for c in split(&comments, ',')
        if c =~# '\v^b?:'
            return substitute(c, '\v^.{-}:', '', '')
        endif
    endfor
    return ''
endfunction
"}}}

function! MakeSection(...) "{{{
        let l:text = " " . join(a:000, " ") . " "
        let l:comment_character = GetCommentCharacter()
        let l:width = &textwidth > 0 ? &textwidth : 80
        let l:banner = repeat('-', l:width - len(l:comment_character) - len(l:text))
        set paste
        execute "normal o\r" . l:comment_character . l:text . l:banner
        set nopaste
endfunction
"}}}

function! MakeHeader(...) "{{{
        let l:text = join(a:000, ' ')
        let l:comment_character = GetCommentCharacter()
        let l:width = &textwidth ? &textwidth : 80
        let l:space = l:comment_character . repeat(' ', l:width/2 - len(l:text)/2 - len(l:comment_character))
        let l:banner = l:comment_character . repeat('~', l:width - len(l:comment_character))
        set paste
        execute "normal o\r" . l:banner . "\r" . l:space . l:text . "\r" . l:banner . "\r\e"
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
    " You need/ought to specify the upper case abbreviation. I.e.:
    "   1. ST  -> Some Thing
    "   2. STs -> Some Things
    let l:abbrev = tolower(a:abbrev)
    let l:text   = tolower(join(a:000))
    let l:ABBREV = toupper(a:abbrev)
    let l:TEXT   = substitute(l:text, '\<.', '\u&', 'g')
    let l:Abbrev = substitute(l:abbrev, '\<.', '\u&', '')
    let l:Text   = substitute(l:text, '\<.', '\u&', '')
    exe "iabbrev" l:ABBREV l:TEXT
    exe "iabbrev" l:abbrev l:text
    exe "iabbrev" l:Abbrev l:Text
endfunction
"}}}


function! IndentAdjustSpaces(from, to) range "{{{
    let old_ts = &tabstop
    set noexpandtab     " change to tabs
    let &tabstop = a:from
    exe a:firstline . ',' . a:lastline . 'retab!' a:to
    set expandtab       " go back to spaces
    exe a:firstline . ',' . a:lastline . 'retab' old_ts
endfunction
"}}}

function! Align(char) range "{{{
    silent exec a:firstline.','.a:lastline.'s@\s*\(' . a:char . '\)\s*@\1★@g'
    silent exec a:firstline.','.a:lastline.'!column -ts "★"'
endfunction "}}}


function! SetLanguage(lang) "{{{
    let &spelllang = a:lang
    let &spellfile = substitute(&spellfile, '\v\w+\ze\.[[:alnum:]-]+\.add$', a:lang, '')
endfunction
"}}}


function! Replace(dict) range "{{{
    exe a:firstline . ',' . a:lastline . 's#\V'.join(keys(a:dict),'\|').'#\='.string(a:dict).'[submatch(0)]#g'
endfunction
"}}}

function! Exchange(key1, key2) range "{{{
    let l:dict = {a:key1 : a:key2 , a:key2 : a:key1}
    exe a:firstline . ',' . a:lastline . 'call Replace('.string(l:dict).')'
endfunction
"}}}

