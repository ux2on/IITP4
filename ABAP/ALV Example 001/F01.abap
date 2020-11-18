*&---------------------------------------------------------------------*
*& Include          ZR17_0010F01
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
  
* LAYOUT 셋팅
      PERFORM SET_LAYOUT.
  
* ALV 출력
      PERFORM DISPLAY_ALV.
  
    ELSE.
      "REFRESH
      PERFORM REFRESH_0100.
  
    ENDIF.
  
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
  
    CREATE OBJECT GO_CONTAINER
      EXPORTING
        CONTAINER_NAME = 'GO_CONTAINER'.
  
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
  
    CLEAR GT_FCAT.
  
    CLEAR GS_FCAT.
    GS_FCAT-FIELDNAME = 'EMPNO'.
    GS_FCAT-COLTEXT   = '사원번호'.
    GS_FCAT-KEY       = 'X'.
    APPEND GS_FCAT TO GT_FCAT.
  
    CLEAR GS_FCAT.
    GS_FCAT-FIELDNAME = 'NAME'.
    GS_FCAT-COLTEXT   = '이름'.
    APPEND GS_FCAT TO GT_FCAT.
  
    CLEAR GS_FCAT.
    GS_FCAT-FIELDNAME = 'DEPT'.
    GS_FCAT-COLTEXT   = '부서'.
    GS_FCAT-REF_TABLE = 'ZT00_0010'.
    APPEND GS_FCAT TO GT_FCAT.
  
    CLEAR GS_FCAT.
    GS_FCAT-FIELDNAME = 'DEPT_T'.
    GS_FCAT-COLTEXT   = '부서내역'.
    APPEND GS_FCAT TO GT_FCAT.
  
    CLEAR GS_FCAT.
    GS_FCAT-FIELDNAME = 'ENTDT'.
    GS_FCAT-COLTEXT   = '입사일'.
    APPEND GS_FCAT TO GT_FCAT.
  
    CLEAR GS_FCAT.
    GS_FCAT-FIELDNAME = 'GRADE'.
    GS_FCAT-COLTEXT   = '직급'.
    GS_FCAT-REF_TABLE = 'ZT00_0010'.
    APPEND GS_FCAT TO GT_FCAT.
  
    CLEAR GS_FCAT.
    GS_FCAT-FIELDNAME = 'GRADE_T'.
    GS_FCAT-COLTEXT   = '직급내역'.
    APPEND GS_FCAT TO GT_FCAT.
  
    CLEAR GS_FCAT.
    GS_FCAT-FIELDNAME = 'RETDT'.
    GS_FCAT-COLTEXT   = '퇴사일'.
    APPEND GS_FCAT TO GT_FCAT.
  
    CLEAR GS_FCAT.
    GS_FCAT-FIELDNAME = 'STATUS'.
    GS_FCAT-COLTEXT   = '재직구분'.
    GS_FCAT-REF_TABLE = 'ZT00_0010'.
    APPEND GS_FCAT TO GT_FCAT.
  
    CLEAR GS_FCAT.
    GS_FCAT-FIELDNAME = 'STATUS_T'.
    GS_FCAT-COLTEXT   = '재직구분 내역'.
    APPEND GS_FCAT TO GT_FCAT.
  
    CLEAR GS_FCAT.
    GS_FCAT-FIELDNAME = 'PHONE'.
    GS_FCAT-COLTEXT   = '전화번호'.
    APPEND GS_FCAT TO GT_FCAT.
  
    CLEAR GS_FCAT.
    GS_FCAT-FIELDNAME = 'ADDR_H'.
    GS_FCAT-COLTEXT   = '자택주소'.
    APPEND GS_FCAT TO GT_FCAT.
  
    CLEAR GS_FCAT.
    GS_FCAT-FIELDNAME = 'ADDR_W'.
    GS_FCAT-COLTEXT   = '근무지주소'.
    APPEND GS_FCAT TO GT_FCAT.
  
    CLEAR GS_FCAT.
    GS_FCAT-FIELDNAME = 'SALARY'.
    GS_FCAT-COLTEXT   = '기본급'.
    GS_FCAT-CFIELDNAME = 'WAERS'.
    APPEND GS_FCAT TO GT_FCAT.
  
    CLEAR GS_FCAT.
    GS_FCAT-FIELDNAME = 'WAERS'.
    GS_FCAT-NO_OUT    = 'X'.
    APPEND GS_FCAT TO GT_FCAT.
  
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
*     I_BUFFER_ACTIVE =
*     I_BYPASSING_BUFFER            =
*     I_CONSISTENCY_CHECK           =
*     I_STRUCTURE_NAME              =
*     IS_VARIANT      =
*     I_SAVE          =
*     I_DEFAULT       = 'X'
        IS_LAYOUT       = GS_LAYOUT
