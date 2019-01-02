\version ""


global = {
  \key c \major
  \time 4/4
  % allow text in the dynamics block to be centered vertically
  \override TextScript.extra-offset = #'(0 . 1)
}

% Some other usefull commands
%
% Use this to put notes into another staff
% \change Staff = "left" \voiceOne 
%
% Use this to merge heads
% \mergeDifferentlyHeadedOn
% \mergeDifferentlyDottedOn
