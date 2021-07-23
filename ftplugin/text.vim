setl textwidth=70
setl tabstop=4
setl nosmartindent

"inoremap jk jk
inoremap <buffer> <LocalLeader>w <c-o>:w<CR>
inoremap <buffer> <LocalLeader>u <c-o>u
inoremap <buffer> <LocalLeader>r <c-o><c-r>

"join paragraph into single line
nnoremap <LocalLeader>J vipJ0}}{j

nnoremap <buffer> <LocalLeader><space> gqip
