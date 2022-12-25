|=  input=(list @t)
=<
=|  cd=tape
=|  dirs=(map tape @ud)
=|  folders=(set tape)
=.  dirs  (~(put by dirs) "/" 0)
=.  folders  (~(put in folders) "/")
|-
?~  input  (get-sum dirs folders)
=/  line=tape  (trip i.input)
?:  =('$' +2:line)
  ?~  (find "$ cd " line)
    $(input t.input)
  $(cd (parse-dir cd (slag 5 line)), input t.input)
=/  filename=tape  (slag +((need (find " " line))) line)
=|  filesize=@ud
=?  filesize  ?!(=("dir" (scag 3 line)))  (convert-decimal (crip (scag (need (find " " line)) line)))
=?  folders  =("dir" (scag 3 line))  (~(put in folders) (weld cd filename))
?:  (~(has by dirs) filename)  $(input t.input)
=/  temp=(map tape @ud)  dirs
=.  temp  (update-folder-sizes temp cd filesize)
$(dirs (~(put by temp) (weld cd filename) filesize), input t.input)
::
|%
++  get-sum :: just rewriting this gate
|=  [dirs=(map tape @ud) folders=(set tape)]
^-  @ud
=/  needed=@ud  (sub 30.000.000 (sub 70.000.000 (~(got by dirs) "/")))
=/  best=@ud  70.000.000 :: any folder will be better
=/  folders-list=(list tape)  ~(tap in folders)
|-
?~  folders-list  best
=/  size=@ud  (~(got by dirs) i.folders-list)
?:  ?&((gte size needed) (lth size best))
  $(best size, folders-list t.folders-list)
$(folders-list t.folders-list)
::
++  update-folder-sizes
|=  [dirs=(map tape @ud) cd=tape size=@ud]
^-  (map tape @ud)
|-
?:  =(cd ~)  dirs
?:  =("/" cd)
  =/  folder-size=@ud  (~(got by dirs) cd)
  (~(put by dirs) cd (add folder-size size))
=.  cd  (snip cd)
=/  folder-size=@ud  (~(got by dirs) cd)
=/  next-dir=tape  (flop (slag (need (find "/" (flop cd))) (flop cd)))
$(dirs (~(put by dirs) cd (add folder-size size)), cd next-dir)
::
++  convert-decimal
|=  input=@t
^-  @ud
=/  num=tape  (trip input)
=.  num  (flop num)
=|  count=@ud
=|  output=tape
|-
?~  num  (slav %ud (crip output))
?:  (gth count 2)
  $(output (weld "." output), count 0)
$(output [i.num output], num t.num, count +(count))
::
++  parse-dir
|=  [cd=tape dir=tape]
^-  tape
?.  =(".." dir)
  ?:  =("" cd)  "/"
  (weld cd (weld dir "/"))
=.  cd  +3:(flop cd)
(flop (slag (need (find "/" cd)) cd))
--