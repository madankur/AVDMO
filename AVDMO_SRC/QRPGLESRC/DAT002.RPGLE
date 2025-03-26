000000161027
000000161027      * Status Data Structure
000000161027      *
000000161027     d                sds
000000161027      * Program Name
000000161027     d stPgmName               1     10
000000161027      * Exception Error Message Text
000000161027     d stExcText              91    170
000000161027
000000161027     d isotodat40      pr                    extpgm('DAT002')
000000161027       // input
000000161027     d  dat8                          8  0
000000161027       // result
000000161027     d  date                           d
000000161027       // Null Indicator Parameters
000000161027     d  dat8_ind                      5i 0
000000161027     d  date_ind                      5i 0
000000161027       // SQL Function Parameters
000000161027       // SQL State  -  Input/Output
000000161027     d SQL_State                      5
000000161027       // Function Name    Schema.Def name - Input only
000000161027     d Function_Name                139
000000161027       // Function Specific Name - Input Only
000000161027     d Specific_Name                128
000000161027       // Message Text - Input/Output
000000161027     d Msg_Text                      70    varying
000000161027
000000161027     d isotodat40      pi
000000161027     d  dat8                          8  0
000000161027     d  date                           d
000000161027     d  dat8_ind                      5i 0
000000161027     d  date_ind                      5i 0
000000161027     d SQL_State                      5
000000161027     d Function_Name                139
000000161027     d Specific_Name                128
000000161027     d Msg_Text                      70    varying
000000161103      /free
000000161027       // Clear NULL column indicator and SQL State
000000161027       date_ind=*zero ;
000000161027       SQL_State='00000';
000000161027        //  Special values
000000161027       if dat8 = 0;
000000161027         date = D'1940-01-01';
000000161027       elseif dat8 = *Hival;
000000161027         date = D'2039-12-31';
000000161027       else;
000000161027         test(de) *iso dat8;
000000161027         if %error;
000000161027           date_ind = -1;
000000161027         else;
000000161027           date = %date(dat8:*iso);
000000161027         endif;
000000161027       endif;
000000161027       return;
000000161027
000000161027       begsr *PSSR;
000000161027         // Return error code in SQL State (38xxx)
000000161027         // Set SQL Message Text to first 70 characters of SDS exception text
000000161027
000000161027         SQL_State='38I02';
000000161027         Msg_Text=%trimr(stExcText);
000000161027         return;
000000161027       endsr;
000000161103      /end-free
