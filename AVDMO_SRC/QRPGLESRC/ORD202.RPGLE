000000161103
000000161103     h dftactgrp(*no) bnddir('SAMPLE')
000000161103
000000161103     fcustome1  if   e           k disk
000000161103     farticle1  if   e           k disk
000000161103     fdetord1   if   e           k disk
000000161103     forder1    if   e           k disk
000000161103     ford202d   cf   e             workstn
000000161103     F                                     indds(indds)
000000161103     F                                     sfile(sfl01:rrn01)
000000161103     F                                     Infds(Info)
000000161103
000000161103     d ord202          pr
000000161103     d  id                                 like(orid)
000000161103     d ord202          pi
000000161103     d  id                                 like(orid)
000000161103     D indds           ds
000000161103     D  help                   1      1n
000000161103     D  exit                   3      3n
000000161103     D  prompt                 4      4n
000000161103     D  refresh                5      5n
000000161103     D  create                 6      6n
000000161103     D  cancel                12     12n
000000161103     D  morekeys              24     24n
000000161103     D  pagedown              25     25n
000000161103     D  sflclr                30     30n
000000161103     D  sfldsp                31     31n
000000161103     D  sfldspctl             32     32n
000000161103     D  sflnxtchg             33     33n
000000161103     D  dspatr_ri             34     34n
000000161103     D  sflmsg                35     35n
000000161103     D  sflend                80     80n
000000161103
000000161103     D info            ds
000000161103     D  lrrn                 378    379i 0
000000161103
000000161103     D rrn01           s              5i 0
000000161103     D rrs01           s              5i 0
000000161103     D err01           s               n
000000161103
000000161103     D panel           S              3i 0 INZ(1)
000000161103     D step01          S              3    inz(prp)
000000161103     d User            s             10    inz(*user)
000000161103     d count           s              3i 0
000000161103     d mode            s              3
000000161103
000000161103     d crt             c                   'CRT'
000000161103     d upd             c                   'UPD'
000000161103     d prp             c                   'prp'
000000161103     d lod             c                   'lod'
000000161103     d dsp             c                   'dsp'
000000161103     d key             c                   'key'
000000161103     d chk             c                   'chk'
000000161103     d act             c                   'act'
000000161103     d datBlank        c                   d'1940-01-01'
000000161103      /free
000000161103       select;
000000161103       when panel = 1;
000000161103         exsr pnl01;
000000161103       other;
000000161103         exsr pnl00;
000000161103       endsl;
000000161103       //- Subfiles  01 Subroutines --------------------------------------  ---
000000161103       begsr pnl01;
000000161103         select ;
000000161103         when step01 = prp ;
000000161103           exsr s01prp;
000000161103         when step01 = lod ;
000000161103           exsr s01lod;
000000161103         when step01 = dsp ;
000000161103           exsr s01dsp;
000000161103         when step01 = key ;
000000161103           exsr s01key;
000000161103         when step01 = act ;
000000161103           exsr s01act ;
000000161103         endsl;
000000161103       endsr;
000000161103       //--- Clear Subfile  ----------------------------------------------------
000000161103       begsr s01prp;
000000161103         chain id order1;
000000161103         chain orcuid custome1;
000000161103         datord = %date(ordate:*iso);
000000161103         if ordatdel > 0;
000000161103           datliv = %date(ordatdel:*iso);
000000161103         endif;
000000161103         if ordatclo > 0;
000000161103           datclo = %date(ordatclo:*iso);
000000161103         endif;
000000161103         RRn01 = 0;
000000161103         sflclr = *on;
000000161103         write ctl01;
000000161103         sflclr = *off;
000000161103         step01 = lod;
000000161103       endsr;
000000161103       //--- Load Subfile  -----------------------------------------------------
000000161103       begsr s01lod;
000000161103         RRb01 = RRn01 + 1;
000000161201         tot = 0;
000000161201         totvat = 0;
000000161103         setll id detord1;
000000161103         reade id detord1;
000000161103         dow not %eof(detord1);
000000161201           tot += odtot;
000000161201           totvat += odtotvat;
000000161103           chain odarid article1;
000000161103           RRN01 += 1;
000000161103           write sfl01;
000000161103           reade id detord1;
000000161103         enddo;
000000161201         sflend = *on;
000000161103         step01 = dsp;
000000161103       endsr;
000000161103       //--- Display Subfile  --------------------------------------------------
000000161103       begsr s01dsp;
000000161103         sfldspctl = *on;
000000161103         sfldsp = RRn01 > 0;
000000161103
000000161103         write key01;
000000161103         exfmt ctl01;
000000161103         if LRRN <>0;
000000161103           RRb01 = LRRN;
000000161103         endif;
000000161103         step01 = key;
000000161103       endsr;
000000161103       //--- Command Keys  -----------------------------------------------------
000000161103       begsr s01key;
000000161103         select;
000000161103         when exit;
000000161103           panel  = 0;
000000161103           step01 = prp;
000000161103         when cancel;
000000161103           step01 = prp;
000000161103           panel  = 0 ;
000000161103         other;
000000161103           step01 = act;
000000161103         endsl;
000000161103       endsr;
000000161103       //--- action Subfile  ---------------------------------------------------
000000161103       begsr s01act;
000000161103         panel = 0;
000000161103       endsr;
000000161103
000000161103       //--------INITIALIZATION ----------------------------------
000000161103       begsr *inzsr;
000000161103         datord = datBlank;
000000161103         datclo = datBlank;
000000161103         datliv = datBlank;
000000161103       endsr;
000000161103       //--------END SUBROUTINE ----------------------------------
000000161103       begsr pnl00;
000000161103         *inlr = *on;
000000161103       endsr;
000000161103      /end-free
