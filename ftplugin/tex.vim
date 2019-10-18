"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"                                  Settings
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

setlocal tabstop=4
setlocal textwidth=70
setlocal noexpandtab
setlocal keywordprg=texdoc
"spell checking 
setlocal spell

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"                                Abbreviations
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

" use ellipsis
iabb <buffer> ... \ldots\
iabb <buffer> latex \LaTeX MH

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"                                  Mappings
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

"quotation with \enquote {{{
"use the 'csquotes' package for this
inoremap <buffer> <LocalLeader>2  \enquote{}<LEFT>
nnoremap <buffer> <LocalLeader>2 a\enquote{}<LEFT>
vnoremap <buffer> <LocalLeader>2 s\enquote{}<ESC>P
"}}}

"save, undo, redo w/o leaving insert mode {{{
inoremap <buffer> <LocalLeader>w <c-o>:w<CR>
inoremap <buffer> <LocalLeader>u <c-o>u
inoremap <buffer> <LocalLeader>r <c-o><c-r>
"}}}

"text manipulation {{{
inoremap <buffer> <LocalLeader><c-i> \textit{} [>VIM<]<c-o>T{
inoremap <buffer> <LocalLeader><c-e> \emph{} [>VIM<]<c-o>T{
inoremap <buffer> <LocalLeader><c-b> \textbf{} [>VIM<]<c-o>T{
inoremap <buffer> <LocalLeader><c-u> \underline{} [>VIM<]<c-o>T{
inoremap <buffer> <LocalLeader><c-t> \texttt{} [>VIM<]<c-o>T{

vnoremap <buffer> <LocalLeader><c-i> s\textit{}<ESC>P
vnoremap <buffer> <LocalLeader><c-e> s\emph{}<ESC>P
vnoremap <buffer> <LocalLeader><c-b> s\textbf{}<ESC>P
vnoremap <buffer> <LocalLeader><c-u> s\underline{}<ESC>P
vnoremap <buffer> <LocalLeader><c-t> s\texttt{}<ESC>P

nnoremap <buffer> <LocalLeader><space> gqip
"}}}

"insert three new lines and edit on the second one {{{
"insert below
nnoremap <buffer> <LocalLeader>o o<CR><ESC>O
"insert above
nnoremap <buffer> <LocalLeader>O O<CR><ESC>O
"}}}

"toggle spellcheck {{{
inoremap <buffer> <LocalLeader>s <c-o>:set spell! spell?<CR>
nnoremap <buffer> <LocalLeader>s :set spell! spell?<CR>
"}}}

"put word in a line into a \begin{word} and \end{word} {{{
inoremap <buffer> <LocalLeader>b <ESC>:s#\(\w\+\)#\\begin\{\1\}\r\\end\{\1\}#<CR>O
nnoremap <buffer> <LocalLeader>b :s#\(\w\+\)#\\begin\{\1\}\r\\end\{\1\}#<CR>O
"place the cursor such that you can specify parameters
inoremap <LocalLeader>B <ESC>:s#\(\w\+\)#\\begin\{\1\}\r\\end\{\1\}#<CR><UP>A
nnoremap <LocalLeader>B :s#\(\w\+\)#\\begin\{\1\}\r\\end\{\1\}#<CR><UP>A
"}}}

" use detex to get the word count of a latex file
nnoremap <LocalLeader>d :w !detex \| wc -w<CR>

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"                                Miscellaneous
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

" " Get Tex help for packages "{{{
" " TODO
" "     * Since 'texdoc' is not only used for getting the documentation of a
" "     given package, this script should verify if there exists documentation
" "     of a given keyword in 'texdoc'. If not, perform a web search.
" "     * If document exists on 'texdoc' then prompt the user to open texdoc or
" "     perform a web search.
" function GetTeXHelp()
"     let l:keyword = expand("<cword>")
"     " If the word '\usepackage' is present in the current line.
"     if match(getline("."), "\usepackage") != -1
"         " Open documentation from the official package repository (i.e.
"         " documentation from the CTAN website)
"         silent exe "!texdoc " . l:keyword
"     else
"         " Perform Google Search using the keyword and the word 'latex'
"         silent exe "!firefox --new-window --args 'https://www.duckduckgo.com/?q=latex+'" . l:keyword . " &"
"     endif    
" endfunction

" nnoremap <silent> <buffer> K :call GetTeXHelp()<CR>
" "}}}
