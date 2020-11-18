DATA I TYPE INT1.

IF EVENT_ID EQ 'save'.

  DATA WT TYPE ZEXAM.
  CLEAR WT.

* ID 중복 체크
  SELECT SINGLE *
    FROM ZEXAM
    INTO CORRESPONDING FIELDS OF WT
    WHERE ID = P_ID.

* 평균 계산
    IF P_FTESTR2 = 0.
      I = P_MTESTR1 + P_FTESTR1 + P_MTESTR2.
      WT-PREDICT = I / 3 .
      CLEAR I.
    ENDIF.

    IF P_MTESTR2 = 0 AND P_FTESTR2 = 0.
      I = P_MTESTR1 + P_FTESTR1.
      WT-PREDICT = I / 2 .
      CLEAR I.
    ENDIF.

    IF P_FTESTR1 = 0 AND P_MTESTR2 = 0 AND P_FTESTR2 = 0.
      WT-PREDICT = P_MTESTR1 .
    ENDIF.

    IF P_MTESTR1 = 0 AND P_FTESTR1 = 0 AND P_MTESTR2 = 0 AND P_FTESTR2 = 0.
      WT-PREDICT = 0.
    ENDIF.

    IF P_MTESTR1 <> 0 AND P_FTESTR1 <> 0 AND P_MTESTR2 <> 0 AND P_FTESTR2 <> 0.
      I = P_MTESTR1 + P_FTESTR1 + P_MTESTR2 + P_FTESTR2.
      WT-PREDICT = I / 4 .
      CLEAR I.
    ENDIF.

    WT-NAME = P_NAME.
    WT-MTEST1 = P_MTEST1.
    WT-MTESTR1 = P_MTESTR1.
    WT-FTEST1 = P_FTEST1.
    WT-FTESTR1 = P_FTESTR1.
    WT-MTEST2 = P_MTEST2.
    WT-MTESTR2 = P_MTESTR2.
    WT-FTEST2 = P_FTEST2.
    WT-FTESTR2 = P_FTESTR2.
    WT-MO_DATE = SY-DATUM.
    WT-MO_USER = SY-UNAME.

    UPDATE ZEXAM FROM WT.


    IF SY-SUBRC EQ 0.
      COMMIT WORK.
      PAGE->WRITE( `<script language=javascript>alert('저장되었습니다..');`).
      PAGE->WRITE( ` window.close();`).
      PAGE->WRITE( ` opener.doSearch();`).
      PAGE->WRITE( `</script>`).
    ELSE.
      ROLLBACK WORK.
      PAGE->WRITE( `<script language=javascript>alert('`).
      PAGE->WRITE( `Database Error.` ).
      PAGE->WRITE( `');</script>`).
    ENDIF.

ENDIF.