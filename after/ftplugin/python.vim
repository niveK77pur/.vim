setlocal define=def

iabb <buffer> slef  self
iabb <buffer> none  None
iabb <buffer> true  True
iabb <buffer> false False

inoremap <LocalLeader>s self.
inoremap <LocalLeader>=S <ESC>:s#\(\w\+\)#self.\1 = \1#<CR>

