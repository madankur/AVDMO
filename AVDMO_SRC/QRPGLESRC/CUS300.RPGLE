000000000000     h nomain
000000000000
000000000000     FCUSTOME1  if   e           k disk    usropn
000000000000
000000000000      /copy qprotosrc,CUSTOMER
000000000000
000000000000     d chainCUSTOME1   pr
000000161025     D P_CUID                         5  0  value
000000000000
000000000000     D K_CUID          S                   LIKE(CUID)
000000000000
000000000000     C     kf            klist
000000000000     C                   KFLD                    K_CUID
000000000000
000000000000      *=============================================
000000000000     PGetCusName       B                     export
000000161027     DGetCusName       PI                   like(custnm)
000000161025     D P_CUID                         5  0  value
000000000000      /free
000000000000         chainCUSTOME1(P_CUID
000000000000               );
000000000000         return CUSTNM;
000000000000      /end-free
000000000000     pGetCusName       e
000000000000      *=============================================
000000000000     PGetCusPhone      B                     export
000000161027     DGetCusPhone      PI                   like(cuphone)
000000161025     D P_CUID                         5  0  value
000000000000      /free
000000000000         chainCUSTOME1(P_CUID
000000000000               );
000000000000         return CUPHONE;
000000000000      /end-free
000000000000     pGetCusPhone      e
000000000000      *=============================================
000000221013     PGetCusCategory   B                     export
000000221013     DGetCusCategory   PI                   like(cuCat)
000000161025     D P_CUID                         5  0  value
000000000000      /free
000000000000         chainCUSTOME1(P_CUID
000000000000               );
000000221013         return CUCAT;
000000000000      /end-free
000000221013     pGetCusCategory   e
000000221013      *=============================================
000000221013     PGetCusVat        B                     export
000000221013     DGetCusVat        PI                   like(cuvat)
000000221013     D P_CUID                         5  0  value
000000221013      /free
000000221013         chainCUSTOME1(P_CUID
000000221013               );
000000221013         return CUVAT;
000000221013      /end-free
000000221013     pGetCusVat        e
000000000000      *=============================================
000000000000     PGetCusMail       B                     export
000000161027     DGetCusMail       PI                   like(cumail)
000000161025     D P_CUID                         5  0  value
000000000000      /free
000000000000         chainCUSTOME1(P_CUID
000000000000               );
000000000000         return CUMAIL;
000000000000      /end-free
000000000000     pGetCusMail       e
000000000000      *=============================================
000000000000     PGetCusAdrline1   B                     export
000000161027     DGetCusAdrline1   PI                   like(culine1)
000000161025     D P_CUID                         5  0  value
000000000000      /free
000000000000         chainCUSTOME1(P_CUID
000000000000               );
000000000000         return CULINE1;
000000000000      /end-free
000000000000     pGetCusAdrline1   e
000000000000      *=============================================
000000000000     PGetCusAdrline2   B                     export
000000161027     DGetCusAdrline2   PI                   like(culine2)
000000161025     D P_CUID                         5  0  value
000000000000      /free
000000000000         chainCUSTOME1(P_CUID
000000000000               );
000000000000         return CULINE2;
000000000000      /end-free
000000000000     pGetCusAdrline2   e
000000000000      *=============================================
000000000000     PGetCusAdrline3   B                     export
000000161027     DGetCusAdrline3   PI                   like(culine3)
000000161025     D P_CUID                         5  0  value
000000000000      /free
000000000000         chainCUSTOME1(P_CUID
000000000000               );
000000000000         return CULINE3;
000000000000      /end-free
000000000000     pGetCusAdrline3   e
000000000000      *=============================================
000000000000     PGetCusZip        B                     export
000000161027     DGetCusZip        PI                   like(cuzip)
000000161025     D P_CUID                         5  0  value
000000000000      /free
000000000000         chainCUSTOME1(P_CUID
000000000000               );
000000000000         return CUZIP;
000000000000      /end-free
000000000000     pGetCusZip        e
000000000000      *=============================================
000000000000     PGetCusCity       B                     export
000000161027     DGetCusCity       PI                   like(cucity)
000000161025     D P_CUID                         5  0  value
000000000000      /free
000000000000         chainCUSTOME1(P_CUID
000000000000               );
000000000000         return CUCITY;
000000000000      /end-free
000000000000     pGetCusCity       e
000000000000      *=============================================
000000000000     PGetCusCountry    B                     export
000000161027     DGetCusCountry    PI                   like(cucoun)
000000161025     D P_CUID                         5  0  value
000000000000      /free
000000000000         chainCUSTOME1(P_CUID
000000000000               );
000000000000         return CUCOUN;
000000000000      /end-free
000000000000     pGetCusCountry    e
000000000000      *=============================================
000000000000     PGetCusLimCredit  B                     export
000000161027     DGetCusLimCredit  PI                   like(culimcre)
000000161025     D P_CUID                         5  0  value
000000000000      /free
000000000000         chainCUSTOME1(P_CUID
000000000000               );
000000000000         return CULIMCRE;
000000000000      /end-free
000000000000     pGetCusLimCredit  e
000000000000      *=============================================
000000000000     PGetCusCredit     B                     export
000000161027     DGetCusCredit     PI                   like(cucredit)
000000161025     D P_CUID                         5  0  value
000000000000      /free
000000000000         chainCUSTOME1(P_CUID
000000000000               );
000000000000         return CUCREDIT;
000000000000      /end-free
000000000000     pGetCusCredit     e
000000161219      *=============================================
000000161219      // Remove the comment (//) to test the addition of a function
000000161219      // PGetCusLastOrdDate...
000000161219      // P                 B                     export
000000161219      // dGetCusLastOrdDate...
000000161219      // D                 PI                   like(culastord)
000000161219      // D P_CUID                         5  0  value
000000161219      //  /free
000000161219      //   chainCUSTOME1(P_CUID
000000161219      //         );
000000161219      //   return CULastOrd;
000000161219      //  /end-free
000000161219      // p                 e
000000161025      *=============================================
000000161025     P ExistCus        B                     export
000000161025     D ExistCus        PI              n
000000161025     D P_CUID                         5  0  value
000000161025      /free
000000161025         chainCUSTOME1(P_CUID
000000161025               );
000000161025         return %found(custome1) and CUDEL <> 'X';
000000161025      /end-free
000000161025     p ExistCus        e
000000161025
000000000000      *=============================================
000000000000     PIsCusDeleted     B                     export
000000161025     DIsCusDeleted     PI              n
000000161025     D P_CUID                         5  0  value
000000000000      /free
000000000000         chainCUSTOME1(P_CUID
000000000000               );
000000161025         return CUDEL = 'X';
000000000000      /end-free
000000000000     pIsCusDeleted     e
000000000000
000000000000     p chainCUSTOME1   b
000000000000     d chainCUSTOME1   pi
000000161025     D P_CUID                         5  0  value
000000000000      /free
000000000000        if not %open(CUSTOME1);
000000000000          open CUSTOME1;
000000000000        endif;
000000000000         if P_CUID <> CUID;
000000000000           K_CUID =  P_CUID;
000000000000           clear *all FCUST;
000000000000           chain kf CUSTOME1;
000000000000         endif;
000000000000      /end-free
000000000000     p chainCUSTOME1   e
000000000000
000000000000     p closeCUSTOME1   b
000000000000     d closeCUSTOME1   pi
000000000000      /free
000000000000        if %open(CUSTOME1);
000000000000          close CUSTOME1;
000000000000        endif;
000000000000      /end-free
000000000000     p closeCUSTOME1   e
000000000000
000000000000
