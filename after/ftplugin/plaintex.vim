setlocal textwidth=70
setlocal noexpandtab
"spell checking 
setlocal spell

" use ellipsis
iabb <buffer> ... \ldots\

"quotation with \enquote
inoremap <buffer> <LocalLeader>2  \enquote{}<LEFT>
nnoremap <buffer> <LocalLeader>2 a\enquote{}<LEFT>

"save, undo, redo w/o leaving insert mode
inoremap <buffer> <LocalLeader>w <c-o>:w<CR>
inoremap <buffer> <LocalLeader>u <c-o>u
inoremap <buffer> <LocalLeader>r <c-o><c-r>

"delete text w/o leaving insert mode
" use vim's <c-w> in insert mode alternatively (:h i_CTRL-W)
inoremap <buffer> <LocalLeader><BS> <c-w>

"text manipulation
inoremap <buffer> <c-i> \textit{}<LEFT>
inoremap <buffer> <c-b> \textbf{}<LEFT>
inoremap <buffer> <c-u> \underline{}<LEFT>

"insert three new lines and edit on the second one
"insert below
nnoremap <buffer> <LocalLeader>o o<CR><ESC>O
"insert above
nnoremap <buffer> <LocalLeader>O O<CR><ESC>O

"toggle spellcheck
inoremap <buffer> <LocalLeader>s <c-o>:set spell! spell?<CR>
nnoremap <buffer> <LocalLeader>s :set spell! spell?<CR>
