"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"                           Vimscript file settings
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

augroup filetype_vim
        autocmd!
        autocmd FileType vim setlocal foldmethod=marker
augroup END


"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"                            Compiling source code
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

" functions for compiling code {{{

function! RunMessage() "{{{
    !$HOME/bin/draw_center_text.sh "Running program"
endfunction
"}}}

function! s:createTrackedTerm(cmd, where, options, track) "{{{
    let l:cmd = substitute(a:cmd, '%', '\=expand("%")', '')
    if bufexists(winbufnr(eval(a:track)))
        " return to previous terminal if it still exists
        call win_gotoid(eval(a:track))
        call term_start(l:cmd, extend({"curwin": v:true},a:options))
    else
        " create new terminal if none exists
        if a:where ==? 'vertical' || a:where ==? 'v'
            exe 'let' a:track '= win_findbuf(term_start(l:cmd, extend({"vertical":1},a:options)))[0]'
        elseif a:where ==? 'horizontal' || a:where ==? 'h'
            exe 'let' a:track '= win_findbuf(term_start(l:cmd, a:options))[0]'
        elseif a:where ==? 'auto' || a:where ==? 'a'
            echo winwidth(0) '>' winheight(0)
            if winwidth(0) > winheight(0)
                " s:createTrackedTerm(a:cmd, 'vertical', a:track)
                echom "V"
                exe 'let' a:track '= win_findbuf(term_start(l:cmd, extend({"vertical":1},a:options)))[0]'
            else
                " s:createTrackedTerm(a:cmd, 'horizontal', a:track)
                echom "H"
                exe 'let' a:track '= win_findbuf(term_start(l:cmd,a:options))[0]'
            endif
        elseif a:where ==? 'tab' || a:where ==? 't'
            exe 'tab let' a:track '= win_findbuf(term_start(l:cmd,a:options))[0]'
        endif
    endif
endfunction
"}}}

" function! RunTermCommand(cmd, where=eval('g:where_term'), options={}, track='g:compile_term') "{{{
"     " cmd   : String of command to be executed in terminal
"     " track : Variable that tracks the terminal window. This way the 
"     "   terminal is reused when you run the command again
"     if has('terminal') && a:where !=? 'shell'
"         call s:createTrackedTerm(a:cmd, a:where, a:options, a:track)
"     else "no terminal support  OR  a:where ==? 'shell'
"         exe ':!' a:cmd
"     endif
" endfunction
" "}}}

function! RunTermCommand(cmd, ...) "{{{
    " above is the original version. Replaced with this one for compatibility.
    let s:where =   get(a:000, 0, eval('g:where_term'))
    let s:options = get(a:000, 1, {})
    let s:track =   get(a:000, 2, 'g:compile_term')
    " cmd   : String of command to be executed in terminal
    " track : Variable that tracks the terminal window. This way the 
    "   terminal is reused when you run the command again
    if has('terminal') && s:where !=? 'shell'
        call s:createTrackedTerm(a:cmd, s:where, s:options, s:track)
    else "no terminal support  OR  s:where ==? 'shell'
        exe ':!' a:cmd
    endif
endfunction
"}}}

" }}}

let g:compile_term = -1 "window id
let g:where_term = 'auto'
    " Where to place the terminal. Either of these values:
    "     'vertical'   or 'v': Terminal is in a vertically split window
    "     'horizontal' or 'h': Terminal is in a horizontally split window
    "     'auto'       or 'a': window is split vertically or horizontally
    "                           according to window size. So
    "                               vertical   if height > width
    "                               horizontal if width > height
    "     'tab'        or 't': Terminal is in a new tab
    "     'shell'      or 's': Run command in the shell (i.e. with :!)

