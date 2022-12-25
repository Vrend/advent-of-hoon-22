|=  input=(list @t)
=<
=|  raw-stacks=(list @t)
=|  stacks=(map @ud (list @t))
=/  parsed-stacks=?  |
|-
?~  input  stacks
?:  parsed-stacks
  $(stacks (parse-command stacks i.input), input t.input)
?:  =("" i.input)  
  $(stacks (parse-stacks raw-stacks), input t.input, parsed-stacks &)
$(raw-stacks [i.input raw-stacks], input t.input)
::
|%
++  parse-command
|=  [stacks=(map @ud (list @t)) raw-line=@t]
^-  (map @ud (list @t))
=/  line=tape  (trip raw-line)
=/  c=@ud  (slav %ud (crip (slag +((need (find " " (scag (need (find " from" line)) line)))) (scag (need (find " from" line)) line))))
=/  to-from=tape  (slag (add (need (find "from " line)) 5) line)
=/  from=@ud  (slav %ud (crip (scag (need (find " " to-from)) to-from)))
=/  to=@ud  (slav %ud (crip (slag (add (need (find "to " line)) 3) line)))
|-
?:  =(c 0)  stacks
=/  temp=(map @ud (list @t))  stacks
=/  from-stack=(list @t)  (~(got by stacks) from)
=/  to-stack=(list @t)  (~(got by stacks) to)
=/  val=@t  (need (peek from-stack))
=.  temp  (~(put by temp) from (pop from-stack))
=.  temp  (~(put by temp) to (push to-stack val))
$(stacks temp, c (sub c 1))
::
++  parse-stacks
|=  stacks=(list @t)
^-  (map @ud (list @t))
=|  output=(map @ud (list @t))
|-
?~  stacks  output
=/  line=tape  (trip i.stacks)
?.  =(+2:line '[')
  $(stacks t.stacks)
=/  stack-count=@ud  1
|- :: inner loop
?~  line  ^$(stacks t.stacks)
?:  =(i.line '[')
  $(output (~(put by output) stack-count (weld ~[(snag 1 `tape`line)] (~(gut by output) stack-count *(list @t)))), line (slag 4 `tape`line), stack-count +(stack-count))
$(line (slag 4 `tape`line), stack-count +(stack-count))
::
++  peek
|=  stack=(list @t)
^-  (unit @t)
?~  stack  ~
(some i.stack)
::
++  push
|=  [stack=(list @t) val=@t]
^-  (list @t)
[val stack]
::
++  pop
|=  stack=(list @t)
^-  (list @t)
?~  stack  !!
t.stack
--