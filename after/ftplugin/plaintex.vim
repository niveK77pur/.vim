set textwidth=70
"spell checking 
set spell

"save, undo, redo w/o leaving insert mode
inoremap <LocalLeader>w <c-o>:w<CR>
inoremap <LocalLeader>u <c-o>u
inoremap <LocalLeader>r <c-o><c-r>

"delete text w/o leaving insert mode
inoremap <LocalLeader><BS> <c-o>db

"text manipulation
inoremap <c-i> \textit{}<LEFT>
inoremap <c-b> \textbf{}<LEFT>
inoremap <c-u> \underline{}<LEFT>

" use ellips
iabb <buffer> ... \ldots\

"quotation with \enquote
iabb <buffer> <2 \enquote{
iabb <buffer> >2 }
