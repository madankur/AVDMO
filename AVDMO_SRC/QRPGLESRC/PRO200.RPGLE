000000161025
000000161025     fprovide1  uf a e           k disk
000000161025     fpro200d   cf   e             workstn
000000161025     F                                     indds(indds)
000000161025     F                                     sfile(sfl01:rrn01)
000000161025     F                                     Infds(Info)
000000161025
000000161025      /copy qprotosrc,country
000000161201
000000161104     d articles        pr                  extpgm('ART202')
000000161104     d  id                                 like(prid)
000000161104
000000161201     d prpord          pr                  extproc('PRO202')
000000161201     d  id                                 like(prid)
000000161201
000000161025     D indds           ds
000000161025     D  help                   1      1n
000000161025     D  exit                   3      3n
000000161025     D  prompt                 4      4n
000000161025     D  refresh                5      5n
000000161025     D  cancel                12     12n
000000161025     D  morekeys              24     24n
000000161025     D  pagedown              25     25n
000000161025     D  sflclr                30     30n
000000161025     D  sfldsp                31     31n
000000161025     D  sfldspctl             32     32n
000000161025     D  sflnxtchg             33     33n
000000161025     D  dspatr_ri             34     34n
000000161025     D  sflmsg                35     35n
000000161025     D  ErrCountry            40     40n
000000161025     D  ErrName               41     41n
000000161025     D  sflend                80     80n
000000161025
000000161025     D info            ds
000000161025     D  lrrn                 378    379i 0
000000161025
000000161025     D rrn01           s              5i 0
000000161025     D rrs01           s              5i 0
000000161025     D err01           s               n
000000161025
000000161025     D panel           S              3i 0 INZ(1)
000000161025     D step01          S              3    inz(prp)
000000161025     D step02          S              3    inz(prp)
000000161025     D step03          S              3    inz(prp)
000000161025     d savId           s                   like(prid)
000000161025     d User            s             10    inz(*user)
000000161025     d count           s              3i 0
000000161025     d mode            s              3
000000161025
000000161025     d crt             c                   'CRT'
000000161025     d upd             c                   'UPD'
000000161025     d prp             c                   'prp'
000000161025     d lod             c                   'lod'
000000161025     d dsp             c                   'dsp'
000000161025     d key             c                   'key'
000000161025     d chk             c                   'chk'
000000161025     d act             c                   'act'
000000161103      /free
000000161025       select;
000000161025       when panel = 1;
000000161025         exsr pnl01;
000000161025       when panel = 2;
000000161025         exsr pnl02;
000000161025       other;
000000161025         exsr pnl00;
000000161025       endsl;
000000161025       //- Subfiles  01 Subroutines --------------------------------------  ---
000000161025       begsr pnl01;
000000161025         select ;
000000161025         when step01 = prp ;
000000161025           exsr s01prp;
000000161025         when step01 = lod ;
000000161025           exsr s01lod;
000000161025         when step01 = dsp ;
000000161025           exsr s01dsp;
000000161025         when step01 = key ;
000000161025           exsr s01key;
000000161025         when step01 = chk ;
000000161025           exsr s01chk;
000000161025         when step01 = act ;
000000161025           exsr s01act ;
000000161025         endsl;
000000161025       endsr;
000000161025       //--- Clear Subfile  ----------------------------------------------------
000000161025       begsr s01prp;
000000161025         RRn01 = 0;
000000161025         sflclr = *on;
000000161025         write ctl01;
000000161025         sflclr = *off;
000000161025         step01 = lod;
000000161025         clear savid;
000000161025         rrs01 = 0;
000000161025       endsr;
000000161025       //--- Load Subfile  -----------------------------------------------------
000000161025       begsr s01lod;
000000161025         exsr s01rst;
000000161025         RRb01 = RRn01 + 1;
000000161025         opt01 = 0;
000000161025         count = 0;
000000161025         read(n) provide1;
000000161025         dow not %eof(provide1) and count < 14;
000000161025           RRN01 += 1;
000000161025           count += 1;
000000161025           write sfl01;
000000161025           read(n) provide1;
000000161025         enddo;
000000161025         sflend = %eof(provide1);
000000161025         step01 = dsp;
000000161025         exsr s01sav;
000000161025       endsr;
000000161025       //--- restore last read -------------------------------------------------
000000161025       begsr s01rst;
000000161025         setll savid  provide1;
000000161025         rrn01 = rrs01;
000000161025       endsr;
000000161025       //--- Save last read -------------------------------------------------
000000161025       begsr s01sav;
000000161025         savid = prid;
000000161025         rrs01 = rrn01;
000000161025       endsr;
000000161025       //--- Display Subfile  --------------------------------------------------
000000161025       begsr s01dsp;
000000161025         sfldspctl = *on;
000000161025         sfldsp = RRn01 > 0;
000000161025
000000161025         write key01;
000000161025         exfmt ctl01;
000000161025         if LRRN <>0;
000000161025           RRb01 = LRRN;
000000161025         endif;
000000161025         step01 = key;
000000161025       endsr;
000000161025       //--- Command Keys  -----------------------------------------------------
000000161025       begsr s01key;
000000161025         select;
000000161025         when exit;
000000161025           panel  = 0;
000000161025           step01 = prp;
000000161025         when cancel;
000000161025           step01 = prp;
000000161025           panel  = panel  - 1;
000000161025         when pagedown;
000000161025           step01 = lod;
000000161025         other;
000000161025           step01 = chk;
000000161025         endsl;
000000161025       endsr;
000000161025       //--- Check Subfile  ----------------------------------------------------
000000161025       begsr s01chk;
000000161025         step01 = act;
000000161025         err01 = *off;
000000161025         sflnxtchg = *on;
000000161025         readc(e) sfl01;
000000161025         dow not %error and not %eof;
000000161201           if opt01  <> 0 and opt01  <> 2 and opt01  <> 5 and opt01  <> 7;
000000161025             step01 = dsp;
000000161025             dspatr_ri = *on;
000000161025             sflmsg = *on;
000000161025             if not err01;
000000161025               rrb01 = rrn01;
000000161025               err01 = *on;
000000161025             endif;
000000161025           endif;
000000161025           update sfl01;
000000161025           dspatr_ri = *off;
000000161025           readc(e) sfl01;
000000161025         enddo;
000000161025         sflnxtchg = *off;
000000161025       endsr;
000000161025       //--- action Subfile  ---------------------------------------------------
000000161025       begsr s01act;
000000161025         readc(e) sfl01;
000000161025         select;
000000161025         when %error or %eof;
000000161025           step01 = dsp;
000000161025         when opt01 = 2;
000000161025           panel = 2;
000000161025           step02 = prp;
000000161025           opt01 = 0;
000000161025           update sfl01;
000000170511           // to remove the bug uncomment the following line
000000170511           // mode = upd;
000000161025         when opt01 = 5;
000000161104           articles(prid);
000000161025           opt01 = 0;
000000161025           update sfl01;
000000161201         when opt01 = 7;
000000161201           prpOrd(prid);
000000161201           opt01 = 0;
000000161201           update sfl01;
000000161025         other;
000000161025
000000161025         endsl;
000000161025       endsr;
000000161025
000000161025
000000161025       //--- Format 02 Subroutines ------------------------------------     ---
000000161025       begsr pnl02;
000000161025         select ;
000000161025         when step02 = prp ;
000000161025           exsr s02prp;
000000161025         when step02 = dsp ;
000000161025           exsr s02dsp;
000000161025         when step02 = key ;
000000161025           exsr s02key;
000000161025         when step02 = chk ;
000000161025           exsr s02chk;
000000161025         when step02 = act ;
000000161025           exsr s02act ;
000000161025         endsl;
000000161025
000000161025       endsr;
000000161025       //--- clear & Load ------------------------------------------------------
000000161025       begsr S02prp;
000000161025         chain prid provide1;
000000161025         coname = GetCountryName(prcoun);
000000161025         step02 = dsp;
000000161025       endsr;
000000161025       //--- Display  ----------------------------------------------------------
000000161025       begsr S02dsp;
000000161025         exfmt fmt02;
000000161025         step02 = key;
000000161025       endsr;
000000161025       //--- command Keys  -----------------------------------------------------
000000161025       begsr S02key;
000000161025         select;
000000161025         when exit;
000000161025           panel  = 1;
000000161025           step02 = prp;
000000161025         when cancel;
000000161025           step02 = prp;
000000161025           panel  = panel  - 1;
000000161025         when prompt;
000000161025           step02 = dsp;
000000161025           prcoun = SltCountry(prcoun);
000000161025           coname = GetCountryName(prcoun);
000000161025         other;
000000161025           step02 = chk;
000000161025         endsl;
000000161025       endsr;
000000161025       //--- check -------------------------------------------------------------
000000161025       begsr S02chk;
000000161025         step02 = act;
000000161025         if not ExistCountry(prcoun);
000000161025           errCountry = *on;
000000161025           step02 = dsp;
000000161025         endif;
000000161025         if provnm = *blanks;
000000161025           errName = *on;
000000161025           step02 = dsp;
000000161025         endif;
000000161025
000000161025       endsr;
000000161025       //--- Action ------------------------------------------------------------
000000161025       begsr S02act;
000000161025         step02 = prp;
000000161025         if mode = upd;
000000161025           prmod = %timestamp();
000000161025           prmodid = user;
000000161025           update fprov;
000000161025         endif;
000000161025         panel = 1;
000000161025       endsr;
000000161025
000000161025       //--------INITIALIZATION ----------------------------------
000000161025       begsr *inzsr;
000000161025       endsr;
000000161025       //--------END SUBROUTINE ----------------------------------
000000161025       begsr pnl00;
000000161025         *inlr = *on;
000000161025       endsr;
000000161103      /end-free
