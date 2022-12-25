|=  input=(list @t)
^-  @ud
=<
=|  sum=@ud
=|  l1=@t
=/  count=@ud  1
|-
?~  input  sum
?:  =(i.input '')  $(input t.input)
?:  =(l1 '')  $(input t.input, l1 i.input)
?.  =(2 (ordered +3:(de-json:html l1) +3:(de-json:html i.input)))  $(input t.input, l1 '', count +(count))
$(input t.input, l1 '', count +(count), sum (add sum count))
::
|%
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