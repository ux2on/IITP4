IF EVENT_ID EQ 'excel'.
    DATA: ENTITY         TYPE REF TO IF_HTTP_ENTITY,
          FILE           TYPE XSTRING,
          CONTENT_TYPE   TYPE STRING,
          CONTENT_LENGTH TYPE STRING,
          NUM_MULTIPARTS TYPE I,
          I              TYPE I VALUE 1,
          VALUE          TYPE STRING,
          CONTENT        TYPE STRING.
  
* find multipart containing file
    NUM_MULTIPARTS = REQUEST->NUM_MULTIPARTS( ).
  
    WHILE I LE NUM_MULTIPARTS.
  
* num_multiparts.
      ENTITY = REQUEST->GET_MULTIPART( I ).
      VALUE = ENTITY->GET_HEADER_FIELD( '~content_filename' ).
  
      IF NOT VALUE IS INITIAL.
* found a file!
        NAVIGATION->SET_PARAMETER( NAME = 'content_filename' VALUE = VALUE ).
        CONTENT_TYPE = ENTITY->GET_HEADER_FIELD( 'Content-Type' ).
        NAVIGATION->SET_PARAMETER( NAME = 'content_type' VALUE = CONTENT_TYPE ).
  
* get file content
        FILE = ENTITY->GET_DATA( ).
  
* get file size
        CONTENT_LENGTH = XSTRLEN( FILE ).
        NAVIGATION->SET_PARAMETER( NAME = 'content_length' VALUE = CONTENT_LENGTH ).
      ENDIF.
      I = I + 1.
    ENDWHILE.
  
  
    DATA: CONV TYPE REF TO CL_ABAP_CONV_IN_CE.
    CONV = CL_ABAP_CONV_IN_CE=>CREATE( INPUT = FILE ENCODING = 'NON-UNICODE').
    CONV->READ( IMPORTING DATA = CONTENT ).
    CLEAR: CONV.
  
    TYPES: BEGIN OF ITAB_TYPE,
             WORD(500) TYPE C,
           END OF ITAB_TYPE.
  
    DATA: ITAB TYPE STANDARD TABLE OF ITAB_TYPE.
    DATA: WA_TMP TYPE ITAB_TYPE.
    DATA: HEXCR TYPE X VALUE '0D'.
    DATA: STRCR TYPE STRING.
  
    CONV = CL_ABAP_CONV_IN_CE=>CREATE( INPUT = HEXCR ).
    CONV->READ( IMPORTING DATA = STRCR ).
  
    DATA : LT_TMP TYPE STRING_TABLE,
           LV_TMP TYPE STRING.
  
    SPLIT CONTENT AT CL_ABAP_CHAR_UTILITIES=>CR_LF INTO TABLE LT_TMP.
  
    "=======================================================================
  
    DATA: ID       TYPE STRING,
          SCHOOL   TYPE STRING,
          GRADE    TYPE STRING,
          NAME     TYPE STRING,
          CLASS    TYPE STRING,
          BIRTH    TYPE STRING,
          ADDRESS  TYPE STRING,
          CONTACT  TYPE STRING,
          CONTACT2 TYPE STRING.
  
    DATA: LT_TABLE TYPE TABLE OF ZSTUDENT,  "결과
          WA_TABLE TYPE ZSTUDENT.
  
    DATA: WA_ERROR TYPE TYS_ERR_TABLE.  "에러
  
  
    LOOP AT LT_TMP INTO LV_TMP.
      IF SY-TABIX <> 1.  "첫번째 라인은 가져오지 않음
        SPLIT LV_TMP AT CL_ABAP_CHAR_UTILITIES=>HORIZONTAL_TAB INTO :
          ID SCHOOL GRADE NAME CLASS BIRTH ADDRESS CONTACT CONTACT2.
  
        CLEAR WA_TABLE.
        WA_TABLE-ID = ID.
        WA_TABLE-SCHOOL = SCHOOL.
        WA_TABLE-GRADE = GRADE.
        WA_TABLE-NAME = NAME.
        WA_TABLE-CLASS = CLASS.
        WA_TABLE-BIRTH = BIRTH.
        WA_TABLE-ADDRESS = ADDRESS.
        WA_TABLE-CONTACT = CONTACT.
        WA_TABLE-CONTACT2 = CONTACT2.
  
        "CHECK VALIDATION
        WA_ERROR-LINE = SY-TABIX.
        IF STRLEN( WA_TABLE-ID ) > 4.
          WA_ERROR-ERROR = 'ID는 4자 이내로 입력하세요.'.
          APPEND WA_ERROR TO GT_ERROR.
        ENDIF.
  
        IF WA_TABLE-GRADE    NE '1'
          AND WA_TABLE-GRADE NE '2'
          AND WA_TABLE-GRADE NE '3'
          AND WA_TABLE-GRADE NE '0'.
          WA_ERROR-ERROR = `학년은 1, 2, 3 중에서 입력하세요. (자퇴생은 '0' 입력)`.
          APPEND WA_ERROR TO GT_ERROR.
        ENDIF.
  
        IF WA_TABLE-CLASS     NE 'A1'
           AND WA_TABLE-CLASS NE 'A2'
           AND WA_TABLE-CLASS NE 'B1'
           AND WA_TABLE-CLASS NE 'B2'
           AND WA_TABLE-CLASS NE 'B3'
           AND WA_TABLE-CLASS NE 'C1'
           AND WA_TABLE-CLASS NE 'C2'
           AND WA_TABLE-CLASS NE 'C3'.
          WA_ERROR-ERROR = '존재하지 않는 반 입니다.'.
          APPEND WA_ERROR TO GT_ERROR.
        ENDIF.
  
  
        APPEND WA_TABLE TO GT_ZSTUDENT.
      ENDIF.
    ENDLOOP.
  
    IF GT_ZSTUDENT IS INITIAL.
      ROLLBACK WORK.
      PAGE->WRITE( `<script language=javascript>alert('`).
      PAGE->WRITE( `등록할 데이터가 없습니다.` ).
      PAGE->WRITE( `');</script>`).
    ELSE.
  
      IF GT_ERROR IS INITIAL.
        MODIFY ZSTUDENT FROM TABLE GT_ZSTUDENT.
        IF SY-SUBRC EQ 0.
          COMMIT WORK.
          PAGE->WRITE( `<script language=javascript>alert('저장되었습니다..');`).
          PAGE->WRITE( ` window.close();`).
          PAGE->WRITE( ` opener.doSearch(); `).
          PAGE->WRITE( `</script>`).
  
        ELSE.
          ROLLBACK WORK.
          PAGE->WRITE( `<script language=javascript>alert('`).
          PAGE->WRITE( `Database Error.` ).
          PAGE->WRITE( `');</script>`).
        ENDIF.
  
      ENDIF.
    ENDIF.
  ENDIF.