000000161129     h nomain
000000161129
000000161129     FVATDEF    if   e           k disk    usropn
000000161129
000000161129      /copy qprotosrc,VAT
000000161129
000000161129     d chainVATDEF     pr
000000161129     D P_VATCODE                      1A    value
000000161129
000000161129     D K_VATCODE       S                   LIKE(VATCODE)
000000161129
000000161129     C     kf            klist
000000161129     C                   KFLD                    K_VATCODE
000000161129
000000161129      *=============================================
000000161129     PGetVATRate       B                     export
000000161129     DGetVATRate       PI             4P 2
000000161129     D P_VATCODE                      1A    value
000000161129      /free
000000161129         chainVATDEF(P_VATCODE  );
000000161129         return VATRATE;
000000161129      /end-free
000000161129     pGetVATRate       e
000000161129      *=============================================
000000161129     PGetVATDesc       B                     export
000000161129     DGetVATDesc       PI            20A
000000161129     D P_VATCODE                      1A    value
000000161129      /free
000000161129         chainVATDEF(P_VATCODE  );
000000161129         return VATDESC;
000000161129      /end-free
000000161129     pGetVATDesc       e
000000161129
000000161129      *=============================================
000000161129     P ClcVAT          B                     export
000000161129     D ClcVAT          PI             9  2
000000161129     D P_VATCODE                      1     value
000000161129     d Net                            9  2  value
000000161129
000000161129     d tot             s             11  4
000000161129      /free
000000161129         chainVATDEF(P_VATCODE  );
000000161129         tot = (net * vatrate) / 100;
000000161129         return %dech(tot : 9 :2) ;
000000161129      /end-free
000000161129     p ClcVAT          e
000000161129
000000161129      *=============================================
000000161129     P ExistVATRate    B                     export
000000161129     D ExistVATRate    PI              n
000000161129     D P_VATCODE                      1A    value
000000161129      /free
000000161129         chainVATDEF(P_VATCODE  );
000000161129         return %found(VATDEF) and VATDEL <> 'X';
000000161129      /end-free
000000161129     p ExistVATRate    e
000000161129
000000161129     p chainVATDEF     b
000000161129     d chainVATDEF     pi
000000161129     D P_VATCODE                      1A    value
000000161129      /free
000000161129        if not %open(VATDEF);
000000161129          open VATDEF;
000000161129        endif;
000000161129         if P_VATCODE <> VATCODE;
000000161129           K_VATCODE =  P_VATCODE;
000000161129           clear *all FVAT;
000000161129           chain kf VATDEF;
000000161129         endif;
000000161129      /end-free
000000161129     p chainVATDEF     e
000000161129
000000161129     p closeVATDEF     b
000000161129     d closeVATDEF     pi
000000161129      /free
000000161129        if %open(VATDEF);
000000161129          close VATDEF;
000000161129        endif;
000000161129      /end-free
000000161129     p closeVATDEF     e
000000161129
000000161129