*     IS_PRINT        =
*     IT_SPECIAL_GROUPS             =
*     IT_TOOLBAR_EXCLUDING          =
*     IT_HYPERLINK    =
*     IT_ALV_GRAPHICS =
*     IT_EXCEPT_QINFO =
*     IR_SALV_ADAPTER =
      CHANGING
        IT_OUTTAB       = GT_DISP
        IT_FIELDCATALOG = GT_FCAT
*     IT_SORT         =
*     IT_FILTER       =
*    EXCEPTIONS
*     INVALID_PARAMETER_COMBINATION = 1
*     PROGRAM_ERROR   = 2
*     TOO_MANY_LINES  = 3
*     others          = 4
      .
    IF SY-SUBRC <> 0.
*   Implement suitable error handling here
    ENDIF.
  
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
*& Form SET_LAYOUT
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
  FORM SET_LAYOUT .
  
    CLEAR GS_LAYOUT.
    GS_LAYOUT-CWIDTH_OPT = 'A'.
  
  
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
      FROM ZT17_0010
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
  
    ENDLOOP.
  
  ENDFORM.
*&---------------------------------------------------------------------*
*& Form CREATE_DATA
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
  FORM CREATE_DATA .
  
    DATA : LS_DATA TYPE ZT17_0010,
           LV_ANSWER.
  
* USER CONFIRM
    PERFORM USER_CONFIRM USING    TEXT-Q01
                                  TEXT-Q03    "'입력하신 사원정보가 등록됩니다. 계속 진행하시겠습니까?'
                         CHANGING LV_ANSWER.
  
*  IF LV_ANSWER NE '1'.
*    EXIT.
*  ENDIF.
  
    CHECK LV_ANSWER EQ '1'.
  
* 저장할 WA 로 데이터 이관
    MOVE-CORRESPONDING GS_DISP_0200 TO LS_DATA.
  
* 레코드 생성정보 적용
    LS_DATA-ERDAT = SY-DATUM.
    LS_DATA-ERZET = SY-UZEIT.
    LS_DATA-ERNAM = SY-UNAME.
  
* 데이터 저장
    INSERT ZT17_0010 FROM LS_DATA.
    IF SY-SUBRC = 0.
      "성공처리
      COMMIT WORK.    " AND WAIT.
      MESSAGE S001.   "정상 처리되었습니다.
  
      CLEAR GS_DISP.
      MOVE-CORRESPONDING GS_DISP_0200 TO GS_DISP.
  
      "도메인 내역 조회
      PERFORM GET_TEXT_SINGLE_LINE CHANGING GS_DISP.
  
      "화면(ALV) 테이블에 추가
      APPEND GS_DISP TO GT_DISP.
  
      "현재화면 종료
      LEAVE TO SCREEN 0.
  
    ELSE.
      "실패처리
      ROLLBACK WORK.
      MESSAGE S002 DISPLAY LIKE 'E'.   "데이터 처리 중 오류가 발생하였습니다.
    ENDIF.
  
  ENDFORM.
*&---------------------------------------------------------------------*
*& Form REFRESH_0100
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
  FORM REFRESH_0100 .
  
    CALL METHOD GO_GRID->REFRESH_TABLE_DISPLAY.
  
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
      READ TABLE GT_DEPT INTO GS_TEXT
                         WITH KEY CODE = PS_DATA-DEPT
                         BINARY SEARCH.
      IF SY-SUBRC = 0.
        PS_DATA-DEPT_T = GS_TEXT-TEXT.
      ENDIF.
  
* 직급 내역
      READ TABLE GT_GRADE INTO GS_TEXT
                          WITH KEY CODE = PS_DATA-GRADE
                          BINARY SEARCH.
      IF SY-SUBRC = 0.
        PS_DATA-GRADE_T = GS_TEXT-TEXT.
      ENDIF.
  
