000000161209     forder     UF   E             DISK
000000161209
000000161209     d lastdate        s              8  0
000000161209     d today           s              8  0
000000161209     d days            s              5  0
000000161209
000000161209      /free
000000161209         exec sql select max(ordate)  into :LastDate from order;
000000161209         if lastdate = 0;
000000161209           *inlr = *on;
000000161209           return;
000000161209         ENDIF;
000000161209         today = %dec(%date():*iso);
000000161209         days = %diff(%date():%date(lastdate:*iso):*d);
000000161209         lastdate = %dec(%date() - %days(10):*iso);
000000161209         read order;
000000161209         dow not %eof;
000000161209           ordate = %dec(%date(ordate:*iso) + %days(days):*iso);
000000161209           if ordatdel > 0;
000000161209              ordatdel = %dec(%date(ordatdel:*iso) + %days(days):*iso);
000000161209              if  ordatdel > today;
000000161209                ordatdel = 0;
000000161209              ENDIF;
000000161209           ENDIF;
000000161209           if ordatclo > 0;
000000161209              ordatclo = %dec(%date(ordatclo:*iso) + %days(days):*iso);
000000161209              if  ordatclo > today ;
000000161209                ordatclo = 0;
000000161209              ENDIF;
000000161209           else;
000000161209              if ordatdel > 0 and ordatdel < lastdate ;
000000161209                ordatclo =  %dec(%date(ordatdel:*iso) + %days(10):*iso);
000000161209              ENDIF;
000000161209           ENDIF;
000000161209           oryear = %subdt(%date(ordate:*iso):*Y);
000000161209           update forde;
000000161209           read order;
000000161209         ENDDO;
000000161209         exec sql Update detord d set odyear = (select oryear
000000161209                from order where d.odorid = orid)
000000161209                where odyear <> (select oryear
000000161209                from order where d.odorid = orid) ;
000000161219         exec sql  UPDATE CUSTOMER  C SET CULASTORD =
000000161219              ( SELECT MAX ( ORDATE ) FROM "ORDER"
000000161219                      WHERE C.CUID = ORCUID )
000000161219                WHERE EXISTS ( SELECT ORCUID FROM "ORDER"
000000161219                      WHERE C.CUID = ORCUID );
000000161209         *inlr = *on;
000000161209      /end-free
