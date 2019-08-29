setlocal ts=2
setlocal define=function

iabbrev <buffer> begine begin<CR>end;<Up><Right><CR> 
iabbrev <buffer> wln    writeln()<left>
iabbrev <buffer> wlns   writeln('')<Left><Left>
iabbrev <buffer> intr   integer
iabbrev <buffer> :: :=
iabbrev <buffer> id   imgDessin
iabbrev <buffer> idc  imgDessin.Canvas
iabbrev <buffer> idcp imgDessin.Canvas.Pen
iabbrev <buffer> idcb imgDessin.Canvas.Brush
iabbrev <buffer> idcr imgDessin.Canvas.Rectangle()<Left>

" navigate to previous 'var' declaration
inoremap <buffer> <LocalLeader>gv <ESC>?\cvar<CR>
nnoremap <buffer> <LocalLeader>gv ?\cvar<CR>
" 'const' declaration
inoremap <buffer> <LocalLeader>gc <ESC>?\cconst<CR>
nnoremap <buffer> <LocalLeader>gc ?\cconst<CR>

" Put semi-colon at the end of the line
inoremap <buffer> <LocalLeader>, <ESC>A;<ESC>
nnoremap <buffer> <LocalLeader>, A;<ESC>

" put writeln(text); around the entire line
"nnoremap <buffer> <LocalLeader>p Iwriteln(<ESC>A);<ESC>
"inoremap <buffer> <LocalLeader>p <c-o>Iwriteln(<c-o>A);

" insert 'begin end' or 'begin end;'
inoremap <buffer> <LocalLeader>bb <c-o>$<CR>begin<CR><TAB><CR>end;<UP>
inoremap <buffer> <LocalLeader>BB <c-o>$<CR>begin<CR><TAB><CR>end<UP>

" wrap a 'begin end' around the current line
nnoremap <buffer> <LocalLeader>wb Obegin<ESC><Down>>>oend<ESC><<<UP>
inoremap <buffer> <LocalLeader>wb <ESC>Obegin<ESC><Down>>>oend<ESC><<<UP>A

" wrap a 'begin end;' around the current line
nnoremap <buffer> <LocalLeader>we Obegin<ESC><Down>>>oend;<ESC><<<UP>
inoremap <buffer> <LocalLeader>we <ESC>Obegin<ESC><Down>>>oend;<ESC><<<UP>A

" wrap a 'begin end' or 'begin end;' around selected text
vnoremap <buffer> <LocalLeader>wb <ESC>'<Obegin<ESC>'>oend<ESC>'<>'>
vnoremap <buffer> <LocalLeader>we <ESC>'<Obegin<ESC>'>oend;<ESC>'<>'>

