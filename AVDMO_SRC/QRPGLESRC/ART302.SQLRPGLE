000000170303     h nomain
000000170303
000000170303      /copy qprotosrc,ARTICLE
000000170303
000000170303     d savInfo         s           1520
000000170303     d savId           s              6
000000170303      *=============================================
000000170303     PGetArtInfo       B                     export
000000170303     DGetArtInfo       PI          1520
000000170303     D P_ARID                         6A    value
000000170303      /free
000000170303         if P_arid <> savId;
000000170303           savid = p_arid;
000000170303           exec sql select artinf into :savinfo
000000170303              from artiinf
000000170303              where arid = :savid;
000000170303         endif;
000000170303
000000170303         return savinfo;
000000170303      /end-free
000000170303     pGetArtInfo       e
