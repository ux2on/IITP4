IF EVENT_ID EQ 'save'.

    DATA WT TYPE ZSTUDENT.
  
    SELECT SINGLE *
      FROM ZSTUDENT
      INTO CORRESPONDING FIELDS OF WT
      WHERE ID = P_ID.
  
    WT-ID = P_ID.
    WT-SCHOOL = P_SCHOOL.
    WT-GRADE = P_GRADE.
    WT-NAME = P_NAME.
    WT-CLASS = P_CLASS.
    WT-BIRTH = P_BIRTH.
    WT-ADDRESS = P_ADDRESS.
    WT-CONTACT = P_CONTACT.
    WT-CONTACT2 = P_CONTACT2.
  
    WT-MO_DATE = SY-DATUM.
    WT-MO_USER = SY-UNAME.
  
    UPDATE ZSTUDENT FROM WT.
  
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