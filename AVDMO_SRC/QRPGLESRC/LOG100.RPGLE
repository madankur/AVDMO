000000161216
000000161216     h dftactgrp(*no)
000000161216     fparameter if   e           k disk
000000161216     f                                     infds(info)
000000161216
000000161216      /copy qprotosrc,apicall
000000161216
000000161216     d info            ds
000000161216     D  lib                   93    102
000000161216
000000161216     d                 ds                  based(p1)
000000161216     d  pos                          10i 0
000000161216     d  data                          3
000000161216
000000161216     d usrspc          s             20
000000161216      /free
000000161216        usrspc = 'SAMLOG    ' + Lib;
000000161216        crtusrspc(usrspc:'LOG':5000:X'00':'*ALL':'Sample Application Log'
000000161216                  :'*YES':errcod);
000000161216        rtvusrspcptr(usrspc:p1);
000000161216        pos = 7;
000000161216        data = '***';
000000161216        *inlr = *on;
000000161216      /end-free
