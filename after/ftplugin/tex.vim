setlocal textwidth=70
setlocal noexpandtab
"spell checking 
setlocal spell

" use ellipsis
iabb <buffer> ... \ldots\
iabb <buffer> latex \LaTeX

inoremap <Tab> <Tab> 

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
inoremap <buffer> <c-i> \textit{}<LEFT>
inoremap <buffer> <c-b> \textbf{}<LEFT>
inoremap <buffer> <c-u> \underline{}<LEFT>
inoremap <buffer> <c-t> \texttt{}<LEFT>

vnoremap <c-i> s\textit{}<ESC>P
vnoremap <c-b> s\textbf{}<ESC>P
vnoremap <c-u> s\underline{}<ESC>P
vnoremap <c-t> s\texttt{}<ESC>P
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

