syntax region Tick start=#`# end=#`#
syntax region Test start=#{# end=#}#

syntax match NewLine /  $/

syn match ExtraWhitespace /\s\+$\| \+\ze\t/
highlight ExtraWhitespace ctermbg=red guibg=red


highlight default link Tick Error
highlight default link Test Error
highlight default link NewLine Error
