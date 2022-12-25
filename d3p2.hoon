:: Rewrite to compare and look for biggest value of all three

|=  input=(list @t)
=>
|%
++  check-ruck
|=  rucks=(list tape)
?~  rucks  !!
=/  first=tape  (sort `tape`+2:rucks gth)
=/  second=tape  (sort `tape`+2:+3:rucks gth)
=/  third=tape  (sort `tape`+2:+3:+3:rucks gth)
:: ~&  >  first
:: ~&  >  second
:: ~&  >  third
|-
?~  first  !!
?~  second  !!
?~  third  !!
?:  ?&(=(i.first i.second) =(i.first i.third))  i.first
?:  ?&((gte i.first i.second) (gte i.first i.third))
  $(first t.first)
?:  ?&((gte i.second i.first) (gte i.second i.third))
  $(second t.second)
$(third t.third)
--

=|  sum=@ud
|-
?~  input  sum
=/  rucks=(list tape)  (turn (scag 3 `(list @t)`input) trip)
=/  common=@ud  `@ud`(check-ruck rucks)
?:  (gte common 97)
  $(sum (add sum (sub common 96)), input (slag 3 `(list @t)`input))
$(sum (add sum (sub common 38)), input (slag 3 `(list @t)`input))

