|=  input=(list @t)
^-  @ud
=<
=/  packets=(list json)  (create-packet-list input)
=/  ordered-packets=(list json)  (sort packets sort-wrapper)
=/  count=@ud  1
=/  sum=@ud  1
|-
?~  ordered-packets  sum
?:  ?|(=(i.ordered-packets +3:(de-json:html '[[2]]')) =(i.ordered-packets +3:(de-json:html '[[6]]')))
  $(ordered-packets t.ordered-packets, count +(count), sum (mul sum count))
$(ordered-packets t.ordered-packets, count +(count))
::
|%
++  sort-wrapper
|=  [left=json right=json]
^-  ?
?:  =(2 (ordered left right))  &
|
::
++  create-packet-list
|=  input=(list @t)
^-  (list json)
=|  output=(list json)
|-
?~  input  (weld (weld output ~[+3:(de-json:html '[[2]]')]) ~[+3:(de-json:html '[[6]]')])
?:  =(i.input '')  $(input t.input)
$(input t.input, output (weld output ~[+3:(de-json:html i.input)]))
::
++  handle-list
|=  [left=(list json) right=(list json)]
^-  @ud
?:  ?&(=(left ~) =(right ~))  1
?~  left  2
?~  right  0
=/  val=@ud  (ordered i.left i.right)
?:  =(2 val)  2
?:  =(0 val)  0
$(left t.left, right t.right)
::
++  ordered
|=  [left=json right=json]
^-  @ud
?:  ?&(=(+2:left %a) =(+2:right %a))
  ?>  ?=([%a *] left)
  ?>  ?=([%a *] right)
  (handle-list p.left p.right)
?:  ?&(=(+2:left %n) =(+2:right %n))
  ?>  ?=([%n *] left)
  ?>  ?=([%n *] right)
  ?:  (gth (slav %ud p.left) (slav %ud p.right))  0
  ?:  =((slav %ud p.left) (slav %ud p.right))  1
  2
?:  =(+2:left %n)
  ?>  ?=([%n *] left)
  ?>  ?=([%a *] right)
  (handle-list [left ~] p.right)
?>  ?=([%a *] left)
?>  ?=([%n *] right)
(handle-list p.left [right ~])
--