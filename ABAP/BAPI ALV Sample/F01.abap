*&---------------------------------------------------------------------*
*& Include          ZR17_0050F01
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
  
    CLEAR GT_FCAT.
  
    CLEAR GS_FCAT.
    GS_FCAT-FIELDNAME = 'STAT'.
    GS_FCAT-COLTEXT   = '상태'.
    APPEND GS_FCAT TO GT_FCAT.
  
    CLEAR GS_FCAT.
    GS_FCAT-FIELDNAME = 'EBELN'.
    GS_FCAT-COLTEXT   = '구매오더'.
    APPEND GS_FCAT TO GT_FCAT.
  
    CLEAR GS_FCAT.
    GS_FCAT-FIELDNAME = 'BUKRS'.
    GS_FCAT-COLTEXT   = '회사코드'.
    APPEND GS_FCAT TO GT_FCAT.
  
    CLEAR GS_FCAT.
    GS_FCAT-FIELDNAME = 'BSART'.
    GS_FCAT-COLTEXT   = '문서유형'.
    APPEND GS_FCAT TO GT_FCAT.
  
    CLEAR GS_FCAT.
    GS_FCAT-FIELDNAME = 'ERNAM'.
    GS_FCAT-COLTEXT   = '생성자'.
    APPEND GS_FCAT TO GT_FCAT.
  
    CLEAR GS_FCAT.
    GS_FCAT-FIELDNAME = 'LIFNR'.
    GS_FCAT-COLTEXT   = '공급업체'.
    APPEND GS_FCAT TO GT_FCAT.
  
    CLEAR GS_FCAT.
    GS_FCAT-FIELDNAME = 'ZTERM'.
    GS_FCAT-COLTEXT   = '지급조건'.
    APPEND GS_FCAT TO GT_FCAT.
  
    CLEAR GS_FCAT.
    GS_FCAT-FIELDNAME = 'VERKF'.
    GS_FCAT-COLTEXT   = '담당자'.
    GS_FCAT-EDIT      = 'X'.
    APPEND GS_FCAT TO GT_FCAT.
  
    CLEAR GS_FCAT.
    GS_FCAT-FIELDNAME = 'TELF1'.
    GS_FCAT-COLTEXT   = '연락처'.
    GS_FCAT-EDIT      = 'X'.
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
  
    GS_LAYOUT-ZEBRA      = 'X'.
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
  
    CLEAR GT_DISP.
  
    SELECT '@5B@' AS STAT,
           EBELN, BUKRS, BSART, ERNAM, LIFNR,
           ZTERM, VERKF, TELF1
      INTO CORRESPONDING FIELDS OF TABLE @GT_DISP
      FROM EKKO
     WHERE EBELN IN @S_EBELN
       AND BUKRS IN @S_BUKRS
       AND BSART IN @S_BSART
       AND BSTYP EQ 'F'
       AND LOEKZ EQ ''.
  
    SORT GT_DISP BY EBELN.
  
  *  LOOP AT GT_DISP INTO GS_DISP.
  *    GS_DISP-STAT = ICON_LED_GREEN.
  *    MODIFY GT_DISP FROM GS_DISP.
  *  ENDLOOP.
  
  *  GS_DISP-STAT = ICON_LED_GREEN.
  *  MODIFY GT_DISP FROM GS_DISP TRANSPORTING STAT
  *                              WHERE STAT <> ICON_LED_GREEN.
  
  
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
*& Form SET_EVENT
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
  FORM SET_EVENT .
  
    CREATE OBJECT GO_EVENT_RECEIVER.
  
    SET HANDLER GO_EVENT_RECEIVER->HANDLE_DATA_CHANGED FOR GO_GRID.
  
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
  FORM HANDLE_DATA_CHANGED  USING    PO_DATA_CHANGED
                                 TYPE REF TO CL_ALV_CHANGED_DATA_PROTOCOL.
  
    DATA : LS_CHANGED TYPE LVC_S_MODI,
           LT_CHANGED TYPE LVC_T_MODI.
  
    LT_CHANGED = PO_DATA_CHANGED->MT_GOOD_CELLS.
    SORT LT_CHANGED BY ROW_ID.
    LOOP AT LT_CHANGED INTO LS_CHANGED.
  
