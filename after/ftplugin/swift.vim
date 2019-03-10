setl tabstop=4

inoremap <LocalLeader>s self.
inoremap <LocalLeader>=S <ESC>:s#\(\w\+\)#self.\1 = \1#<CR>

