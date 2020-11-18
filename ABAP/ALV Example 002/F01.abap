*&---------------------------------------------------------------------*
*& Include          ZR17_0020F01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Form SET_ALV_0100
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM SET_ALV_0100 .

    IF GO_CONTAINER IS INITIAL.
* INSTANCE 생성
      PERFORM CREATE_OBJECT.
  
* 출력필드 셋팅
      PERFORM SET_FIELDCAT.
  
* 레이아웃 셋팅
      PERFORM SET_LAYOUT.
  
* EVENT 등록
      PERFORM SET_EVENT.
  
* ALV 호출
      PERFORM DISPLAY_ALV.
  
    ELSE.
      PERFORM REFRESH_DATA.
    ENDIF.
  
    DATA : LV_INPUT TYPE INT4.
  
    IF SY-TCODE = 'ZR17_0020_D'.
      LV_INPUT = 0.
    ELSE.
      LV_INPUT = 1.
    ENDIF.
  
    CALL METHOD GO_GRID->SET_READY_FOR_INPUT
      EXPORTING
        I_READY_FOR_INPUT = LV_INPUT.
  
  
  ENDFORM.
*&---------------------------------------------------------------------*
*& Form CREATE_OBJECT
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
  FORM CREATE_OBJECT .
  
* CONTAINER 생성
    CREATE OBJECT GO_CONTAINER
      EXPORTING
        CONTAINER_NAME = 'GO_CONTAINER'.
  
* GRID 생성
    CREATE OBJECT GO_GRID
      EXPORTING
        I_PARENT = GO_CONTAINER.
   
  ENDFORM.
