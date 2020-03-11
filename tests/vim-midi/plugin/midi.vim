function! s:OnEvent(id, data, event) dict
  let str = join(a:data, "\n")
  exe 'normal! o"' . str
endfunction
" let id = jobstart(['python3', '-u', 'testmidi.py'], {'on_stdout': function('s:OnEvent') } )
