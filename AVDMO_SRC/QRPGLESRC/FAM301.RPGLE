000000161025     h nomain
000000161025
000000161025     Ffamilly   IF   E           K DISK
000000161025     Ffamill1   IF   E           K DISK
000000161025     F                                     RENAME(ffami   :REC52)
000000161025     Ffam301d   CF   E             WORKSTN
000000161025     F                                     INFDS(INFO)
000000161025     F                                     SFILE(SFL01:RRN01)
000000161025     F                                     indds(indds)
000000161025     D INFO            DS
000000161025     D  LRRN                 378    379B 0
000000161025
000000161025      /copy qprotosrc,familly
000000161025
000000161025     D indds           ds
000000161025     D  help                   1      1n
000000161025     D  exit                   3      3n
000000161025     D  prompt                 4      4n
000000161025     D  refresh                5      5n
000000161025     D  create                 6      6n
000000161025     D  cf08                   8      8n
000000161025     D  cancel                12     12n
000000161025     D  morekeys              24     24n
000000161025     D  pagedown              25     25n
000000161025     D  sflclr                30     30n
000000161025     D  sfldsp                31     31n
000000161025     D  sfldspctl             32     32n
000000161025     D  sflnxtchg             33     33n
000000161025     D  dspatrri              34     34n
000000161025     D  InvalidOpt            35     35n
000000161025     D  OneSelect             36     36n
000000161025     D  bydesc                40     40n
000000161025     D  InvalidOptC           41     41n
000000161025     D  NotAvail              42     42n
000000161025     D  sflend                80     80n
000000161025
000000161025     D rrn01           s              5i 0
000000161025
000000161025     d prp             c                   'prp'
000000161025     d lod             c                   'lod'
000000161025     d dsp             c                   'dsp'
000000161025     d key             c                   'key'
000000161025     d chk             c                   'chk'
000000161025     d chkctl          c                   'chc'
000000161025     d actctl          c                   'acc'
000000161025     d act             c                   'act'
000000161025
000000161025
000000161025      *=============================================
000000161025     P sltArtFam       B                   export
000000161025     D sltArtFam       PI                  like(faid      )
000000161025     d pcod                                like(faid      )
000000161025     D dft             S                   like(faid      )
000000161025     D step01          S              3    inz(prp)
000000161025     d in08            s               n
000000161025     d sts01           s               n
000000161025     D rrs01           s              5i 0
000000161025     D teller          s              5i 0
000000161025     D err01           s               n
000000161025     D slt01           s               n
000000161025     d keycod          s                    like(faid       )
000000161025     d savcod          s                    like(faid       )
000000161025     d pdes            s                    like(fadesc     )
000000161025     d keydes          s                    like(fadesc     )
000000161025     d savdes          s                    like(fadesc     )
000000161103      /free
000000161025       if not %open(fam301d   );
000000161025         open fam301d    ;
000000161025       endif;
000000161025       keycod = pcod;
000000161025       dft = pcod;
000000161025       bydesc = *off;
000000161025       dow step01 <> ' ';
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
000000161025       enddo;
000000161025       return dft;
000000161103       //--- Clear Subfile  -----------------------------------------------------
000000161025
000000161025       begsr s01prp;
000000161025         RRS01 = 0;
000000161025         clear CTL01;
000000161025         sflclr = *on;
000000161025         sfldsp = *off;
000000161025         sfldspctl = *off;
000000161025         write CTL01;
000000161025         sflclr = *off;
000000161025         if not bydesc;
000000161025           setll KEYCOD familly   ;
000000161025           read familly;
000000161025           sflend = %EOF;
000000161025         else;
000000161025           setll KEYDES famill1   ;
000000161025           read famill1    ;
000000161025           SflEnd = %EOF;
000000161025         endif;
000000161025         SAVCOD = faid  ;
000000161025         SAVDES = fadesc;
000000161025         Step01 = lod;
000000161025       endsr;
000000161025       //--- Load Subfile  -----------------------------------------------------
000000161025       begsr S01lod;
000000161025         RRN01 = RRS01;
000000161025         RRB01 = RRS01 + 1;
000000161025         TELLER = 0;
000000161025         OPT01 = 0;
000000161025         SflNxtChg = *OFF;
000000161025         faid   = SAVCOD;
000000161025         fadesc = SAVDES;
000000161025         dow not sflend
000000161025               and TELLER < 20;
000000161025           RRN01 = RRN01 + 1;
000000161025           TELLER = TELLER + 1;
000000161025           write SFL01;
000000161025           if not bydesc;
000000161025             read familly   ;
000000161025           else;
000000161025             read famill1   ;
000000161025           endif;
000000161025           SflEnd = %EOF;
000000161025         enddo;
000000161025         SAVCOD = faid  ;
000000161025         SAVDES = fadesc;
000000161025         RRS01 = RRN01;
000000161025         Step01 = dsp;
000000161025       endsr;
000000161025       //--- Display Subfile  --------------------------------------------------
000000161025       begsr S01dsp;
000000161025         sfldsp = rrs01 > 0;
000000161025         sfldspctl = *on;
000000161025         write KEY01;
000000161025         exfmt CTL01;
000000161025         IN08 = CF08;
000000161025         RRB01 = LRRN;
000000161025         Step01 = key;
000000161025       endsr;
000000161025       //--- Command Keys  -----------------------------------------------------
000000161025       begsr S01key;
000000161025         select;
000000161025         when exit;
000000161025           step01 = ' ';
000000161025         when cancel ;
000000161025           Step01 = ' ';
000000161025         when PageDown;
000000161025           Step01 = lod;
000000161025         other;
000000161025           Step01 = chk;
000000161025         endsl;
000000161025       endsr;
000000161025       //--- Check Subfile  ----------------------------------------------------
000000161025       begsr S01chk;
000000161025         // SET FLAG SELECTION MADE OFF
000000161025         SLT01 = *OFF;
000000161025         // SET FLAG OPTION  MADE OFF
000000161025         STS01 = *OFF;
000000161025         // SET FLAG ERROR   MADE OFF
000000161025         ERR01 = *OFF;
000000161025         Step01 = act;
000000161025         readc(E) SFL01;
000000161025         SflNxtChg = *ON;
000000161025         dow not %error and not %eof;
000000161025           select;
000000161025           when OPT01 = 0;
000000161025             // NO ERROR
000000161025           when OPT01 <>1;
000000161025             STS01 = *ON;
000000161025             Step01 = dsp;
000000161025             dspatrRi = *on;
000000161025             InvalidOpt= *on;
000000161025             if ERR01 = *OFF;
000000161025               RRB01 = RRN01;
000000161025               ERR01 = *ON;
000000161025             endif;
000000161025             //OPTION = 1 BUT SELECTION ALREADY MADE
000000161025           when SLT01 = *ON;
000000161025             Step01 = dsp;
000000161025             dspatrRi = *on;
000000161025             OneSelect = *on;
000000161025             if ERR01 = *OFF;
000000161025               RRB01 = RRN01;
000000161025               ERR01 = *ON;
000000161025             endif;
000000161025           other;
000000161025             //OPTION = 1
000000161025             SLT01 = *ON;
000000161025             STS01 = *ON;
000000161025           endsl;
000000161025           update SFL01;
000000161025           dspatrRi = *off;
000000161025           readc SFL01;
000000161025         enddo;
000000161025         select;
000000161025         when OPTC1 <>8
000000161025               and OPTC1 <>0;
000000161025           InvalidOptC = *ON;
000000161025           Step01 = dsp;
000000161025         when SLT01 = *ON
000000161025               and OPTC1 <>0;
000000161025           NotAvail = *ON;
000000161025           Step01 = dsp;
000000161025         when STS01 = *ON
000000161025               and IN08 = *ON;
000000161025           Step01 = dsp;
000000161025         endsl;
000000161025       endsr;
000000161025       //--- Write Subfile  ----------------------------------------------------
000000161025       begsr S01act;
000000161025         Step01 = dsp;
000000161025         select;
000000161025         when IN08 ;
000000161025           Step01 = prp;
000000161025           bydesc = not bydesc;
000000161025           if bydesc;
000000161025             clear KEYCOD;
000000161025           else;
000000161025             clear KEYDES;
000000161025           endif;
000000161025         when OPTC1 = 8;
000000161025           Step01 = prp;
000000161025           if not bydesc;
000000161025             KEYCOD = POSCOD;
000000161025           else;
000000161025             KEYDES = POSDES;
000000161025           endif;
000000161025         other;
000000161025           readc(E) SFL01;
000000161025           dow not %error and not %eof;
000000161025             if OPT01 = 1;
000000161025               return faid      ;
000000161025             endif;
000000161025             readc SFL01;
000000161025           enddo;
000000161025         endsl;
000000161025       endsr;
000000161025
000000161103      /end-free
000000161025     p sltArtFam       e