" wrap 'conversion(...)' around selected text
vnoremap <buffer> <LocalLeader>csi v`>a)<c-o>`<strToInt(<ESC>
vnoremap <buffer> <LocalLeader>cis v`>a)<c-o>`<intToStr(<ESC>
vnoremap <buffer> <LocalLeader>cfs v`>a)<c-o>`<floatToStr(<ESC>
vnoremap <buffer> <LocalLeader>csf v`>a)<c-o>`<strToFloat(<ESC>
vnoremap <buffer> <LocalLeader>Csi v`>a)<c-o>`<strToIntDef(<ESC>f)i
vnoremap <buffer> <LocalLeader>Cis v`>a)<c-o>`<intToStrDef(<ESC>f)i
vnoremap <buffer> <LocalLeader>Cfs v`>a)<c-o>`<floatToStrDef(<ESC>f)i
vnoremap <buffer> <LocalLeader>Csf v`>a)<c-o>`<strToFloatDef(<ESC>f)i

" insert 'conversion(...)'
inoremap <buffer> <LocalLeader>csi strToInt()<Left>
inoremap <buffer> <LocalLeader>cis intToStr()<Left>
inoremap <buffer> <LocalLeader>cfs floatToStr()<Left>
inoremap <buffer> <LocalLeader>csf strToFloat()<Left>
inoremap <buffer> <LocalLeader>Csi strToIntDef(, [>VIM<])<c-o>F,
inoremap <buffer> <LocalLeader>Cis intToStrDef(, [>VIM<])<c-o>F,
inoremap <buffer> <LocalLeader>Cfs floatToStrDef(, [>VIM<])<c-o>F,
inoremap <buffer> <LocalLeader>Csf strToFloatDef(, [>VIM<])<c-o>F,

" append type to variables (end of line)
inoremap <buffer> <LocalLeader>ti <c-o>$ : integer;<ESC>
inoremap <buffer> <LocalLeader>ts <c-o>$ : string;<ESC>
inoremap <buffer> <LocalLeader>tc <c-o>$ : char;<ESC>
inoremap <buffer> <LocalLeader>tb <c-o>$ : boolean;<ESC>
inoremap <buffer> <LocalLeader>tr <c-o>$ : real;<ESC>
inoremap <buffer> <LocalLeader>te <c-o>$ : extended;<ESC>
inoremap <buffer> <LocalLeader>taa <c-o>$ : array [] of [>VIM<];<ESC>2F[a
inoremap <buffer> <LocalLeader>tai <c-o>$ : array [] of integer;<ESC>F[a
inoremap <buffer> <LocalLeader>tas <c-o>$ : array [] of string;<ESC>F[a
inoremap <buffer> <LocalLeader>tac <c-o>$ : array [] of char;<ESC>F[a
inoremap <buffer> <LocalLeader>tab <c-o>$ : array [] of boolean;<ESC>F[a
inoremap <buffer> <LocalLeader>tar <c-o>$ : array [] of real;<ESC>F[a
inoremap <buffer> <LocalLeader>tae <c-o>$ : array [] of extended;<ESC>F[a

" append type to variables (at cursor position)
inoremap <buffer> <LocalLeader>Ti :integer
inoremap <buffer> <LocalLeader>Ts :string
inoremap <buffer> <LocalLeader>Tc :char
inoremap <buffer> <LocalLeader>Tb :boolean
inoremap <buffer> <LocalLeader>Tr :real
inoremap <buffer> <LocalLeader>Te :extended
inoremap <buffer> <LocalLeader>Taa :array [] of [>VIM<]<ESC>2F[a
inoremap <buffer> <LocalLeader>Tai :array [] of integer<ESC>F[a
inoremap <buffer> <LocalLeader>Tas :array [] of string<ESC>F[a
inoremap <buffer> <LocalLeader>Tac :array [] of char<ESC>F[a
inoremap <buffer> <LocalLeader>Tab :array [] of boolean<ESC>F[a
inoremap <buffer> <LocalLeader>Tar :array [] of real<ESC>F[a
inoremap <buffer> <LocalLeader>Tae :array [] of extended<ESC>F[a

"insert function/procedure template
inoremap <buffer> <LocalLeader>if function <CR>begin<CR><TAB>[>VIM<]<CR><c-d>end;<ESC><UP><UP><UP>A
nnoremap <buffer> <LocalLeader>if ofunction <CR>begin<CR><TAB>[>VIM<]<CR><c-d>end;<ESC><UP><UP><UP>A
inoremap <buffer> <LocalLeader>ip procedure <CR>begin<CR><TAB>[>VIM<]<CR><c-d>end;<ESC><UP><UP><UP>A
nnoremap <buffer> <LocalLeader>ip oprocedure <CR>begin<CR><TAB>[>VIM<]<CR><c-d>end;<ESC><UP><UP><UP>A
"insert function/procedure template with variables
inoremap <buffer> <LocalLeader>iF function <CR>var<CR><TAB>[>VIM<]<CR><c-d>begin<CR><TAB>[>VIM<]<CR><c-d>end;<ESC><UP><UP><UP><UP><UP>A
nnoremap <buffer> <LocalLeader>iF ofunction <CR>var<CR><TAB>[>VIM<]<CR><c-d>begin<CR><TAB>[>VIM<]<CR><c-d>end;<ESC><UP><UP><UP><UP><UP>A
inoremap <buffer> <LocalLeader>iP procedure <CR>var<CR><TAB>[>VIM<]<CR><c-d>begin<CR><TAB>[>VIM<]<CR><c-d>end;<ESC><UP><UP><UP><UP><UP>A
nnoremap <buffer> <LocalLeader>iP oprocedure <CR>var<CR><TAB>[>VIM<]<CR><c-d>begin<CR><TAB>[>VIM<]<CR><c-d>end;<ESC><UP><UP><UP><UP><UP>A

"insert type template
inoremap <buffer> <LocalLeader>it type  = record<CR><TAB>[>VIM<]<CR><c-d>end;<UP><UP><ESC>0ela

"insert if template
inoremap <buffer> <LocalLeader>ii if () then<CR>begin<CR><TAB>[>VIM<]<CR><c-d>end<ESC><UP><UP><UP>0f(a
inoremap <buffer> <LocalLeader>iI if () then<CR>begin<CR><TAB>[>VIM<]<CR><c-d>end;<ESC><UP><UP><UP>0f(a

"insert case template
inoremap <buffer> <LocalLeader>ic case  of<CR><TAB>[>VIM<]<CR><c-d>end;<ESC><UP><UP>0ela

"insert for/while loop template
inoremap <buffer> <LocalLeader>ilf for to [>VIM<] do<CR>begin<CR><TAB>[>VIM<]<CR><c-d>end;<ESC><UP><UP><UP>0ea 
inoremap <buffer> <LocalLeader>ilw while () do<CR>begin<CR><TAB>[>VIM<]<CR><c-d>end;<ESC><UP><UP><UP>0f(a

" delete surrounding 'begin ... end' block
nnoremap <buffer> <LocalLeader>db ?begin<CR>dd/end;\?<CR>dd``j<``

" make 'var := var + 1'. 'var' needs to be longer than 1 character
inoremap <buffer> <LocalLeader>++ <ESC>ByEA := <c-o>p + 1;<ESC>

" transform C style ternary operator to if else statement. i.e.:
" var1 := condition ? value1 : value2;          <-- becomes:
" if (condition) then
"   var1 := value1
" else
"   var1 := value2;
nnoremap <buffer> <LocalLeader>to :s#\(\s*\)\(\w.\+\)\s*:=\s*\(\w.\+\)\s\+?\s\+\('\?.\+'\?\)\s\+:\s\+\('\?.\+'\?\);\?#\1if (\3) then\r\1\t\2 := \4\r\1else\r\1\t\2 := \5#<CR>
inoremap <buffer> <LocalLeader>to <ESC>:s#\(\s*\)\(\w.\+\)\s*:=\s*\(\w.\+\)\s\+?\s\+\('\?.\+'\?\)\s\+:\s\+\('\?.\+'\?\);\?#\1if (\3) then\r\1\t\2 := \4\r\1else\r\1\t\2 := \5#<CR>

" (un)comment selected lines
vnoremap <LocalLeader>cc v'<O{<ESC>'>o}<ESC>
nnoremap <LocalLeader>cc /}<CR>%dd``dd