*&---------------------------------------------------------------------*
*& Form SET_FIELDCAT
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
  FORM SET_FIELDCAT .
  
    DATA : LV_EDIT TYPE C.
  
    IF SY-TCODE = 'ZR17_0020_D'.
      LV_EDIT = ''.
    ELSE.
      LV_EDIT = 'X'.
    ENDIF.
  
    CLEAR GT_FCAT.
  
    CLEAR GS_FCAT.
    GS_FCAT-FIELDNAME = 'STAT'.
    GS_FCAT-COLTEXT   = '상태'.
    GS_FCAT-KEY       = 'X'.
    APPEND GS_FCAT TO GT_FCAT.
  
    CLEAR GS_FCAT.
    GS_FCAT-FIELDNAME = 'EMPNO'.
    GS_FCAT-COLTEXT   = '사원번호'.
    GS_FCAT-KEY       = 'X'.
    APPEND GS_FCAT TO GT_FCAT.
  
    CLEAR GS_FCAT.
    GS_FCAT-FIELDNAME = 'NAME'.
    GS_FCAT-COLTEXT   = '이름'.
    GS_FCAT-EDIT      = 'X'.
    APPEND GS_FCAT TO GT_FCAT.
  
    CLEAR GS_FCAT.
    GS_FCAT-FIELDNAME = 'DEPT'.
    GS_FCAT-COLTEXT   = '부서'.
    GS_FCAT-REF_TABLE = 'ZT00_0010'.
    GS_FCAT-EDIT      = 'X'.
    APPEND GS_FCAT TO GT_FCAT.
  
    CLEAR GS_FCAT.
    GS_FCAT-FIELDNAME = 'DEPT_T'.
    GS_FCAT-COLTEXT   = '부서내역'.
    APPEND GS_FCAT TO GT_FCAT.
  
    CLEAR GS_FCAT.
    GS_FCAT-FIELDNAME = 'ENTDT'.
    GS_FCAT-COLTEXT   = '입사일'.
    GS_FCAT-EDIT      = 'X'.
    APPEND GS_FCAT TO GT_FCAT.
  
    CLEAR GS_FCAT.
    GS_FCAT-FIELDNAME = 'GRADE'.
    GS_FCAT-COLTEXT   = '직급'.
    GS_FCAT-REF_TABLE = 'ZT00_0010'.
    GS_FCAT-EDIT      = 'X'.
    APPEND GS_FCAT TO GT_FCAT.
  
    CLEAR GS_FCAT.
    GS_FCAT-FIELDNAME = 'GRADE_T'.
    GS_FCAT-COLTEXT   = '직급내역'.
    APPEND GS_FCAT TO GT_FCAT.
  
    CLEAR GS_FCAT.
    GS_FCAT-FIELDNAME = 'RETDT'.
    GS_FCAT-COLTEXT   = '퇴사일'.
    GS_FCAT-EDIT      = 'X'.
    APPEND GS_FCAT TO GT_FCAT.
  
    CLEAR GS_FCAT.
    GS_FCAT-FIELDNAME = 'STATUS'.
    GS_FCAT-COLTEXT   = '재직구분'.
    GS_FCAT-REF_TABLE = 'ZT00_0010'.
    GS_FCAT-EDIT      = 'X'.
    APPEND GS_FCAT TO GT_FCAT.
  
    CLEAR GS_FCAT.
    GS_FCAT-FIELDNAME = 'STATUS_T'.
    GS_FCAT-COLTEXT   = '재직구분 내역'.
    APPEND GS_FCAT TO GT_FCAT.
  
    CLEAR GS_FCAT.
    GS_FCAT-FIELDNAME = 'PHONE'.
    GS_FCAT-COLTEXT   = '전화번호'.
    GS_FCAT-EDIT      = 'X'.
    APPEND GS_FCAT TO GT_FCAT.
  
    CLEAR GS_FCAT.
    GS_FCAT-FIELDNAME = 'ADDR_H'.
    GS_FCAT-COLTEXT   = '자택주소'.
    GS_FCAT-EDIT      = 'X'.
    APPEND GS_FCAT TO GT_FCAT.
  
    CLEAR GS_FCAT.
    GS_FCAT-FIELDNAME = 'ADDR_W'.
    GS_FCAT-COLTEXT   = '근무지주소'.
    GS_FCAT-EDIT      = 'X'.
    APPEND GS_FCAT TO GT_FCAT.
  
    CLEAR GS_FCAT.
    GS_FCAT-FIELDNAME = 'SALARY'.
    GS_FCAT-COLTEXT   = '기본급'.
    GS_FCAT-CFIELDNAME = 'WAERS'.
    GS_FCAT-EDIT      = 'X'.
    APPEND GS_FCAT TO GT_FCAT.
  
    CLEAR GS_FCAT.
    GS_FCAT-FIELDNAME = 'WAERS'.
    GS_FCAT-COLTEXT   = '통화'.
    APPEND GS_FCAT TO GT_FCAT.
  
    CLEAR GS_FCAT.
    GS_FCAT-FIELDNAME = 'RESULT'.
    GS_FCAT-COLTEXT   = '처리결과'.
    APPEND GS_FCAT TO GT_FCAT.
  
  ENDFORM.
*&---------------------------------------------------------------------*
*& Form SET_LAYOUT
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
  FORM SET_LAYOUT .
  
    CLEAR GS_LAYOUT.
  
    GS_LAYOUT-ZEBRA = 'X'.
    GS_LAYOUT-CWIDTH_OPT = 'A'.
    GS_LAYOUT-SEL_MODE   = 'D'.
    GS_LAYOUT-NO_ROWINS  = 'X'.
  
  ENDFORM.
*&---------------------------------------------------------------------*
*& Form DISPLAY_ALV
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
  FORM DISPLAY_ALV .
  
    CALL METHOD GO_GRID->SET_TABLE_FOR_FIRST_DISPLAY
      EXPORTING
        IS_LAYOUT       = GS_LAYOUT
      CHANGING
        IT_OUTTAB       = GT_DISP
        IT_FIELDCATALOG = GT_FCAT.
  
  
  ENDFORM.
*&---------------------------------------------------------------------*
*& Form GET_DATA
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
  FORM GET_DATA .
  
* 도메인 텍스트 조회
    PERFORM GET_DOMAIN_TEXT.
  
* 인사마스터 조회
    PERFORM GET_EMPLOYEE_MASTER.
  
* 데이터취합
    PERFORM MERGE_DATA.
  
  ENDFORM.
