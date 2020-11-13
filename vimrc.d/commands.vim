" set the b:comment_character variable below in the FileType-Specific
" Settings for the following commands
command! -nargs=+ MakeHeader  call MakeHeader(<f-args>)
command! -nargs=+ MakeSection call MakeSection(<f-args>)

command! -nargs=+ MakeTextAbbrevs call MakeTextAbbrevs(<f-args>)

command! -nargs=1 IFcheck if <args> | echo <args> "is True" | else | echo <args> "is False" | endif

command! -nargs=+ -range IndentAdjustSpaces <line1>,<line2>call IndentAdjustSpaces(<f-args>)
command! -nargs=+ -range Align <line1>,<line2>call Align(<f-args>)

command! -nargs=1 SetLanguage call SetLanguage(<f-args>)

command! -nargs=+ -range Exchange <line1>,<line2>call Exchange(<f-args>)

command! XX %s#\s\+$##e <bar> x
