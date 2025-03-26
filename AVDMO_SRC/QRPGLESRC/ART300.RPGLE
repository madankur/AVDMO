000000000000     h nomain
000000000000
000000000000     FARTICLE1  if   e           k disk    usropn
000000000000
000000000000      /copy qprotosrc,ARTICLE
000000000000
000000000000     d chainARTICLE1   pr
000000000000     D P_ARID                         6A    value
000000000000
000000000000     D K_ARID          S                   LIKE(ARID)
000000000000
000000000000     C     kf            klist
000000000000     C                   KFLD                    K_ARID
000000000000
000000000000      *=============================================
000000000000     PGetArtDesc       B                     export
000000161027     DGetArtDesc       PI                   like(ardesc)
000000000000     D P_ARID                         6A    value
000000000000      /free
000000000000         chainARTICLE1(P_ARID
000000000000               );
000000000000         return ARDESC;
000000000000      /end-free
000000000000     pGetArtDesc       e
000000000000      *=============================================
000000161025     PGetArtRefSalPrice...
000000161025     P                 B                     export
000000161025     DGetArtRefSalPrice...
000000161027     D                 PI                   like(arsalepr)
000000000000     D P_ARID                         6A    value
000000000000      /free
000000000000         chainARTICLE1(P_ARID
000000000000               );
000000000000         return ARSALEPR;
000000000000      /end-free
000000161025     p                 e
000000000000      *=============================================
000000161025     PGetArtStockPrice...
000000161025     P                 B                     export
000000161025     DGetArtStockPrice...
000000161027     D                 PI                   like(arwhspr)
000000000000     D P_ARID                         6A    value
000000000000      /free
000000000000         chainARTICLE1(P_ARID
000000000000               );
000000000000         return ARWHSPR;
000000000000      /end-free
000000161025     p                 e
000000000000      *=============================================
000000000000     PGetArtFam        B                     export
000000161027     DGetArtFam        PI                   like(artifa)
000000000000     D P_ARID                         6A    value
000000000000      /free
000000000000         chainARTICLE1(P_ARID
000000000000               );
000000000000         return ARTIFA;
000000000000      /end-free
000000000000     pGetArtFam        e
000000000000      *=============================================
000000000000     PGetArtStock      B                     export
000000161027     DGetArtStock      PI                   like(arstock)
000000000000     D P_ARID                         6A    value
000000000000      /free
000000000000         chainARTICLE1(P_ARID
000000000000               );
000000000000         return ARSTOCK;
000000000000      /end-free
000000000000     pGetArtStock      e
000000000000      *=============================================
000000000000     PGetArtMinStock   B                     export
000000161027     DGetArtMinStock   PI                   like(arminqty)
000000000000     D P_ARID                         6A    value
000000000000      /free
000000000000         chainARTICLE1(P_ARID
000000000000               );
000000000000         return ARMINQTY;
000000000000      /end-free
000000000000     pGetArtMinStock   e
000000161027      *=============================================
000000161027     PGetArtVatCode    B                     export
000000161027     DGetArtVatCode    PI                   like(arvatcd)
000000161027     D P_ARID                         6A    value
000000161027      /free
000000161027         chainARTICLE1(P_ARID
000000161027               );
000000161027         return ARvatcd ;
000000161027      /end-free
000000161027     pGetArtVatCode    e
000000000000      *=============================================
000000161025     P ExistArt        B                     export
000000161025     D ExistArt        PI              n
000000000000     D P_ARID                         6A    value
000000000000      /free
000000000000         chainARTICLE1(P_ARID
000000000000               );
000000161027         return %found(article1) and ardel <> 'X';
000000000000      /end-free
000000161025     p ExistArt        e
000000000000
000000161025      *=============================================
000000161025     PIsArtDeleted     B                     export
000000161025     DIsArtDeleted     PI              n
000000161025     D P_ARID                         6A    value
000000161025      /free
000000161025         chainARTICLE1(P_ARID
000000161025               );
000000161027         return ArDEL = 'X';
000000161025      /end-free
000000161025     pIsArtDeleted     e
000000161025
000000000000     p chainARTICLE1   b
000000000000     d chainARTICLE1   pi
000000000000     D P_ARID                         6A    value
000000000000      /free
000000000000        if not %open(ARTICLE1);
000000000000          open ARTICLE1;
000000000000        endif;
000000000000         if P_ARID <> ARID;
000000000000           K_ARID =  P_ARID;
000000000000           clear *all FARTI;
000000000000           chain kf ARTICLE1;
000000000000         endif;
000000000000      /end-free
000000000000     p chainARTICLE1   e
000000000000
000000000000     p closeARTICLE1   b
000000000000     d closeARTICLE1   pi
000000000000      /free
000000000000        if %open(ARTICLE1);
000000000000          close ARTICLE1;
000000000000        endif;
000000000000      /end-free
000000000000     p closeARTICLE1   e
000000000000
000000000000
