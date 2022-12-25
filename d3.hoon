|=  input=(list @t)
=>
|%
++  check-ruck
|=  ruck=tape
=/  first=tape  (sort (scag (div (lent ruck) 2) ruck) gth)
=/  second=tape  (sort (slag (div (lent ruck) 2) ruck) gth)
|-
?~  first  !!
?~  second  !!
?:  =(i.first i.second)  i.first
?:  (gth i.first i.second)
  $(first t.first)
$(second t.second)
--

=|  sum=@ud
|-
?~  input  sum
=/  ruck=tape  (trip i.input)
=/  common=@ud  `@ud`(check-ruck ruck)
?:  (gte common 97)
  $(sum (add sum (sub common 96)), input t.input)
$(sum (add sum (sub common 38)), input t.input)

