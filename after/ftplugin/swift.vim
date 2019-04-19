setl tabstop=4

setl def=func


"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"                                  Mappings
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

" Shortcuts for self.
inoremap <LocalLeader>s self.
nnoremap <LocalLeader>ss :call PutSelfFuncArgs()<CR>
inoremap <LocalLeader>=S <ESC>:call PutSelf()<CR>
nnoremap <LocalLeader>=S :call PutSelf()<CR>
vnoremap <LocalLeader>=S v:call PutSelfSelection()<CR>

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
        let s:lst = []
        try
            s#\w\+\ze:#\=add(s:lst,submatch(0))#g
        catch "E486"
            return
        endtry
        exe "normal uA \<c-v>{"
        for arg in s:lst
            exec "normal oself." . arg . " = " . arg
        endfor
        exe "normal o\<c-v>}\<c-d>"
        normal ``jjv``<
endfunction
"}}}

