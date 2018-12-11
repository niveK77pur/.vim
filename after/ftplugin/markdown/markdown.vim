setl tabstop=2
setl textwidth=80

" bold text
nnoremap <buffer> <LocalLeader>b bi__<ESC>ea__<ESC>
vnoremap <buffer> <LocalLeader>b v`<i__<ESC>`>ea__<ESC>
"vnoremap <LocalLeader>b va__<ESC>`<i__<ESC>

" italic text
nnoremap <buffer> <LocalLeader>i bi_<ESC>ea_<ESC>
vnoremap <buffer> <LocalLeader>i v`<i_<ESC>`>ea_<ESC>

" highlight double spaces at the end of a line
" (this creates a new line in the rendered version)
nnoremap <buffer> <LocalLeader>n /<space><space>$<CR>


" Change Title (underlined)
"onoremap: operator pending, see :help map-modes
onoremap <buffer> ih :<c-u>execute "normal! ?.*==\\+$\r:nohlsearch\rkvg_"<CR>
onoremap <buffer> ah :<c-u>execute "normal! ?.*==\\+$\r:nohlsearch\rg_vk0"<CR>
onoremap <buffer> iH :<c-u>execute "normal! ?.*--\\+$\r:nohlsearch\rkvg_"<CR>
onoremap <buffer> aH :<c-u>execute "normal! ?.*--\\+$\r:nohlsearch\rkv2g_"<CR>

" Change behaviour of <ENTER> in insert mode when listing stuff
"function! MD_listing_enter()
"    <ESC>^yl
"    for i in [-,+,*]
"        if "" ==# i
"            o\i
"    endfor