*    AT FIRST.
*
*    ENDAT.
  
      AT NEW ROW_ID.
        CALL METHOD PO_DATA_CHANGED->MODIFY_CELL
          EXPORTING
            I_ROW_ID    = LS_CHANGED-ROW_ID
            I_FIELDNAME = 'STAT'
            I_VALUE     = ICON_LED_YELLOW.
      ENDAT.
  
*    AT END OF ROW_ID.
*
*    ENDAT.
*
*    AT LAST.
*
*    ENDAT.
  
    ENDLOOP.
  
  
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
  
    DATA : LT_RETURN  TYPE TABLE OF BAPIRET2,
           LS_RETURN  TYPE          BAPIRET2,
           LS_HEADER  TYPE          BAPIMEPOHEADER,
           LS_HEADERX TYPE          BAPIMEPOHEADERX.
    DATA LV_ANSWER TYPE C.
  
    CALL METHOD GO_GRID->CHECK_CHANGED_DATA.
  
* 변경데이터 유무 체크
    READ TABLE GT_DISP INTO GS_DISP WITH KEY STAT = ICON_LED_YELLOW.
    IF SY-SUBRC NE 0.
      MESSAGE S006.   "변경된 데이터가 없습니다.
      EXIT.
    ENDIF.
  
* USER CONFIRM
    PERFORM USER_CONFIRM USING    TEXT-Q01    "
                                  TEXT-Q02    "구매오더가 변경됩니다. 계속 진행하시겠습니까?
                         CHANGING LV_ANSWER.
    CHECK LV_ANSWER EQ '1'.
  
  
    LOOP AT GT_DISP INTO GS_DISP WHERE STAT EQ ICON_LED_YELLOW.
      "BAPI 데이터 구성
      CLEAR : LS_HEADER, LS_HEADERX.
      LS_HEADER-SALES_PERS = GS_DISP-VERKF.
      LS_HEADER-TELEPHONE  = GS_DISP-TELF1.
  
      LS_HEADERX-SALES_PERS = 'X'.
      LS_HEADERX-TELEPHONE  = 'X'.
  
      "BAPI 수행
      CLEAR LT_RETURN.
      CALL FUNCTION 'BAPI_PO_CHANGE'
        EXPORTING
          PURCHASEORDER = GS_DISP-EBELN
          POHEADER      = LS_HEADER
          POHEADERX     = LS_HEADERX
        TABLES
          RETURN        = LT_RETURN.
  
      "성공/실패에 따른 결과를 ALV에 적용
      READ TABLE LT_RETURN INTO LS_RETURN
                           WITH KEY TYPE = 'E'.
      IF SY-SUBRC = 0.
        "실패처리
        CALL FUNCTION 'BAPI_TRANSACTION_ROLLBACK'.
        GS_DISP-STAT = ICON_LED_RED.
  
        CLEAR GS_DISP-RESULT.
        LOOP AT LT_RETURN INTO LS_RETURN WHERE TYPE = 'E'.
          IF GS_DISP-RESULT IS INITIAL.
            GS_DISP-RESULT = LS_RETURN-MESSAGE.
          ELSE.
            CONCATENATE GS_DISP-RESULT LS_RETURN-MESSAGE
                   INTO GS_DISP-RESULT
              SEPARATED BY '#'.
          ENDIF.
        ENDLOOP.
  
      ELSE.
        "성공처리
        CALL FUNCTION 'BAPI_TRANSACTION_COMMIT'
          EXPORTING
            WAIT = 'X'.
  
        GS_DISP-STAT   = ICON_LED_GREEN.
        GS_DISP-RESULT = ''.
  
      ENDIF.
  
      MODIFY GT_DISP FROM GS_DISP.
  
    ENDLOOP.
  
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
*& Form EXIT_0100
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
  FORM EXIT_0100 .
  
    DATA : LV_ANSWER TYPE C.
  
    LOOP AT GT_DISP INTO GS_DISP WHERE STAT EQ ICON_LED_YELLOW
                                    OR STAT EQ ICON_LED_RED.
      EXIT.
    ENDLOOP.
    IF SY-SUBRC = 0.
* USER CONFIRM
      PERFORM USER_CONFIRM USING    TEXT-Q03    "
                                    TEXT-Q04    "저장되지 않은 데이터가 손실됩니다. 현재화면을 종료하시겠습니까?
                           CHANGING LV_ANSWER.
      CHECK LV_ANSWER EQ '1'.
    ENDIF.
  
    LEAVE TO SCREEN 0.
  
  ENDFORM.