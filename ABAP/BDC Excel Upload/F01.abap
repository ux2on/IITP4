*&---------------------------------------------------------------------*
*& Include          ZR17_0070F01
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
    GS_FCAT-KEY       = 'X'.
    APPEND GS_FCAT TO GT_FCAT.
  
    CLEAR GS_FCAT.
    GS_FCAT-FIELDNAME = 'MATNR'.
    GS_FCAT-COLTEXT   = '자재코드'.
    GS_FCAT-KEY       = 'X'.
    APPEND GS_FCAT TO GT_FCAT.
  
    CLEAR GS_FCAT.
    GS_FCAT-FIELDNAME = 'MAKTX'.
    GS_FCAT-COLTEXT   = '자재내역'.
    APPEND GS_FCAT TO GT_FCAT.
  
    CLEAR GS_FCAT.
    GS_FCAT-FIELDNAME = 'MTART'.
    GS_FCAT-COLTEXT   = '자재유형'.
    APPEND GS_FCAT TO GT_FCAT.
  
    CLEAR GS_FCAT.
    GS_FCAT-FIELDNAME = 'MBRSH'.
    GS_FCAT-COLTEXT   = '산업군'.
    APPEND GS_FCAT TO GT_FCAT.
  
    CLEAR GS_FCAT.
    GS_FCAT-FIELDNAME = 'MEINS'.
    GS_FCAT-COLTEXT   = '기본단위'.
    APPEND GS_FCAT TO GT_FCAT.
  
    CLEAR GS_FCAT.
    GS_FCAT-FIELDNAME = 'RESULT'.
    GS_FCAT-COLTEXT   = '결과'.
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
*& Form GET_FILE_PATH
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
  FORM GET_FILE_PATH .
  
    DATA : LT_FILE TYPE FILETABLE,
           LS_FILE TYPE FILE_TABLE,
           LV_RC   TYPE I.
  
    CALL METHOD CL_GUI_FRONTEND_SERVICES=>FILE_OPEN_DIALOG
      CHANGING
        FILE_TABLE = LT_FILE
        RC         = LV_RC.
  
    READ TABLE LT_FILE INTO LS_FILE INDEX 1.
    IF SY-SUBRC = 0.
      P_PATH = LS_FILE.
    ENDIF.
  
  ENDFORM.
*&---------------------------------------------------------------------*
*& Form UPLOAD_FROM_EXCEL
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
  FORM UPLOAD_FROM_EXCEL .
  
    DATA : LT_INTERN TYPE TABLE OF ALSMEX_TABLINE,
           LS_INTERN TYPE          ALSMEX_TABLINE.
  
    CALL FUNCTION 'ALSM_EXCEL_TO_INTERNAL_TABLE'
      EXPORTING
        FILENAME                = P_PATH
        I_BEGIN_COL             = 1
        I_BEGIN_ROW             = 2
        I_END_COL               = 5
        I_END_ROW               = 1000
      TABLES
        INTERN                  = LT_INTERN
      EXCEPTIONS
        INCONSISTENT_PARAMETERS = 1
        UPLOAD_OLE              = 2
        OTHERS                  = 3.
    IF SY-SUBRC <> 0.
      MESSAGE S010 DISPLAY LIKE 'E'.    "업로드 중 오류가 발생하였습니다.
      LEAVE LIST-PROCESSING.
    ENDIF.
  
    CLEAR : GT_EXCEL, GS_EXCEL.
  
    LOOP AT LT_INTERN INTO LS_INTERN.
  
      CASE LS_INTERN-COL.
        WHEN 1.
          GS_EXCEL-MATNR = LS_INTERN-VALUE.
        WHEN 2.
          GS_EXCEL-MAKTX = LS_INTERN-VALUE.
        WHEN 3.
          GS_EXCEL-MTART = LS_INTERN-VALUE.
        WHEN 4.
          GS_EXCEL-MBRSH = LS_INTERN-VALUE.
        WHEN 5.
          GS_EXCEL-MEINS = LS_INTERN-VALUE.
      ENDCASE.
  
      AT END OF ROW.
        APPEND GS_EXCEL TO GT_EXCEL.
        CLEAR GS_EXCEL.
      ENDAT.
  
    ENDLOOP.
  
  
  
  ENDFORM.
