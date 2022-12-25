|=  input=(list @t)
^-  @ud
=<
=/  monkes=(map @ud monke)  (parse-monke input)
=|  round=@ud
|-
?:  =(round 10.000)  (get-inspects ~(val by monkes))
=|  mc=@ud
|-
?:  =(mc ~(wyt in ~(key by monkes)))  ^$(round +(round))
$(monkes (handle-monke monkes mc), mc +(mc))
::
|%
++  get-inspects
|=  monkes=(list monke)
^-  @ud
=|  m1=@ud
=|  m2=@ud
|-
?~  monkes  (mul m1 m2)
=/  val=@ud  inspects.i.monkes
?:  (gth val m1)  $(monkes t.monkes, m1 val, m2 m1)
?:  (gth val m2)  $(monkes t.monkes, m2 val)
$(monkes t.monkes)
++  handle-monke
|=  [monkes=(map @ud monke) mc=@ud]
=/  m=monke  (~(got by monkes) mc)
=/  cm=@ud  (roll (turn ~(val by monkes) |=(mon=monke divisor.mon)) mul)
=/  items=(list @ud)  items.m
=.  items.m  ~
=.  inspects.m  (add (lent items) inspects.m)
=.  monkes  (~(put by monkes) mc m)
|-
?~  items  monkes
=/  worry=@ud  i.items
=/  operand=@ud  operand.m
=?  operand  =(operand 0)  worry
?:  =(operator.m '*')
  =.  worry  (mod (mul worry operand) cm)
  ?:  =(0 (mod worry divisor.m))
    =/  m2=monke  (~(got by monkes) yes.m)
    =.  items.m2  (weld items.m2 ~[worry])
    =.  monkes  (~(put by monkes) yes.m m2)
    $(monkes monkes, items t.items)
  =/  m2=monke  (~(got by monkes) no.m)
  =.  items.m2  (weld items.m2 ~[worry])
  =.  monkes  (~(put by monkes) no.m m2)
  $(monkes monkes, items t.items)
=.  worry  (mod (add worry operand) cm)
?:  =(0 (mod worry divisor.m))
  =/  m2=monke  (~(got by monkes) yes.m)
  =.  items.m2  (weld items.m2 ~[worry])
  =.  monkes  (~(put by monkes) yes.m m2)
  $(monkes monkes, items t.items)
=/  m2=monke  (~(got by monkes) no.m)
=.  items.m2  (weld items.m2 ~[worry])
=.  monkes  (~(put by monkes) no.m m2)
$(monkes monkes, items t.items)

::
++  parse-items
|=  raw-items=tape
^-  (list @ud)
=|  out=(list @ud)
|-
?:  =(~ raw-items)  out
?:  =(~ (find "," raw-items))  $(out (weld out ~[(slav %ud (crip raw-items))]), raw-items "")
=/  new-num=@ud  (slav %ud (crip (scag (need (find "," raw-items)) raw-items)))
$(out (weld out ~[new-num]), raw-items (slag (add 2 (need (find "," raw-items))) raw-items))
::
++  parse-monke
|=  input=(list @t)
^-  (map @ud monke)
=|  out=(map @ud monke)
=|  c=@ud
=|  m=monke
|-
?~  input  
=.  out  (~(put by out) c m)
out
?:  =(i.input '')  $(input t.input, c +(c), out (~(put by out) c m), m *monke)
?:  ?!(=(~ (find "Monkey" (trip i.input))))  $(input t.input)
?:  ?!(=(~ (find "items: " (trip i.input))))
  =/  raw-items=tape  (slag (add (need (find "items: " (trip i.input))) 7) (trip i.input))
  =.  items.m  (parse-items raw-items)
  $(m m, input t.input)
?:  ?!(=(~ (find "old" (trip i.input))))
  =/  op=@t  (snag (add 4 (need (find "old" (trip i.input)))) (trip i.input))
  =/  raw-operand=(unit @ud)  (slaw %ud (crip (slag (add 6 (need (find "old" (trip i.input)))) (trip i.input))))
  =/  operand=@ud  0
  =?  operand  ?!(=(~ raw-operand))  (need raw-operand)
  =.  operator.m  op
  =.  operand.m  operand
  $(m m, input t.input)
?:  ?!(=(~ (find "by " (trip i.input))))
  =/  div=@ud  (slav %ud (crip (slag (add 3 (need (find "by " (trip i.input)))) (trip i.input))))
  =.  divisor.m  div
  $(m m, input t.input)
?:  ?!(=(~ (find "true" (trip i.input))))
  =/  yes=@ud  (slav %ud (snag (add 7 (need (find "monkey" (trip i.input)))) (trip i.input)))
  =.  yes.m  yes
  $(m m, input t.input)
=/  no=@ud  (slav %ud (snag (add 7 (need (find "monkey" (trip i.input)))) (trip i.input)))
=.  no.m  no
$(m m, input t.input)
::
+$  monke
$~  :*  items=*(list @ud)
        operator=''
        operand=0
        divisor=1
        yes=0
        no=1
        inspects=0
    ==
$:
  items=(list @ud)
  operator=@t
  operand=@ud
  divisor=@ud
  yes=@ud
  no=@ud
  inspects=@ud
==
--