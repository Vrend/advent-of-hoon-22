|=  input=(list @t)
=<
^-  @ud
=|  seen=(set (pair @sd @sd))
=/  head=[@sd @sd]  [--0 --0]
=/  tails=(list [@sd @sd])  ~[[--0 --0] [--0 --0] [--0 --0] [--0 --0] [--0 --0] [--0 --0] [--0 --0] [--0 --0] [--0 --0]]
=.  seen  (~(put in seen) [--0 --0])
|-
?~  input  ~(wyt in seen)
=/  out=[(set (pair @sd @sd)) [@sd @sd] (list [@sd @sd])]  (parse-line i.input head tails seen)
$(seen +2:out, head +2:+3:out, tails +3:+3:out, input t.input)
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
|=  [line=@t h=[@sd @sd] ts=(list [@sd @sd]) s=(set (pair @sd @sd))]
^-  [(set (pair @sd @sd)) [@sd @sd] (list [@sd @sd])]
=/  m=@t  (snag 0 (trip line))
=/  c=@ud  (slav %ud (crip (slag 2 (trip line))))
|-
?:  =(c 0)  [s h ts]
=/  new-h=[@sd @sd]  (update-head h m)
=/  new-ts=(list [@sd @sd])  (update-tails new-h ts)
$(s (~(put in s) (rear new-ts)), h new-h, ts new-ts, c (sub c 1))

++  update-tails
|=  [head=[@sd @sd] tails=(list [@sd @sd])]
^-  (list [@sd @sd])
=|  ts=(list [@sd @sd])
|-
?~  tails  ts
=/  nt=[@sd @sd]  (update-tail head i.tails)
$(ts (weld ts ~[nt]), head nt, tails t.tails)
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
?:  (is-adjacent h t)  t
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