*&---------------------------------------------------------------------*
*& Form REFRESH_DATA
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
  FORM REFRESH_DATA .
  
    CALL METHOD GO_GRID->REFRESH_TABLE_DISPLAY.
  
  
  ENDFORM.
*&---------------------------------------------------------------------*
*& Form GET_DOMAIN_TEXT
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
  FORM GET_DOMAIN_TEXT .
  
    CLEAR : GT_GRADE, GT_DEPT, GT_STATUS.
  
    SELECT DOMVALUE_L AS CODE
           DDTEXT     AS TEXT
      INTO CORRESPONDING FIELDS OF TABLE GT_DEPT
      FROM DD07T
     WHERE DOMNAME = GC_DOM_DEPT.        "'ZD17_DEPT'.
  
    SELECT DOMVALUE_L
           DDTEXT
      INTO TABLE GT_DEPT
      FROM DD07T
     WHERE DOMNAME = GC_DOM_DEPT.        "'ZD17_DEPT'.
  
    SELECT DOMVALUE_L AS CODE
           DDTEXT     AS TEXT
      INTO CORRESPONDING FIELDS OF TABLE GT_GRADE
      FROM DD07T
     WHERE DOMNAME = GC_DOM_GRADE.       "'ZD17_GRADE'.
  
    SELECT DOMVALUE_L AS CODE
           DDTEXT     AS TEXT
      INTO CORRESPONDING FIELDS OF TABLE GT_STATUS
      FROM DD07T
     WHERE DOMNAME = GC_DOM_STATUS.      "'ZD17_STATUS'.
  
  ENDFORM.
*&---------------------------------------------------------------------*
*& Form GET_EMPLOYEE_MASTER
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
  FORM GET_EMPLOYEE_MASTER .
  
    CLEAR GT_DISP.
  
    SELECT *
      INTO CORRESPONDING FIELDS OF TABLE GT_DISP
      FROM ZT00_0010
     WHERE EMPNO  IN S_EMPNO
       AND DEPT   IN S_DEPT
       AND ENTDT  IN S_ENTDT
       AND GRADE  IN S_GRADE
       AND STATUS IN S_STATUS.
  
  ENDFORM.
*&---------------------------------------------------------------------*
*& Form MERGE_DATA
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
  FORM MERGE_DATA .
  
    FIELD-SYMBOLS : <FS_DISP> LIKE GS_DISP.
  
    SORT : GT_DEPT   BY CODE,
           GT_GRADE  BY CODE,
           GT_STATUS BY CODE.
  
    LOOP AT GT_DISP ASSIGNING <FS_DISP>.           "INTO GS_DISP.
  
      PERFORM GET_TEXT_SINGLE_LINE CHANGING <FS_DISP>.
  
      <FS_DISP>-STAT = ICON_LED_GREEN.
  
    ENDLOOP.
  
  ENDFORM.
*&---------------------------------------------------------------------*
*& Form GET_TEXT_SINGLE_LINE
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*      <--P_<FS_DISP>  text
*&---------------------------------------------------------------------*
  FORM GET_TEXT_SINGLE_LINE  CHANGING PS_DATA LIKE GS_DISP.
  
* 부서내역
    PERFORM GET_DEPT_TEXT USING     PS_DATA-DEPT
                          CHANGING  PS_DATA-DEPT_T.
  
* 직급 내역
    PERFORM GET_GRADE_TEXT USING     PS_DATA-GRADE
                           CHANGING  PS_DATA-GRADE_T.
  
* 재직구분 내역
    PERFORM GET_STATUS_TEXT USING     PS_DATA-STATUS
                            CHANGING  PS_DATA-STATUS_T.
  
  ENDFORM.
*&---------------------------------------------------------------------*
*& Form SET_EVENT
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
  FORM SET_EVENT .
  
* EVENT RECEIVER INSTANCE 생성
    CREATE OBJECT GO_EVENT_RECEIVER.
  
* ALV에 EVENT 등록
    SET HANDLER GO_EVENT_RECEIVER->HANDLE_DOUBLE_CLICK
            FOR GO_GRID.
  
    SET HANDLER GO_EVENT_RECEIVER->HANDLE_DATA_CHANGED
            FOR GO_GRID.
  
    SET HANDLER GO_EVENT_RECEIVER->HANDLE_TOOLBAR
            FOR GO_GRID.
  
    SET HANDLER GO_EVENT_RECEIVER->HANDLE_USER_COMMAND
            FOR GO_GRID.
  
