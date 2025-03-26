000000210331       ctl-opt dftactgrp(*NO) bnddir('SAMPLE');
000000210329
000000210414       Dcl-F  art250d workstn
000000210331         SFILE(SFL03:RRN03)
000000210331         Infds(Info)
000000210331         indds(indds);
000000210329       dcl-f  article1 disk keyed;
000000210401       dcl-f  artipro2 disk keyed;
000000210329
000000210329      /copy qprotosrc,familly
000000210329      /copy qprotosrc,article
000000210329      /copy qprotosrc,vat
000000210414
000000210414       dcl-pr Providers extpgm('ART201');
000000210414         id   like(arid);
000000210414       end-pr;
000000210329
000000210329       Dcl-Ds indds;
000000210329         help            Ind             Pos(1);
000000210329         exit            Ind             Pos(3);
000000210329         prompt          Ind             Pos(4);
000000210329         refresh         Ind             Pos(5);
000000210414         DspProvider     Ind             Pos(7);
000000210329         cancel          Ind             Pos(12);
000000210329         morekeys        Ind             Pos(24);
000000210329         pagedown        Ind             Pos(25);
000000210329         sflclr          Ind             Pos(30);
000000210329         sfldsp          Ind             Pos(31);
000000210329         sfldspctl       Ind             Pos(32);
000000210329         sflnxtchg       Ind             Pos(33);
000000210329         dspatr_ri       Ind             Pos(34);
000000210329         sflmsg          Ind             Pos(35);
000000210329         NotFound        Ind             Pos(40);
000000210329         sflend          Ind             Pos(80);
000000210329       End-Ds;
000000210331       Dcl-Ds info;
000000210331         lrrn            Int(5)          Pos(378);
000000210331       End-Ds;
000000210329
000000210329       Dcl-S panel           Packed(3:0)     INZ(1);
000000210329       Dcl-S step01          Char(3)         inz(prp);
000000210329       Dcl-S step02          Char(3)         inz(prp);
000000210331       Dcl-S step03          Char(3)         inz(prp);
000000210329       dcl-s id              like(arid);
000000210331       dcl-s likeid          varchar(8);
000000210331       Dcl-S rrn03           Int(5);
000000210331       Dcl-S rrs03           Int(5);
000000210331       Dcl-S i               Int(5);
000000210331       Dcl-S err03           Ind;
000000210331
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
000000210329         exsr pnl02;
000000210331       when panel = 3;
000000210331         exsr pnl03;
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
000000210329         id = arid;
000000210329       endsr;
000000210329       //--- command Keys  -----------------------------------------------------
000000210329       begsr S01key;
000000210329         select;
000000210329         when exit;
000000210329           panel  = 0;
000000210329           step01 = prp;
000000210329         when prompt;
000000210329           id = SltArticle(id);
000000210329           step01 = chk;
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
000000210329         chain id article1;
000000210329         if not %found();
000000210331           panel = 3;
000000210331           step01 = dsp;
000000210329         endif;
000000210329
000000210329       endsr;
000000210329       //--- Action ------------------------------------------------------------
000000210329       begsr S01act;
000000210329         step01 = dsp;
000000210330
000000210329         panel = 2;
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
000000210329         step02 = dsp;
000000210330         fadesc = GetArtFamDesc(ARTIFA);
000000210330         VATINCL = CLCVat(ARVATCD:ARSALEPR);
000000210330         STOPRICE = ARSTOCK * ARWHSPR;
000000210330         info = GetArtInfo(arid);
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
000000210414         when dspProvider;
000000210414           step02 = prp;
000000210414           providers(arid);
000000210329         other;
000000210329           step02 = chk;
000000210329         endsl;
000000210329       endsr;
000000210329       //--- check -------------------------------------------------------------
000000210329       begsr S02chk;
000000210329         step02 = act;
000000210329
000000210329
000000210329       endsr;
000000210329       //--- Action ------------------------------------------------------------
000000210329       begsr S02act;
000000210329         panel = 1;
000000210329         step02 = prp;
000000210329       endsr;
000000210329
000000210331       //- Subfiles  03 Subroutines --------------------------------------  ---
000000210331       begsr pnl03;
000000210331         select ;
000000210331         when step03 = prp ;
000000210331           exsr s03prp;
000000210331         when step03 = lod ;
000000210331           exsr s03lod;
000000210331         when step03 = dsp ;
000000210331           exsr s03dsp;
000000210331         when step03 = key ;
000000210331           exsr s03key;
000000210331         when step03 = chk ;
000000210331           exsr s03chk;
000000210331         when step03 = act ;
000000210331           exsr s03act ;
000000210331         endsl;
000000210331       endsr;
000000210331       //--- Clear Subfile  ----------------------------------------------------
000000210331       begsr s03prp;
000000210331         RRn03 = 0;
000000210331         sflclr = *on;
000000210331         write ctl03;
000000210331         sflclr = *off;
000000210331         likeId = '%' + %trim(id) + '%';
000000210331         exec sql declare c1 cursor for
000000210331           select ARID, ARDESC, artifa from article
000000210331             where arid like :likeId;
000000210331         exec sql open c1;
000000210331         step03 = lod;
000000210401         sflend = *off;
000000210331       endsr;
000000210331       //--- Load Subfile  -----------------------------------------------------
000000210331       begsr s03lod;
000000210331         exec sql fetch c1 into :arid, :ardesc, :artifa;
000000210331         if sqlcod = 0;
000000210331           RRb03 = RRn03 + 1;
000000210331           opt03 = 0;
000000210331           for i = 1 to 16;
000000210331             RRN03 = RRN03 + 1;
000000210331             write sfl03;
000000210331             if i < 16;
000000210331               exec sql fetch c1 into :arid, :ardesc, :artifa;
000000210331               if sqlcod <>  0;
000000210331                 sflend = *on;
000000210401                 leave;
000000210331               ENDIF;
000000210331             ENDIF;
000000210331           endfor;
000000210331           step03 = dsp;
000000210331         // if result = 0
000000210331         elseif rrn03 = 0;
000000210331           notFound = *on;
000000210331           errdata = id;
000000210331           step01 = dsp;
000000210331           panel = 1;
000000210331           step03 = prp;
000000210331           sflend = *on;
000000210331         else;
000000210331           sflend = *on;
000000210331         endif;
000000210331         if sflend;
000000210331           exec sql close c1;
000000210331         ENDIF;
000000210331       endsr;
000000210331       //--- Display Subfile  --------------------------------------------------
000000210331       begsr s03dsp;
000000210331         sfldspctl = *on;
000000210331         sfldsp = RRn03 > 0;
000000210331
000000210331         write key03;
000000210331         exfmt ctl03;
000000210331         if LRRN <>0;
000000210331           RRb03 = LRRN;
000000210331         endif;
000000210331         step03 = key;
000000210331       endsr;
000000210331       //--- Command Keys  -----------------------------------------------------
000000210331       begsr s03key;
000000210331         select;
000000210331         when exit;
000000210331           panel  = 1;
000000210331           step03 = prp;
000000210401           arid = id;
000000210414           exec sql close c1;
000000210331         when cancel;
000000210331           step03 = prp;
000000210331           panel  = 1;
000000210401           arid = id;
000000210414           exec sql close c1;
000000210331         when pagedown;
000000210331           step03 = lod;
000000210331         other;
000000210331           step03 = chk;
000000210331         endsl;
000000210331       endsr;
000000210331       //--- Check Subfile  ----------------------------------------------------
000000210331       begsr s03chk;
000000210331         step03 = act;
000000210331         err03 = *off;
000000210331         sflnxtchg = *on;
000000210331         readc(e) sfl03;
000000210331         dow not %error and not %eof;
000000210331           if opt03 > 1;
000000210331             step03 = dsp;
000000210331             dspatr_ri = *on;
000000210331             sflmsg = *on;
000000210331             if not err03;
000000210331               rrb03 = rrn03;
000000210331               err03 = *on;
000000210331             endif;
000000210331           endif;
000000210331           update sfl03;
000000210331           dspatr_ri = *off;
000000210331           readc(e) sfl03;
000000210331         enddo;
000000210331         sflnxtchg = *off;
000000210331       endsr;
000000210331       //--- action Subfile  ---------------------------------------------------
000000210331       begsr s03act;
000000210331         readc(e) sfl03;
000000210331         select;
000000210331         when %error or %eof;
000000210331           step03 = dsp;
000000210331         when opt03 = 1;
000000210331           panel = 2;
000000210331           chain (arid) article1;
000000210331           step03 = prp;
000000210331         other;
000000210331         endsl;
000000210331       endsr;
000000210331
000000210329
000000210329
000000210329       //--------INITIALIZATION ----------------------------------
000000210329       begsr *inzsr;
000000210329       endsr;
000000210329       //--------END SUBROUTINE ----------------------------------
000000210329       begsr pnl00;
000000210329         *inlr = *on;
000000210329       endsr;
