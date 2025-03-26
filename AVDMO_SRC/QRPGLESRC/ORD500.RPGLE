000000161129     h dftactgrp(*no)
000000161129
000000161130     ford500o   o    e             printer oflind(overflow)
000000161129
000000161129     forder1    if   e           k disk
000000161129     fdetord1   if   e           k disk
000000161129     fcustome1  if   e           k disk
000000161129     farticle1  if   e           k disk
000000161129
000000161209      /copy qprotosrc,parameter
000000161209
000000161129     d ord500          pr
000000161129     d   id                                like(orid)
000000161129
000000161129     d ord500          pi
000000161129     d   id                                like(orid)
000000161130
000000161130     d pdford          pr                  extpgm('ORD500C')
000000161130     d   id                           5    const
000000161209     d   path                       100    const
000000161130
000000161130     d count           s              3u 0
000000161209     d path            s            100
000000161129
000000161129      /free
000000170303
000000170303        datord = %date();
000000161129        chain id order1;
000000170220        datord = %date(ORDATE:*iso);
000000161129        chain orcuid custome1;
000000161129        write header;
000000161130        write header2;
000000161130        write header3;
000000161129        setll (orid) detord1;
000000161129        reade (orid) detord1;
000000161129        dow not %eof;
000000161130          if count > 14;
000000161130            write footer;
000000161130            write header;
000000161130            write header3;
000000161130            count = 0;
000000161129          endif;
000000161129          chain odarid article1;
000000161130          count += 1;
000000161130          totnet += odtot;
000000161130          tottot += odtotvat;
000000161129          write detail;
000000161129          reade (orid) detord1;
000000161129        enddo;
000000161129        *inlr = *on;
000000161130        totvat = tottot -totnet;
000000161130        write total;
000000161130        write footer;
000000161130        close ord500o;
000000161209        path = getParm2('PATH':' ');
000000161209        pdfOrd(%trim(%char(orid)):path);
000000161129      /end-free
