000000161128     h nomain
000000161128
000000210330     Fpro301d   CF   E             WORKSTN
000000161128     F                                     INFDS(INFO)
000000161128     F                                     SFILE(SFL01:RRN01)
000000161128     F                                     indds(indds)
000000161128     D INFO            DS
000000161128     D  LRRN                 378    379B 0
000000161128
000000210330      /copy qprotosrc,provider
000000161128
000000161128     D indds           ds
000000161128     D  help                   1      1n
000000161128     D  exit                   3      3n
000000161128     D  prompt                 4      4n
000000161128     D  refresh                5      5n
000000161128     D  create                 6      6n
000000161128     D  cf08                   8      8n
000000161128     D  cancel                12     12n
000000161128     D  morekeys              24     24n
000000161128     D  pagedown              25     25n
000000161128     D  sflclr                30     30n
000000161128     D  sfldsp                31     31n
000000161128     D  sfldspctl             32     32n
000000161128     D  sflnxtchg             33     33n
000000161128     D  dspatrri              34     34n
000000161128     D  InvalidOpt            35     35n
000000161128     D  OneSelect             36     36n
000000161128     D  bydesc                40     40n
000000161128     D  InvalidOptC           41     41n
000000161128     D  NotAvail              42     42n
000000161128     D  sflend                80     80n
000000161129
000000161129     d  data           ds                  inz
000000210330     d   prid                         5  0
000000210330     d   provnm                      30
000000210330     d   prcity                      30
000000210330     d   prcoun                       2
000000161128
000000161128     D rrn01           s              5i 0
000000161128
000000161128     d prp             c                   'prp'
000000161128     d lod             c                   'lod'
000000161128     d dsp             c                   'dsp'
000000161128     d key             c                   'key'
000000161128     d chk             c                   'chk'
000000161128     d act             c                   'act'
000000161128
000000161128
000000161128      *=============================================
000000210330     P sltprovider     B                   export
000000210330     D sltprovider     PI             5  0
000000161129     d pcod                           5  0 value
000000161128
000000161128     d  savData        ds                  likeds(data)
000000161128
000000210330     D dft             S                   like(prid      )
000000161128     D step01          S              3    inz(prp)
000000161128     d in08            s               n
000000161128     d sts01           s               n
000000161128     D rrs01           s              5i 0
000000161128     D teller          s              5i 0
000000161128     D err01           s               n
000000161128     D slt01           s               n
000000210330     d savName         s                    like(provnm     )
000000210330     d savCity         s                    like(prcity     )
000000161128     d stm             s            500     varying
000000161128      /free
000000210330       if not %open(pro301d   );
000000210330         open pro301d    ;
000000161128       endif;
000000161128       dft = pcod;
000000161128       dow step01 <> ' ';
000000161128         select ;
000000161128         when step01 = prp ;
000000161128           exsr s01prp;
000000161128         when step01 = lod ;
000000161128           exsr s01lod;
000000161128         when step01 = dsp ;
000000161128           exsr s01dsp;
000000161128         when step01 = key ;
000000161128           exsr s01key;
000000161128         when step01 = chk ;
000000161128           exsr s01chk;
000000161128         when step01 = act ;
000000161128           exsr s01act ;
000000161128         endsl;
000000161128       enddo;
000000161128       exec sql close c1;
000000161128       return dft;
000000161128       //--- Clear Subfile  -----------------------------------------------------
000000161128
000000161128       begsr s01prp;
000000161128         RRS01 = 0;
000000161128         sflclr = *on;
000000161128         sfldsp = *off;
000000161128         sfldspctl = *off;
000000161128         write CTL01;
000000161128         sflclr = *off;
000000210330         stm =  'SELECT prid, provnm, prcity, prcoun FROM provideR ';
000000161128         if srchName <> ' '  and srchCity <> ' ' ;
000000210330           stm += 'Where UPPER(provnm) like ''%' + %trim(srchName) +
000000210330                  '%'' AND UPPER(prcity) like ''%' + %trim(srchCity)
000000161129                 + '%'' ';
000000161128         elseif srchName <> ' ';
000000210330           stm += 'Where UPPER(provnm) like ''%' + %trim(srchName) +
000000161129                  '%'' ';
000000161128         else;
000000210330           stm += 'Where UPPER(prcity) like ''%' + %trim(srchCity) +
000000161129                  '%'' ';
000000161128         endif;
000000210330         stm += ' ORDER BY provnm';
000000161128         SAVName = srchName;
000000161128         SAVCity = srchCity;
000000161128         Step01 = lod;
000000161128         exec sql prepare s1 from :stm;
000000161128         exec sql declare C1 cursor for s1;
000000161128         exec sql open c1;
000000161128         exec sql fetch c1 into :data;
000000161128         savData = data;
000000161128       endsr;
000000161128       //--- Load Subfile  -----------------------------------------------------
000000161128       begsr S01lod;
000000161128         RRN01 = RRS01;
000000161128         Data = Savdata;
000000161128         RRB01 = RRS01 + 1;
000000161128         TELLER = 0;
000000161128         OPT01 = 0;
000000161128         SflNxtChg = *OFF;
000000161128         dow sqlcod = 0
000000161129               and TELLER < 14;
000000161128           RRN01 = RRN01 + 1;
000000161128           TELLER = TELLER + 1;
000000161128           write SFL01;
000000161128           exec sql fetch c1 into :data;
000000161128         enddo;
000000161129         sflend = sqlcod <> 0;
000000161128         savData = data;
000000161128         RRS01 = RRN01;
000000161128         Step01 = dsp;
000000161128       endsr;
000000161128       //--- Display Subfile  --------------------------------------------------
000000161128       begsr S01dsp;
000000161128         sfldsp = rrs01 > 0;
000000161128         sfldspctl = *on;
000000161128         write KEY01;
000000161128         exfmt CTL01;
000000161128         RRB01 = LRRN;
000000161128         Step01 = key;
000000161128       endsr;
000000161128       //--- Command Keys  -----------------------------------------------------
000000161128       begsr S01key;
000000161128         select;
000000161128         when exit;
000000161128           step01 = ' ';
000000161128         when cancel ;
000000161128           Step01 = ' ';
000000161128         when PageDown;
000000161128           Step01 = lod;
000000161128         other;
000000161128           Step01 = chk;
000000161128         endsl;
000000161128       endsr;
000000161128       //--- Check Subfile  ----------------------------------------------------
000000161128       begsr S01chk;
000000161128         // SET FLAG SELECTION MADE OFF
000000161128         SLT01 = *OFF;
000000161128         // SET FLAG OPTION  MADE OFF
000000161128         STS01 = *OFF;
000000161128         // SET FLAG ERROR   MADE OFF
000000161128         ERR01 = *OFF;
000000161128         Step01 = act;
000000161128         readc(E) SFL01;
000000161128         SflNxtChg = *ON;
000000161128         dow not %error and not %eof;
000000161128           select;
000000161128           when OPT01 = 0;
000000161128             // NO ERROR
000000161128           when OPT01 <>1;
000000161128             STS01 = *ON;
000000161128             Step01 = dsp;
000000161128             dspatrRi = *on;
000000161128             InvalidOpt= *on;
000000161128             if ERR01 = *OFF;
000000161128               RRB01 = RRN01;
000000161128               ERR01 = *ON;
000000161128             endif;
000000161128             //OPTION = 1 BUT SELECTION ALREADY MADE
000000161128           when SLT01 = *ON;
000000161128             Step01 = dsp;
000000161128             dspatrRi = *on;
000000161128             OneSelect = *on;
000000161128             if ERR01 = *OFF;
000000161128               RRB01 = RRN01;
000000161128               ERR01 = *ON;
000000161128             endif;
000000161128           other;
000000161128             //OPTION = 1
000000161128             SLT01 = *ON;
000000161128             STS01 = *ON;
000000161128           endsl;
000000161128           update SFL01;
000000161128           dspatrRi = *off;
000000161128           readc SFL01;
000000161128         enddo;
000000161128       endsr;
000000161128       //--- Write Subfile  ----------------------------------------------------
000000161128       begsr S01act;
000000161128         Step01 = dsp;
000000161128         select;
000000161128         when savName <> srchName or savCity <> srchCity;
000000161128           Step01 = prp;
000000161128           exec sql close c1;
000000161128         other;
000000161128           readc(E) SFL01;
000000161128           dow not %error and not %eof;
000000161128             if OPT01 = 1;
000000161129               exec sql close c1;
000000210330               return prid      ;
000000161128             endif;
000000161128             readc SFL01;
000000161128           enddo;
000000161128         endsl;
000000161128       endsr;
000000161128      /end-free
000000161128
000000210330     p sltprovider     e
000000161128
000000161128
