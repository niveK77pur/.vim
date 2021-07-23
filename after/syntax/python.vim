hi Conceal guibg=None guifg=white

syntax conceal on
syntax keyword Error lambda cchar=λ
syntax match todo "&amp;" containedin=pythonString contained cchar=&
syntax match todo "\[\ \]" contained cchar=
syntax match todo "\[x\]"  contained cchar=
syntax conceal off
