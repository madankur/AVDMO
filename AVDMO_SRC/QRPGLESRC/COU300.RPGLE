000000000000     h nomain
000000000000
000000000000     FCOUNTRY   if   e           k disk    usropn
000000000000
000000000000      /copy qprotosrc,COUNTRY
000000000000
000000000000     d chainCOUNTRY    pr
000000000000     D P_COID                         2A    value
000000000000
000000000000     D K_COID          S                   LIKE(COID)
000000000000
000000000000     C     kf            klist
000000000000     C                   KFLD                    K_COID
000000000000
000000000000      *=============================================
000000161027     PGetCountryName   B                     export
000000161027     DGetCountryName   PI                   like(countr)
000000000000     D P_COID                         2A    value
000000000000      /free
000000000000         chainCOUNTRY(P_COID
000000000000               );
000000000000         return COUNTR;
000000000000      /end-free
000000000000     pGetCountryName   e
000000000000      *=============================================
000000000000     PGetCountryIso3   B                     export
000000161027     DGetCountryIso3   PI                   like(coiso)
000000000000     D P_COID                         2A    value
000000000000      /free
000000000000         chainCOUNTRY(P_COID
000000000000               );
000000000000         return COISO;
000000000000      /end-free
000000000000     pGetCountryIso3   e
000000000000
000000161025      *=============================================
000000161025     P ExistCountry    B                     export
000000161025     D ExistCountry    PI              n
000000161025     D P_COID                         2A    value
000000161025      /free
000000161025         chainCOUNTRY(P_COID
000000161025               );
000000161025         return %found(country);
000000161025      /end-free
000000161025     p ExistCountry    e
000000161025
000000000000     p chainCOUNTRY    b
000000000000     d chainCOUNTRY    pi
000000000000     D P_COID                         2A    value
000000000000      /free
000000000000        if not %open(COUNTRY);
000000000000          open COUNTRY;
000000000000        endif;
000000000000         if P_COID <> COID;
000000000000           K_COID =  P_COID;
000000000000           clear *all FCOUN;
000000000000           chain kf COUNTRY;
000000000000         endif;
000000000000      /end-free
000000000000     p chainCOUNTRY    e
000000000000
000000000000     p closeCOUNTRY    b
000000000000     d closeCOUNTRY    pi
000000000000      /free
000000000000        if %open(COUNTRY);
000000000000          close COUNTRY;
000000000000        endif;
000000000000      /end-free
000000000000     p closeCOUNTRY    e
000000000000
000000000000
