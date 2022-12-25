|=  input=(list @t)
^-  @ud
=/  code=tape  (trip +2:input)
=/  count=@ud  4
|-
?~  code  !!
=/  c1=@t  (snag 0 `tape`code)
=/  c2=@t  (snag 1 `tape`code)
=/  c3=@t  (snag 2 `tape`code)
=/  c4=@t  (snag 3 `tape`code)
?.  ?|(=(c1 c2) =(c1 c3) =(c1 c4) =(c2 c3) =(c2 c4) =(c3 c4))  count
$(code t.code, count +(count))