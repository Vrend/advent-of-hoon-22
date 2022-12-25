|=  input=(list @t)
=<
^-  @ud
=|  seen=(set (pair @sd @sd))
=/  head=[@sd @sd]  [--0 --0]
=/  tail=[@sd @sd]  [--0 --0]
=.  seen  (~(put in seen) tail)
|-
?~  input  ~(wyt in seen)
=/  out=[(set (pair @sd @sd)) [@sd @sd] [@sd @sd]]  (parse-line i.input head tail seen)
$(seen +2:out, head +2:+3:out, tail +3:+3:out, input t.input)
::
|%
++  is-adjacent
|=  [h=[@sd @sd] t=[@sd @sd]]
^-  ?
=/  diff=[@sd @sd]  [(abs:si (dif:si +2:h +2:t)) (abs:si (dif:si +3:h +3:t))]
?:  ?&(=(-1 (cmp:si +2:diff --1)) =(-1 (cmp:si +3:diff --1)))  &
|
::
++  parse-line
|=  [line=@t h=[@sd @sd] t=[@sd @sd] s=(set (pair @sd @sd))]
^-  [(set (pair @sd @sd)) [@sd @sd] [@sd @sd]]
=/  m=@t  (snag 0 (trip line))
=/  c=@ud  (slav %ud (crip (slag 2 (trip line))))
|-
?:  =(c 0)  [s h t]
=/  new-h=[@sd @sd]  (update-head h m)
?:  (is-adjacent new-h t)  
  $(h new-h, c (sub c 1))
=/  new-t=[@sd @sd]  (update-tail new-h t)
$(s (~(put in s) new-t), h new-h, t new-t, c (sub c 1))
::
++  update-head
|=  [h=[@sd @sd] m=@t]
^-  [@sd @sd]
?:  =(m 'R')  [(sum:si +2:h --1) +3:h]
?:  =(m 'L')  [(dif:si +2:h --1) +3:h]
?:  =(m 'U')  [+2:h (sum:si +3:h --1)]
[+2:h (dif:si +3:h --1)]
::
++  update-tail
|=  [h=[@sd @sd] t=[@sd @sd]]
^-  [@sd @sd]
?:  =(+2:h +2:t)
  ?:  =(--1 (cmp:si +3:h +3:t))  [+2:t (sum:si +3:t --1)]
  [+2:t (dif:si +3:t --1)]
?:  =(+3:h +3:t)
  ?:  =(--1 (cmp:si +2:h +2:t))  [(sum:si +2:t --1) +3:t]
  [(dif:si +2:t --1) +3:t]
?:  ?&(=(--1 (cmp:si +2:h +2:t)) =(--1 (cmp:si +3:h +3:t)))  [(sum:si +2:t --1) (sum:si +3:t --1)]
?:  ?&(=(--1 (cmp:si +2:h +2:t)) =(-1 (cmp:si +3:h +3:t)))  [(sum:si +2:t --1) (dif:si +3:t --1)]
?:  ?&(=(-1 (cmp:si +2:h +2:t)) =(--1 (cmp:si +3:h +3:t)))  [(dif:si +2:t --1) (sum:si +3:t --1)]
[(dif:si +2:t --1) (dif:si +3:t --1)]
--