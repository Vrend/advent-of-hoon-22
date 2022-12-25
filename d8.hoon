|=  input=(list @t)
=<
=/  height=@ud  (lent input)
=/  width=@ud  (lent (trip +2:input))
=/  tree-grid=(map (pair @ud @ud) @ud)  (convert-input input)
=|  visible-trees=(set (pair @ud @ud))
=.  visible-trees  (check-left tree-grid visible-trees width height)
=.  visible-trees  (check-right tree-grid visible-trees width height)
=.  visible-trees  (check-down tree-grid visible-trees width height)
=.  visible-trees  (check-up tree-grid visible-trees width height)
~(wyt in visible-trees)
|%
++  check-up
|=  [tg=(map (pair @ud @ud) @ud) vt=(set (pair @ud @ud)) width=@ud height=@ud]
^-  (set (pair @ud @ud))
=|  w=@ud
=/  h=@ud  (sub height 1)
|-
?:  =(w width)  vt
=|  biggest=@ud
|-
?:  =(h 0)  ^$(vt (~(put in vt) [w h]), w +(w), h (sub height 1))
?:  ?|(=(+(h) height) (gth (~(got by tg) [w h]) biggest))  
  $(vt (~(put in vt) [w h]), biggest (~(got by tg) [w h]), h (sub h 1))
$(h (sub h 1))
::
++  check-down
|=  [tg=(map (pair @ud @ud) @ud) vt=(set (pair @ud @ud)) width=@ud height=@ud]
^-  (set (pair @ud @ud))
=|  w=@ud
=|  h=@ud
|-
?:  =(w width)  vt
=|  biggest=@ud
|-
?:  =(h height)  ^$(w +(w), h 0)
?:  ?|(=(h 0) =(+(h) height) (gth (~(got by tg) [w h]) biggest))  
  $(vt (~(put in vt) [w h]), biggest (~(got by tg) [w h]), h +(h))
$(h +(h))
::
++  check-right
|=  [tg=(map (pair @ud @ud) @ud) vt=(set (pair @ud @ud)) width=@ud height=@ud]
^-  (set (pair @ud @ud))
=/  w=@ud  (sub width 1)
=|  h=@ud
|-
?:  =(h height)  vt
=|  biggest=@ud
|-
?:  =(w 0)  ^$(vt (~(put in vt) [w h]), h +(h), w (sub width 1))
?:  ?|(=(+(w) width) (gth (~(got by tg) [w h]) biggest))  
  $(vt (~(put in vt) [w h]), biggest (~(got by tg) [w h]), w (sub w 1))
$(w (sub w 1))
::
++  check-left
|=  [tg=(map (pair @ud @ud) @ud) vt=(set (pair @ud @ud)) width=@ud height=@ud]
^-  (set (pair @ud @ud))
=|  w=@ud
=|  h=@ud
|-
?:  =(h height)  vt
=|  biggest=@ud
|-
?:  =(w width)  ^$(h +(h), w 0)
?:  ?|(=(w 0) =(+(w) width) (gth (~(got by tg) [w h]) biggest))  
  $(vt (~(put in vt) [w h]), biggest (~(got by tg) [w h]), w +(w))
$(w +(w))
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