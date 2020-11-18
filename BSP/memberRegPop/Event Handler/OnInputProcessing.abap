IF EVENT_ID EQ 'save'.

    DATA WT TYPE ZSTUDENT.
    DATA WT_EXAM TYPE ZEXAM.
    CLEAR WT.
    CLEAR WT_EXAM.
  
* ID 중복 체크
      SELECT SINGLE *
      FROM ZSTUDENT
      INTO CORRESPONDING FIELDS OF WT
      WHERE ID = P_ID.
  
    IF WT IS INITIAL.
      WT-ID = P_ID.
      WT-SCHOOL = P_SCHOOL.
      WT-GRADE = P_GRADE.
      WT-NAME = P_NAME.
      WT-CLASS = P_CLASS.
      WT-BIRTH = P_BIRTH.
      WT-ADDRESS = P_ADDRESS.
      WT-CONTACT = P_CONTACT.
      WT-CONTACT2 = P_CONTACT2.
      WT-CR_DATE = SY-DATUM.
      WT-CR_USER = SY-UNAME.
  
      MODIFY ZSTUDENT FROM WT.
  
  
    IF SY-SUBRC = 0.
      WT_ZEXAM-ID = P_ID.
      WT_ZEXAM-NAME = P_NAME.
      WT_ZEXAM-CR_DATE = SY-DATUM.
      WT_ZEXAM-CR_USER = SY-UNAME.
  
      MODIFY ZEXAM FROM WT_ZEXAM.
    ENDIF.
  
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
  
    ELSE.
      PAGE->WRITE( `<script language=javascript>alert('중복된 ID입니다.');</script>`).
  
    ENDIF.
  ENDIF.