000000161209     h nomain
000000161209
000000161209     FPARAMETER if   e           k disk    usropn
000000161209
000000161209      /copy qprotosrc,PARAMETER
000000161209
000000161209     d chainPARAMETER  pr
000000161209     D P_PACODE                      10A    value
000000161209     D P_PASUBCODE                   10A    value
000000161209
000000161209     D K_PACODE        S                   LIKE(PACODE)
000000161209     D K_PASUBCODE     S                   LIKE(PASUBCODE)
000000161209
000000161209     C     kf            klist
000000161209     C                   KFLD                    K_PACODE
000000161209     C                   KFLD                    K_PASUBCODE
000000161209
000000161209      *=============================================
000000161209     PGetPARM1         B                     export
000000161209     DGetPARM1         PI            10A
000000161209     D P_PACODE                      10A    value
000000161209     D P_PASUBCODE                   10A    value
000000161209      /free
000000161209         chainPARAMETER(P_PACODE
000000161209               :P_PASUBCODE);
000000161209
000000161209         return PARM1;
000000161209      /end-free
000000161209     pGetPARM1         e
000000161209      *=============================================
000000161209     PGetPARM2         B                     export
000000161209     DGetPARM2         PI           100A
000000161209     D P_PACODE                      10A    value
000000161209     D P_PASUBCODE                   10A    value
000000161209      /free
000000161209         chainPARAMETER(P_PACODE
000000161209               :P_PASUBCODE);
000000161209
000000161209         return PARM2;
000000161209      /end-free
000000161209     pGetPARM2         e
000000161209      *=============================================
000000161209     PGetPARM3         B                     export
000000161209     DGetPARM3         PI             2A
000000161209     D P_PACODE                      10A    value
000000161209     D P_PASUBCODE                   10A    value
000000161209      /free
000000161209         chainPARAMETER(P_PACODE
000000161209               :P_PASUBCODE);
000000161209
000000161209         return PARM3;
000000161209      /end-free
000000161209     pGetPARM3         e
000000161209      *=============================================
000000161209     PGetPARM4         B                     export
000000161209     DGetPARM4         PI             1P 0
000000161209     D P_PACODE                      10A    value
000000161209     D P_PASUBCODE                   10A    value
000000161209      /free
000000161209         chainPARAMETER(P_PACODE
000000161209               :P_PASUBCODE);
000000161209
000000161209         return PARM4;
000000161209      /end-free
000000161209     pGetPARM4         e
000000161209      *=============================================
000000161209     PGetPARM5         B                     export
000000161209     DGetPARM5         PI             3P 0
000000161209     D P_PACODE                      10A    value
000000161209     D P_PASUBCODE                   10A    value
000000161209      /free
000000161209         chainPARAMETER(P_PACODE
000000161209               :P_PASUBCODE);
000000161209
000000161209         return PARM5;
000000161209      /end-free
000000161209     pGetPARM5         e
000000221013      *=============================================
000000221013     PExistParm        B                     export
000000221013     DExistParm        PI             1n
000000221013     D P_PACODE                      10A    value
000000221013     D P_PASUBCODE                   10A    value
000000221013      /free
000000221013         chainPARAMETER(P_PACODE
000000221013               :P_PASUBCODE);
000000221013
000000221013         return %found();
000000221013      /end-free
000000221013     pExistParm        e
000000161209
000000161209     p chainPARAMETER  b
000000161209     d chainPARAMETER  pi
000000161209     D P_PACODE                      10A    value
000000161209     D P_PASUBCODE                   10A    value
000000161209      /free
000000161209        if not %open(PARAMETER);
000000161209          open PARAMETER;
000000161209        endif;
000000161209         if P_PACODE <> PACODE
000000161209           or P_PASUBCODE <> PASUBCODE;
000000161209           K_PACODE =  P_PACODE;
000000161209           K_PASUBCODE =  P_PASUBCODE;
000000161209           clear *all FPARAM;
000000161209           chain kf PARAMETER;
000000161209         endif;
000000161209      /end-free
000000161209     p chainPARAMETER  e
000000161209
000000161209     p closePARAMETER  b
000000161209     d closePARAMETER  pi
000000161209      /free
000000161209        if %open(PARAMETER);
000000161209          close PARAMETER;
000000161209        endif;
000000161209      /end-free
000000161209     p closePARAMETER  e
000000161209
000000161209
