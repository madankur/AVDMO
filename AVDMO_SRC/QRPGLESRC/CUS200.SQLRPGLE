000000221013**FREE
000000161025
000000221013  Ctl-Opt dftactgrp(*no) bnddir('SAMPLE');
000000161025
000000221013  Dcl-F custome2   Keyed rename(fcust:fcust2);
000000221013  Dcl-F custome1   Usage(*Update:*Delete:*Output) Keyed;
000000221013  Dcl-F cus200d    WORKSTN
000000221013                           indds(indds)
000000221013                           sfile(sfl01:rrn01)
000000221013                           Infds(Info);
000000161025
000000221013  /copy qprotosrc,country
000000221013  /copy qprotosrc,parameter
000000161025
000000221013  Dcl-Pr orders extpgm('ORD200');
000000221013    id              like(cuid);
000000221013  End-Pr;
000000161027
000000221013  Dcl-Ds indds;
000000221013    help            Ind             Pos(1);
000000221013    exit            Ind             Pos(3);
000000221013    prompt          Ind             Pos(4);
000000221013    refresh         Ind             Pos(5);
000000221013    create          Ind             Pos(6);
000000221013    cancel          Ind             Pos(12);
000000221013    GetPrivilege    Ind             Pos(13);
000000221013    morekeys        Ind             Pos(24);
000000221013    pagedown        Ind             Pos(25);
000000221013    sflclr          Ind             Pos(30);
000000221013    sfldsp          Ind             Pos(31);
000000221013    sfldspctl       Ind             Pos(32);
000000221013    sflnxtchg       Ind             Pos(33);
000000221013    dspatr_ri       Ind             Pos(34);
000000221013    sflmsg          Ind             Pos(35);
000000221013    ErrCountry      Ind             Pos(40);
000000221013    ErrName         Ind             Pos(41);
000000221013    ErrDup          Ind             Pos(42);
000000221013    ErrPhone        Ind             Pos(43);
000000221013    ErrPhoneNum     Ind             Pos(44);
000000221013    ErrCategory     Ind             Pos(45);
000000221013    InvalidPassword Ind             Pos(46);
000000221013    privilegedUser  ind             pos(50);
000000221013    sflend          Ind             Pos(80);
000000221013  End-Ds;
000000161025
000000221013  Dcl-Ds info;
000000221013    lrrn            Int(5)          Pos(378);
000000221013  End-Ds;
000000161025
000000221013  Dcl-S rrn01           Int(5);
000000221013  Dcl-S rrs01           Int(5);
000000221013  Dcl-S err01           Ind;
000000161025
000000221013  Dcl-S panel           Int(3)          INZ(1);
000000221013  Dcl-S step01          Char(3)         inz(prp);
000000221013  Dcl-S step02          Char(3)         inz(prp);
000000221013  Dcl-S step03          Char(3)         inz(prp);
000000221013  Dcl-S savId           like(cuid);
000000221013  Dcl-S savName         like(custnm);
000000221013  Dcl-S User            Char(10)        inz(*user);
000000221013  Dcl-S count           Int(3);
000000221013  Dcl-S dup             Int(3);
000000221013  dcl-s privilege       int(3);
000000221013
000000221012
000000221013  Dcl-C crt             'CRT';
000000221013  Dcl-C upd             'UPD';
000000221013  Dcl-C prp             'prp';
000000221013  Dcl-C lod             'lod';
000000221013  Dcl-C dsp             'dsp';
000000221013  Dcl-C key             'key';
000000221013  Dcl-C chk             'chk';
000000221013  Dcl-C act             'act';
000000221013  Dcl-C datBlank        d'1940-01-01';
000000221013  select;
000000221013  when panel = 1;
000000221013    exsr pnl01;
000000221013  when panel = 2;
000000221013    exsr pnl02;
000000221013  when panel = 3;
000000221013    exsr pnl03;
000000221013  other;
000000221013    exsr pnl00;
000000221013  endsl;
000000221013  //- Subfiles  01 Subroutines --------------------------------------  ---
000000221013  begsr pnl01;
000000221013    select ;
000000221013    when step01 = prp ;
000000221013      exsr s01prp;
000000221013    when step01 = lod ;
000000221013      exsr s01lod;
000000221013    when step01 = dsp ;
000000221013      exsr s01dsp;
000000221013    when step01 = key ;
000000221013      exsr s01key;
000000221013    when step01 = chk ;
000000221013      exsr s01chk;
000000221013    when step01 = act ;
000000221013      exsr s01act ;
000000221013    endsl;
000000221013  endsr;
000000221013  //--- Clear Subfile  ----------------------------------------------------
000000221013  begsr s01prp;
000000221013    RRn01 = 0;
000000221013    sflclr = *on;
000000221013    write ctl01;
000000221013    sflclr = *off;
000000221013    step01 = lod;
000000221013    clear savid;
000000221013    savName = posTo;
000000221013    clear posTo;
000000221013    rrs01 = 0;
000000221013  endsr;
000000221013  //--- Load Subfile  -----------------------------------------------------
000000221013  begsr s01lod;
000000221013    exsr s01rst;
000000221013    RRb01 = RRn01 + 1;
000000221013    opt01 = 0;
000000221013    count = 0;
000000221013    read custome2;
000000221013    dow not %eof(custome2) and count < 14;
000000221013      RRN01 += 1;
000000221013      count += 1;
000000221013      write sfl01;
000000221013      read custome2;
000000221013    enddo;
000000221013    sflend = %eof(custome2);
000000221013    step01 = dsp;
000000221013    exsr s01sav;
000000221013  endsr;
000000221013  //--- restore last read -------------------------------------------------
000000221013  begsr s01rst;
000000221013    setll (savName:savid)  custome2;
000000221013    rrn01 = rrs01;
000000221013  endsr;
000000221013  //--- Save last read -------------------------------------------------
000000221013  begsr s01sav;
000000221013    savid = cuid;
000000221013    savName = custNm;
000000221013    rrs01 = rrn01;
000000221013  endsr;
000000221013  //--- Display Subfile  --------------------------------------------------
000000221013  begsr s01dsp;
000000221013    sfldspctl = *on;
000000221013    sfldsp = RRn01 > 0;
000000161025
000000221013    write key01;
000000221013    exfmt ctl01;
000000221013    if LRRN <>0;
000000221013      RRb01 = LRRN;
000000221013    endif;
000000221013    step01 = key;
000000221013  endsr;
000000221013  //--- Command Keys  -----------------------------------------------------
000000221013  begsr s01key;
000000221013    select;
000000221013    when exit;
000000221013      panel  = 0;
000000221013      step01 = prp;
000000221013    when cancel;
000000221013      step01 = prp;
000000221013      panel  = panel  - 1;
000000221013    when refresh;
000000221013      step01 = prp;
000000221013    when GetPrivilege;
000000221013      exfmt wdw01;
000000221013      if cancel;
000000221013        step01 = dsp;
000000221013      elseif password = 'ARCAD';
000000221013        step01 = prp;
000000221013        exec sql set privilege = 1;
000000221019        close custome1;
000000221019        close custome2;
000000221019        open custome1;
000000221019        open custome2;
000000221013        privilegedUser = *on;
000000221013      else;
000000221013        InvalidPassword = *on;
000000221013      ENDIF;
000000221013    when create;
000000221013      step01 = dsp;
000000221013      panel  = 2;
000000221013      step02 = dsp;
000000221013      mode = CRT;
000000221013      reset fcust;
000000221013      exec sql set :Cuid  = NEXT VALUE FOR CusSeq     ;
000000221013    when pagedown;
000000221013      step01 = lod;
000000221013    other;
000000221013      step01 = chk;
000000221013    endsl;
000000221013  endsr;
000000221013  //--- Check Subfile  ----------------------------------------------------
000000221013  begsr s01chk;
000000221013    step01 = act;
000000221013    err01 = *off;
000000221013    sflnxtchg = *on;
000000221013    readc(e) sfl01;
000000221013    dow not %error and not %eof;
000000221013      if opt01  <> 0 and opt01  <> 2 and opt01  <> 5 and opt01 <> 6;
000000221013        step01 = dsp;
000000221013        dspatr_ri = *on;
000000221013        sflmsg = *on;
000000221013        if not err01;
000000221013          rrb01 = rrn01;
000000221013          err01 = *on;
000000221013        endif;
000000221013      endif;
000000221013      if opt01  = 2 and not privilegedUser;
000000221013        step01 = dsp;
000000221013        dspatr_ri = *on;
000000221013        sflmsg = *on;
000000221013        if not err01;
000000221013          rrb01 = rrn01;
000000221013          err01 = *on;
000000221013        endif;
000000221013      endif;
000000221013      update sfl01;
000000221013      dspatr_ri = *off;
000000221013      readc(e) sfl01;
000000221013    enddo;
000000221013    sflnxtchg = *off;
000000221013  endsr;
000000221013  //--- action Subfile  ---------------------------------------------------
000000221013  begsr s01act;
000000221013    readc(e) sfl01;
000000221013    select;
000000221013    when %error or %eof;
000000221013      if posto <> ' ';
000000221013        step01 = prp;
000000221013      else;
000000221013        step01 = dsp;
000000221013      endif;
000000221013    when opt01 = 2;
000000221013      mode = upd;
000000221013      panel = 2;
000000221013      step02 = prp;
000000221013      opt01 = 0;
000000221013      update sfl01;
000000221013    when opt01 = 5;
000000221013      panel = 3;
000000221013      step03 = prp;
000000221013      opt01 = 0;
000000221013      update sfl01;
000000221013    when opt01 = 6;
000000221013      orders(cuid);
000000221013      opt01 = 0;
000000221013      update sfl01;
000000221013    other;
000000161025
000000221013    endsl;
000000221013  endsr;
000000161025
000000161025
000000221013  //--- Format 02 Subroutines ------------------------------------     ---
000000221013  begsr pnl02;
000000221013    select ;
000000221013    when step02 = prp ;
000000221013      exsr s02prp;
000000221013    when step02 = dsp ;
000000221013      exsr s02dsp;
000000221013    when step02 = key ;
000000221013      exsr s02key;
000000221013    when step02 = chk ;
000000221013      exsr s02chk;
000000221013    when step02 = act ;
000000221013      exsr s02act ;
000000221013    endsl;
000000161025
000000221013  endsr;
000000221013  //--- clear & Load ------------------------------------------------------
000000221013  begsr S02prp;
000000221013    chain cuid custome1;
000000221013    // Value generated by a SQL Mask
000000221013    coname = GetCountryName(CuCoun);
000000221013    catName = GetPARM2('CUSCAT':cucat);
000000221013    if CULASTORD = 0;
000000221013      LASTORD = datBlank;
000000221013    else;
000000221013      LASTORD  =%date(CULASTORD:*iso);
000000221013    ENDIF;
000000221013    step02 = dsp;
000000221013  endsr;
000000221013  //--- Display  ----------------------------------------------------------
000000221013  begsr S02dsp;
000000221013    exfmt fmt02;
000000221013    step02 = key;
000000221013  endsr;
000000221013  //--- command Keys  -----------------------------------------------------
000000221013  begsr S02key;
000000221013    select;
000000221013    when exit;
000000221013      panel  = 1;
000000221013      step02 = prp;
000000221013    when cancel;
000000221013      step02 = prp;
000000221013      panel  = panel  - 1;
000000221013    when prompt;
000000221013      step02 = dsp;
000000221013      cucoun = SltCountry(cucoun);
000000221013      coname = GetCountryName(CuCoun);
000000221013    other;
000000221013      step02 = chk;
000000221013    endsl;
000000221013  endsr;
000000221013  //--- check -------------------------------------------------------------
000000221013  begsr S02chk;
000000221013    step02 = act;
000000221013    if not ExistCountry(cucoun);
000000221013      errCountry = *on;
000000221013      step02 = dsp;
000000221013    endif;
000000221013    if not ExistParm('CUSCAT':cucat);
000000221013      errCategory = *on;
000000221013      step02 = dsp;
000000221013    endif;
000000221013    if custnm = *blanks;
000000221013      errName = *on;
000000221013      step02 = dsp;
000000221013    endif;
000000221013    if cuphone = *blanks;
000000221013      errPhone = *on;
000000221013      step02 = dsp;
000000221013    else;
000000221013      cuphone = %trim(cuphone);
000000221013      if %check('0123456789':%trim(cuphone)) > 0;
000000221013        errPhoneNum = *on;
000000221013        step02 = dsp;
000000221013      ENDIF;
000000221013      exec sql select count(*) into :dup from customer
000000221013               where UPPER(custnm) = UPPER(:Custnm)
000000221013                 and cuphone = :cuphone ;
000000221013      if mode = CRT and dup > 0 or mode = UPD and dup > 1;
000000221013        errData = custnm + cuphone;
000000221013        errDup = *on;
000000221013        step02 = dsp;
000000221013      ENDIF;
000000221013    endif;
000000161025
000000221013  endsr;
000000221013  //--- Action ------------------------------------------------------------
000000221013  begsr S02act;
000000221013    step02 = prp;
000000221013    if mode = upd;
000000221013      update fcust;
000000221013    else;
000000221013      write fcust;
000000221013    endif;
000000221013    panel = 1;
000000221013  endsr;
000000161025
000000221013  //--- Format 03 Subroutines ------------------------------------     ---
000000221013  begsr pnl03;
000000221013    select ;
000000221013    when step03 = prp ;
000000221013      exsr s03prp;
000000221013    when step03 = dsp ;
000000221013      exsr s03dsp;
000000221013    when step03 = key ;
000000221013      exsr s03key;
000000221013    when step03 = chk ;
000000221013      exsr s03chk;
000000221013    when step03 = act ;
000000221013      exsr s03act ;
000000221013    endsl;
000000221013
000000221013  endsr;
000000221013  //--- clear & Load ------------------------------------------------------
000000221013  begsr S03prp;
000000221013    chain cuid custome1;
000000221013    catName = GetPARM2('CUSCAT':cucat);
000000221013    coname = GetCountryName(CuCoun);
000000221013    step03 = dsp;
000000221013  endsr;
000000221013  //--- Display  ----------------------------------------------------------
000000221013  begsr S03dsp;
000000221013    exfmt fmt03;
000000221013    step03 = key;
000000221013  endsr;
000000221013  //--- command Keys  -----------------------------------------------------
000000221013  begsr S03key;
000000221013    select;
000000221013    when exit;
000000221013      panel  = 1;
000000221013      step03 = prp;
000000221013    when cancel;
000000221013      step03 = prp;
000000221013      panel  = 1;
000000221013    other;
000000221013      step03 = chk;
000000221013    endsl;
000000221013  endsr;
000000221013  //--- check -------------------------------------------------------------
000000221013  begsr S03chk;
000000221013    step03 = act;
000000221013
000000221013  endsr;
000000221013  //--- Action ------------------------------------------------------------
000000221013  begsr S03act;
000000221013    step03 = prp;
000000221013    panel = 1;
000000221013  endsr;
000000221013
000000221013  //--------INITIALIZATION ----------------------------------
000000221013  begsr *inzsr;
000000221013    cumodid = user;
000000221013    cucrea = %date();
000000221013    LASTORD = datblank;
000000221013    exec sql set :privilege = privilege;
000000221013    privilegedUser = privilege = 1;
000000221013  endsr;
000000221013  //--------END SUBROUTINE ----------------------------------
000000221013  begsr pnl00;
000000221013    *inlr = *on;
000000221013    exec sql set privilege = 0;
000000221013  endsr;
