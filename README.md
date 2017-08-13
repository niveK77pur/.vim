# vimrc
My personal vim configuration files. I created this repository so that I have acces to MY vim from anywhere there is internet :)

The `.vimrc_linked` file is essentially my `.vimrc`. I have just created a hard link to the original file because it is located outside the repository.

# problems
The autocommand `clean_compiled_source` inside of `.vimrc_linked` is not working correctly. I assume it is the way I set up the `CleanCompiledSource()` function.

If I open a C++ and a Pascal file then there is a variable that is being set. If I compile either one then the compiler will output an executable file. Purpose of this is to delete this file once I quit vim. As of now, vim only deletes one of the two executable files.