** 이벤트 발생
    CALL METHOD GO_GRID->REGISTER_EDIT_EVENT
      EXPORTING
        I_EVENT_ID = CL_GUI_ALV_GRID=>MC_EVT_MODIFIED.
  
  
  ENDFORM.
*&---------------------------------------------------------------------*
*& Form HANDLE_DATA_CHANGED
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*      -->P_ER_DATA_CHANGED  text
*&---------------------------------------------------------------------*
  FORM HANDLE_DATA_CHANGED  USING    PO_DATA_CHANGED TYPE REF TO CL_ALV_CHANGED_DATA_PROTOCOL.
  
    DATA : LS_CHANGED TYPE LVC_S_MODI,
           LV_TEXT    TYPE DD07T-DDTEXT.
  
    LOOP AT PO_DATA_CHANGED->MT_GOOD_CELLS INTO LS_CHANGED.
  
      CASE LS_CHANGED-FIELDNAME.
        WHEN 'DEPT'.    
          "부서변경
          "부서명 조회
          PERFORM GET_DEPT_TEXT USING    LS_CHANGED-VALUE
                                CHANGING LV_TEXT.
  
          "ALV 및 INTERNAL TABLE 에 반영
          CALL METHOD PO_DATA_CHANGED->MODIFY_CELL
            EXPORTING
              I_ROW_ID    = LS_CHANGED-ROW_ID
              I_FIELDNAME = 'DEPT_T'
              I_VALUE     = LV_TEXT.
  
        WHEN 'GRADE'.
          "직급명 조회
          PERFORM GET_GRADE_TEXT USING     LS_CHANGED-VALUE
                                 CHANGING  LV_TEXT.
  
          "ALV 및 INTERNAL TABLE 에 반영
          CALL METHOD PO_DATA_CHANGED->MODIFY_CELL
            EXPORTING
              I_ROW_ID    = LS_CHANGED-ROW_ID
              I_FIELDNAME = 'GRADE_T'
              I_VALUE     = LV_TEXT.
  
  
        WHEN 'STATUS'.
          "재직구분내역 조회
          PERFORM GET_STATUS_TEXT USING     LS_CHANGED-VALUE
                                  CHANGING  LV_TEXT.
  
          "ALV 및 INTERNAL TABLE 에 반영
          CALL METHOD PO_DATA_CHANGED->MODIFY_CELL
            EXPORTING
              I_ROW_ID    = LS_CHANGED-ROW_ID
              I_FIELDNAME = 'STATUS_T'
              I_VALUE     = LV_TEXT.
  
      ENDCASE.
  
      CALL METHOD PO_DATA_CHANGED->MODIFY_CELL
        EXPORTING
          I_ROW_ID    = LS_CHANGED-ROW_ID
          I_FIELDNAME = 'STAT'
          I_VALUE     = ICON_LED_YELLOW.
  
    ENDLOOP.
  
  
  ENDFORM.
*&---------------------------------------------------------------------*
*& Form GET_DEPT_TEXT
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*      -->P_LS_CHANGED_VALUE  text
*      <--P_LV_TEXT  text
*&---------------------------------------------------------------------*
  FORM GET_DEPT_TEXT  USING    P_CODE
                      CHANGING P_TEXT.
  
    CLEAR P_TEXT.
    READ TABLE GT_DEPT INTO GS_TEXT
                       WITH KEY CODE = P_CODE
                       BINARY SEARCH.
    IF SY-SUBRC = 0.
      P_TEXT = GS_TEXT-TEXT.
    ENDIF.
  
  ENDFORM.
