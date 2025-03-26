000000000000     h nomain
000000000000
000000000000     FFAMILLY   if   e           k disk    usropn
000000000000
000000000000      /copy qprotosrc,FAMILLY
000000000000
000000000000     d chainFAMILLY    pr
000000161025     D P_FAID                         3     value
000000000000
000000000000     D K_FAID          S                   LIKE(FAID)
000000000000
000000000000     C     kf            klist
000000000000     C                   KFLD                    K_FAID
000000000000
000000000000      *=============================================
000000000000     PGetArtFamDesc    B                     export
000000161027     DGetArtFamDesc    PI                   like(fadesc)
000000161025     D P_FAID                         3     value
000000000000      /free
000000000000         chainFAMILLY(P_FAID
000000000000               );
000000000000         return FADESC;
000000000000      /end-free
000000000000     pGetArtFamDesc    e
000000000000      *=============================================
000000161025     P ExistArtFam     B                     export
000000161025     D ExistArtFam     PI              n
000000161025     D P_FAID                         3     value
000000000000      /free
000000000000         chainFAMILLY(P_FAID
000000000000               );
000000161025         return %found(familly);
000000000000      /end-free
000000161025     p ExistArtFam     e
000000000000
000000161025      *=============================================
000000161025     PIsArtFamDeleted  B                     export
000000161025     DIsArtFamDeleted  PI              n
000000161025     D P_FAID                         3     value
000000161025      /free
000000161025         chainFAMILLY(P_FAID
000000161025               );
000000161025         return FADEL = 'X';
000000161025      /end-free
000000161025     pIsArtFamDeleted  e
000000161025
000000000000     p chainFAMILLY    b
000000000000     d chainFAMILLY    pi
000000161025     D P_FAID                         3     value
000000000000      /free
000000000000        if not %open(FAMILLY);
000000000000          open FAMILLY;
000000000000        endif;
000000000000         if P_FAID <> FAID;
000000000000           K_FAID =  P_FAID;
000000000000           clear *all FFAMI;
000000000000           chain kf FAMILLY;
000000000000         endif;
000000000000      /end-free
000000000000     p chainFAMILLY    e
000000000000
000000000000     p closeFAMILLY    b
000000000000     d closeFAMILLY    pi
000000000000      /free
000000000000        if %open(FAMILLY);
000000000000          close FAMILLY;
000000000000        endif;
000000000000      /end-free
000000000000     p closeFAMILLY    e
000000000000
000000000000
