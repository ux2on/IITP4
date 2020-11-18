*&---------------------------------------------------------------------*
*& Include          ZR17_0003F01
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

    IF GO_DOCKING IS INITIAL.
  * INSTANCE 생성
      PERFORM CREATE_OBJECT.
  
  * 출력필드 셋팅
      PERFORM SET_FIELDCAT.
  
  * LAYOUT 셋팅
      PERFORM SET_LAYOUT.
  
  * EVENT
      PERFORM SET_EVENT.
  
  * ALV 호출
      PERFORM DISPLAY_ALV.
  
    ELSE.
  
      PERFORM REFRESH_ALV.
  
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
  
  * MAIN CONTAINER 생성
    CREATE OBJECT GO_DOCKING
      EXPORTING
        SIDE      = CL_GUI_DOCKING_CONTAINER=>DOCK_AT_LEFT
        EXTENSION = 2000.
  
  * MAIN CONTAINER 영역 분할(SPLITTER CONTAINER 생성)
    CREATE OBJECT GO_SPLITTER
      EXPORTING
        PARENT  = GO_DOCKING
        ROWS    = 2
        COLUMNS = 1.
  
  * 분할된 CONTAINER를 개별 CONTAINER에 할당
    CALL METHOD GO_SPLITTER->GET_CONTAINER
      EXPORTING
        ROW       = 1
        COLUMN    = 1
      RECEIVING
        CONTAINER = GO_CONTAINER1.
  
    CALL METHOD GO_SPLITTER->GET_CONTAINER
      EXPORTING
        ROW       = 2
        COLUMN    = 1
      RECEIVING
        CONTAINER = GO_CONTAINER2.
  
  * 개별 CONTAINER에 ALV 생성
    CREATE OBJECT GO_GRID1
      EXPORTING
        I_PARENT = GO_CONTAINER1.
  
    CREATE OBJECT GO_GRID2
      EXPORTING
        I_PARENT = GO_CONTAINER2.
  
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
  
    CLEAR : GT_FCAT1, GT_FCAT2.
  
* 상단 ALV 필드 셋팅
    CLEAR GS_FCAT.
    GS_FCAT-FIELDNAME = 'EBELN'.
    GS_FCAT-COLTEXT   = '구매문서'.
    APPEND GS_FCAT TO GT_FCAT1.
  
    CLEAR GS_FCAT.
    GS_FCAT-FIELDNAME = 'BUKRS'.
    GS_FCAT-COLTEXT   = '회사코드'.
    APPEND GS_FCAT TO GT_FCAT1.
  
    CLEAR GS_FCAT.
    GS_FCAT-FIELDNAME = 'LIFNR'.
    GS_FCAT-COLTEXT   = '공급업체'.
    APPEND GS_FCAT TO GT_FCAT1.
  
* 하단 ALV 필드 셋팅
    CLEAR GS_FCAT.
    GS_FCAT-FIELDNAME = 'EBELN'.
    GS_FCAT-COLTEXT   = '구매문서'.
    APPEND GS_FCAT TO GT_FCAT2.
  
    CLEAR GS_FCAT.
    GS_FCAT-FIELDNAME = 'EBELP'.
    GS_FCAT-COLTEXT   = '아이템'.
    APPEND GS_FCAT TO GT_FCAT2.
  
    CLEAR GS_FCAT.
    GS_FCAT-FIELDNAME = 'MATNR'.
    GS_FCAT-COLTEXT   = '자재코드'.
    APPEND GS_FCAT TO GT_FCAT2.
  
    CLEAR GS_FCAT.
    GS_FCAT-FIELDNAME = 'MENGE'.
    GS_FCAT-COLTEXT   = '수량'.
    APPEND GS_FCAT TO GT_FCAT2.
  
    CLEAR GS_FCAT.
    GS_FCAT-FIELDNAME = 'MEINS'.
    GS_FCAT-COLTEXT   = '단위'.
    APPEND GS_FCAT TO GT_FCAT2.
  
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
  
    CLEAR : GS_LAYOUT1, GS_LAYOUT2.
  
    GS_LAYOUT1-ZEBRA      = 'X'.
    GS_LAYOUT1-CWIDTH_OPT = 'A'.
    GS_LAYOUT1-SEL_MODE   = 'D'.
  
    GS_LAYOUT2-ZEBRA      = 'X'.
    GS_LAYOUT2-CWIDTH_OPT = 'A'.
    GS_LAYOUT2-SEL_MODE   = 'D'.
  
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
  
    CALL METHOD GO_GRID1->SET_TABLE_FOR_FIRST_DISPLAY
      EXPORTING
        IS_LAYOUT       = GS_LAYOUT1
      CHANGING
        IT_OUTTAB       = GT_DISP_TOP
        IT_FIELDCATALOG = GT_FCAT1.
  
    CALL METHOD GO_GRID2->SET_TABLE_FOR_FIRST_DISPLAY
      EXPORTING
        IS_LAYOUT       = GS_LAYOUT2
      CHANGING
        IT_OUTTAB       = GT_DISP_BOTTOM
        IT_FIELDCATALOG = GT_FCAT2.
  
  
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
  
    CLEAR : GT_DISP_TOP, GT_DISP_BOTTOM.
  
    SELECT EBELN BUKRS LIFNR
      INTO CORRESPONDING FIELDS OF TABLE GT_DISP_TOP
      FROM EKKO
     WHERE BSART IN S_BSART.
  
  ENDFORM.
