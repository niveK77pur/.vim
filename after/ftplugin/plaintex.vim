set textwidth=70
"spell checking 
set spell

"save, undo, redo w/o leaving insert mode
inoremap <buffer> <LocalLeader>w <c-o>:w<CR>
inoremap <buffer> <LocalLeader>u <c-o>u
inoremap <buffer> <LocalLeader>r <c-o><c-r>

"delete text w/o leaving insert mode
inoremap <buffer> <LocalLeader><BS> <c-o>db

"text manipulation
inoremap <buffer> <c-i> \textit{}<LEFT>
inoremap <buffer> <c-b> \textbf{}<LEFT>
inoremap <buffer> <c-u> \underline{}<LEFT>

" use ellips
iabb <buffer> ... \ldots\

"quotation with \enquote
iabb <buffer> <2 \enquote{
iabb <buffer> >2 }
