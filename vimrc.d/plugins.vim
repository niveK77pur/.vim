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
    Plug 'SirVer/ultisnips'
    " Plug 'liuchengxu/vista.vim'
    " Plug 'JetBrains/ideavim'
    " Plug 'junegunn/vim-peekaboo'

" Interface ------------------------------------------------------------------
    " Plug 'morhetz/gruvbox'
    Plug 'sainnhe/vim-color-forest-night'
    " Plug 'itchyny/vim-cursorword'
    " Plug 'junegunn/goyo.vim', { 'on' : 'Goyo' }
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
    Plug '/usr/share/lilypond/2.18.2/vim/', { 'for' : 'lilypond' }
    " Plug 'keith/swift.vim', { 'for' : 'swift' }
    Plug 'lervag/vimtex', { 'for' : ['latex', 'tex', 'plaintex', 'context', 'bib'] }
    " Plug 'sheerun/vim-polyglot'
    " Plug 'sukima/xmledit', { 'for' : ['html', 'xhtml', 'xml', 'php'] }
    
" Collaboration --------------------------------------------------------------
    if has('python')
        Plug 'FredKSchott/CoVim', { 'on' : 'CoVim' }
    endif
    
" Language Server ------------------------------------------------------------
    if v:version >= 800 || has('nvim')  " requires vim 8.0+ or neovim
        Plug 'neoclide/coc.nvim', {'branch': 'release'}
    endif

" Neovim candy ---------------------------------------------------------------
    " Plug 'glacambre/firenvim'
call plug#end()
