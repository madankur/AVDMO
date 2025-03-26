000000161209
000000161209     fparameter uf a e           k disk
000000161209     fpar200d   cf   e             workstn
000000161209     F                                     indds(indds)
000000161209     F                                     sfile(sfl01:rrn01)
000000161209     F                                     Infds(Info)
000000161209
000000161209     D indds           ds
000000161209     D  help                   1      1n
000000161209     D  exit                   3      3n
000000161209     D  prompt                 4      4n
000000161209     D  refresh                5      5n
000000161209     D  create                 6      6n
000000161209     D  cancel                12     12n
000000161209     D  morekeys              24     24n
000000161209     D  pagedown              25     25n
000000161209     D  sflclr                30     30n
000000161209     D  sfldsp                31     31n
000000161209     D  sfldspctl             32     32n
000000161209     D  sflnxtchg             33     33n
000000161209     D  dspatr_ri             34     34n
000000161209     D  sflmsg                35     35n
000000161209     D  ErrDuplicate          40     40n
000000161209     D  sflend                80     80n
000000161209
000000161209     D info            ds
000000161209     D  lrrn                 378    379i 0
000000161209
000000161209     D rrn01           s              5i 0
000000161209     D rrs01           s              5i 0
000000161209     D err01           s               n
000000161209
000000161209     D panel           S              3i 0 INZ(1)
000000161209     D step01          S              3    inz(prp)
000000161209     D step02          S              3    inz(prp)
000000161209     D step03          S              3    inz(prp)
000000161209     d savId1          s                   like(pacode)
000000161209     d savId2          s                   like(pasubcode)
000000161209     d User            s             10    inz(*user)
000000161209     d count           s              3i 0
000000161209     d mode            s              3
000000161209
000000161209     d prp             c                   'prp'
000000161209     d lod             c                   'lod'
000000161209     d dsp             c                   'dsp'
000000161209     d key             c                   'key'
000000161209     d chk             c                   'chk'
000000161209     d act             c                   'act'
000000161209      /free
000000161209       select;
000000161209       when panel = 1;
000000161209         exsr pnl01;
000000161209       when panel = 2;
000000161209         exsr pnl02;
000000161209       when panel = 3;
000000161209         exsr pnl03;
000000161209       other;
000000161209         exsr pnl00;
000000161209       endsl;
000000161209       //- Subfiles  01 Subroutines --------------------------------------  ---
000000161209       begsr pnl01;
000000161209         select ;
000000161209         when step01 = prp ;
000000161209           exsr s01prp;
000000161209         when step01 = lod ;
000000161209           exsr s01lod;
000000161209         when step01 = dsp ;
000000161209           exsr s01dsp;
000000161209         when step01 = key ;
000000161209           exsr s01key;
000000161209         when step01 = chk ;
000000161209           exsr s01chk;
000000161209         when step01 = act ;
000000161209           exsr s01act ;
000000161209         endsl;
000000161209       endsr;
000000161209       //--- Clear Subfile  ----------------------------------------------------
000000161209       begsr s01prp;
000000161209         RRn01 = 0;
000000161209         sflclr = *on;
000000161209         write ctl01;
000000161209         sflclr = *off;
000000161209         step01 = lod;
000000161209         clear savid1;
000000161209         clear savid2;
000000161209         rrs01 = 0;
000000161209       endsr;
000000161209       //--- Load Subfile  -----------------------------------------------------
000000161209       begsr s01lod;
000000161209         exsr s01rst;
000000161209         RRb01 = RRn01 + 1;
000000161209         opt01 = 0;
000000161209         count = 0;
000000161209         read(n) parameter;
000000161209         dow not %eof(parameter) and count < 14;
000000161209           RRN01 += 1;
000000161209           count += 1;
000000161209           parm2s = parm2;
000000161209           write sfl01;
000000161209           read(n) parameter;
000000161209         enddo;
000000161209         sflend = %eof(parameter);
000000161209         step01 = dsp;
000000161209         exsr s01sav;
000000161209       endsr;
000000161209       //--- restore last read -------------------------------------------------
000000161209       begsr s01rst;
000000161209         setll (savid1:savid2)  parameter;
000000161209         rrn01 = rrs01;
000000161209       endsr;
000000161209       //--- Save last read -------------------------------------------------
000000161209       begsr s01sav;
000000161209         savid1 = pacode;
000000161209         savid2 = pasubcode;
000000161209         rrs01 = rrn01;
000000161209       endsr;
000000161209       //--- Display Subfile  --------------------------------------------------
000000161209       begsr s01dsp;
000000161209         sfldspctl = *on;
000000161209         sfldsp = RRn01 > 0;
000000161209
000000161209         write key01;
000000161209         exfmt ctl01;
000000161209         if LRRN <>0;
000000161209           RRb01 = LRRN;
000000161209         endif;
000000161209         step01 = key;
000000161209       endsr;
000000161209       //--- Command Keys  -----------------------------------------------------
000000161209       begsr s01key;
000000161209         select;
000000161209         when exit;
000000161209           panel  = 0;
000000161209           step01 = prp;
000000161209         when cancel;
000000161209           step01 = prp;
000000161209           panel  = panel  - 1;
000000161209         when pagedown;
000000161209           step01 = lod;
000000161209         when refresh;
000000161209           step01 = prp;
000000161209         when create;
000000161209           panel = 3;
000000221013           step01 = prp;
000000161209         other;
000000161209           step01 = chk;
000000161209         endsl;
000000161209       endsr;
000000161209       //--- Check Subfile  ----------------------------------------------------
000000161209       begsr s01chk;
000000161209         step01 = act;
000000161209         err01 = *off;
000000161209         sflnxtchg = *on;
000000161209         readc(e) sfl01;
000000161209         dow not %error and not %eof;
000000161209           if opt01  <> 0 and opt01  <> 2 and opt01  <> 4;
000000161209             step01 = dsp;
000000161209             dspatr_ri = *on;
000000161209             sflmsg = *on;
000000161209             if not err01;
000000161209               rrb01 = rrn01;
000000161209               err01 = *on;
000000161209             endif;
000000161209           endif;
000000161209           update sfl01;
000000161209           dspatr_ri = *off;
000000161209           readc(e) sfl01;
000000161209         enddo;
000000161209         sflnxtchg = *off;
000000161209       endsr;
000000161209       //--- action Subfile  ---------------------------------------------------
000000161209       begsr s01act;
000000161209         readc(e) sfl01;
000000161209         select;
000000161209         when %error or %eof;
000000161209           step01 = dsp;
000000161209         when opt01 = 2;
000000161209           panel = 2;
000000161209           step02 = prp;
000000161209           opt01 = 0;
000000161209           update sfl01;
000000161209         when opt01 = 4;
000000161209           delete (pacode:pasubcode) parameter;
000000161209           clear pacode;
000000161209           clear pasubcode;
000000161209           clear parm1;
000000161209           parm2 = '*** Deleted ****';
000000161209           opt01 = 0;
000000161209           update sfl01;
000000161209         other;
000000161209
000000161209         endsl;
000000161209       endsr;
000000161209
000000161209
000000161209       //--- Format 02 Subroutines ------------------------------------     ---
000000161209       begsr pnl02;
000000161209         select ;
000000161209         when step02 = prp ;
000000161209           exsr s02prp;
000000161209         when step02 = dsp ;
000000161209           exsr s02dsp;
000000161209         when step02 = key ;
000000161209           exsr s02key;
000000161209         when step02 = chk ;
000000161209           exsr s02chk;
000000161209         when step02 = act ;
000000161209           exsr s02act ;
000000161209         endsl;
000000161209
000000161209       endsr;
000000161209       //--- clear & Load ------------------------------------------------------
000000161209       begsr S02prp;
000000161209         chain (pacode:pasubcode) parameter;
000000161209         step02 = dsp;
000000161209       endsr;
000000161209       //--- Display  ----------------------------------------------------------
000000161209       begsr S02dsp;
000000161209         exfmt fmt02;
000000161209         step02 = key;
000000161209       endsr;
000000161209       //--- command Keys  -----------------------------------------------------
000000161209       begsr S02key;
000000161209         select;
000000161209         when exit;
000000161209           panel  = 1;
000000161209           step02 = prp;
000000161209         when cancel;
000000161209           step02 = prp;
000000161209           panel  = panel  - 1;
000000161209         other;
000000161209           step02 = chk;
000000161209         endsl;
000000161209       endsr;
000000161209       //--- check -------------------------------------------------------------
000000161209       begsr S02chk;
000000161209         step02 = act;
000000161209
000000161209       endsr;
000000161209       //--- Action ------------------------------------------------------------
000000161209       begsr S02act;
000000161209         step02 = prp;
000000161209         update fparam;
000000161209         panel = 1;
000000161209       endsr;
000000161209
000000161209
000000161209       //--- Format 03 Subroutines ------------------------------------     ---
000000161209       begsr pnl03;
000000161209         select ;
000000161209         when step03 = prp ;
000000161209           exsr s03prp;
000000161209         when step03 = dsp ;
000000161209           exsr s03dsp;
000000161209         when step03 = key ;
000000161209           exsr s03key;
000000161209         when step03 = chk ;
000000161209           exsr s03chk;
000000161209         when step03 = act ;
000000161209           exsr s03act ;
000000161209         endsl;
000000161209
000000161209       endsr;
000000161209       //--- clear & Load ------------------------------------------------------
000000161209       begsr S03prp;
000000161209         clear fmt03;
000000161209         step03 = dsp;
000000161209       endsr;
000000161209       //--- Display  ----------------------------------------------------------
000000161209       begsr S03dsp;
000000161209         exfmt fmt03;
000000161209         step03 = key;
000000161209       endsr;
000000161209       //--- command Keys  -----------------------------------------------------
000000161209       begsr S03key;
000000161209         select;
000000161209         when exit;
000000161209           panel  = 1;
000000161209           step03 = prp;
000000161209         when cancel;
000000161209           step03 = prp;
000000161209           panel  = 1;
000000161209         other;
000000161209           step03 = chk;
000000161209         endsl;
000000161209       endsr;
000000161209       //--- check -------------------------------------------------------------
000000161209       begsr S03chk;
000000161209         step03 = act;
000000161209         chain (pacode:pasubcode) parameter;
000000161209         if %found();
000000161209           ErrDuplicate = *on;
000000161209           step03 = dsp;
000000161209         endif;
000000161209
000000161209       endsr;
000000161209       //--- Action ------------------------------------------------------------
000000161209       begsr S03act;
000000161209         step03 = prp;
000000161209         write fparam;
000000161209         panel = 1;
000000161209       endsr;
000000161209
000000161209       //--------INITIALIZATION ----------------------------------
000000161209       begsr *inzsr;
000000161209       endsr;
000000161209       //--------END SUBROUTINE ----------------------------------
000000161209       begsr pnl00;
000000161209         *inlr = *on;
000000161209       endsr;
000000161209      /end-free
