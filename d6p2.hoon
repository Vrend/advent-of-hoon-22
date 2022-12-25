|=  input=(list @t)
^-  @ud
=/  code=tape  (trip +2:input)
=/  count=@ud  14
|-
?~  code  !!
=|  known=(set @t)
=/  letters=(list @t)  `(list @t)`(scag 14 `tape`code)
|-
?~  letters  count
?:  (~(has in known) i.letters)  ^$(code t.code, count +(count))
$(letters t.letters, known (~(put in known) i.letters))