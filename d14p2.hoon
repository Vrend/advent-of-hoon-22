|=  input=(list @t)
=<
=/  cavern-map=(map (pair @ud @ud) @ud)  (create-map input)
=/  deepest=@ud  (add 2 (deepest-rock cavern-map))
=|  count=@ud
|-
=/  res=(map (pair @ud @ud) @ud)  (drop-sand [500 0] cavern-map deepest)
?:  =(1 (~(got by res) [500 0]))  +(count)
$(cavern-map res, count +(count))
|%
++  drop-sand
|=  [sc=[@ud @ud] cm=(map (pair @ud @ud) @ud) deepest=@ud]
^-  (map (pair @ud @ud) @ud)
?:  =(+(+3:sc) deepest)  (~(put by cm) sc 1)
?.  (~(has by cm) [+2:sc +(+3:sc)])  (drop-sand [+2:sc +(+3:sc)] cm deepest)
?.  (~(has by cm) [(sub +2:sc 1) +(+3:sc)])  (drop-sand [(sub +2:sc 1) +(+3:sc)] cm deepest)
?.  (~(has by cm) [+(+2:sc) +(+3:sc)])  (drop-sand [+(+2:sc) +(+3:sc)] cm deepest)
(~(put by cm) sc 1)
::
++  deepest-rock
|=  cm=(map (pair @ud @ud) @ud)
^-  @ud
=|  deepest=@ud
=/  cml=(list (pair @ud @ud))  ~(tap in ~(key by cm))
|-
?~  cml  deepest
?:  (gth +3:i.cml deepest)  $(deepest +3:i.cml, cml t.cml)
$(cml t.cml)
::
++  create-map
|=  input=(list @t)
^-  (map (pair @ud @ud) @ud)
=|  output=(map (pair @ud @ud) @ud)
=.  output  (~(put by output) [500 0] 2)
|-
?~  input  output
=/  line=tape  (trip i.input)
|-
?~  (find " " line)  ^$(input t.input)
=/  comma-index=@ud  (need (find "," line))
=/  space-index=@ud  (need (find " " line))
=/  x1=@ud  (slav %ud (crip (scag comma-index line)))
=/  y1=@ud  (slav %ud (crip (swag [+(comma-index) (sub (sub space-index comma-index) 1)] line)))
=/  updated-line=tape  (slag (add 2 (need (find ">" line))) line)
?~  (find " " updated-line)
  =.  comma-index  (need (find "," updated-line))
  =/  x2=@ud  (slav %ud (crip (scag comma-index updated-line)))
  =/  y2=@ud  (slav %ud (crip (slag +(comma-index) updated-line)))
  $(output (add-vector x1 y1 x2 y2 output), line updated-line)
=.  comma-index  (need (find "," updated-line))
=.  space-index  (need (find " " updated-line))
=/  x2=@ud  (slav %ud (crip (scag comma-index updated-line)))
=/  y2=@ud  (slav %ud (crip (swag [+(comma-index) (sub (sub space-index comma-index) 1)] updated-line)))
$(output (add-vector x1 y1 x2 y2 output), line updated-line)
::
++  add-vector
|=  [x1=@ud y1=@ud x2=@ud y2=@ud cm=(map (pair @ud @ud) @ud)]
=/  xs=[@ud @ud]  [x1 x2]
=?  xs  (gth x1 x2)  [x2 x1]
=.  x1  +2:xs
=.  x2  +3:xs
=/  ys=[@ud @ud]  [y1 y2]
=?  ys  (gth y1 y2)  [y2 y1]
=.  y1  +2:ys
=.  y2  +3:ys
^-  (map (pair @ud @ud) @ud)
?:  =(x1 x2)
  =/  pairs=(list [(pair @ud @ud) @ud])  (turn (gulf y1 y2) |=(a=@ud [[x1 a] 0]))
  (~(gas by cm) pairs)
=/  pairs=(list [(pair @ud @ud) @ud])  (turn (gulf x1 x2) |=(a=@ud [[a y1] 0]))
(~(gas by cm) pairs)
--