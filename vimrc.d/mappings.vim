"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"                                   Editing
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

" vim configs ----------------------------------------------------------------{{{1
" Quickly edit vimrc file "{{{
nnoremap <leader>ve :tabnew <BAR> Files ~/.vim/vimrc.d<CR>
" if exists(':Files')
"     nnoremap <leader>ve :tabnew <BAR> Files ~/.vim/vimrc.d<CR>
" elseif exists(':NERDTree')
"     nnoremap <leader>ve :tabnew <BAR> NERDTree ~/.vim/vimrc.d<CR>
" else
"     nnoremap <leader>ve :tabnew ~/.vim/vimrc.d/
" endif
"}}}

" edit filtype plugin of current file
nnoremap <Leader>F :exe ":tabnew $HOME/.vim/ftplugin/" . &filetype . ".vim"<CR>

" edit UltiSnips snippet definition of current filetype
nnoremap <Leader>S :UltiSnipsEdit<CR>

" edit localrc file
nnoremap <Leader>L :exe 'tabnew' join(g:localrc#search(g:localrc_filename), ' ')<CR>

" text manipulation ----------------------------------------------------------{{{1

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

" Registers ------------------------------------------------------------------{{{1

" paste text in " register more easily in insert mode
inoremap <a-p> <c-r>"

" copy directly to clipboard "{{{
nnoremap <Leader>yy "+yy
vnoremap <Leader>y "+y
"}}}

" paste directly from clipboard "{{{
nnoremap <Leader>p "+p
nnoremap <Leader>P "+P
nnoremap <Leader>[p "+[p
nnoremap <Leader>]p "+]p
nnoremap <Leader>[P "+[P
nnoremap <Leader>]P "+]P
"}}}

"}}}1

" execute macros comfortably (and remove unnecessary ex mode, see :h gQ)
nnoremap Q @

" conveniently execute macro in register 'q'
nnoremap <space> @q
" empty the 'q' register to avoid running a macro by accident
nnoremap <c-space> :let @q=""<CR>

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"                                  Settings
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

"Toggle number and relativenumber
noremap <F3> :set relativenumber! number! relativenumber?<CR><ESC>

"Toggle line wrapping
noremap <F5> :set wrap! wrap?<CR>

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

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"                                 Navigation
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

" navigate windows with ALT+{h,j,k,l} "{{{
if has('nvim') || has('terminal')
    tnoremap <A-h> <C-\><C-N><C-w>h 
    tnoremap <A-j> <C-\><C-N><C-w>j
    tnoremap <A-k> <C-\><C-N><C-w>k
    tnoremap <A-l> <C-\><C-N><C-w>l
endif
inoremap <A-h> <C-\><C-N><C-w>h
inoremap <A-j> <C-\><C-N><C-w>j
inoremap <A-k> <C-\><C-N><C-w>k
inoremap <A-l> <C-\><C-N><C-w>l
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l
"}}}

" use ALT+{, .} to navigate tabs "{{{
if has('nvim') || has('terminal')
    tnoremap <A-,> <C-\><C-N>:tabprevious<CR>
    tnoremap <A-.> <C-\><C-N>:tabnext<CR>
endif
inoremap <A-,> <esc>:tabprevious<CR>
inoremap <A-.> <esc>:tabnext<CR>
nnoremap <A-,> :tabprevious<CR>
nnoremap <A-.> :tabnext<CR>
"}}}

" use arrow keys to move linewise on wrapped lines "{{{
nnoremap  <up>    g<up>
nnoremap  <down>  g<down>
inoremap  <up>    <c-o>g<up>
inoremap  <down>  <c-o>g<down>
"}}}

" use ALT+{h,j,k,l} to move cursor in insert mode "{{{
inoremap <a-h> <left>
inoremap <a-j> <down>
inoremap <a-k> <up>
inoremap <a-l> <right>
"}}}

