000000161104     forder1    if   e           k disk
000000161104     d next            s              6s 0 DTAARA('LASTORDNO')
000000161104     c     *hival        setgt     order1
000000161104     c                   readp     order1
000000161104     c     *lock         in        next
000000161104     c                   z-add     orid          next
000000161104     c                   out       next
000000161104     c                   seton                                        lr
