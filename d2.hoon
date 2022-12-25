|=  input=(list @t)
=|  total=@ud
|-
?~  input  total
=/  combo=tape  (cass (trip i.input))
=/  opp=@tas  +2:(scag 1 combo)
=/  us=@tas  (rear combo)
?+  us  0
  %x
  ?+  opp  0
    %a  $(total (add 4 total), input t.input)
    %b  $(total (add 1 total), input t.input)
    %c  $(total (add 7 total), input t.input)
  ==
  %y
  ?+  opp  0
    %a  $(total (add 8 total), input t.input)
    %b  $(total (add 5 total), input t.input)
    %c  $(total (add 2 total), input t.input)
  ==
  %z
  ?+  opp  0
    %a  $(total (add 3 total), input t.input)
    %b  $(total (add 9 total), input t.input)
    %c  $(total (add 6 total), input t.input)
  ==
==