*&---------------------------------------------------------------------*
*& Form REFRESH_ALV
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
  FORM REFRESH_ALV .
  
    CALL METHOD GO_GRID1->REFRESH_TABLE_DISPLAY.
    CALL METHOD GO_GRID2->REFRESH_TABLE_DISPLAY.
  
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
  
    SET HANDLER GO_EVENT_RECEIVER->HANDLE_DOUBLE_CLICK
            FOR GO_GRID1.
  
    SET HANDLER GO_EVENT_RECEIVER->HANDLE_HOTSPOT_CLICK
            FOR GO_GRID1.
  
    SET HANDLER GO_EVENT_RECEIVER->HANDLE_TOOLBAR
            FOR GO_GRID1.
  
    SET HANDLER GO_EVENT_RECEIVER->HANDLE_USER_COMMAND
            FOR GO_GRID1.
  
    SET HANDLER GO_EVENT_RECEIVER->HANDLE_DOUBLE_CLICK
            FOR GO_GRID2.
  
    SET HANDLER GO_EVENT_RECEIVER->HANDLE_HOTSPOT_CLICK
            FOR GO_GRID2.
  
    SET HANDLER GO_EVENT_RECEIVER->HANDLE_TOOLBAR
            FOR GO_GRID2.
  
    SET HANDLER GO_EVENT_RECEIVER->HANDLE_USER_COMMAND
            FOR GO_GRID2.
  
  ENDFORM.
*&---------------------------------------------------------------------*
*& Form HANDLE_DOUBLE_CLICK
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*      -->P_E_ROW  text
*      -->P_E_COLUMN  text
*      -->P_SENDER  text
*&---------------------------------------------------------------------*
  FORM HANDLE_DOUBLE_CLICK  USING    PS_ROW TYPE LVC_S_ROW
                                     PS_COL TYPE LVC_S_COL
                                     PO_SENDER.
  
    CASE PO_SENDER.
      WHEN GO_GRID1.
        READ TABLE GT_DISP_TOP INTO GS_DISP_TOP INDEX PS_ROW-INDEX.
        IF SY-SUBRC = 0.
          CLEAR GT_DISP_BOTTOM.
          SELECT EBELN EBELP MATNR MENGE MEINS
            INTO CORRESPONDING FIELDS OF TABLE GT_DISP_BOTTOM
            FROM EKPO
           WHERE EBELN = GS_DISP_TOP-EBELN.
        ENDIF.
  
        CALL METHOD GO_GRID2->REFRESH_TABLE_DISPLAY.
  
  
      WHEN GO_GRID2.
    ENDCASE.
  
  
  ENDFORM.
*&---------------------------------------------------------------------*
*& Form HANDLE_HOTSPOT_CLICK
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*      -->P_E_ROW_ID  text
*      -->P_E_COLUMN_ID  text
*      -->P_SENDER  text
*&---------------------------------------------------------------------*
  FORM HANDLE_HOTSPOT_CLICK  USING    PS_ROW TYPE LVC_S_ROW
                                      PS_COL TYPE LVC_S_COL
                                      PO_SENDER.
  
    CASE PO_SENDER.
      WHEN GO_GRID1.
      WHEN GO_GRID2.
    ENDCASE.
  
  ENDFORM.
*&---------------------------------------------------------------------*
*& Form HANDLE_TOOLBAR
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*      -->P_E_OBJECT  text
*      -->P_SENDER  text
*&---------------------------------------------------------------------*
  FORM HANDLE_TOOLBAR  USING    PO_OBJECT TYPE REF TO CL_ALV_EVENT_TOOLBAR_SET
                                PO_SENDER.
  
    DATA : LS_TOOLBAR TYPE STB_BUTTON.
  
    CASE PO_SENDER.
      WHEN GO_GRID1.
        LS_TOOLBAR-FUNCTION = 'SAVE'.
        LS_TOOLBAR-ICON     = ICON_SYSTEM_SAVE.
        LS_TOOLBAR-TEXT     = ' 저장'.
  
        APPEND LS_TOOLBAR TO PO_OBJECT->MT_TOOLBAR.
  
  
      WHEN GO_GRID2.
        LS_TOOLBAR-FUNCTION = 'SAVE'.
        LS_TOOLBAR-ICON     = ICON_SYSTEM_SAVE.
        LS_TOOLBAR-TEXT     = ' 저장'.
  
        APPEND LS_TOOLBAR TO PO_OBJECT->MT_TOOLBAR.
  
    ENDCASE.
  
  ENDFORM.
*&---------------------------------------------------------------------*
*& Form HANDLE_USER_COMMAND
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*      -->P_E_UCOMM  text
*      -->P_SENDER  text
*&---------------------------------------------------------------------*
  FORM HANDLE_USER_COMMAND  USING    P_UCOMM
                                     PO_SENDER.
  
    CASE PO_SENDER.

      WHEN GO_GRID1.
        CASE P_UCOMM.
          WHEN 'SAVE'.  
        ENDCASE.
    
      WHEN GO_GRID2.
        CASE P_UCOMM.
          WHEN 'SAVE'. 
        ENDCASE.  

    ENDCASE.
  
  ENDFORM.