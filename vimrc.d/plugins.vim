
" hand-made {{{
"set runtimepath+=$HOME/.vim/bundle/nerdtree/
"set runtimepath+=$HOME/.vim/bundle/auto-pairs/
" }}}

" Vundle {{{
"
" NOTE: migrated to Vim-Plug because Vundle is barely being supported
" anymore. While facing difficulties related to setting up coc.vim, I
" found mention of a very similar issue on its github page. As they
" were trying to solve the issue, someone actually got the exact same
" error as me and they were wondering if Vundle was the issue, because
" with other package managers it seemed to work. The conclusion in the
" end was to try moving away from Vundle. This was quite a bummer as I
" used Vundle for as long as I was using plugins! I decided to follow
" the advice in hopes of making plugins work with less fiddling
" around. Vim-Plug seems to be the spiritual successor to Vundle, so I
" quickly opted for this package manager going forward.
"
" if !isdirectory($HOME . "/.vim/bundle/Vundle.vim")
"         echom "Setting up ~/.vim/bundle/ directory and Vundle."
"         call mkdir($HOME . "/.vim/bundle", "p")
"         !git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
" endif
" set nocompatible        " be iMproved, required
" filetype off            " required
" set runtimepath+=$HOME/.vim/bundle/Vundle.vim
" call vundle#begin()
"         Plugin 'VundleVim/Vundle.vim'           " let Vundle manage Vundle
"         Plugin 'scrooloose/nerdtree'
"         Plugin 'scrooloose/nerdcommenter'
"         Plugin 'jiangmiao/auto-pairs'
"         "Plugin 'vim-syntastic/syntastic'
"         Plugin 'junegunn/goyo.vim'
"         Plugin 'tpope/vim-surround'
"         " Plugin 'suan/vim-instant-markdown'
"         Plugin 'thinca/vim-localrc'
"         Plugin 'terryma/vim-multiple-cursors'
"         Plugin 'keith/swift.vim'
"         Plugin 'morhetz/gruvbox'
"         if has('python')
"             Plugin 'FredKSchott/CoVim'          " requires to be compiled with +python
"         endif
"         " if v:version >= 800
"         "     Plugin 'neoclide/coc.nvim'          " requires vim 8.0+ or neovim
"         " endif
" call vundle#end()
" }}}

" Vim-Plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
call plug#begin('~/.vim/plugged/')
    " use :PlugUpgrade to upgrade vim-plug itself
    Plug 'junegunn/vim-plug'
    
" Handy tools ----------------------------------------------------------------
    Plug 'scrooloose/nerdtree', { 'on' : ['NERDTree', 'NERDTreeToggle', 'NERDTreeFocus'] }
    Plug 'thinca/vim-localrc'
    Plug 'terryma/vim-multiple-cursors'
    Plug '/opt/fzf'
    Plug 'junegunn/fzf.vim'
    " Plug 'junegunn/vim-peekaboo'
    Plug 'SirVer/ultisnips'
    " Plug 'liuchengxu/vista.vim'

" Interface ------------------------------------------------------------------
    Plug 'junegunn/goyo.vim', { 'on' : 'Goyo' }
    Plug 'morhetz/gruvbox'
    Plug 'sainnhe/vim-color-forest-night'

" Editing --------------------------------------------------------------------
    Plug 'scrooloose/nerdcommenter'
    Plug 'jiangmiao/auto-pairs'
    Plug 'tpope/vim-surround'
    " Plug 'tpope/vim-fugitive'

" Music ----------------------------------------------------------------------
    " Plug g:plug_home . '/vim-midi'
    
" Language support -----------------------------------------------------------
    Plug 'sheerun/vim-polyglot'
    " Plug '/usr/share/lilypond/2.18.2/vim/', { 'for' : 'lilypond' }
    Plug 'lervag/vimtex', { 'for' : ['latex', 'tex', 'plaintex', 'context', 'bib'] }
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
