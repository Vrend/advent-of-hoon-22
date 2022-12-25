|%

++  foo
|=  input=(list @t)
=|  total=@ud
=|  max=@ud
|-
?~  input  max
?.  =(i.input "")
  $(total (add total (convert-decimal i.input)), input t.input)
?:  (gth total max)
  $(max total, total 0, input t.input)
$(input t.input, total 0)

:: Converts chord into unsigned decimal
++  convert-decimal
|=  input=@t
^-  @ud
=/  num=tape  (trip input)
=.  num  (flop num)
=|  count=@ud
=|  output=tape
|-
?~  num  (slav %ud (crip output))
?:  (gth count 2)
  $(output (weld "." output), count 0)
$(output [i.num output], num t.num, count +(count))
--