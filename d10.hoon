|=  input=(list @t)
^-  @sd
=|  sum=@sd
=/  c=@ud  1
=/  x=@sd  --1
|-
?~  input  sum
=?  sum  =(20 (mod c 40))  (sum:si sum (pro:si (new:si & c) x))
?:  =(i.input 'noop')  $(c +(c), sum sum, input t.input)
=/  x-ch=tape  (slag 5 (trip i.input))
=?  x-ch  ?!(=('-' (snag 0 x-ch)))  (weld "--" x-ch)
=?  sum  =(20 (mod +(c) 40))  (sum:si sum (pro:si (new:si & +(c)) x))
$(x (sum:si x (slav %sd (crip x-ch))), sum sum, c (add c 2), input t.input)
