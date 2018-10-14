set tabstop=4

iabb <buffer> <, << endl;

" Put semi-colon at the end of the line
inoremap <LocalLeader>, <ESC>A;<CR>
inoremap <LocalLeader>; <ESC>A;<ESC>
nnoremap <LocalLeader>, A;<ESC>

" Create loops (templates)
inoremap <LocalLeader>cw while (<C-O>mm)<CR>{<CR>>>VIM<<<CR>};<C-O>`m<Right>
inoremap <LocalLeader>cf for (int <C-O>mm)<CR>{<CR>>>VIM<<<CR>};<C-O>`m<Right>

" insert std::
inoremap <LocalLeader>s std::