*&---------------------------------------------------------------------*
*& Form GET_GRADE_TEXT
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*      -->P_LS_CHANGED_VALUE  text
*      <--P_LV_TEXT  text
*&---------------------------------------------------------------------*
  FORM GET_GRADE_TEXT  USING    P_CODE
                      CHANGING P_TEXT.
  
    CLEAR P_TEXT.
    READ TABLE GT_GRADE INTO GS_TEXT
                        WITH KEY CODE = P_CODE
                        BINARY SEARCH.
    IF SY-SUBRC = 0.
      P_TEXT = GS_TEXT-TEXT.
    ENDIF.
  
  ENDFORM.
*&---------------------------------------------------------------------*
*& Form GET_STATUS_TEXT
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*      -->P_LS_CHANGED_VALUE  text
*      <--P_LV_TEXT  text
*&---------------------------------------------------------------------*
  FORM GET_STATUS_TEXT  USING    P_CODE
                        CHANGING P_TEXT.
  
    CLEAR P_TEXT.
    READ TABLE GT_STATUS INTO GS_TEXT
                         WITH KEY CODE = P_CODE
                         BINARY SEARCH.
    IF SY-SUBRC = 0.
      P_TEXT = GS_TEXT-TEXT.
    ENDIF.
  
  ENDFORM.
*&---------------------------------------------------------------------*
*& Form HANDLE_TOOLBAR
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*      -->P_E_OBJECT  text
*&---------------------------------------------------------------------*
  FORM HANDLE_TOOLBAR  USING    PO_OBJECT TYPE REF TO CL_ALV_EVENT_TOOLBAR_SET.
  
    DATA : LS_TOOLBAR TYPE STB_BUTTON.
  
    IF SY-TCODE NE 'ZR17_0020_D'.
      LS_TOOLBAR-FUNCTION = 'CRTE'.
      LS_TOOLBAR-ICON     = ICON_CREATE.
      LS_TOOLBAR-TEXT     = ' 사원등록 '.
      APPEND LS_TOOLBAR TO PO_OBJECT->MT_TOOLBAR.
    ENDIF.
  
  ENDFORM.
*&---------------------------------------------------------------------*
*& Form HANDLE_USER_COMMAND
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*      -->P_E_UCOMM  text
*&---------------------------------------------------------------------*
  FORM HANDLE_USER_COMMAND  USING    P_UCOMM.
  
    CASE P_UCOMM.
      WHEN 'CRTE'.
        CLEAR GS_DISP.
        GS_DISP-STAT   = ICON_LED_YELLOW.
        GS_DISP-ENTDT  = SY-DATUM.
        GS_DISP-STATUS = '1'.
        GS_DISP-WAERS  = 'JPY'.
  
        "재직구분 내역
        PERFORM GET_STATUS_TEXT USING     GS_DISP-STATUS
                                CHANGING  GS_DISP-STATUS_T.
  
        APPEND GS_DISP TO GT_DISP.
  
        PERFORM REFRESH_DATA.
  
    ENDCASE.
  
  ENDFORM.
*&---------------------------------------------------------------------*
*& Form SAVE_DATA
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
  FORM SAVE_DATA .
  
    DATA : LT_SAVE_I TYPE TABLE OF ZT17_0010, "신규 등록 사번
           LT_SAVE_U TYPE TABLE OF ZT17_0010, "변경 사번
           LS_SAVE   TYPE          ZT17_0010.
  
    DATA : LV_EMPNO  TYPE ZT17_0010-EMPNO,
           LV_ERR    TYPE C,
           LV_ANSWER TYPE C.
  
    FIELD-SYMBOLS : <FS_DISP> LIKE GS_DISP.
  
    "ALV 에서 변경한 데이터 반영
    CALL METHOD GO_GRID->CHECK_CHANGED_DATA.
  
