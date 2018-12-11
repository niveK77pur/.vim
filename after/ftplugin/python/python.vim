setlocal define=def

iabb <buffer> slef  self
iabb <buffer> none  None
iabb <buffer> true  True
iabb <buffer> false False

inoremap <buffer> <LocalLeader>s self.
inoremap <buffer> <LocalLeader>S self.__
inoremap <buffer> <LocalLeader>=S <ESC>:s#\(\w\+\)#self.\1 = \1#<CR>
inoremap <buffer> <LocalLeader>=s <ESC>:s#\(\w\+\)#self.__\1 = \1#<CR>

