" Vim-Plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
call plug#begin('~/.vim/plugged/')
    " use :PlugUpgrade to upgrade vim-plug itself
    " Plug 'junegunn/vim-plug'
    
" Handy tools ----------------------------------------------------------------
    Plug 'scrooloose/nerdtree', { 'on' : ['NERDTree', 'NERDTreeToggle', 'NERDTreeFocus'] }
    Plug 'thinca/vim-localrc'
    Plug 'terryma/vim-multiple-cursors'
    Plug 'junegunn/fzf', { 'do': './install --xdg --all --no-fish' }
    Plug 'junegunn/fzf.vim'
    " Plug 'lotabout/skim', { 'dir': '~/.skim', 'do': './install' }
    if has('nvim') || xor(has('python_dynamic'), has('python3_dynamic'))
        Plug 'SirVer/ultisnips'
    endif
    " Plug 'liuchengxu/vista.vim'
    " Plug 'JetBrains/ideavim'
    " Plug 'junegunn/vim-peekaboo'
    " Plug 'szymonmaszke/vimpyter'

" Writing --------------------------------------------------------------------
    " https://tomfern.com/posts/vim-for-writers
    Plug 'reedes/vim-pencil', { 'for' : ['tex', 'latex', 'text', 'clipboard'] }
    Plug 'dbmrq/vim-ditto', { 'for' : ['tex', 'latex', 'text', 'markdown'] }
    " Plug 'reedes/vim-lexical', { 'for' : ['tex', 'latex', 'text', 'clipboard'] }
    " Plug 'reedes/vim-litecorrect', { 'for' : ['tex', 'latex', 'text'] }
    " Plug 'junegunn/goyo.vim', { 'on' : 'Goyo' }

" Interface ------------------------------------------------------------------
    " Plug 'morhetz/gruvbox'
    Plug 'sainnhe/everforest'
    " Plug 'branwright1/salvation-vim'
    " Plug 'itchyny/vim-cursorword'
    " Plug 'Yggdroot/indentLine', { 'on' : ['IndentLinesToggle', 'IndentLinesEnable', 'LeadingSpaceEnable', 'LeadingSpaceToggle'] }

" Editing --------------------------------------------------------------------
    Plug 'scrooloose/nerdcommenter'
    Plug 'jiangmiao/auto-pairs'
    Plug 'tpope/vim-surround'
    " Plug 'metakirby5/codi.vim'
    " Plug 'dyng/ctrlsf.vim'
    " Plug 'tpope/vim-fugitive'

" Music ----------------------------------------------------------------------
    " Plug $HOME . '/.vim/tests/vim-midi'
    
" Language support -----------------------------------------------------------
    " Plug '/usr/share/lilypond/2.22.1/vim/', { 'for' : 'lilypond' }
    " Plug '/usr/local/bin', { 'for' : 'lilypond' }
    Plug 'sersorrel/vim-lilypond', { 'for' : 'lilypond' }
    " Plug 'keith/swift.vim', { 'for' : 'swift' }
    Plug 'lervag/vimtex', { 'for' : ['latex', 'tex', 'plaintex', 'context', 'bib'] }
    " Plug 'sheerun/vim-polyglot'
    " Plug 'sukima/xmledit', { 'for' : ['html', 'xhtml', 'xml', 'php'] }
    Plug 'mfukar/robotframework-vim', { 'for': ['robot'] }
    
" Collaboration --------------------------------------------------------------
    " if has('python')
    "     Plug 'FredKSchott/CoVim', { 'on' : 'CoVim' }
    " endif
    
" Language Server ------------------------------------------------------------
    if v:version >= 800 || has('nvim')  " requires vim 8.0+ or neovim
        Plug 'neoclide/coc.nvim', {'branch': 'release'}
    endif

" Candy ----------------------------------------------------------------------
    if has('nvim')
        " Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }
        " Plug 'subnut/nvim-ghost.nvim', {'do': ':call nvim_ghost#installer#install()'}
        Plug 'raghur/vim-ghost', { 'do': ':GhostInstall'}
    endif
    Plug 'voldikss/vim-floaterm'

call plug#end()
