setl tabstop=4
setl def=func

let g:NERDCustomDelimiters = {'swift' : { 'left': '//', 'leftAlt': '/*', 'rightAlt': '*/' }}

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"                                Abbreviations
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

iabb CSC CustomStringConvertible

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"                                  Mappings
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

" Shortcuts for self. "{{{
inoremap <LocalLeader>s self.
nnoremap <LocalLeader>ss :call PutSelfFuncArgs()<CR>
inoremap <LocalLeader>=S <ESC>:call PutSelf()<CR>
nnoremap <LocalLeader>=S :call PutSelf()<CR>
vnoremap <LocalLeader>=S v:call PutSelfSelection()<CR>
"}}}

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"                                  Functions
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

function! PutSelf() "{{{
        s#\(\w\+\)#self.\1 = \1#
endfunction
"}}}

function! PutSelfSelection() "{{{
    let line_range = [getpos("'<")[1], getpos("'>")[1]]
    exec line_range[0] . "," . line_range[1] . "s#\\(\\w\\+\\)#self.\\1 = \\1#"
endfunction
"}}}

function! PutSelfFuncArgs() "{{{
        let s:args = []
        let s:super = []
        try
            s#-\?\(\w\+\)\ze:#\=submatch(0)[0] == '-' ? add(s:super, submatch(1)) : add(s:args,submatch(1))#g
            undo
            s#-\ze\<\w##ge
        catch "E486"
            echom "PutSelfFuncArgs(): Could not find match"
            return
        endtry
        exe "normal A \<c-v>{"
        if len(s:super) != 0
            exe "normal osuper.init(" . join(map(s:super, 'substitute(v:val,".*","&:&","")'), ", ") . ")"
        endif
        for arg in s:args
            exec "normal oself." . arg . " = " . arg
        endfor
        exe "normal o\<c-v>}\<c-d>"
        "normal ``jjv``<
endfunction
"}}}

