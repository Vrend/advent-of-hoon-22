:: Algorithm adapted shamelessly from GitHub user Goggle via the link below:
:: https://github.com/goggle/AdventOfCode2022.jl/blob/master/src/day15.jl
::
|=  input=(list @t)
=<
=|  ranges=(list [@sd @sd])
=/  sb=(map (pair @sd @sd) (pair @sd @sd))  (parse-input input)
=/  sensors=(map (pair @sd @sd) @ud)
  (~(rut by sb) |=([k=[@sd @sd] v=[@sd @sd]] (add (abs:si (dif:si +2:k +2:v)) (abs:si (dif:si +3:k +3:v)))))
=/  s=(list [[@sd @sd] @ud])  ~(tap by sensors)
=/  l=(list (list @sd))  (get-lines s)
=/  intersections=(list [@sd @sd])  (get-intersections l)
=.  intersections  ~(tap in (silt intersections))
=/  dists=(map [@sd @sd] @ud)  (get-intersection-neighbors intersections)
=/  candidates=(list [@sd @sd])  (get-intersection-candidates dists intersections)
=/  p=[@sd @sd]  (get-point candidates)
(sum:si (pro:si --4.000.000 +2:p) +3:p)
::
|%
++  get-point
|=  candidates=(list [@sd @sd])
^-  [@sd @sd]
=/  cs=(set [@sd @sd])  (silt candidates)
=|  c=@ud
|-
?:  =(c (lent candidates))  ~&  >  "Problem"  [--0 --0]
=/  candidate=[@sd @sd]  (snag c candidates)
?:  ?&((~(has in cs) [(sum:si --2 +2:candidate) +3:candidate]) (~(has in cs) [(sum:si --1 +2:candidate) (sum:si --1 +3:candidate)]) (~(has in cs) [(sum:si --1 +2:candidate) (dif:si +3:candidate --1)]))
  [(sum:si --1 +2:candidate) +3:candidate]
$(c +(c))
::
++  get-intersection-candidates
|=  [dists=(map [@sd @sd] @ud) intersections=(list [@sd @sd])]
^-  (list [@sd @sd])
=|  output=(list [@sd @sd])
|-
?~  intersections  output
?:  (gte (~(gut by dists) i.intersections 0) 3)
  $(output [i.intersections output], intersections t.intersections)
$(intersections t.intersections)
::
++  get-intersection-neighbors
|=  intersections=(list [@sd @sd])
^-  (map [@sd @sd] @ud)
=|  output=(map [@sd @sd] @ud)
=/  i=@ud  0
=/  end=@ud  (lent intersections)
|-
?:  =(i end)  output
=/  j=@ud  +(i)
|-
?:  =(j end)  ^$(i +(i))
=/  p1=[@sd @sd]  (snag i intersections)
=/  p2=[@sd @sd]  (snag j intersections)
=/  distance=@ud  (add (abs:si (dif:si +2:p1 +2:p2)) (abs:si (dif:si +3:p1 +3:p2)))
?:  =(2 distance)
  =.  output  (~(put by output) p1 +((~(gut by output) p1 0)))
  =.  output  (~(put by output) p2 +((~(gut by output) p2 0)))
  $(output output, j +(j))
$(j +(j))
::
++  get-intersections
|=  lines=(list (list @sd))
^-  (list [@sd @sd])
=|  output=(list [@sd @sd])
=/  lc=(list (list @sd))  lines
|-
?~  lc  output
=/  run=(list [@sd @sd])  (get-intersection-from-line i.lc lines)
$(output (weld output run), lc t.lc)
::
++  get-intersection-from-line
|=  [line=(list @sd) lines=(list (list @sd))]
^-  (list [@sd @sd])
=|  output=(list [@sd @sd])
|-
?~  lines  output
=/  line2=(list @sd)  i.lines
=/  i=@ud  0
|-
?:  =(i 2)  ^$(lines t.lines)
=/  j=@ud  2
|-
?:  =(j 4)  ^$(i +(i))
=/  b1=@sd  (snag i line)
=/  b2=@sd  (snag j line2)
?:  ?!(=(--0 (rem:si (sum:si b1 b2) --2)))  $(j +(j))
=/  x=@sd  (fra:si (dif:si b2 b1) --2)
=/  y=@sd  (fra:si (sum:si b2 b1) --2)
?:  (in-bounds [x y])  $(j +(j), output [[x y] output])
$(j +(j))
::
:: Get Y intercepts of lines
++  get-lines
|=  input=(list [[@sd @sd] @ud])
^-  (list (list @sd))
=|  output=(list (list @sd))
|-
?~  input  output
=/  c=[@sd @sd]  +2:i.input
=/  d=@sd  (new:si & +3:i.input)
=/  y1=@sd  (dif:si (dif:si +3:c +2:c) d)
=/  y2=@sd  (sum:si (dif:si +3:c +2:c) d)
=/  y3=@sd  (sum:si (sum:si +3:c +2:c) d)
=/  y4=@sd  (dif:si (sum:si +3:c +2:c) d)
$(output [~[y1 y2 y3 y4] output], input t.input)
::
++  in-bounds
|=  p=[@sd @sd]
^-  ?
?&(?!(=(-1 (cmp:si +2:p --0))) ?!(=(--1 (cmp:si +2:p --4.000.000))) ?!(=(-1 (cmp:si +3:p --0))) ?!(=(--1 (cmp:si +3:p --4.000.000))))
::
++  parse-input 
|=  input=(list @t)
^-  (map (pair @sd @sd) (pair @sd @sd))
=|  output=(map (pair @sd @sd) (pair @sd @sd))
|-
?~  input  output
=/  line=tape  (trip i.input)
=/  start=@ud  (add 2 (need (find "x=" line)))
=/  end=@ud  (need (find "," line))
=/  x1r=tape  (swag [start (sub end start)] line)
=.  start  (add 2 (need (find "y=" line)))
=.  end  (need (find ":" line))
=/  y1r=tape  (swag [start (sub end start)] line)
=/  x1=@sd  (tape-to-signed x1r)
=/  y1=@sd  (tape-to-signed y1r)
=.  line  (slag (need (find "closest" line)) line)
=.  start  (add 2 (need (find "x=" line)))
=.  end  (need (find "," line))
=/  x2r=tape  (swag [start (sub end start)] line)
=.  start  (add 2 (need (find "y=" line)))
=/  y2r=tape  (slag start line)
=/  x2=@sd  (tape-to-signed x2r)
=/  y2=@sd  (tape-to-signed y2r)
$(output (~(put by output) [x1 y1] [x2 y2]), input t.input)
::
++  tape-to-signed
|=  input=tape
^-  @sd
=/  signed=?  &
=?  signed  =('-' (snag 0 input))  |
=?  input  =('-' (snag 0 input))  (slag 1 input)
=/  d=@ud  (ni:dejs:format n+(crip input))
(new:si signed d)
--