000000000000     h nomain
000000000000
000000000000     FPROVIDE1  if   e           k disk    usropn
000000000000
000000000000      /copy qprotosrc,PROVIDER
000000000000
000000000000     d chainPROVIDE1   pr
000000000000     D P_PRID                         5P 0  value
000000000000
000000000000     D K_PRID          S                   LIKE(PRID)
000000000000
000000000000     C     kf            klist
000000000000     C                   KFLD                    K_PRID
000000000000
000000000000      *=============================================
000000000000     PGetProName       B                     export
000000161027     DGetProName       PI                  like(provnm)
000000000000     D P_PRID                         5P 0  value
000000000000      /free
000000000000         chainPROVIDE1(P_PRID
000000000000               );
000000000000         return PROVNM;
000000000000      /end-free
000000000000     pGetProName       e
000000000000      *=============================================
000000000000     PGetProCONT       B                     export
000000161027     DGetProCONT       PI                  like(prcont)
000000000000     D P_PRID                         5P 0  value
000000000000      /free
000000000000         chainPROVIDE1(P_PRID
000000000000               );
000000000000         return PRCONT;
000000000000      /end-free
000000000000     pGetProCONT       e
000000000000      *=============================================
000000000000     PGetProPHONE      B                     export
000000161027     DGetProPHONE      PI                  like(prphone)
000000000000     D P_PRID                         5P 0  value
000000000000      /free
000000000000         chainPROVIDE1(P_PRID
000000000000               );
000000000000         return PRPHONE;
000000000000      /end-free
000000000000     pGetProPHONE      e
000000000000      *=============================================
000000000000     PGetProVAT        B                     export
000000161027     DGetProVAT        PI                  like(prvat)
000000000000     D P_PRID                         5P 0  value
000000000000      /free
000000000000         chainPROVIDE1(P_PRID
000000000000               );
000000000000         return PRVAT;
000000000000      /end-free
000000000000     pGetProVAT        e
000000000000      *=============================================
000000000000     PGetProMAIL       B                     export
000000161027     DGetProMAIL       PI                  like(prmail)
000000000000     D P_PRID                         5P 0  value
000000000000      /free
000000000000         chainPROVIDE1(P_PRID
000000000000               );
000000000000         return PRMAIL;
000000000000      /end-free
000000000000     pGetProMAIL       e
000000000000      *=============================================
000000000000     PGetProAdr1       B                     export
000000161027     DGetProAdr1       PI                  like(prline1)
000000000000     D P_PRID                         5P 0  value
000000000000      /free
000000000000         chainPROVIDE1(P_PRID
000000000000               );
000000000000         return PRLINE1;
000000000000      /end-free
000000000000     pGetProAdr1       e
000000000000      *=============================================
000000000000     PGetProAdr2       B                     export
000000161027     DGetProAdr2       PI                  like(prline2)
000000000000     D P_PRID                         5P 0  value
000000000000      /free
000000000000         chainPROVIDE1(P_PRID
000000000000               );
000000000000         return PRLINE2;
000000000000      /end-free
000000000000     pGetProAdr2       e
000000000000      *=============================================
000000000000     PGetProAdr3       B                     export
000000161027     DGetProAdr3       PI                  like(prline3)
000000000000     D P_PRID                         5P 0  value
000000000000      /free
000000000000         chainPROVIDE1(P_PRID
000000000000               );
000000000000         return PRLINE3;
000000000000      /end-free
000000000000     pGetProAdr3       e
000000000000      *=============================================
000000000000     PGetProZip        B                     export
000000161027     DGetProZip        PI                  like(przip)
000000000000     D P_PRID                         5P 0  value
000000000000      /free
000000000000         chainPROVIDE1(P_PRID
000000000000               );
000000000000         return PRZIP;
000000000000      /end-free
000000000000     pGetProZip        e
000000000000      *=============================================
000000000000     PGetProCity       B                     export
000000161027     DGetProCity       PI                  like(prcity)
000000000000     D P_PRID                         5P 0  value
000000000000      /free
000000000000         chainPROVIDE1(P_PRID
000000000000               );
000000000000         return PRCITY;
000000000000      /end-free
000000000000     pGetProCity       e
000000000000      *=============================================
000000000000     PGetProCountry    B                     export
000000161027     DGetProCountry    PI                  like(prcoun)
000000000000     D P_PRID                         5P 0  value
000000000000      /free
000000000000         chainPROVIDE1(P_PRID
000000000000               );
000000000000         return PRCOUN;
000000000000      /end-free
000000000000     pGetProCountry    e
000000000000      *=============================================
000000161025     P ExistProvider   B                     export
000000161025     D ExistProvider   PI              n
000000000000     D P_PRID                         5P 0  value
000000000000      /free
000000000000         chainPROVIDE1(P_PRID
000000000000               );
000000161025         return %found(provide1) and prdel <> 'X';
000000000000      /end-free
000000161025     p ExistProvider   e
000000000000
000000161025      *=============================================
000000161025     PIsProDeleted     B                     export
000000161025     DIsProDeleted     PI              n
000000161025     D P_PRID                         5P 0  value
000000161025      /free
000000161025         chainPROVIDE1(P_PRID
000000161025               );
000000161025         return PRDEL = 'X';
000000161025      /end-free
000000161025     pIsProDeleted     e
000000161025
000000000000     p chainPROVIDE1   b
000000000000     d chainPROVIDE1   pi
000000000000     D P_PRID                         5P 0  value
000000000000      /free
000000000000        if not %open(PROVIDE1);
000000000000          open PROVIDE1;
000000000000        endif;
000000000000         if P_PRID <> PRID;
000000000000           K_PRID =  P_PRID;
000000000000           clear *all FPROV;
000000000000           chain kf PROVIDE1;
000000000000         endif;
000000000000      /end-free
000000000000     p chainPROVIDE1   e
000000000000
000000000000     p closePROVIDE1   b
000000000000     d closePROVIDE1   pi
000000000000      /free
000000000000        if %open(PROVIDE1);
000000000000          close PROVIDE1;
000000000000        endif;
000000000000      /end-free
000000000000     p closePROVIDE1   e
000000000000
000000000000
