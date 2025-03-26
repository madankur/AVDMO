000000210330       ctl-opt dftactgrp(*NO) bnddir('SAMPLE');
000000210330
000000210330       Dcl-F  cus250d workstn   indds(indds);
000000210330       dcl-f  custome1 disk keyed;
000000210330
000000210330      /copy qprotosrc,customer
000000210330      /copy qprotosrc,country
000000221013      /copy qprotosrc,parameter
000000210330
000000210329       Dcl-Ds indds;
000000210329         help            Ind             Pos(1);
000000210329         exit            Ind             Pos(3);
000000210329         prompt          Ind             Pos(4);
000000210329         refresh         Ind             Pos(5);
000000210329         cancel          Ind             Pos(12);
000000210329         morekeys        Ind             Pos(24);
000000210329         pagedown        Ind             Pos(25);
000000210329         sflclr          Ind             Pos(30);
000000210329         sfldsp          Ind             Pos(31);
000000210329         sfldspctl       Ind             Pos(32);
000000210329         sflnxtchg       Ind             Pos(33);
000000210329         dspatr_ri       Ind             Pos(34);
000000210329         sflmsg          Ind             Pos(35);
000000210330         NotFound        Ind             Pos(40);
000000210329         sflend          Ind             Pos(80);
000000210329       End-Ds;
000000210329
000000210329       Dcl-S panel           Packed(3:0)     INZ(1);
000000210329       Dcl-S step01          Char(3)         inz(prp);
000000210329       Dcl-S step02          Char(3)         inz(prp);
000000210330       dcl-s id              like(cuid);
000000210329
000000210329       Dcl-C prp             'prp';
000000210329       Dcl-C lod             'lod';
000000210329       Dcl-C dsp             'dsp';
000000210329       Dcl-C key             'key';
000000210329       Dcl-C chk             'chk';
000000210329       Dcl-C chkctl          'chc';
000000210329       Dcl-C actctl          'acc';
000000210329       Dcl-C act             'act';
000000210329
000000210329       select;
000000210329       when panel = 1;
000000210329         exsr pnl01;
000000210329       when panel = 2;
000000210330         exsr pnl02;
000000210329       other;
000000210329         exsr pnl00;
000000210329       endsl;
000000210329       //--- Format 01 Subroutines ------------------------------------     ---
000000210329       begsr pnl01;
000000210329         select ;
000000210329         when step01 = prp ;
000000210329           exsr s01prp;
000000210329         when step01 = dsp ;
000000210329           exsr s01dsp;
000000210329         when step01 = key ;
000000210329           exsr s01key;
000000210329         when step01 = chk ;
000000210329           exsr s01chk;
000000210329         when step01 = act ;
000000210329           exsr s01act ;
000000210329         endsl;
000000210329
000000210329       endsr;
000000210329       //--- clear & Load ------------------------------------------------------
000000210329       begsr S01prp;
000000210329         clear fmt01;
000000210329         step01 = dsp;
000000210329       endsr;
000000210329       //--- Display  ----------------------------------------------------------
000000210329       begsr S01dsp;
000000210329         exfmt fmt01;
000000210329         step01 = key;
000000210330         id = cuid;
000000210329       endsr;
000000210329       //--- command Keys  -----------------------------------------------------
000000210329       begsr S01key;
000000210329         select;
000000210329         when exit;
000000210330           panel  = 0;
000000210329           step01 = prp;
000000210330         when prompt;
000000210330           id = SltCustomer(id);
000000210330           step01 = chk;
000000210329         when cancel;
000000210329           step01 = prp;
000000210329           panel  = panel  - 1;
000000210329         other;
000000210329           step01 = chk;
000000210329         endsl;
000000210329       endsr;
000000210329       //--- check -------------------------------------------------------------
000000210329       begsr S01chk;
000000210329         step01 = act;
000000210330         chain id custome1;
000000210330         if not %found();
000000210330           notFound = *on;
000000210331           ERRDATA = %editc(id:'Z');
000000210330           step01 = dsp;
000000210330         endif;
000000210329
000000210329       endsr;
000000210329       //--- Action ------------------------------------------------------------
000000210329       begsr S01act;
000000210329         step01 = dsp;
000000210330         panel = 2;
000000210329       endsr;
000000210329
000000210329       //--- Format 02 Subroutines ------------------------------------     ---
000000210329       begsr pnl02;
000000210329         select ;
000000210329         when step02 = prp ;
000000210329           exsr s02prp;
000000210329         when step02 = dsp ;
000000210329           exsr s02dsp;
000000210329         when step02 = key ;
000000210329           exsr s02key;
000000210329         when step02 = chk ;
000000210329           exsr s02chk;
000000210329         when step02 = act ;
000000210329           exsr s02act ;
000000210329         endsl;
000000210329
000000210329       endsr;
000000210329       //--- clear & Load ------------------------------------------------------
000000210329       begsr S02prp;
000000210330         COUNTR = GetCountryName(CUCOUN);
000000221013         catname = GetPARM2('CUSCAT':cucat);
000000210329         step02 = dsp;
000000210329       endsr;
000000210329       //--- Display  ----------------------------------------------------------
000000210329       begsr S02dsp;
000000210329         exfmt fmt02;
000000210329         step02 = key;
000000210329       endsr;
000000210329       //--- command Keys  -----------------------------------------------------
000000210329       begsr S02key;
000000210329         select;
000000210329         when exit;
000000210329           panel  = 1;
000000210329           step02 = prp;
000000210329         when cancel;
000000210329           step02 = prp;
000000210329           panel  = panel  - 1;
000000210329         other;
000000210329           step02 = chk;
000000210329         endsl;
000000210329       endsr;
000000210329       //--- check -------------------------------------------------------------
000000210329       begsr S02chk;
000000210329         step02 = act;
000000210330
000000210329
000000210329       endsr;
000000210329       //--- Action ------------------------------------------------------------
000000210329       begsr S02act;
000000210330         panel = 1;
000000210330         step02 = prp;
000000210329       endsr;
000000210329
000000210329
000000210329
000000210329       //--------INITIALIZATION ----------------------------------
000000210329       begsr *inzsr;
000000210329       endsr;
000000210329       //--------END SUBROUTINE ----------------------------------
000000210329       begsr pnl00;
000000210329         *inlr = *on;
000000210329       endsr;
