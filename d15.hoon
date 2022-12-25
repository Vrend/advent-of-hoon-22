|=  input=(list @t)
=<
=|  ranges=(list [@sd @sd])
=/  sb=(map (pair @sd @sd) (pair @sd @sd))  (parse-input input)
=/  sensors=(list (pair @sd @sd))  ~(tap in ~(key by sb))
=/  row=@sd  --2.000.000
|-
?~  sensors
  =.  ranges  (handle-ranges ranges)
  =/  diff=@ud  
    (add (remove-beacons ranges row ~(tap in ~(key by sb))) (remove-beacons ranges row ~(tap in (silt ~(val by sb)))))
  =|  total=@ud
  |-
  ?~  ranges  (sub total diff)
  =/  r=[@sd @sd]  i.ranges
  $(total (add total +((abs:si (dif:si +3:r +2:r)))), ranges t.ranges)
::   (remove-beacons-or-sensors xs row ~(tap in ~(key by sb)) ~(tap in (silt ~(val by sb))))
=/  val=(unit [@sd @sd])  (add-nogo i.sensors (~(got by sb) i.sensors) row)
?~  val  $(sensors t.sensors)
$(sensors t.sensors, ranges (weld ranges ~[(need val)]))
::
|%
++  remove-beacons
|=  [ranges=(list [@sd @sd]) y=@sd beacons=(list (pair @sd @sd))]
^-  @ud
=|  count=@ud
|-
?~  ranges  count
=/  cr=[@sd @sd]  i.ranges
|-
?~  beacons  ^$(ranges t.ranges)
=/  cb=[@sd @sd]  i.beacons
?:  ?&(=(y +3:cb) ?!(=(--1 (cmp:si +2:cr +2:cb))) ?!(=(-1 (cmp:si +3:cr +2:cb))))
  $(count +(count), beacons t.beacons)
$(beacons t.beacons)
::
::
++  handle-ranges
|=  input=(list [@sd @sd])
^-  (list [@sd @sd])
=/  prev-size=@ud  0
=|  revised=(list [@sd @sd])
|-

?:  =(~ input)  revised
?:  =(1 (lent input))  (weld revised ~[(snag 0 input)])
=/  r1=[@sd @sd]  (snag 0 input)
=/  c=@ud  1
|-
?:  =(c (lent input))  ^$(input (slag 1 input), revised (weld revised ~[r1]))
=/  r2=[@sd @sd]  (snag c input)

?:  ?|(=(--1 (cmp:si +2:r1 +3:r2)) =(--1 (cmp:si +2:r2 +3:r1)))  :: r1 and r2 are exclusive
  $(c +(c))
?:  ?!(=(--1 (cmp:si +2:r1 +2:r2))) :: r1x <= r2x
  ?:  ?!(=(--1 (cmp:si +3:r1 +3:r2)))
    =/  updated=[@sd @sd]  [+2:r1 +3:r2]
    =.  input  (oust [c 1] input)
    =.  input  (snap input 0 updated)
    ^$(input input) :: r1y <= r2y
  =/  updated=[@sd @sd]  [+2:r1 +3:r1]
  =.  input  (oust [c 1] input)
  =.  input  (snap input 0 updated)
  ^$(input input) :: r1y > r2y
:: r1x > r2x
?:  ?!(=(-1 (cmp:si +3:r1 +3:r2)))
  =/  updated=[@sd @sd]  [+2:r2 +3:r1]
  =.  input  (oust [c 1] input)
  =.  input  (snap input 0 updated)
  ^$(input input) :: r1y >= r2y
:: r1y < r2y
=/  updated=[@sd @sd]  r2
=.  input  (oust [c 1] input)
=.  input  (snap input 0 updated)
^$(input input)

::
++  add-nogo
|=  [sensor=(pair @sd @sd) beacon=(pair @sd @sd) row=@sd]
^-  (unit [@sd @sd])
=/  distance=@ud  (add (abs:si (dif:si +2:sensor +2:beacon)) (abs:si (dif:si +3:sensor +3:beacon)))
=/  x1=@sd  (dif:si +2:sensor (new:si & distance))
=/  x2=@sd  (sum:si +2:sensor (new:si & distance))
=/  y1=@sd  (dif:si +3:sensor (new:si & distance))
=/  y2=@sd  (sum:si +3:sensor (new:si & distance))
?.  ?&(?!(=(--1 (cmp:si row y2))) ?!(=(-1 (cmp:si row y1))))  ~
=/  ydiff=@ud  (abs:si (dif:si +3:sensor row))
=.  x1  (sum:si x1 (new:si & ydiff))
=.  x2  (dif:si x2 (new:si & ydiff))
(some [x1 x2])
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