* 재직구분 내역
      READ TABLE GT_STATUS INTO GS_TEXT
                           WITH KEY CODE = PS_DATA-STATUS
                           BINARY SEARCH.
      IF SY-SUBRC = 0.
        PS_DATA-STATUS_T = GS_TEXT-TEXT.
      ENDIF.
  
  ENDFORM.
*&---------------------------------------------------------------------*
*& Form CALL_CREATE_SCREEN
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
  FORM CALL_CREATE_SCREEN .
  
        CLEAR GS_DISP_0200.
        GS_DISP_0200-STATUS = GC_STATUS_DEFAULT.      "'1'.
        GS_DISP_0200-WAERS  = GC_WAERS_DEFAULT.       "'JPY'.
        GS_DISP_0200-ENTDT  = SY-DATUM.
        GS_DISP_0200-MODE   = GC_MODE_INSERT.         "'I'.
  
        CALL SCREEN '0200' STARTING AT 5  5.
  
  ENDFORM.
*&---------------------------------------------------------------------*
*& Form CALL_CHANGE_SCREEN
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
  FORM CALL_CHANGE_SCREEN .
  
    DATA : LT_ROW TYPE LVC_T_ROID,
           LS_ROW TYPE LVC_S_ROID.
  
* 선택한 라인 확인
    CALL METHOD GO_GRID->GET_SELECTED_ROWS
      IMPORTING
        ET_ROW_NO     = LT_ROW.
  
    IF LT_ROW IS INITIAL.
      MESSAGE S003 DISPLAY LIKE 'E'.    "변경할 라인을 선택하세요.
      EXIT.
    ENDIF.
  
    READ TABLE LT_ROW INTO LS_ROW INDEX 1.
    READ TABLE GT_DISP INTO GS_DISP INDEX LS_ROW-ROW_ID.
  
* 변경화면에 출력할 WA 로 데이터 이관
    CLEAR GS_DISP_0200.
    MOVE-CORRESPONDING GS_DISP TO GS_DISP_0200.
    GS_DISP_0200-MODE  = GC_MODE_UPDATE.
    GS_DISP_0200-INDEX = LS_ROW-ROW_ID.
  
* 변경 화면 호출   
    CALL SCREEN '0200' STARTING AT 5 5.
  
  ENDFORM.
*&---------------------------------------------------------------------*
*& Form UPDATE_DATA
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
  FORM UPDATE_DATA .
  
    DATA : LS_DATA TYPE ZT17_0010,
           LV_ANSWER.
  
* USER CONFIRM
    PERFORM USER_CONFIRM USING    TEXT-Q01      "'데이터 저장'
                                  TEXT-Q02      "'변경하신 데이터가 반영됩니다. 계속 진행하시겠습니까?'
                         CHANGING LV_ANSWER.
  
    CHECK LV_ANSWER EQ '1'.
  
* 저장할 WA 로 데이터 이관
    MOVE-CORRESPONDING GS_DISP_0200 TO LS_DATA.
  
* 레코드 변경정보 적용
    LS_DATA-AEDAT = SY-DATUM.
    LS_DATA-AEZET = SY-UZEIT.
    LS_DATA-AENAM = SY-UNAME.
  
* 데이터 저장
    UPDATE ZT00_0010 FROM LS_DATA.
    IF SY-SUBRC = 0.
      "성공처리
      COMMIT WORK AND WAIT.
      MESSAGE S001.   "정상 처리되었습니다.
  
      CLEAR GS_DISP.
      MOVE-CORRESPONDING GS_DISP_0200 TO GS_DISP.
  
      "도메인 내역 조회
      PERFORM GET_TEXT_SINGLE_LINE CHANGING GS_DISP.
  
      "화면(ALV) 테이블에 변경
      MODIFY GT_DISP FROM GS_DISP INDEX GS_DISP_0200-INDEX.
  
      "현재화면 종료
      LEAVE TO SCREEN 0.
  
    ELSE.
      "실패처리
      ROLLBACK WORK.
      MESSAGE S002 DISPLAY LIKE 'E'.   "데이터 처리 중 오류가 발생하였습니다.
    ENDIF.
  
  ENDFORM.