*&---------------------------------------------------------------------*
*& Form CONVERT_TO_DISPLAY_FORMAT
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
  FORM CONVERT_TO_DISPLAY_FORMAT .
  
    CLEAR : GT_DISP, GS_DISP.
  
    LOOP AT GT_EXCEL INTO GS_EXCEL.
  
      CLEAR GS_DISP.
  
      "데이터 유효성 검증
  
  
      MOVE-CORRESPONDING GS_EXCEL TO GS_DISP.
      GS_DISP-STAT = ICON_LED_YELLOW.
  
      APPEND GS_DISP TO GT_DISP.
  
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
  
    DATA : LV_MSG TYPE CHAR100.
  
    LOOP AT GT_DISP INTO GS_DISP WHERE STAT = ICON_LED_YELLOW.
  
      CLEAR : GT_BDC.
  
      PERFORM SET_BDC_TAB USING : 'SAPLMGMM' '0060' 'X' '' '',
                                  '' '' '' 'BDC_OKCODE' '=ENTR',
                                  '' '' '' 'RMMG1-MATNR' GS_DISP-MATNR,
                                  '' '' '' 'RMMG1-MBRSH' GS_DISP-MBRSH,
                                  '' '' '' 'RMMG1-MTART' GS_DISP-MTART.
  
      PERFORM SET_BDC_TAB USING : 'SAPLMGMM' '0070' 'X' '' '',
                                  '' '' '' 'BDC_OKCODE' '=ENTR',
                                  '' '' '' 'MSICHTAUSW-KZSEL(01)' 'X'.
  
      PERFORM SET_BDC_TAB USING : 'SAPLMGMM' '4004' 'X' '' '',
                                  '' '' '' 'BDC_OKCODE' '=BU',
                                  '' '' '' 'MAKT-MAKTX' GS_DISP-MAKTX,
                                  '' '' '' 'MARA-MEINS' GS_DISP-MEINS.
  
  
      CLEAR GS_OPT.
      GS_OPT-DISMODE = 'N'.   "N, E
      GS_OPT-UPDMODE = 'S'.
  
      CLEAR GT_MSG.
      CALL TRANSACTION 'MM01' USING GT_BDC
                              OPTIONS FROM GS_OPT
                              MESSAGES INTO GT_MSG.
      READ TABLE GT_MSG INTO GS_MSG WITH KEY MSGID = 'M3'
                                             MSGNR = '800'.
      IF SY-SUBRC = 0.
        "성공처리
        GS_DISP-STAT   = ICON_LED_GREEN.
        GS_DISP-RESULT = ''.
        MESSAGE S009 WITH GS_DISP-MATNR.  "자재코드 & 가 생성되었습니다.
      ELSE.
        "실패처리
        LOOP AT GT_MSG INTO GS_MSG.
          CALL FUNCTION 'MESSAGE_TEXT_BUILD'
            EXPORTING
              MSGID                     = GS_MSG-MSGID
              MSGNR                     = GS_MSG-MSGNR
              MSGV1                     = GS_MSG-MSGV1
              MSGV2                     = GS_MSG-MSGV2
              MSGV3                     = GS_MSG-MSGV3
              MSGV4                     = GS_MSG-MSGV4
           IMPORTING
             MESSAGE_TEXT_OUTPUT       = LV_MSG.
  
          IF GS_DISP-RESULT IS INITIAL.
            GS_DISP-RESULT = LV_MSG.
            ELSE.
              CONCATENATE GS_DISP-RESULT LV_MSG
                     INTO GS_DISP-RESULT
                SEPARATED BY '#'.
              ENDIF.
  
        ENDLOOP.
  
        GS_DISP-STAT = ICON_LED_RED.
      ENDIF.
  
      MODIFY GT_DISP FROM GS_DISP.
  
    ENDLOOP.
  
  ENDFORM.
*&---------------------------------------------------------------------*
*& Form SET_BDC_TAB
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*      -->P_       text
*      -->P_       text
*      -->P_       text
*      -->P_       text
*      -->P_       text
*&---------------------------------------------------------------------*
  FORM SET_BDC_TAB  USING    P_PROGRAM
                             P_DYNPRO
                             P_DYNBEGIN
                             P_FNAM
                             P_FVAL.
  
    CLEAR GS_BDC.
    GS_BDC-PROGRAM  = P_PROGRAM.
    GS_BDC-DYNPRO   = P_DYNPRO.
    GS_BDC-DYNBEGIN = P_DYNBEGIN.
    GS_BDC-FNAM     = P_FNAM.
    GS_BDC-FVAL     = P_FVAL.
  
    APPEND GS_BDC TO GT_BDC.
  
  ENDFORM.