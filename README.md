# DEPRECATED

Consider this repository deprecated. I have finally made the switch to using Lua and rewrote my config for NeoVim (which is the only one I am using these days anyway). You can find the new repository here:  
<https://github.com/niveK77pur/nvim>

I am not archiving this repository just yet, as I am not fully ready to let go (plus my rewrite is still heavily in progress). And there may or may not be cases where I might have to go back and change stuff if I ever use this again.

# vimrc

My personal vim configuration files. I created this repository so that I have acces to MY vim from anywhere there is internet :) But also in case something goes wrong and I lose all my configurations (which actually happend to me ... I accidentially deleted my whole vimrc and I was so glad I had a backup).

The configuration for vim needs to be put inside a `.vim` folder located inside your home directory. This is essentially the place where you put all you custom configurations.

I decided to put the `vimrc` file into the `.vim` folder. That way there is no need to create a symbolic link to the home directory. If you were to place it in the home directory however, don't forget to name it `.vimrc` and not `vimrc`. Look at `:help exrc`
