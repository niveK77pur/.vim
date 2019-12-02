set tabstop=4

let g:NERDCustomDelimiters['c'] = g:NERDDelimiterMap['cpp']

iabb <buffer> <, << endl;

" Put semi-colon at the end of the line
inoremap <LocalLeader>, <ESC>A;<CR>
inoremap <LocalLeader>; <ESC>A;<ESC>
nnoremap <LocalLeader>, A;<ESC>

" insert std::
inoremap <LocalLeader>s std::
