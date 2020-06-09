"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"                                  Mappings
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

" simple 'x' → 'this.x = x;'
nnoremap <LocalLeader>=t :s#\w\+#this.& = &;#<CR>
inoremap <LocalLeader>=t <ESC>:s#\w\+#this.& = &;#<CR>

nnoremap <LocalLeader>=T :call MakeFuncArgsContructor()<CR>
nnoremap <LocalLeader>=C :call MakeFuncArgsContructorGetSet()<CR>

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"                                      Functions
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

function! MakeFuncArgsContructor()
    normal! A {
    copy .
    s#\v\s*\S.*\(\s*(.{-})\s*\).*#\1#
    s#\v.{-} (\w+)[,\n]#this.\1 = \1;\r#g
    exec "normal! O}\<esc>=ip']"
endfunction

function! MakeFuncArgsContructorGetSet()
    normal! A {
    copy .
    copy .
    .-1,.s#\v\s*\S.*\(\s*(.{-})\s*\).*#\1#
    .-1s#\v.{-} (\w+)[,\n]#this.\1 = \1;\r#g
    exec "normal! O}\<esc>=ip']"
    s#\v(\w.{-}) (\w+)[,\n]#\rpublic \1 get\u\2() {\rreturn \2;\r}\rpublic void set\u\2(\1 \2) {\rthis.\2 = \2;\r}\r#g
    normal! ='[']
endfunction