augroup compile_source "{{{
        au!
        " au FileType,BufEnter * nnoremap <Leader>m :make<CR>
        au FileType python   nnoremap <buffer> <LocalLeader>r :update \| call RunTermCommand('python3 %')<CR>
        au FileType bash     nnoremap <buffer> <LocalLeader>r :update \| call RunTermCommand('bash %')<CR>
        au FileType pascal   nnoremap <buffer> <LocalLeader>r :update \| call RunTermCommand('fpc -ovimPasEXE % ; echo -e "\e[44m Running program ...\e(B\e[m"; ./vimPasEXE')<CR>
        " au FileType tex      nnoremap <buffer> <LocalLeader>r :update \| call RunTermCommand('pdflatex -synctex=1 -interaction=nonstopmode %', 'tab')<CR>
        au FileType markdown nnoremap <buffer> <LocalLeader>r :update \| call RunTermCommand('retext --preview %', 'shell')<CR>
        au FileType cpp      nnoremap <buffer> <LocalLeader>r :update \| call RunTermCommand('g++ -o vim-a.out % ; draw_center_text.sh "Running program"; ./*.out')<CR>
        au FileType cpp      nnoremap <buffer> <LocalLeader>r :update \| call RunTermCommand('g++ -o a.out % ; draw_center_text.sh "Running program"; ./*.out')<CR>
        au FileType sh       nnoremap <buffer> <LocalLeader>r :update \| call RunTermCommand('./%')<CR>
        au FileType swift    nnoremap <buffer> <LocalLeader>r :update \| call RunMessage() \| call RunTermCommand('swift %')<CR>
        au FileType html     nnoremap <buffer> <LocalLeader>r :update \| call RunTermCommand('firefox %', 'shell')<CR>
        au FileType lilypond nnoremap <buffer> <LocalLeader>R :wa     \| call RunTermCommand('lilypond main.ly', 'horizontal')<CR>
augroup END
"}}}

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"                         FileType-Specific Settings
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

" also see the '.vim/ftplugin' and the '.vim/after/ftplugin' directories

" comment character for filetypes (b:comment_character) "{{{
augroup comment_char
        autocmd!
        au FileType python,bash,sh,ruby,yaml,conf   let b:comment_character = '#'
        au FileType pascal,cpp,swift,javascript     let b:comment_character = '//'
        au FileType vim                             let b:comment_character = '"'
        au FileType tex,plaintex,lilypond           let b:comment_character = '%'
        au FileType text,md                         let b:comment_character = ''
augroup END
"}}}

" colons {{{
augroup put_semicolon
        autocmd!
        au FileType,BufRead pascal,cpp inoremap <buffer> <LocalLeader>, <ESC>A;
        au FileType,BufRead pascal,cpp nnoremap <buffer> <LocalLeader>, <ESC>A;<ESC>
augroup END
" }}}

" print me!{{{
augroup print_me
        au!
        au FileType python nnoremap <buffer> <LocalLeader>p Iprint(<ESC>A)<ESC>
        au FileType python inoremap <buffer> <LocalLeader>p <ESC>Iprint(<ESC>A)
augroup END
" }}}

"" Create a new lilypond project {{{
"function! NewLilypond()
"        let lv = system("lilypond --version | head -n 1 | awk '{ print $3 }'")
"        silent !cp $HOME/.vim/skeletons/Lilypond/newfile/* .
"        for f in systemlist("ls $HOME/.vim/skeletons/Lilypond/newfile/")
"                execute 'silent !sed "1s/\(.\+\s\).*/\1\"hello\"/"' f '>' f
"        endfor
"        unlet lv
"endfunction
"" }}}

" templates/new files "{{{
augroup script_templates
        "insert templete on :new *.filetype
        autocmd!
        au BufNewFile *.pas   0r $HOME/.vim/skeletons/Pascal/template_consoleApp.pas
        au BufNewFile *.py    0r $HOME/.vim/skeletons/Python/HashBang.py
        au BufNewFile *.sh    0r $HOME/.vim/skeletons/Bash/HashBang.sh
        au BufNewFile *.yml   0r $HOME/.vim/skeletons/Yaml/new.yml
        au BufNewFile *.tex   0r $HOME/.vim/skeletons/Latex/new.tex
        au BufNewFile *.swift 0r $HOME/.vim/skeletons/Swift/foundation.swift
        au BufNewFile *.html  0r $HOME/.vim/skeletons/HTML/new.html
        "au BufNewFile *.ly  call NewLilypond()

        au BufNewFile description.txt 0r $HOME/.vim/skeletons/Miscellaneous/Youtube_description.txt
augroup END
"}}}

" use TEX instead of PLAINTEX by default (:h ft-tex-plugin)
let g:tex_flavor = "latex"


"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"                             Sytax hightlighting
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

augroup custom_marks
    au!
    let arekeywords = &iskeyword
    set iskeyword=V,I,M,60,62,91,93
    
    au BufRead,BufNewFile * syntax keyword Todo [>VIM<]
    au BufRead,BufNewFile * syntax match   Todo "\[>VIM<\]"

    let &iskeyword = arekeywords
    unlet arekeywords
augroup END
