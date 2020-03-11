if exists('g:midi_plugin_loaded')
    finish
endif

if !has('python3')
    echom "You need the +python3 feature for vim-midi"
    finish
endif

let s:plugin_root_dir = fnamemodify(resolve(expand('<sfile>:p')), ':h')

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"                                 Python code
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


python3 << EOF
import sys
from os.path import normpath, join
import vim
plugin_root_dir = vim.eval('s:plugin_root_dir')
python_root_dir = normpath(join(plugin_root_dir, '..', 'python'))
sys.path.insert(0, python_root_dir)

# import vim_midi as vm
from time import sleep

from time import sleep

def test():
    for i in range(5):
        yield 'test{}'.format(i)

t_gen = test()

def listen():
    txt = next(t_gen)
    row,col = vim.current.window.cursor
    line = vim.current.line
    vim.current.line = line[:col] + txt + line[col:]
    vim.current.window.cursor = row,col+len(txt)

def vimPut(txt):
    row,col = vim.current.window.cursor
    line = vim.current.line
    vim.current.line = line[:col] + txt + line[col:]
    vim.current.window.cursor = row,col+len(txt)
    

def getInput():
    notes = test()
    for t in notes:
        vimPut(t)
        sleep(1)

g = test()
EOF

let g:python_listen = ''

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"                     Functions to call python functions
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


function! Test()
    " python3 vim.command('return "' + next(g) + '"')
    py3 listen()
endfunction

function! GetInput()
    py3 getInput()
endfunction

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"                         Mappings to call functions
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

noremap <Leader>T :call Test()<CR>
inoremap <Leader>T <c-o>:call Test()<CR>

noremap <Leader>G :call GetInput()<CR>
inoremap <Leader>G <c-o>:call GetInput()<CR>

let g:midi_plugin_loaded = 1
