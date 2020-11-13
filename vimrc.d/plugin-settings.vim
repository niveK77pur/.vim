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
let g:AutoPairsShortcutToggle = "<Leader><M-p>"
augroup AutoPairsVim
    " au FileType vim let b:AutoPairs = remove(g:AutoPairs, '"')
    au FileType vim let b:AutoPairs = {'(':')', '[':']', '{':'}',"'":"'", '`':'`'}
    au FileType lilypond let b:AutoPairs = {'{':'}','"':'"', '`':'`'}
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

let g:coc_node_path = '/usr/bin/node'
let g:coc_global_extensions = [
    \ 'coc-json',
    \ 'coc-ultisnips',
    \ 'coc-vimlsp', 
    \ 'coc-python',
    \ 'coc-vimtex'
\ ]

nnoremap <expr><C-f> coc#util#has_float() ? coc#util#float_scroll(1) : "\<C-f>"
nnoremap <expr><C-b> coc#util#has_float() ? coc#util#float_scroll(0) : "\<C-b>"

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"                                   vimtex
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

" Settings -------------------------------------------------------------------
let g:vimtex_view_method = 'zathura'
let g:vimtex_fold_enabled = 1
let g:tex_conceal='adbmgs'

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
nnoremap <Leader>fr :Rg<CR>
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
let g:UltiSnipsSnippetDirectories = [ '~/.vim/UltiSnips' ]

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"                                  Ployglot
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

" The LaTeX-Box plugin is included with vim-ployglot and conflicts with vimtex
let g:polyglot_disabled = ['latex']

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"                                 indentLine
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

let g:indentLine_char_list = ['│', '|', '¦', '┆', '┊']

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"                                    NETRW
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

let g:netrw_silent = 1

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"                                 vim-pencil
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

" let g:pencil#autoformat = 1
" let g:pencil#wrapModeDefault = 'hard'   " default is 'hard'
" " let g:pencil#textwidth = 74
" " let g:pencil#cursorwrap = 1     " 0=disable, 1=enable (def)

" nnoremap <Leader>pt :PencilToggle<CR>
" nnoremap <Leader>po :PencilOff<CR>
" nnoremap <Leader>ph :PencilHard<CR>
" nnoremap <Leader>ps :PencilSoft<CR>

" let g:turnPencilOff = v:false
" nnoremap <Leader>i :let g:turnPencilOff = v:true<CR>:PencilHard<CR>i
" nnoremap <Leader>a :let g:turnPencilOff = v:true<CR>:PencilHard<CR>a

" augroup pencil
"     autocmd!
"     au FileType text call pencil#init({'wrap': 'hard'})
"     au FileType tex,latex,markdown call pencil#init({'wrap': 'hard'})
"     au InsertLeave *.tex if g:turnPencilOff | call execute('PencilOff') | let g:turnPencilOff = v:false | endif
"     au FileType clipboard call pencil#init({'wrap': 'soft', 'autoformat': 0})
" augroup END

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"                                  vim-ditto
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

" Turn Ditto on and off
nmap <Leader>dt <Plug>ToggleDitto
" Jump to the next word
nmap <Leader>dn <Plug>DittoNext
" Jump to the previous word
nmap <Leader>dp <Plug>DittoPrev
" Ignore the word under the cursor
nmap <Leader>d+ <Plug>DittoGood
" Stop ignoring the word under the cursor
nmap <Leader>d- <Plug>DittoBad
" Show the next matches
nmap <Leader>d> <Plug>DittoMore
" Show the previous matches
nmap <Leader>d< <Plug>DittoLess

augroup ditto
    autocmd!
    au FileType markdown,text,tex,latex DittoOn
augroup END

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"                                 vim-lexical
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

" let g:lexical#spell = 1         " 0=disabled, 1=enabled
" let g:lexical#spelllang = ['en_us','en_ca',]
" let g:lexical#thesaurus = ['~/.vim/thesaurus/mthesaur.txt',]
" let g:lexical#dictionary = ['/usr/share/dict/words',]

" augroup lexical
"     autocmd!
"     au FileType markdown,text,tex,latex call lexical#init()
"     au FileType clipboard call lexical#init()
" augroup END
