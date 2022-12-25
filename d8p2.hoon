|=  input=(list @t)
=<
=/  height=@ud  (lent input)
=/  width=@ud  (lent (trip +2:input))
=/  tree-grid=(map (pair @ud @ud) @ud)  (convert-input input)
=|  max=@ud
=/  tree-coords=(list (pair @ud @ud))  ~(tap in ~(key by tree-grid))
|-
?~  tree-coords  max
=/  left=@ud  (check-left tree-grid i.tree-coords)
=/  right=@ud  (check-right tree-grid i.tree-coords width)
=/  up=@ud  (check-up tree-grid i.tree-coords)
=/  down=@ud  (check-down tree-grid i.tree-coords height)
=/  val=@ud  (mul left (mul right (mul up down)))
?:  (gth val max)  $(max val, tree-coords t.tree-coords)
$(tree-coords t.tree-coords)
|%
++  check-down
|=  [tg=(map (pair @ud @ud) @ud) tr=[@ud @ud] height=@ud]
^-  @ud
=|  score=@ud
=/  tsize=@ud  (~(got by tg) tr)
?:  =(+3:tr (sub height 1))  0
=/  h=@ud  +(+3:tr)
|-
?:  =(+(h) height)  +(score)
?:  (lth (~(got by tg) [+2:tr h]) tsize)  $(score +(score), h +(h))
+(score)
::
++  check-up
|=  [tg=(map (pair @ud @ud) @ud) tr=[@ud @ud]]
^-  @ud
=|  score=@ud
=/  tsize=@ud  (~(got by tg) tr)
?:  =(+3:tr 0)  0
=/  h=@ud  (sub +3:tr 1)
|-
?:  =(h 0)  +(score)
?:  (lth (~(got by tg) [+2:tr h]) tsize)  $(score +(score), h (sub h 1))
+(score)
::
++  check-right
|=  [tg=(map (pair @ud @ud) @ud) tr=[@ud @ud] width=@ud]
^-  @ud
=|  score=@ud
=/  tsize=@ud  (~(got by tg) tr)
?:  =(+2:tr (sub width 1))  0
=/  w=@ud  +(+2:tr)
|-
?:  =(+(w) width)  +(score)
?:  (lth (~(got by tg) [w +3:tr]) tsize)  $(score +(score), w +(w))
+(score)
::
++  check-left
|=  [tg=(map (pair @ud @ud) @ud) tr=[@ud @ud]]
^-  @ud
=|  score=@ud
=/  tsize=@ud  (~(got by tg) tr)
?:  =(+2:tr 0)  0
=/  w=@ud  (sub +2:tr 1)
|-
?:  =(w 0)  +(score)
?:  (lth (~(got by tg) [w +3:tr]) tsize)  $(score +(score), w (sub w 1))
+(score)
::
++  convert-input
|=  in=(list @t)
^-  (map (pair @ud @ud) @ud)
=|  out=(map (pair @ud @ud) @ud)
=|  w=@ud
=|  h=@ud
|-
?~  in  out
=/  line=tape  (trip i.in)
|-
?~  line  ^$(in t.in, h +(h), w 0)
$(out (~(put by out) [w h] (slav %ud i.line)), w +(w), line t.line)
--