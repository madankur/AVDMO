000000161129
000000161129     h dftactgrp(*no) bnddir('SAMPLE')
000000161129
000000161129
000000161201     forder1    uf   e           k disk
000000161201     fdetord1   uf   e           k disk
000000161201     ford101d   cf   e             workstn
000000161128     F                                     indds(indds)
000000161128     F                                     sfile(sfl01:rrn01)
000000161128     F                                     Infds(Info)
000000161128
000000161129      /copy qprotosrc,customer
000000161129      /copy qprotosrc,article
000000161129      /copy qprotosrc,vat
000000161129
000000161201     d  ord101         pr
000000161201     d   id
000000161201     d                                     like(orid)
000000161128
000000161201     d  ord101         pi
000000161201     d   id
000000161201     d                                     like(orid)
000000161129
000000161129     d Prtord          pr                  extpgm('ORD500')
000000161129     d  x                                  like(orid)
000000161128
000000161128     D info            ds
000000161128     D  lrrn                 378    379i 0
000000161128
000000161128     D indds           ds
000000161128     D  help                   1      1n
000000161128     D  exit                   3      3n
000000161128     D  prompt                 4      4n
000000161128     D  refresh                5      5n
000000161129     D  create                 6      6n
000000161129     D  confirm                8      8n
000000161128     D  cancel                12     12n
000000161128     D  morekeys              24     24n
000000161128     D  pagedown              25     25n
000000161129     D  change                27     27n
000000161128     D  sflclr                30     30n
000000161128     D  sfldsp                31     31n
000000161128     D  sfldspctl             32     32n
000000161128     D  sflnxtchg             33     33n
000000161128     D  dspatr_ri             34     34n
000000161128     D  sflmsg                35     35n
000000161129     D  sflmsg2               36     36n
000000161201     D  ErrQtyLiv             37     37n
000000161201     D  ErrQty                38     38n
000000161128     D  sflend                80     80n
000000161129
000000161128     D panel           S              3  0 INZ(1)
000000161128     D step01          S              3    inz(prp)
000000161129     D step02          S              3    inz(prp)
000000161128     D rrn01           s              5i 0
000000161129     D count           s              3  0
000000161128     D err01           s               n
000000161128
000000161128     d prp             c                   'prp'
000000161128     d lod             c                   'lod'
000000161128     d dsp             c                   'dsp'
000000161128     d key             c                   'key'
000000161128     d chk             c                   'chk'
000000161128     d act             c                   'act'
000000161129      /free
000000161129        select;
000000161129        when panel = 1;
000000161129          exsr pnl01;
000000161129        when panel = 2;
000000161129          exsr pnl02;
000000161129        other;
000000161129          exsr pnl00;
000000161129        endsl;
000000161129        //- Subfiles  01 Subroutines --------------------------------------  ---
000000161129        begsr pnl01;
000000161129          select ;
000000161129          when step01 = prp ;
000000161129            exsr s01prp;
000000161129          when step01 = lod ;
000000161129            exsr s01lod;
000000161129          when step01 = dsp ;
000000161129            exsr s01dsp;
000000161129          when step01 = key ;
000000161129            exsr s01key;
000000161129          when step01 = chk ;
000000161129            exsr s01chk;
000000161129          when step01 = act ;
000000161129            exsr s01act ;
000000161129          endsl;
000000161129        endsr;
000000161129        //--- Clear Subfile  ----------------------------------------------------
000000161129        begsr s01prp;
000000161129          RRn01 = 0;
000000161129          sflclr = *on;
000000161129          write ctl01;
000000161129          sflclr = *off;
000000161129          step01 = lod;
000000161201          tot = 0;
000000161201          totvat = 0;
000000161129        endsr;
000000161129        //--- Load Subfile  -----------------------------------------------------
000000161129        begsr s01lod;
000000161129          RRb01 = RRn01 + 1;
000000161129          opt01 = 0;
000000161201          setll id    detord1;
000000161201          reade(n)  id detord1;
000000161129          dow not %eof;
000000161201            tot += odtot;
000000161201            totvat += odtotvat;
000000161129            RRN01 = RRN01 + 1;
000000161129            artdesc = GetArtDesc(odarid);
000000161129            write sfl01;
000000161201            reade(n)  id detord1;
000000161129          enddo;
000000161129          sflend = *on;
000000161129          step01 = dsp;
000000161129        endsr;
000000161129        //--- Display Subfile  --------------------------------------------------
000000161129        begsr s01dsp;
000000161129          sfldspctl = *on;
000000161129          sfldsp = RRn01 > 0;
000000161128
000000161129          write key01;
000000161129          exfmt ctl01;
000000161129          if LRRN <>0;
000000161129            RRb01 = LRRN;
000000161129          endif;
000000161129          step01 = key;
000000161129        endsr;
000000161129        //--- Command Keys  -----------------------------------------------------
000000161129        begsr s01key;
000000161129          select;
000000161129          when exit;
000000161129            panel  = 0;
000000161129            step01 = prp;
000000161129          when cancel;
000000161129            step01 = prp;
000000161129            panel  = panel  - 1;
000000161129          when refresh;
000000161129            step01 = prp;
000000161129          other;
000000161129            step01 = chk;
000000161129          endsl;
000000161129        endsr;
000000161129        //--- Check Subfile  ----------------------------------------------------
000000161129        begsr s01chk;
000000161129          step01 = act;
000000161129          err01 = *off;
000000161129          sflnxtchg = *on;
000000161129          readc(e) sfl01;
000000161129          dow not %error and not %eof;
000000161201            if opt01 <> 0 and opt01 <> 2 and opt01 <> 4 and opt01 <> 6;
000000161129              step01 = dsp;
000000161129              dspatr_ri = *on;
000000161129              sflmsg = *on;
000000161129              if not err01;
000000161129                rrb01 = rrn01;
000000161129                err01 = *on;
000000161129              endif;
000000161129            endif;
000000161201            if opt01 =  4 and odqtyliv > 0 ;
000000161129              step01 = dsp;
000000161129              dspatr_ri = *on;
000000161129              sflmsg2 = *on;
000000161129              if not err01;
000000161129                rrb01 = rrn01;
000000161129                err01 = *on;
000000161129              endif;
000000161129            endif;
000000161129            update sfl01;
000000161129            dspatr_ri = *off;
000000161129            readc(e) sfl01;
000000161129          enddo;
000000161129          sflnxtchg = *off;
000000161129        endsr;
000000161129        //--- action Subfile  ---------------------------------------------------
000000161129        begsr s01act;
000000161129          readc(e) sfl01;
000000161129          select;
000000161129          when %error or %eof;
000000161129            step01 = dsp;
000000161129          when opt01 = 2;
000000161129             panel = 2;
000000161129             step02 = prp;
000000161129          when opt01 = 4;
000000161201            tot -= odtot;
000000161201            totvat -= odtotvat;
000000161201            delete (id:odline) detord1;
000000161201            opt01 = 0;
000000161201            odarid = ' ';
000000161201            odqty = 0;
000000161201            odprice = 0;
000000161201            odtot = 0;
000000161201            artdesc = '**** Delete ***';
000000161201            update sfl01;
000000161129          endsl;
000000161129        endsr;
000000161129        //--- Format 02 Subroutines ------------------------------------     ---
000000161129        begsr pnl02;
000000161129          select ;
000000161129          when step02 = prp ;
000000161129            exsr s02prp;
000000161129          when step02 = dsp ;
000000161129            exsr s02dsp;
000000161129          when step02 = key ;
000000161129            exsr s02key;
000000161129          when step02 = chk ;
000000161129            exsr s02chk;
000000161129          when step02 = act ;
000000161129            exsr s02act ;
000000161129          endsl;
000000161128
000000161129        endsr;
000000161129        //--- clear & Load ------------------------------------------------------
000000161129        begsr S02prp;
000000161201          chain (id:odline) detord1;
000000161201          dsqty = odqty;
000000161201          dsqtyliv = odqtyliv;
000000161201          dsprice = odprice;
000000161129          artdesc = GetArtDesc(odarid);
000000161129          vat = CLCVat(GetArtVatCode(odarid):odtot);
000000161129          odtotvat = odtot + vat;
000000161129          vatRate = GetVatRate(GetArtVatCode(odarid));
000000161129          step02 = dsp;
000000161129        endsr;
000000161129        //--- Display  ----------------------------------------------------------
000000161129        begsr S02dsp;
000000161129          exfmt fmt02;
000000161129          step02 = key;
000000161129        endsr;
000000161129        //--- command Keys  -----------------------------------------------------
000000161129        begsr S02key;
000000161129          select;
000000161129          when exit;
000000161129            panel  = 1;
000000161129            step02 = prp;
000000161129          when cancel;
000000161129            step02 = prp;
000000161129            panel  = panel  - 1;
000000161129          other;
000000161129            step02 = chk;
000000161129          endsl;
000000161129        endsr;
000000161129        //--- check -------------------------------------------------------------
000000161129        begsr S02chk;
000000161129          step02 = act;
000000161201          if dsqtyliv > odqty;
000000161201            errqtyliv = *on;
000000161201            step02 = dsp;
000000161201          endif;
000000161201          if dsqty < odqtyliv;
000000161201            errqty = *on;
000000161201            step02 = dsp;
000000161201          endif;
000000161201          odtot =  dsqty * dsprice;
000000161129          vat = CLCVat(GetArtVatCode(odarid):odtot);
000000161129          odtotvat = odtot + vat;
000000161129        endsr;
000000161129        //--- Action ------------------------------------------------------------
000000161129        begsr S02act;
000000161129          if change;
000000161129            step02 = dsp;
000000161129          else;
000000161201            odqty = dsqty;
000000161201            odqtyliv = dsqtyliv;
000000161201            odprice = dsprice;
000000161201            update fdeto;
000000161201            opt01 = 0;
000000161201            update sfl01;
000000161201            step01 = dsp;
000000161129            panel = 1;
000000161129          endif;
000000161129        endsr;
000000161128
000000161128
000000161128
000000161129        //--------INITIALIZATION ----------------------------------
000000161129        begsr *inzsr;
000000161201          chain id order1;
000000161201          CUSTNAME = GetCusName(orcuid);
000000161129
000000161129        endsr;
000000161129        //--------END SUBROUTINE ----------------------------------
000000161129        begsr pnl00;
000000161129          *inlr = *on;
000000161129        endsr;
000000161129      /end-free
000000161129
