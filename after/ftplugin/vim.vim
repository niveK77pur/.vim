set ts=4

". escape caracters
iabb <buffer> <e   <ESC>
iabb <buffer> <b   <buffer>
iabb <buffer> <l   <Leader>
iabb <buffer> ll   <LocalLeader>
iabb <buffer> cr   <CR>
iabb <buffer> bs   <BS>
iabb <buffer> tab  <Tab>

" motion
iabb <buffer> left  <Left>
iabb <buffer> right <Right>
iabb <buffer> up    <Up>
iabb <buffer> down  <Down>

" autocommad-events 
iabb <buffer> FT   FileType
iabb <buffer> BNF  BufNewFile
iabb <buffer> BR   BufRead

" mapping
iabb <buffer> inap inoremap
iabb <buffer> nnap nnoremap
iabb <buffer> onap onoremap

" open and closing arguments
iabb <buffer> augr augroup<CR>augroup END<Up>

" insert jump mark
inoremap <buffer> <LocalLeader>jj [>VIM<]

" make a fold out of block in .vim files
nnoremap <LocalLeader>f {jA "{{{<ESC>}O"}}}<ESC>

" make a mapping buffer local by putting <buffer>
nnoremap <LocalLeader>b ^ea <buffer> <ESC>
