" syntax region readReport start="READ" end="$" contains=readSection
syntax region readReport start="READ" end="$"
syntax region readAddition start="+" end="$"
" syntax region readSection start=/"/ end=/"/ contained

syntax region videoComment start="%%" end=";;" skipnl
syntax region textUncertain start="??" end="$"
syntax region textComment start="(" end=")" skipnl



highlight link readReport   Special
highlight link readAddition Constant
highlight readSection cterm=italic,bold ctermfg=11 ctermbg=NONE guifg=fg guibg=bg

highlight link videoComment PreProc
highlight link textComment Comment
highlight link textUncertain Error
