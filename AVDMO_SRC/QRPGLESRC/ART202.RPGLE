000000161025
000000161025     h dftactgrp(*no) bnddir('SAMPLE')
000000161025
000000161104     fartiprov  uf a e           k disk
000000161104     fart202d   cf   e             workstn
000000161024     F                                     indds(indds)
000000161024     F                                     sfile(sfl01:rrn01)
000000161024     F                                     Infds(Info)
000000161024
000000161025      /copy qprotosrc,provider
000000161025      /copy qprotosrc,article
000000161025
000000161104     d art202          pr
000000161104     d  prid                               like(apprid)
000000161025
000000161104     d art202          pi
000000161104     d  prid                               like(apprid)
000000161025
000000161024     D indds           ds
000000161024     D  help                   1      1n
000000161024     D  exit                   3      3n
000000161024     D  prompt                 4      4n
000000161024     D  refresh                5      5n
000000161024     D  cancel                12     12n
000000161024     D  morekeys              24     24n
000000161024     D  pagedown              25     25n
000000161024     D  sflclr                30     30n
000000161024     D  sfldsp                31     31n
000000161024     D  sfldspctl             32     32n
000000161024     D  sflnxtchg             33     33n
000000161024     D  dspatr_ri             34     34n
000000161024     D  sflmsg                35     35n
000000161025     D  errFamilly            40     40n
000000161025     D  errDesc               41     41n
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
000000161024     D step02          S              3    inz(prp)
000000161104     d savId           s                   like(prid)
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
000000161024     d chkctl          c                   'chc'
000000161024     d actctl          c                   'acc'
000000161024     d act             c                   'act'
000000161103      /free
000000161024       select;
000000161024       when panel = 1;
000000161024         exsr pnl01;
000000161024       when panel = 2;
000000161024         exsr pnl02;
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
000000161104         provnm = GetProName(prid);
000000161024         step01 = lod;
000000161024       endsr;
000000161024       //--- Load Subfile  -----------------------------------------------------
000000161024       begsr s01lod;
000000161024         RRb01 = RRn01 + 1;
000000161024         opt01 = 0;
000000161104         setll prid artiprov;
000000161104         reade(n) prid artiprov;
000000161104         dow not %eof(artiprov);
000000161104           ardesc = GetArtDesc(aparid);
000000161024           RRN01 += 1;
000000161024           write sfl01;
000000161104           reade(n) prid artiprov;
000000161024         enddo;
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
000000161025           if opt01 <> 0 and opt01 <> 2;
000000161024             step01 = dsp;
000000161024             dspatr_ri = *on;
000000161024             sflmsg = *on;
000000161024             if not err01;
000000161024               rrb01 = rrn01;
000000161024               err01 = *on;
000000161024             endif;
000000161024           endif;
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
000000161024           panel = 2;
000000161024           step02 = prp;
000000161024           opt01 = 0;
000000161024           update sfl01;
000000161024         other;
000000161024
000000161024         endsl;
000000161024       endsr;
000000161024
000000161024
000000161024       //--- Format 02 Subroutines ------------------------------------     ---
000000161024       begsr pnl02;
000000161024         select ;
000000161024         when step02 = prp ;
000000161024           exsr s02prp;
000000161024         when step02 = dsp ;
000000161024           exsr s02dsp;
000000161024         when step02 = key ;
000000161024           exsr s02key;
000000161024         when step02 = chk ;
000000161024           exsr s02chk;
000000161024         when step02 = act ;
000000161024           exsr s02act ;
000000161024         endsl;
000000161024
000000161024       endsr;
000000161024       //--- clear & Load ------------------------------------------------------
000000161024       begsr S02prp;
000000161104         chain (prid: aparid) artiprov;
000000161024         step02 = dsp;
000000161024       endsr;
000000161024       //--- Display  ----------------------------------------------------------
000000161024       begsr S02dsp;
000000161024         exfmt fmt02;
000000161024         step02 = key;
000000161024       endsr;
000000161024       //--- command Keys  -----------------------------------------------------
000000161024       begsr S02key;
000000161024         select;
000000161024         when exit;
000000161024           panel  = 1;
000000161024           step02 = prp;
000000161024         when cancel;
000000161024           step02 = prp;
000000161024           panel  = panel  - 1;
000000161024         other;
000000161024           step02 = chk;
000000161024         endsl;
000000161024       endsr;
000000161024       //--- check -------------------------------------------------------------
000000161024       begsr S02chk;
000000161024         step02 = act;
000000161024
000000161024       endsr;
000000161024       //--- Action ------------------------------------------------------------
000000161024       begsr S02act;
000000161024         step02 = prp;
000000161024         if mode = upd;
000000161025           apmod = %timestamp();
000000161025           apmodid = user;
000000161025           update farpr;
000000161024         endif;
000000161024         panel = 1;
000000161024       endsr;
000000161024
000000161025       //--------INITIALIZATION ----------------------------------
000000161025       begsr *inzsr;
000000161025       endsr;
000000161025       //--------END SUBROUTINE ----------------------------------
000000161025       begsr pnl00;
000000161025         *inlr = *on;
000000161025       endsr;
000000161103      /end-free
