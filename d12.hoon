|=  input=(list @t)
^-  @ud
=<
=/  height=@ud  (lent input)
=/  width=@ud  (lent (trip +2:input))
=/  parsed-output=[(map (pair @ud @ud) @t) (pair @ud @ud) (pair @ud @ud)]  (parse-input input)
=/  heightmap=(map (pair @ud @ud) @t)  +2:parsed-output
=/  start=[@ud @ud]  +2:+3:parsed-output
=/  end=[@ud @ud]  +3:+3:parsed-output
=/  dk-raw=[(map (pair @ud @ud) @ud) (map (pair @ud @ud) (pair @ud @ud))]  (dijkstra heightmap start width height)
(count-smallest-path +3:dk-raw end)
::
|%
++  count-smallest-path
|=  [prev=(map (pair @ud @ud) (pair @ud @ud)) end=[@ud @ud]]
^-  @ud
=|  count=@ud
|-
?:  ?!((~(has by prev) end))  count
$(end (~(got by prev) end), count +(count))
++  get-smallest-dist
|=  [hm=(map (pair @ud @ud) @ud) qr=(set (pair @ud @ud))]
^-  [@ud @ud]
=/  q=(list (pair @ud @ud))  ~(tap in qr)
=|  min-coord=[@ud @ud]
=/  min=@ud  999
?:  =(0 ~(wyt by hm))  +2:q
|-
?~  q  min-coord
?:  (lth (~(gut by hm) i.q 999) min)  $(min (~(gut by hm) i.q 999), min-coord i.q, q t.q)
$(q t.q)
::
++  dijkstra
|=  [hm=(map (pair @ud @ud) @t) s=[@ud @ud] w=@ud h=@ud]
^-  [(map (pair @ud @ud) @ud) (map (pair @ud @ud) (pair @ud @ud))]
=/  q=(set (pair @ud @ud))  ~(key by hm)
=|  dist=(map (pair @ud @ud) @ud)
=|  prev=(map (pair @ud @ud) (pair @ud @ud))
=.  dist  (~(put by dist) s 0)
=/  os=@ud  99.999
|-
?:  =(os ~(wyt in q))  [dist prev]
=.  os  ~(wyt in q)
=/  n=[@ud @ud]  (get-smallest-dist dist q)
=.  q  (~(del in q) n)
=/  top-coord=[@ud @ud]  [999 999]
=/  bot-coord=[@ud @ud]  [999 999]
=/  left-coord=[@ud @ud]  [999 999]
=/  right-coord=[@ud @ud]  [999 999]
=?  top-coord  (gte +((~(got by hm) n)) (~(gut by hm) [+2:n +(+3:n)] 999))  [+2:n +(+3:n)]
=?  bot-coord  
  ?:  (gth +3:n 0)  (gte +((~(got by hm) n)) (~(gut by hm) [+2:n (sub +3:n 1)] 999))
  | 
[+2:n (sub +3:n 1)]
=?  left-coord  
  ?:  (gth +2:n 0)  (gte +((~(got by hm) n)) (~(gut by hm) [(sub +2:n 1) +3:n] 999))
  |
[(sub +2:n 1) +3:n]
=?  right-coord  (gte +((~(got by hm) n)) (~(gut by hm) [+(+2:n) +3:n] 999))  [+(+2:n) +3:n]


=?  dist  ?!(=(top-coord [999 999]))  (~(put by dist) top-coord (min (~(gut by dist) top-coord 999) (add 1 (~(got by dist) n))))
=?  prev  ?!(=(top-coord [999 999]))  ?:((lte (add 1 (~(got by dist) n)) (~(gut by dist) top-coord 999)) (~(put by prev) top-coord n) prev)

=?  dist  ?!(=(bot-coord [999 999]))  (~(put by dist) bot-coord (min (~(gut by dist) bot-coord 999) (add 1 (~(got by dist) n))))
=?  prev  ?!(=(bot-coord [999 999]))  ?:((lte (add 1 (~(got by dist) n)) (~(gut by dist) bot-coord 999)) (~(put by prev) bot-coord n) prev)

=?  dist  ?!(=(left-coord [999 999]))  (~(put by dist) left-coord (min (~(gut by dist) left-coord 999) (add 1 (~(got by dist) n))))
=?  prev  ?!(=(left-coord [999 999]))  ?:((lte (add 1 (~(got by dist) n)) (~(gut by dist) left-coord 999)) (~(put by prev) left-coord n) prev)

=?  dist  ?!(=(right-coord [999 999]))  (~(put by dist) right-coord (min (~(gut by dist) right-coord 999) (add 1 (~(got by dist) n))))
=?  prev  ?!(=(right-coord [999 999]))  ?:((lte (add 1 (~(got by dist) n)) (~(gut by dist) right-coord 999)) (~(put by prev) right-coord n) prev)

$(dist dist, prev prev, q q, os os)

::
++  parse-input
|=  in=(list @t)
^-  [(map (pair @ud @ud) @t) (pair @ud @ud) (pair @ud @ud)]
=|  w=@ud
=|  h=@ud
=|  s=[@ud @ud]
=|  e=[@ud @ud]
=|  m=(map (pair @ud @ud) @t)
|-
?~  in  [m s e]
=/  line=tape  (trip i.in)
|-
?~  line  ^$(in t.in, w 0, h +(h))
=/  val=@t  i.line
?:  =(val 'S')  $(line t.line, w +(w), s [w h], m (~(put by m) [w h] 'a'))
?:  =(val 'E')  $(line t.line, w +(w), e [w h], m (~(put by m) [w h] 'z'))
$(line t.line, m (~(put by m) [w h] i.line), w +(w))
--