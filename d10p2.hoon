|=  input=(list @t)
=|  output=tape
=/  c=@ud  1
=/  x=@sd  --1
=/  h=@sd  --1
=|  adding=@ud
|-
~&  >  c
=?  x  =(adding 1)  h
~&  >  x
?~  input
  =|  out=(list tape)
  |-
  ?~  output  out
  $(out (weld out ~[(scag 40 `tape`output)]), output (slag 40 `tape`output))


=/  r=tape  "."
=?  r  ?|(=(+3:(old:si x) (mod (sub c 1) 40)) =((sub +3:(old:si x) 1) (mod (sub c 1) 40)) =(+(+3:(old:si x)) (mod (sub c 1) 40)))  "#"

?:  (gth adding 1)  $(c +(c), output (weld output r), adding (sub adding 1))
?:  =(i.input 'noop')  $(c +(c), output (weld output r), input t.input)
=/  x-ch=tape  (slag 5 (trip i.input))
=?  x-ch  ?!(=('-' (snag 0 x-ch)))  (weld "--" x-ch)
$(h (sum:si x (slav %sd (crip x-ch))), c +(c), adding 2, output (weld output r), input t.input)
