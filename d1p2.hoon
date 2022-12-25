|%

++  foo
|=  input=(list @t)
=|  total=@ud
=|  vals=(list @ud)
|-
?~  input  (sort vals lth)
?.  =(i.input "")
  $(total (add total (convert-decimal i.input)), input t.input)
$(input t.input, total 0, vals [total vals])

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