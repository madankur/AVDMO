000000161130     H dftactgrp(*no)
000000161130
000000161130     Farticle1  UF   E           K DISK
000000161130
000000161216      /copy qprotosrc,log
000000161216
000000161130     d UpdArt          pr
000000161130     d   qty                          5  0 value
000000161130     d   id                                like(new.ODARID)
000000161130
000000161130     D PARM1           DS
000000161130      * Physical file name
000000161130     D  FNAME                        10
000000161130      * Physical file library
000000161130     D  LNAME                        10
000000161130      * Member name
000000161130     D  MNAME                        10
000000161130      * Trigger event 1=Ins, 2=Del, 3=Upd
000000161130     D  TEVEN                         1
000000161130      * Trigger time  1=After, 2=Before
000000161130     D  TTIME                         1
000000161130      * Commit lock level
000000161130     D  CMTLCK                        1
000000161130      * Reserved
000000161130     D                                3
000000161130      * CCSID
000000161130     D  CCSID                        10i 0
000000161130      * Reserved
000000161130     D                                8
000000161130      * Offset to the original record
000000161130     D  OLDOFF                       10i 0
000000161130      * length of the original record
000000161130     D  OLDLEN                       10i 0
000000161130      * Offset to the original record null byte map
000000161130     D  ONOFF                        10i 0
000000161130      * length of the null byte map
000000161130     D  ONLEN                        10i 0
000000161130      * Offset to the new record
000000161130     D  NEWOFF                       10i 0
000000161130      * length of the new record
000000161130     D  NEWLEN                       10i 0
000000161130      * Offset to the new record null byte map
000000161130     D  NNOFF                        10i 0
000000161130      * length of the null byte map
000000161130     D  NNLEN                        10i 0
000000161130
000000161130      * Trigger Buffer Length
000000161130     D  parm2          s             10i 0
000000161130
000000161130      * Record to be inserted or new values
000000161130     D NEW           E DS                  EXTNAME(detord)
000000161130     D                                     qualified
000000161130     D                                     based(pn)
000000161130
000000161130      * Record to be deleted or old values
000000161130     D OLD           E DS                  EXTNAME(detord)
000000161130     D                                     qualified
000000161130     D                                     based(po)
000000161130
000000161130      * SET UP THE ENTRY PARAMETER LIST.
000000161130
000000161130     C     *ENTRY        PLIST
000000161130     C                   PARM                    PARM1
000000161130     C                   PARM                    PARM2
000000161130     C                   if                      %parms = 0
000000161130     C                   seton                                        lr
000000161130     C                   return
000000161130     C                   ENDIF
000000161130     C                   select
000000161130     c                   when      teven = '1'
000000161130     c                   eval      pn = %addr(parm1) + newoff
000000161130     c                   callp     UpdArt(new.odqty:new.odarid)
000000161130     c                   when      teven = '2'
000000161130     c                   eval      po = %addr(parm1) + oldoff
000000161216     c                   callp(e)  addlogEntry('ORD700:Order Line deleted ' +
000000161216     c                             %char(Old.odorid) + ' ' + %char(Old.odline)
000000161216     c                              + ' article : ' + old.odarid
000000161216     c                              + ' quantity : ' + %char(old.odqty))
000000161130     c                   callp     UpdArt(-Old.odqty + Old.odqtyliv:old.odarid)
000000161130     c                   when      teven = '3'
000000161130     c                   eval      pn = %addr(parm1) + newoff
000000161130     c                   eval      po = %addr(parm1) + oldoff
000000161130     c                   if        new.odarid = Old.odarid
000000161130     c                   callp     UpdArt((New.odqty - Old.odqty)
000000161130     c                              - (New.odqtyLiv - Old.odqtyLiv)
000000161130     c                             :new.odarid)
000000161130     c                   else
000000161130     c                   callp     UpdArt(new.odqty- new.odqtyliv:new.odarid)
000000161130     c                   callp     UpdArt(-Old.odqty + Old.odqtyliv:old.odarid)
000000161130     c                   endif
000000161130     c                   endsl
000000161130     c                   return
000000161130
000000161130     P UpdArt          b
000000161130     d UpdArt          pi
000000161130     d   qty                          5  0 value
000000161130     d   id                                like(new.ODARID)
000000161130     c                   if        qty = 0
000000161130     c                   return
000000161130     c                   ENDIF
000000161130     c     id            chain     article1
000000161130     c                   if        not %found
000000161130     c                   return
000000161130     c                   ENDIF
000000161130     c                   eval      ARCUSQTY += qty
000000161130     c                   update    farti
000000161130     P UpdArt          e
