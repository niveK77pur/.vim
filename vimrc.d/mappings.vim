"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"                               Add information
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

" Name & Student ID ----------------------------------------------------------
nmap <Leader>an gg}oName: Kevin Biewesch<CR>StudentID: 0180556255<CR><ESC><UP>vip<Leader>cc

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"                                   Editing
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

" vim configs ----------------------------------------------------------------

" Quickly edit vimrc file
nnoremap <leader>ve :tabnew <BAR> Files ~/.vim/vimrc.d<CR>
" if exists(':Files')
"     nnoremap <leader>ve :tabnew <BAR> Files ~/.vim/vimrc.d<CR>
" elseif exists(':NERDTree')
"     nnoremap <leader>ve :tabnew <BAR> NERDTree ~/.vim/vimrc.d<CR>
" else
"     nnoremap <leader>ve :tabnew ~/.vim/vimrc.d/
" endif
    

" edit filtype plugin of current file
nnoremap <Leader>F :exe ":tabnew $HOME/.vim/ftplugin/" . &filetype . ".vim"<CR>

" edit UltiSnips snippet definition of current filetype
nnoremap <Leader>S :UltiSnipsEdit<CR>

" text manipulation ----------------------------------------------------------

" toggle 'paste'
nnoremap <F2> :set paste! paste?<CR>

" exit insert mode more comfortably
inoremap jk <left><esc> 

" save and reload files "{{{
inoremap <Leader>s <c-o>:wa<CR>
nnoremap <Leader>s :wa<CR>
inoremap <Leader>e <c-o>:e<CR>
nnoremap <Leader>e :e<CR>
"}}}

" mapping for uni keyboard without <,> and \ "{{{
" noremap  § <
" inoremap § <
" cnoremap § <
" noremap  ° >
" inoremap ° >
" cnoremap ° >
" noremap  ¬ \
" inoremap ¬ \
" cnoremap ¬ \
"}}}

" Add 'TEST<<' to end of line and remove these lines {{{
inoremap <Leader>tt <ESC>:exe 'normal A' . b:comment_character . '<<TEST<<'<CR>
nnoremap <Leader>tt      :exe 'normal A' . b:comment_character . '<<TEST<<'<CR>
nnoremap <Leader>td :g/<<TEST<</normal dd<CR>
" }}}

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"                                  Settings
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

"Toggle number and relativenumber
noremap <F3> :set relativenumber! number! relativenumber?<CR><ESC>

"Toggle line wrapping
noremap <F5> :set wrap! wrap?<CR>

" execute macros comfortably (and remove unnecessary ex mode, see :h gQ)
nnoremap Q @

" terminal mappings {{{
tnoremap <Leader>t <C-W>:tabprevious<CR>
tnoremap <Leader>T <C-W>:tabnext<CR>
tnoremap <Leader>w <C-W>p
" }}}

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"                                  Interface
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

" see tabs, spaces and what have you "{{{
nnoremap <Leader>l :set list! list?<CR>
inoremap <Leader>l <ESC>:set list! list?<CR>a
"}}}

" the custom [>VIM<] tag "{{{
" insert a [>VIM<] to jump to
inoremap <Leader>j [>VIM<]

" jump to next [>VIM<] tag
nnoremap <Leader>j /\[>VIM<\]<CR>

" jump to and replace next [>VIM<] tag
inoremap <Leader><space> <ESC>/\[>VIM<\]<CR>v//e<CR>s
nnoremap <Leader><space> /\[>VIM<\]<CR>v//e<CR>s
"}}}

"Toggle highlighting stuff"{{{
noremap <Leader>hs :set hlsearch! hlsearch?<CR>
noremap <Leader>hl :set cursorline! cursorline?<CR>
noremap <Leader>hc :set cursorcolumn! cursorcolumn?<CR>
noremap <Leader>hf :call ToggleFoldcolumn()<CR>
"}}}

" toggle 'background' between light and dark
" nnoremap <F6> :call ToggleBackground()<CR>

" toggle Goyo
nnoremap <F10> :Goyo<CR>

noremap <F12> :echo "\\°O°/"<CR>

" navigate windows with ALT+{h,j,k,l} "{{{
tnoremap <A-h> <C-\><C-N><C-w>h 
tnoremap <A-j> <C-\><C-N><C-w>j
tnoremap <A-k> <C-\><C-N><C-w>k
tnoremap <A-l> <C-\><C-N><C-w>l
inoremap <A-h> <C-\><C-N><C-w>h
inoremap <A-j> <C-\><C-N><C-w>j
inoremap <A-k> <C-\><C-N><C-w>k
inoremap <A-l> <C-\><C-N><C-w>l
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l
"}}}

