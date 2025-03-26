000000161025
000000161025     h dftactgrp(*no) bnddir('SAMPLE')
000000161025
000000161201     forder1    uf   e           k disk
000000161201     fdetord1   uf   e           k disk
000000161027     fcustome1  if   e           k disk
000000161027     ford200d   cf   e             workstn
000000161024     F                                     indds(indds)
000000161024     F                                     sfile(sfl01:rrn01)
000000161024     F                                     Infds(Info)
000000161025
000000161027     d ord200          pr
000000161027     d  cuid                               like(orcuid)
000000161025
000000161027     d ord200          pi
000000161027     d  cuid                               like(orcuid)
000000161103
000000161201     d Updord          pr                  extpgm('ORD101')
000000161201     d  x                                  like(orid)
000000161201
000000161103     d dspord          pr                  extpgm('ORD202')
000000161103     d  x                                  like(orid)
000000161103
000000161129     d Prtord          pr                  extpgm('ORD500')
000000161129     d  x                                  like(orid)
000000161129
000000161129     d NewOrder        pr                  extpgm('ORD100C')
000000161129     d  x                                  like(cuid)
000000161129
000000161024     D indds           ds
000000161024     D  help                   1      1n
000000161024     D  exit                   3      3n
000000161024     D  prompt                 4      4n
000000161024     D  refresh                5      5n
000000161027     D  create                 6      6n
000000161024     D  cancel                12     12n
000000161024     D  morekeys              24     24n
000000161024     D  pagedown              25     25n
000000161024     D  sflclr                30     30n
000000161024     D  sfldsp                31     31n
000000161024     D  sfldspctl             32     32n
000000161024     D  sflnxtchg             33     33n
000000161024     D  dspatr_ri             34     34n
000000161024     D  sflmsg                35     35n
000000161201     D  sflmsg2               36     36n
000000161201     D  sflmsg3               37     37n
000000161024     D  sflend                80     80n
000000161024
000000161024     D info            ds
000000161024     D  lrrn                 378    379i 0
000000161024
000000161024     D rrn01           s              5i 0
000000161024     D rrs01           s              5i 0
000000161024     D err01           s               n
000000161024
000000161024     D panel           S              3i 0 INZ(1)
000000161024     D step01          S              3    inz(prp)
000000161027     d savId           s                   like(cuid)
000000161025     d User            s             10    inz(*user)
000000161024     d count           s              3i 0
000000161024     d mode            s              3
000000161024
000000161024     d crt             c                   'CRT'
000000161024     d upd             c                   'UPD'
000000161024     d prp             c                   'prp'
000000161024     d lod             c                   'lod'
000000161024     d dsp             c                   'dsp'
000000161024     d key             c                   'key'
000000161024     d chk             c                   'chk'
000000161024     d act             c                   'act'
000000161027     d datBlank        c                   d'1940-01-01'
000000161103      /free
000000161024       select;
000000161024       when panel = 1;
000000161024         exsr pnl01;
000000161024       other;
000000161024         exsr pnl00;
000000161024       endsl;
000000161024       //- Subfiles  01 Subroutines --------------------------------------  ---
000000161024       begsr pnl01;
000000161024         select ;
000000161024         when step01 = prp ;
000000161024           exsr s01prp;
000000161024         when step01 = lod ;
000000161024           exsr s01lod;
000000161024         when step01 = dsp ;
000000161024           exsr s01dsp;
000000161024         when step01 = key ;
000000161024           exsr s01key;
000000161024         when step01 = chk ;
000000161024           exsr s01chk;
000000161024         when step01 = act ;
000000161024           exsr s01act ;
000000161024         endsl;
000000161024       endsr;
000000161024       //--- Clear Subfile  ----------------------------------------------------
000000161024       begsr s01prp;
000000161024         RRn01 = 0;
000000161024         sflclr = *on;
000000161024         write ctl01;
000000161024         sflclr = *off;
000000221013         exec sql declare c1 cursor for
000000221013                 SELECT ORID, ORYEAR,
000000221013                        ISOTODATE40(ORDATE) AS DATORD,
000000221013                        ISOTODATE40(ORDATDEL) AS DATLIV,
000000221013                        ISOTODATE40( ORDATCLO) AS DATCLO ,
000000221013                        Totval
000000221013                 FROM Ordercus
000000221013                 Where orcuid  = :cuid
000000221013                 order by datord desc;
000000161027         exec sql open c1;
000000161024         step01 = lod;
000000161024       endsr;
000000161024       //--- Load Subfile  -----------------------------------------------------
000000161024       begsr s01lod;
000000161024         RRb01 = RRn01 + 1;
000000161024         opt01 = 0;
000000161027         exec sql fetch c1 into :orid, :oryear, :datord,
000000161027                                :datliv, :datclo, :sumord;
000000161027         dow sqlcod = 0;
000000161024           RRN01 += 1;
000000161024           write sfl01;
000000161027           exec sql fetch c1 into :orid, :oryear, :datord,
000000161027                                :datliv, :datclo, :sumord;
000000161024         enddo;
000000161027         exec sql close c1;
000000161025         sflend = *on ;
000000161024         step01 = dsp;
000000161024       endsr;
000000161024       //--- Display Subfile  --------------------------------------------------
000000161024       begsr s01dsp;
000000161024         sfldspctl = *on;
000000161024         sfldsp = RRn01 > 0;
000000161024
000000161024         write key01;
000000161024         exfmt ctl01;
000000161024         if LRRN <>0;
000000161024           RRb01 = LRRN;
000000161024         endif;
000000161024         step01 = key;
000000161024       endsr;
000000161024       //--- Command Keys  -----------------------------------------------------
000000161024       begsr s01key;
000000161024         select;
000000161024         when exit;
000000161024           panel  = 0;
000000161024           step01 = prp;
000000161024         when cancel;
000000161024           step01 = prp;
000000161024           panel  = panel  - 1;
000000161129         when create;
000000161129           newOrder(cuid);
000000161129           step01 = prp;
000000161024         other;
000000161024           step01 = chk;
000000161024         endsl;
000000161024       endsr;
000000161024       //--- Check Subfile  ----------------------------------------------------
000000161024       begsr s01chk;
000000161024         step01 = act;
000000161024         err01 = *off;
000000161024         sflnxtchg = *on;
000000161024         readc(e) sfl01;
000000161024         dow not %error and not %eof;
000000161201           if opt01 = 1  or opt01 = 3  or  opt01  > 8;
000000161024             step01 = dsp;
000000161024             dspatr_ri = *on;
000000161024             sflmsg = *on;
000000161024             if not err01;
000000161024               rrb01 = rrn01;
000000161024               err01 = *on;
000000161024             endif;
000000161024           endif;
000000161201           if opt01 = 7 and datclo > datBlank
000000161201             or opt01 = 8 and datliv > datBlank;
000000161201             step01 = dsp;
000000161201             dspatr_ri = *on;
000000161201             sflmsg = *on;
000000161201             if not err01;
000000161201               rrb01 = rrn01;
000000161201               err01 = *on;
000000161201             endif;
000000161201           endif;
000000161201           if opt01 = 2 or opt01 = 4 and datclo > datBlank;
000000161201             step01 = dsp;
000000161201             dspatr_ri = *on;
000000161201             sflmsg2 = *on;
000000161201             if not err01;
000000161201               rrb01 = rrn01;
000000161201               err01 = *on;
000000161201             endif;
000000161201           endif;
000000161201           if opt01 = 4;
000000161201             setll orid detord1;
000000161201             reade(n) orid detord1;
000000161201             dow not %eof();
000000161201               if odqtyliv > 0;
000000161201                 step01 = dsp;
000000161201                 dspatr_ri = *on;
000000161201                 sflmsg3 = *on;
000000161201                 if not err01;
000000161201                   rrb01 = rrn01;
000000161201                   err01 = *on;
000000161201                 endif;
000000161201                 leave;
000000161201               endif;
000000161201               reade(n) orid detord1;
000000161201             enddo;
000000161201           endif;
000000161024           update sfl01;
000000161024           dspatr_ri = *off;
000000161024           readc(e) sfl01;
000000161024         enddo;
000000161024         sflnxtchg = *off;
000000161024       endsr;
000000161024       //--- action Subfile  ---------------------------------------------------
000000161024       begsr s01act;
000000161024         readc(e) sfl01;
000000161024         select;
000000161024         when %error or %eof;
000000161024           step01 = dsp;
000000161024         when opt01 = 2;
000000161201           Updord(orid);
000000161024           opt01 = 0;
000000161024           update sfl01;
000000161201         when opt01 = 4;
000000161208           delete orid order1;
000000161201           dou not %found();
000000161201             delete orid detord1;
000000161201           enddo;
000000161201           opt01 = 0;
000000161201           update sfl01;
000000161103         when opt01 = 5;
000000161103           dspord(orid);
000000161103           opt01 = 0;
000000161103           update sfl01;
000000161129         when opt01 = 6;
000000161129           Prtord(orid);
000000161129           opt01 = 0;
000000161129           update sfl01;
000000161201         when opt01 = 7;
000000161201           chain (orid) order1;
000000161201           if ordatdel = 0;
000000161201             ordatdel = %dec(%date():*iso);
000000161201             datliv = %date();
000000161201           endif;
000000161201           ordatclo = %dec(%date():*iso);
000000161201           update forde;
000000161201           datclo = %date();
000000161201           opt01 = 0;
000000161201           update sfl01;
000000161201         when opt01 = 8;
000000161201           chain (orid) order1;
000000161201           ordatdel = %dec(%date():*iso);
000000161201           datliv = %date();
000000161201           update forde;
000000161201           setll orid detord1;
000000161201           reade orid detord1;
000000161201           dow not %eof();
000000161201             if odqtyliv = 0;
000000161201               odqtyliv = odqty;
000000161201               update fdeto;
000000161201             else;
000000161201               unlock detord1;
000000161201             endif;
000000161201             reade orid detord1;
000000161201           enddo;
000000161201           opt01 = 0;
000000161201           update sfl01;
000000161024         other;
000000161024
000000161024         endsl;
000000161024       endsr;
000000161024
000000161025       //--------INITIALIZATION ----------------------------------
000000161025       begsr *inzsr;
000000161027         datord = datBlank;
000000161027         datclo = datBlank;
000000161027         datliv = datBlank;
000000161221         chain cuid custome1;
000000161025       endsr;
000000161025       //--------END SUBROUTINE ----------------------------------
000000161025       begsr pnl00;
000000161025         *inlr = *on;
000000161025       endsr;
000000161103      /end-free
