syntax region readReport start="READ" end=";;" skipnl
syntax region readAddition start="+" end="$"
" syntax region readSection start="^" end="^"  skipnl

syntax region videoComment start="%%" end=";;" skipnl
syntax keyword textUncertain ??
syntax region textComment start="(" end=")" skipnl



highlight link readReport   Special
highlight link readAddition Constant
" highlight link readSection  Error

highlight link videoComment PreProc
highlight link textComment Comment
highlight link textUncertain Error
