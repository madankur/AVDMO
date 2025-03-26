000000170303      *   %XREF XREFTYPE(*OBJ)   OBJ(SAMLOG) OBJTYPE(*USRSPC)   USAGE(*UPD)
000000170215
000000161216     h nomain
000000161216
000000161216      /copy qprotosrc,apicall
000000161216      /copy qprotosrc,log
000000161216     d init            pr
000000161216
000000161216     d pos             s             10i 0 based(p1)
000000161216     d data            s            600    based(p2)
000000161216     d usrspc          s             20
000000161216     d inz             s               n
000000161216     d User            s             10    inz(*USER)
000000161216
000000161216     p AddLogEntry     b                   export
000000161216     d AddLogEntry     pi
000000161216     d  entry                       500    value
000000161216
000000161216     d  data2          s            500    varying
000000161216      /free
000000161216        if not inz;
000000161216          init();
000000161216        endif;
000000161216        p2 = p1 + pos;
000000161216        data2 = 'User: ' +user + ' * ';
000000161216        data2 += 'Date: '  + %char(%Timestamp()) + ' * ' ;
000000161216        data2 += 'Msg: '  + %trim(entry) + ' ***' ;
000000161216        data = data2;
000000161216        pos += %len(data2);
000000161216      /end-free
000000161216
000000161216     p AddLogEntry     e
000000161216
000000161216     p init            b
000000161216     d init            pi
000000161216
000000161216      /free
000000161216        usrspc = 'SAMLOG    *LIBL';
000000161216        inz = *on;
000000161216        rtvusrspcptr(usrspc:p1);
000000161216      /end-free
000000161216
000000161216     p init            e
