000000161208     h dftactgrp(*no)
000000161208     fpro202d   cf   e             workstn
000000161208
000000161208      /copy qprotosrc,Xss
000000161209      /copy qprotosrc,Parameter
000000161208
000000161208     d data            ds                  inz
000000161208     d   ARID                         6
000000161208     d   ARDESC                      50A
000000161208     d   ARSTOCK                      5P 0
000000161208     d   ARMINQTY                     5P 0
000000161208     d   ARCUSQTY                     5P 0
000000161208     d   ARPURQTY                     5P 0
000000161208     d   PRID                         5P 0
000000161208     d   PROVNM                      30A
000000161208     d   APPRICE                      7P 2
000000161208     d   APREF                       10A
000000161208     d   TOT                          3  0
000000161208
000000161208     d r1              s             12
000000161208     d r2              s             12
000000161208     d head            s              3u 0
000000161208     d dec2            s              3u 0
000000161208     d Yellow          s              3u 0
000000161208
000000161208      /free
000000161208        fileName = 'Goods to purchase' + '_' +
000000161208                    %char(%dec(%date:*YMD)) + '.xml';
000000161209        path = GetParm2('PATH':' ');
000000161208        xssopenfile(%trim(path) + fileName);
000000161208        XssSetDocProperties('SAMPLE Company':' ':1);
000000161208        head = xsscreatestyle();
000000170109        xssSetFontSize(12);
000000161208        XssSetalign(ALIGN_CENTER);
000000161208        Xsssetwrap();
000000161208        dec2 = xsscreatestyle();
000000161208        XssSetFormat(FORMAT_DEC2);
000000161208        Yellow = xsscreatestyle();
000000161208        XsssetForcolor(COLOR_YELLOW);
000000161208        Xssaddsheet('Purchasing');
000000170109        XssSetColWidth(150 :2);
000000161208        xssaddrow(40);
000000161208        xssaddcellChar('Art Id':head);
000000161208        r1 = XssGetCellId();
000000161208        xssaddcellChar('Description':head);
000000161208        xssaddcellChar('Stock':head);
000000161208        xssaddcellChar('Minimun Stock':head);
000000161208        xssaddcellChar('Customer Order Qty':head);
000000161208        xssaddcellChar('Purchase Order Qty':head);
000000161208        xssaddcellChar('Proposed Order Qty':head);
000000161208        xssaddcellChar('Provider Id':head);
000000161208        xssaddcellChar('Name':head);
000000161208        xssaddcellChar('Purchase Price':head);
000000161208        xssaddcellChar('Provider Reference':head);
000000161208
000000161208        exec sql declare c1 cursor for
000000161208           SELECT ARID, ARDESC, arstock, ARMINQTY, ARCUSQTY, ARPURQTY, PRID,
000000161208                  PROVnm,  APPRICE, apref,
000000161208                  (select count(*) from artiprov b where a.aparid = b.aparid )
000000161208           FROM article, artiprov a, provider
000000161208           WHERE arstock < ARMINQTY - arcusqty + arpurqty
000000161208             and Arcusqty > 0
000000161208             and arid = aparid AND apprid = prid
000000161208          ORDER BY arid, apprid;
000000161208        exec sql open c1;
000000161208
000000161208        exec sql fetch c1 into :data;
000000161208        dow sqlcod = 0;
000000161208          xssaddrow();
000000161208          if tot = 1;
000000161208            XssAddCellChar(ARID);
000000161208            XssAddCellChar(ARDESC);
000000161208          else;
000000161208            XssAddCellChar(ARID:Yellow);
000000161208            XssAddCellChar(ARDESC:Yellow);
000000161208          ENDIF;
000000161208          xssaddcellNum(ARSTOCK);
000000161208          XssAddCellNum(ARMINQTY);
000000161208          XssAddCellNum(ARCUSQTY);
000000161208          XssAddCellNum(ARPURQTY);
000000161208          XssAddCellNum(ARMINQTY + ARCUSQTY - arpurqty - arstock);
000000161208          XssAddCellNum(PRID);
000000161208          XssAddCellChar(PROVNM);
000000161208          XssAddCellNum(APPRICE:dec2);
000000161208          XssAddCellChar(APREF);
000000161208          exec sql fetch c1 into :data;
000000161208        ENDDO;
000000161208        exec sql close c1;
000000161208        r2 = XssGetCellId();
000000161208        XssSetAutoFilter(r1:r2);
000000161208        Xssclosefile();
000000161208        exfmt fmt03;
000000161208
000000161208        *inlr = *on;
000000161208      /end-free
000000161208
