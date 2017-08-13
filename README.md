# vimrc
My personal vim configuration files. I created this repository so that I have acces to MY vim from anywhere there is internet :)

The `.vimrc_linked` file is essentially my `.vimrc`. I have just created a hard link to the original file because it is located outside the repository.

# problems
The autocommand `clean_compiled_source` inside of `.vimrc_linked` is not working correctly. I assume it is the way I set up the `CleanCompiledSource()` function. I'd be glad if anyone could have a look, because the conditionnals seem to do very strange things. I suggest you have look at this quick [introduction](http://learnvimscriptthehardway.stevelosh.com/chapters/21.html) and then come back.
