------------- Multiple voices -------------
Temporary polyphonic passages
<< { \voiceOne 
    [>VIM<]
  }
  \new Voice { \voiceTwo 
    [>VIM<]
  }
>> \oneVoice

The double backslash construct
<< { [>VIM<] } \\ { [>VIM<] } >>
<<
  { [>VIM<] }
  \\
  { [>VIM<] }
>>
