000000161025
000000161201     fprovide1  if   e           k disk
000000161201     fpro202d   cf   e             workstn
000000161024     F                                     indds(indds)
000000161024     F                                     sfile(sfl01:rrn01)
000000161024     F                                     Infds(Info)
000000161201
000000161201      /copy qprotosrc,xml
000000161209      /copy qprotosrc,parameter
000000161201
000000161201     d pro202          pr
000000161201     d  id                                 like(prid)
000000161201     d pro202          pi
000000161201     d  id                                 like(prid)
000000161129
000000161024     D indds           ds
000000161024     D  help                   1      1n
000000161024     D  exit                   3      3n
000000161024     D  prompt                 4      4n
000000161024     D  refresh                5      5n
000000161201     D  confirm                8      8n
000000161024     D  cancel                12     12n
000000161024     D  morekeys              24     24n
000000161024     D  pagedown              25     25n
000000161024     D  sflclr                30     30n
000000161024     D  sfldsp                31     31n
000000161024     D  sfldspctl             32     32n
000000161024     D  sflnxtchg             33     33n
000000161024     D  dspatr_ri             34     34n
000000161024     D  sflmsg                35     35n
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
000000161025     d User            s             10    inz(*user)
000000161024     d mode            s              3
000000161024
000000161024     d prp             c                   'prp'
000000161024     d lod             c                   'lod'
000000161024     d dsp             c                   'dsp'
000000161024     d key             c                   'key'
000000161024     d chk             c                   'chk'
000000161024     d act             c                   'act'
000000161201
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
000000161201         exec sql declare c2 cursor for
000000161201           SELECT ARID, ARDESC, arstock, ARMINQTY,
000000161201                  ARCUSQTY, ARPURQTY, APPRICE, apref
000000161201           FROM article, artiprov
000000161201           WHERE arstock < ARMINQTY - arcusqty + arpurqty
000000161201             and arid = aparid
000000161201             AND apprid = :id
000000161201           order by arid ;
000000161201         exec sql open c2;
000000161024         step01 = lod;
000000161027         rrs01 = 0;
000000161024       endsr;
000000161024       //--- Load Subfile  -----------------------------------------------------
000000161024       begsr s01lod;
000000161027         rrn01 = rrs01;
000000161024         RRb01 = RRn01 + 1;
000000161201         exec sql fetch c2 into :arid, :ardesc, :arstock, :arminqty,
000000161201                                :ARCUSQTY, :ARPURQTY, :APPRICE, :APREF;
000000161201         dow sqlcod = 0;
000000161201           neword = ARMINQTY + ARCUSQTY - arpurqty - arstock;
000000161201           name25 = ardesc;
000000161201           RRN01 += 1;
000000161201           write sfl01;
000000161201           exec sql fetch c2 into :arid, :ardesc, :arstock, :arminqty,
000000161201                                :ARCUSQTY, :ARPURQTY, :APPRICE, :APREF;
000000161024         enddo;
000000161201         sflend = *on;
000000161024         step01 = dsp;
000000161027         rrs01 = rrn01;
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
000000161027         when pagedown;
000000161027           step01 = lod;
000000161024         other;
000000161024           step01 = chk;
000000161024         endsl;
000000161024       endsr;
000000161024       //--- Check Subfile  ----------------------------------------------------
000000161024       begsr s01chk;
000000161024         step01 = act;
000000161024       endsr;
000000161024       //--- action Subfile  ---------------------------------------------------
000000161024       begsr s01act;
000000161201         if confirm;
000000161201           fileName = 'Pur_Ord_' + %trim(%char(prid)) + '_' +
000000161201                      %char(%dec(%date:*YMD)) + '.xml';
000000161209           path = getParm2('PATH':' ');
000000161201           xmlopen(%trim(path) + fileName);
000000161201           xmlStrTable('PURODR');
000000161201           XmlStrRec('Customer');
000000161201           xmladdcol('NAME':'SAMPLE Company');
000000161201           xmladdcol('ADDRES':'55, rue Adrastee');
000000161201           xmladdcol('ZIPCODE':'F-74650');
000000161201           xmladdcol('CITY':'Chavanod');
000000161201           xmlendrec('Customer');
000000161201           rrn01 = 1;
000000161201           chain rrn01 sfl01;
000000161201           dow %found();
000000161201             xmlstrRec('Item');
000000161201             xmladdcol('ID':arid);
000000161201             xmladdcol('YOUR_REF':apref);
000000161201             xmladdcol('DESC':ardesc);
000000161201             xmladdcol('QTY':%char(neword));
000000161201             xmladdcol('UnitPrice':%editc(apprice:'2'));
000000161201             XmlEndRec('Item');
000000161201             rrn01 += 1;
000000161201             chain rrn01 sfl01;
000000161201           ENDDO;
000000161201           xmlEndTable('PURODR');
000000161201           xmlclose();
000000161201           exfmt fmt03;
000000161201           panel = 0;
000000161201         else;
000000161201           step01 = dsp;
000000161201         endif;
000000161201
000000161024       endsr;
000000161024
000000161025       //--------INITIALIZATION ----------------------------------
000000161025       begsr *inzsr;
000000161201         chain prid provide1;
000000161025       endsr;
000000161025       //--------END SUBROUTINE ----------------------------------
000000161025       begsr pnl00;
000000161201         exec sql close c2;
000000161025         *inlr = *on;
000000161025       endsr;
000000161103      /end-free
