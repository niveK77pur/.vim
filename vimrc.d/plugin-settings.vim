"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"                                NERDCommenter
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

let g:NERDSpaceDelims = 1
let g:NERDDefaultAlign = 'left'
let g:NERDCustomDelimiters = {
    \ 'swift': { 'left': '//', 'right': '', 'leftAlt': '/*', 'rightAlt': '*/' },
    \ 'html' : { 'left': '<!--', 'right': '-->', 'leftAlt': '//' },
    \ 'c' : {'rightAlt': '*/', 'leftAlt': '/*', 'left': '//'}
\ }
    " \ 'c' : g:NERDDelimiterMap['cpp']

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"                                  NERDTree
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

"Toggle NERDTree
nnoremap <Leader>nn :NERDTreeToggle<CR>
nnoremap <Leader>nb :NERDTreeFocus<CR>:BookmarkToRoot 
nnoremap <Leader>N  :NERDTreeFocus<CR>

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"                                  AutoPairs
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

let g:AutoPairsMoveCharacter = ""   "Fix 'bug' where § does funny things in insert mode
augroup AutoPairsVim
    " au FileType vim let b:AutoPairs = remove(g:AutoPairs, '"')
    au FileType vim let b:AutoPairs = {'(':')', '[':']', '{':'}',"'":"'", '`':'`'}
    " au FileType vim inoremap " ""<Left>
augroup END

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"                                    CoVim
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

let CoVim_default_name = "Mace Vimdu"
let CoVim_default_port = "8080"

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"                                     COC
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

nnoremap <expr><C-f> coc#util#has_float() ? coc#util#float_scroll(1) : "\<C-f>"
nnoremap <expr><C-b> coc#util#has_float() ? coc#util#float_scroll(0) : "\<C-b>"

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"                                   vimtex
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

" Settings -------------------------------------------------------------------
let g:vimtex_view_method = 'zathura'
let g:tex_conceal='abdmg'

" Mappings -------------------------------------------------------------------
nmap <LocalLeader>ls <plug>(vimtex-compile-ss)

nnoremap <LocalLeader>cw :VimtexCountWords<CR>
nnoremap <LocalLeader>cl :VimtexCountLetters<CR>

" Latex Documentation --------------------------------------------------------
let g:vimtex_doc_handlers = ['TexdocHandler']
function! TexdocHandler(context)
  call vimtex#doc#make_selection(a:context)
  if !empty(a:context.selected)
    silent execute '!texdoc' a:context.selected '&'
  endif
  return 1
endfunction

" Warnings to ignore ---------------------------------------------------------
let g:vimtex_quickfix_latexlog = {
    \ 'overfull' : 0,
    \ 'underfull' : 0,
    \ 'packages' : {
    \    'hyperref' : 0,
    \ },
    \}

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"                                   fzf.vim
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

" FZF Commands
nnoremap <Leader>ff :Files<CR>
nnoremap <Leader>fb :Buffers<CR>
nnoremap <Leader>fl :BLines<CR>
nnoremap <Leader>fL :Lines<CR>
nnoremap <Leader>fh :Helptags<CR>

" Insert mode completion
imap <Leader><c-x><c-k> <plug>(fzf-complete-word)
imap <Leader><c-x><c-f> <plug>(fzf-complete-path)
imap <Leader><c-x><c-j> <plug>(fzf-complete-file-ag)
imap <Leader><c-x><c-l> <plug>(fzf-complete-line)
imap <Leader><c-x><c-L> <plug>(fzf-complete-buffer-line)

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"                                  UltiSnips
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

let g:UltiSnipsEditSplit = 'tabdo'
let g:UltiSnipsSnippetsDir = '~/.vim/UltiSnips'

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"                                  Ployglot
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

" The LaTeX-Box plugin is included with vim-ployglot and conflicts with vimtex
let g:polyglot_disabled = ['latex']

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"                                   localrc
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

nnoremap <Leader>L :exe 'tabnew' join(g:localrc#search(g:localrc_filename), ' ')<CR>
