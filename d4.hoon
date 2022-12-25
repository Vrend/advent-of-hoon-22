|=  input=(list @t)
=|  count=@ud
|-
?~  input  count
=/  val=tape  (trip i.input)
=/  r1=tape  (scag (need (find "," val)) val)
=/  l1=@ud  (slav %ud (crip (scag (need (find "-" r1)) r1)))
=/  h1=@ud  (slav %ud (crip (slag +((need (find "-" r1))) r1)))
=/  r2=tape  (slag +((need (find "," val))) val)
=/  l2=@ud  (slav %ud (crip (scag (need (find "-" r2)) r2)))
=/  h2=@ud  (slav %ud (crip (slag +((need (find "-" r2))) r2)))
?:  ?|(?&((lte l1 l2) (gte h1 h2)) ?&((lte l2 l1) (gte h2 h1)))
  $(count +(count), input t.input)
$(input t.input)