* 변경데이터 유무 검증
    READ TABLE GT_DISP INTO GS_DISP
                       WITH KEY STAT = ICON_LED_YELLOW.
    IF SY-SUBRC NE 0.
      MESSAGE S006.   "변경된 데이터가 없습니다.
      EXIT.
    ENDIF.
  
    LOOP AT GT_DISP ASSIGNING <FS_DISP>
                    WHERE STAT = ICON_LED_YELLOW.
  
      "유효성 검증
      PERFORM CHECK_LINE CHANGING <FS_DISP>
                                  LV_ERR.
  
      "저장데이터 구성(변경, 생성)
      IF <FS_DISP>-EMPNO IS INITIAL.
        "신규사번 채번
        IF LV_EMPNO IS INITIAL.
          PERFORM GET_MAX_EMPNO CHANGING LV_EMPNO.
        ENDIF.
        LV_EMPNO = LV_EMPNO + 1.
  
        <FS_DISP>-EMPNO_BACKUP = LV_EMPNO.
  
        CLEAR LS_SAVE.
        MOVE-CORRESPONDING <FS_DISP> TO LS_SAVE.
        LS_SAVE-EMPNO = LV_EMPNO.
        LS_SAVE-ERDAT = SY-DATUM.
        LS_SAVE-ERZET = SY-UZEIT.
        LS_SAVE-ERNAM = SY-UNAME.
        APPEND LS_SAVE TO LT_SAVE_I.
      ELSE.
        CLEAR LS_SAVE.
        MOVE-CORRESPONDING <FS_DISP> TO LS_SAVE.
        LS_SAVE-AEDAT = SY-DATUM.
        LS_SAVE-AEZET = SY-UZEIT.
        LS_SAVE-AENAM = SY-UNAME.
        APPEND LS_SAVE TO LT_SAVE_U.
      ENDIF.
  
    ENDLOOP.
  
* 데이터 저장
    IF LV_ERR EQ 'X'.
      MESSAGE S007 DISPLAY LIKE 'E'.    "오류데이터가 존재합니다. 점검 후 진행 바랍니다.
      EXIT.
    ENDIF.
  
* USER CONFIRM
    PERFORM USER_CONFIRM USING    TEXT-Q01    "
                                  TEXT-Q02    "입력하신 정보가 저장됩니다. 계속 진행하시겠습니까?
                         CHANGING LV_ANSWER.
    CHECK LV_ANSWER EQ '1'.
  
    "신규생성
    INSERT ZT17_0010 FROM TABLE LT_SAVE_I
                     ACCEPTING DUPLICATE KEYS.
    IF SY-SUBRC = 0.
      COMMIT WORK.
      LOOP AT GT_DISP ASSIGNING <FS_DISP>
                          WHERE STAT  = ICON_LED_YELLOW
                            AND EMPNO = ''.
        <FS_DISP>-STAT  = ICON_LED_GREEN.
        <FS_DISP>-EMPNO = <FS_DISP>-EMPNO_BACKUP.
        <FS_DISP>-ERDAT = LS_SAVE-ERDAT.
        <FS_DISP>-ERZET = LS_SAVE-ERZET.
        <FS_DISP>-ERNAM = LS_SAVE-ERNAM.
      ENDLOOP.
  
  
    ELSE.
      ROLLBACK WORK.
      GS_DISP-STAT = ICON_LED_RED.
      GS_DISP-RESULT = TEXT-M05.    "'신규사원 생성정보 저장 중 오류가 발생하였습니다.'.
      MODIFY GT_DISP FROM GS_DISP TRANSPORTING STAT RESULT
                                          WHERE STAT  = ICON_LED_YELLOW
                                            AND EMPNO = ''.
    ENDIF.
  
    "변경
    UPDATE ZT17_0010 FROM TABLE LT_SAVE_U.
    IF SY-SUBRC = 0.
      COMMIT WORK.
      CLEAR GS_DISP.
      GS_DISP-STAT = ICON_LED_GREEN.
      MODIFY GT_DISP FROM GS_DISP
                     TRANSPORTING STAT
                     WHERE STAT  = ICON_LED_YELLOW
                       AND EMPNO NE ''.
  
    ELSE.
      ROLLBACK WORK.
      GS_DISP-STAT = ICON_LED_RED.
      GS_DISP-RESULT = TEXT-M06.    "'사원 변경정보 저장 중 오류가 발생하였습니다
      MODIFY GT_DISP FROM GS_DISP TRANSPORTING STAT RESULT
                                          WHERE STAT  = ICON_LED_YELLOW
                                            AND EMPNO <> ''.
    ENDIF.
  
  ENDFORM.
