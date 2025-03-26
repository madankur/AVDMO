000000161025
000000161025     h dftactgrp(*no) bnddir('SAMPLE')
000000161025
000000161103     farticle2  if   e           k disk    rename(farti:farti2)
000000161103     farticle1  uf a e           k disk
000000161024     fart200d   cf   e             workstn
000000161024     F                                     indds(indds)
000000161024     F                                     sfile(sfl01:rrn01)
000000161024     F                                     Infds(Info)
000000161024
000000161025      /copy qprotosrc,familly
000000161025
000000161025     d providers       pr                  extpgm('ART201')
000000161025     d  id                                 like(arid)
000000161025
000000161024     D indds           ds
000000161024     D  help                   1      1n
000000161024     D  exit                   3      3n
000000161024     D  prompt                 4      4n
000000161024     D  refresh                5      5n
000000161027     D  Create                 6      6n
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
000000161024     D step03          S              3    inz(prp)
000000161024     d savId           s                   like(arid)
000000161103     d savDesc         s                   like(ardesc)
000000161027     d NewId           s              6  0
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
000000161103      /free
000000161024
000000161024       select;
000000161024       when panel = 1;
000000161024         exsr pnl01;
000000161024       when panel = 2;
000000161024         exsr pnl02;
000000161024       when panel = 3;
000000161024         exsr pnl03;
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
000000161024         step01 = lod;
000000161024         clear savid;
000000161103         savDesc = posTo;
000000161103         clear posTo;
000000161024         rrs01 = 0;
000000161024       endsr;
000000161024       //--- Load Subfile  -----------------------------------------------------
000000161024       begsr s01lod;
000000161024         exsr s01rst;
000000161024         RRb01 = RRn01 + 1;
000000161024         opt01 = 0;
000000161024         count = 0;
000000161103         read article2;
000000161103         dow not %eof(article2) and count < 14;
000000161024           RRN01 += 1;
000000161024           count += 1;
000000161024           write sfl01;
000000161103           read article2;
000000161024         enddo;
000000161024         sflend = %eof(article1);
000000161024         step01 = dsp;
000000161024         exsr s01sav;
000000161024       endsr;
000000161024       //--- restore last read -------------------------------------------------
000000161024       begsr s01rst;
000000161103         setll (savdesc:savid)  article2;
000000161024         rrn01 = rrs01;
000000161024       endsr;
000000161024       //--- Save last read -------------------------------------------------
000000161024       begsr s01sav;
000000161024         savid = arid;
000000161103         savdesc = ardesc;
000000161024         rrs01 = rrn01;
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
000000161027         when create;
000000161027           step01 = prp;
000000161027           panel  = 2 ;
000000161027           step02 = prp;
000000161027           mode = crt;
000000161024         when pagedown;
000000161024           step01 = lod;
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
000000161209           if opt01  > 6 or opt01 = 1 or opt01 = 5;
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
000000161103           if posto > ' ';
000000161103             step01 = prp;
000000161103           else;
000000161103             step01 = dsp;
000000161103           endif;
000000161024         when opt01 = 2;
000000161024           panel = 2;
000000161024           step02 = prp;
000000161024           opt01 = 0;
000000161024           update sfl01;
000000161027           mode = upd;
000000161024         when opt01 = 3;
000000161024           panel = 3;
000000161024           step02 = prp;
000000161024           opt01 = 0;
000000161024           update sfl01;
000000161027         when opt01 = 4;
000000161027           chain arid article1;
000000161027           ardel = 'X';
000000161027           armod = %timestamp();
000000161027           armodid = user;
000000161027           update farti;
000000161027           step02 = dsp;
000000161027           opt01 = 0;
000000161027           update sfl01;
000000161025         when opt01 = 6;
000000161025           providers(arid);
000000161025           opt01 = 0;
000000161025           update sfl01;
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
000000161027         if mode = crt;
000000161027           setgt *hival article1;
000000161027           readp article1;
000000161027           Newid = %dec(arid :6: 0)  +1;
000000161027           reset farti;
000000161027           arid = %editc(NewId:'X');
000000161027         else;
000000161027           chain arid article1;
000000161027           famdesc = getArtFamDesc(artifa);
000000161027         endif;
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
000000161025         when prompt;
000000161025           artifa = sltArtFam(artifa);
000000161025           famdesc = getArtFamDesc(artifa);
000000161025           step02 = dsp;
000000161024         other;
000000161024           step02 = chk;
000000161024         endsl;
000000161024       endsr;
000000161024       //--- check -------------------------------------------------------------
000000161024       begsr S02chk;
000000161024         step02 = act;
000000161025         if ardesc = ' ';
000000161025           errDesc = *on;
000000161025           step02 = dsp;
000000161025         endif;
000000161025         if not existArtFam(artifa);
000000161025           errFamilly = *on;
000000161025           step02 = dsp;
000000161025         endif;
000000161024
000000161024       endsr;
000000161024       //--- Action ------------------------------------------------------------
000000161024       begsr S02act;
000000161024         step02 = prp;
000000161027         armod = %timestamp();
000000161027         armodid = user;
000000161024         if mode = upd;
000000161024           update farti;
000000161027         else;
000000161027           arcrea = %date();
000000161027           write(e) farti;
000000161027           dow %error;
000000161027             Newid += 1;
000000161027             arid = %editc(NewId:'X');
000000161027             write(e) farti;
000000161027           enddo;
000000161103           savdesc = ardesc;
000000161103           savId = arid;
000000161027           step01 = lod;
000000161024         endif;
000000161024         panel = 1;
000000161024       endsr;
000000161024
000000161024       //--- Format 03 Subroutines ------------------------------------     ---
000000161024       begsr pnl03;
000000161024         select ;
000000161024         when step03 = prp ;
000000161024           exsr s03prp;
000000161024         when step03 = dsp ;
000000161024           exsr s03dsp;
000000161024         when step03 = key ;
000000161024           exsr s03key;
000000161024         when step03 = chk ;
000000161024           exsr s03chk;
000000161024         when step03 = act ;
000000161024           exsr s03act ;
000000161024         endsl;
000000161024
000000161024       endsr;
000000161024       //--- clear & Load ------------------------------------------------------
000000161024       begsr S03prp;
000000161027         exec sql set option commit = *none;
000000161024         exec sql select ARTICLE_INFORMATION into :text
000000161024                  FROM artiinf
000000161024                  WHERE ARTICLE_INFO_ID = :arid;
000000161027         if sqlcod <> 0;
000000161027           mode = crt;
000000161027           clear text;
000000161027         else;
000000161027           mode = upd;
000000161027         endif;
000000161024         step03 = dsp;
000000161024       endsr;
000000161024       //--- Display  ----------------------------------------------------------
000000161024       begsr S03dsp;
000000161024         exfmt fmt03;
000000161024         step03 = key;
000000161024       endsr;
000000161024       //--- command Keys  -----------------------------------------------------
000000161024       begsr S03key;
000000161024         select;
000000161024         when exit;
000000161024           panel  = 1;
000000161024           step03 = prp;
000000161024         when cancel;
000000161024           step03 = prp;
000000161024           panel  = 1;
000000161024         other;
000000161024           step03 = chk;
000000161024         endsl;
000000161024       endsr;
000000161024       //--- check -------------------------------------------------------------
000000161024       begsr S03chk;
000000161024         step03 = act;
000000161024       endsr;
000000161024       //--- Action ------------------------------------------------------------
000000161024       begsr S03act;
000000161024         step03 = prp;
000000161024         panel = 1;
000000161027         if mode = upd;
000000161027           exec sql update artiinf
000000161025                  set ARTICLE_INFORMATION = trim(:text)
000000161024                  WHERE ARTICLE_INFO_ID = :arid;
000000161027         else;
000000161027           exec sql insert into artiinf
000000161027                    Values(:arid, trim(:text));
000000161027         endif;
000000161024       endsr;
000000161024       //--------INITIALIZATION ----------------------------------
000000161024       begsr *inzsr;
000000161024       endsr;
000000161024       //--------END SUBROUTINE ----------------------------------
000000161024       begsr pnl00;
000000161024         *inlr = *on;
000000161024       endsr;
000000161103      /end-free
