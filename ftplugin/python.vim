setlocal define=def

let b:template_file = "$HOME/.vim/skeletons/Python/templates.py"

iabb <buffer> slef  self
iabb <buffer> none  None
iabb <buffer> true  True
iabb <buffer> false False
iabb <buffer> classi <c-o>:call FromTemplate("ClassInit")<CR>

inoremap <LocalLeader>s self.
inoremap <LocalLeader>S self.__
inoremap <LocalLeader>=S <ESC>:s#\(\w\+\)#self.\1 = \1#<CR>
inoremap <LocalLeader>=s <ESC>:s#\(\w\+\)#self.__\1 = \1#<CR>