*&---------------------------------------------------------------------*
*& Form SET_RESULT
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*      -->P_TEXT_M01  text
*      <--P_<FS_DISP>_RESULT  text
*&---------------------------------------------------------------------*
  FORM SET_RESULT  USING    P_TEXT
                   CHANGING P_RESULT.
  
    IF P_RESULT IS INITIAL.
      P_RESULT = P_TEXT.
    ELSE.
      CONCATENATE P_RESULT P_TEXT
             INTO P_RESULT
        SEPARATED BY '#'.
    ENDIF.
  
  ENDFORM.
*&---------------------------------------------------------------------*
*& Form GET_MAX_EMPNO
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*      <--P_LV_EMPNO  text
*&---------------------------------------------------------------------*
  FORM GET_MAX_EMPNO  CHANGING P_EMPNO.
  
    DATA : LV_YEAR  TYPE ZT17_0010-EMPNO.
  
    CONCATENATE SY-DATUM+0(4) '%' INTO LV_YEAR.
    SELECT MAX( EMPNO )
      INTO P_EMPNO
      FROM ZT17_0010
     WHERE EMPNO LIKE LV_YEAR.
    IF P_EMPNO IS INITIAL.
      CONCATENATE SY-DATUM+0(4) '000000' INTO P_EMPNO.
    ENDIF.
  
  ENDFORM.
*&---------------------------------------------------------------------*
*& Form USER_CONFIRM
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*      -->P_TEXT_Q01  text
*      -->P_TEXT_Q02  text
*      <--P_LV_ANSWER  text
*&---------------------------------------------------------------------*
  FORM USER_CONFIRM  USING    P_TITLE
                              P_QUEST
                     CHANGING P_ANSWER.
  
    CLEAR : P_ANSWER.
  
    CALL FUNCTION 'POPUP_TO_CONFIRM'
      EXPORTING
        TITLEBAR      = P_TITLE
        TEXT_QUESTION = P_QUEST
        TEXT_BUTTON_1 = 'YES'
        TEXT_BUTTON_2 = 'NO'
      IMPORTING
        ANSWER        = P_ANSWER.
  
  ENDFORM.
*&---------------------------------------------------------------------*
*& Form CHECK_LINE
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*      <--P_<FS_DISP>  text
*      <--P_LV_ERR  text
*&---------------------------------------------------------------------*
  FORM CHECK_LINE  CHANGING PS_DISP LIKE GS_DISP
                            P_ERR.
  
    CLEAR PS_DISP-RESULT.
  
    "필수필드 입력여부 검증
    IF PS_DISP-NAME   IS INITIAL OR
       PS_DISP-DEPT   IS INITIAL OR
       PS_DISP-ENTDT  IS INITIAL OR
       PS_DISP-GRADE  IS INITIAL OR
       PS_DISP-STATUS IS INITIAL.
      PS_DISP-STAT   = ICON_LED_RED.
      P_ERR = 'X'.
  
      PERFORM SET_RESULT USING    TEXT-M01
                         CHANGING PS_DISP-RESULT.
    ENDIF.
  
    IF PS_DISP-STATUS = '3' AND
       PS_DISP-RETDT IS INITIAL.
  
      PS_DISP-STAT   = ICON_LED_RED.
      P_ERR = 'X'.
      PERFORM SET_RESULT USING    TEXT-M02
                         CHANGING PS_DISP-RESULT.
  
    ELSEIF PS_DISP-STATUS <> '3' AND
           PS_DISP-RETDT  IS NOT INITIAL.
  
      PS_DISP-STAT   = ICON_LED_RED.
      P_ERR = 'X'.
      PERFORM SET_RESULT USING    TEXT-M03
                         CHANGING PS_DISP-RESULT.
  
    ENDIF.
  
    "입력데이터에 대한 유효성 검증
    IF PS_DISP-RETDT IS NOT INITIAL AND
       PS_DISP-RETDT < PS_DISP-ENTDT.
      P_ERR = 'X'.
      PS_DISP-STAT   = ICON_LED_RED.
      PERFORM SET_RESULT USING    TEXT-M04    "퇴사일이 입사일 이전입니다
                         CHANGING PS_DISP-RESULT.
    ENDIF.
  
  ENDFORM.