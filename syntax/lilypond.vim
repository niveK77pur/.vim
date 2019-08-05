syntax region PitchNumber start='{' end='}'
syntax match  PitchNumber "{.*}"
syntax keyword Error global

highlight default link PitchNumber Error
highlight default link TEST Error