*&---------------------------------------------------------------------*
*& Form CALL_RET_SCREEN
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
  FORM CALL_RET_SCREEN .
  
    DATA : LT_ROW TYPE LVC_T_ROID,
           LS_ROW TYPE LVC_S_ROID.
  
* 선택한 라인 확인
    CALL METHOD GO_GRID->GET_SELECTED_ROWS
      IMPORTING
        ET_ROW_NO     = LT_ROW.
  
    IF LT_ROW IS INITIAL.
      MESSAGE S004 DISPLAY LIKE 'E'.    "퇴사처리할 라인을 선택하세요.
      EXIT.
    ENDIF.
  
    READ TABLE LT_ROW INTO LS_ROW INDEX 1.
    READ TABLE GT_DISP INTO GS_DISP INDEX LS_ROW-ROW_ID.
  
* 변경화면에 출력할 WA 로 데이터 이관 
    CLEAR GS_DISP_0200.
    MOVE-CORRESPONDING GS_DISP TO GS_DISP_0200.
  
    GS_DISP_0200-RETDT  = SY-DATUM.
    GS_DISP_0200-STATUS = GC_STATUS_RETIRE.     "'3'
  
    GS_DISP_0200-MODE  = GC_MODE_RETIRE.
    GS_DISP_0200-INDEX = LS_ROW-ROW_ID.
  
* 변경화면 호출
    CALL SCREEN '0200' STARTING AT 5 5.
  
  ENDFORM.
*&---------------------------------------------------------------------*
*& Form RETIRE_DATA
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
  FORM RETIRE_DATA .
  
    DATA : LS_DATA TYPE ZT17_0010,
           LV_ANSWER.
  
* 입력값 점검
    IF GS_DISP_0200-ENTDT > GS_DISP_0200-RETDT.
      MESSAGE S005 DISPLAY LIKE 'E'.    "퇴사일이 입사일 이전 입니다.
      EXIT.
    ENDIF.
  
* USER CONFIRM
    PERFORM USER_CONFIRM USING    TEXT-Q01      "'데이터 저장'
                                  TEXT-Q04      "'퇴직처리가 반영됩니다. 계속 진행하시겠습니까?'
                         CHANGING LV_ANSWER.
  
    CHECK LV_ANSWER EQ '1'.
  
* 저장할 WA 로 데이터 이관
    MOVE-CORRESPONDING GS_DISP_0200 TO LS_DATA.
  
* 레코드 변경정보 적용
    LS_DATA-AEDAT = SY-DATUM.
    LS_DATA-AEZET = SY-UZEIT.
    LS_DATA-AENAM = SY-UNAME.
  
* 데이터 저장
    UPDATE ZT00_0010 FROM LS_DATA.
    IF SY-SUBRC = 0.
      "성공처리
      COMMIT WORK AND WAIT.
      MESSAGE S001.   "정상 처리되었습니다.
  
      CLEAR GS_DISP.
      MOVE-CORRESPONDING GS_DISP_0200 TO GS_DISP.
  
      "도메인 내역 조회
      PERFORM GET_TEXT_SINGLE_LINE CHANGING GS_DISP.
  
      "화면(ALV) 테이블에 변경
      MODIFY GT_DISP FROM GS_DISP INDEX GS_DISP_0200-INDEX.
  
      "현재화면 종료
      LEAVE TO SCREEN 0.
  
    ELSE.
      "실패처리
      ROLLBACK WORK.
      MESSAGE S002 DISPLAY LIKE 'E'.   "데이터 처리 중 오류가 발생하였습니다.
    ENDIF.
  
  ENDFORM.
*&---------------------------------------------------------------------*
*& Form USER_CONFIRM
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*      -->P_       text
*      -->P_       text
*      <--P_LV_ANSWER  text
*&---------------------------------------------------------------------*
  FORM USER_CONFIRM  USING    P_TITLE
                              P_QUEST
                     CHANGING P_ANSWER.
  
    CLEAR : P_ANSWER.
  
    CALL FUNCTION 'POPUP_TO_CONFIRM'
      EXPORTING
        TITLEBAR                    = P_TITLE
        TEXT_QUESTION               = P_QUEST
        TEXT_BUTTON_1               = 'YES'
        TEXT_BUTTON_2               = 'NO'
      IMPORTING
        ANSWER                      = P_ANSWER.
  
  ENDFORM.