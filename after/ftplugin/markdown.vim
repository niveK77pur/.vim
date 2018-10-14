setl tabstop=2
setl textwidth=80

" bold text
nnoremap <LocalLeader>b bi__<ESC>ea__<ESC>
vnoremap <LocalLeader>b v`<i__<ESC>`>ea__<ESC>
"vnoremap <LocalLeader>b va__<ESC>`<i__<ESC>

" italic text
nnoremap <LocalLeader>i bi_<ESC>ea_<ESC>
vnoremap <LocalLeader>i v`<i_<ESC>`>ea_<ESC>


" Change Title (underlined)
"onoremap: operator pending, see :help map-modes
onoremap ih :<c-u>execute "normal! ?.*==\\+$\r:nohlsearch\rkvg_"<CR>
onoremap ah :<c-u>execute "normal! ?.*==\\+$\r:nohlsearch\rg_vk0"<CR>
onoremap iH :<c-u>execute "normal! ?.*--\\+$\r:nohlsearch\rkvg_"<CR>
onoremap aH :<c-u>execute "normal! ?.*--\\+$\r:nohlsearch\rkv2g_"<CR>

" Change behaviour of <ENTER> in insert mode when listing stuff
"function! MD_listing_enter()
"    <ESC>^yl
"    for i in [-,+,*]
"        if "" ==# i
"            o\i
"    endfor
