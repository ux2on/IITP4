*&---------------------------------------------------------------------*
*& Include          ZR17_0000F01
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
    GS_FCAT-FIELDNAME = 'MATNR'.
    GS_FCAT-COLTEXT   = '자재코드'.
    GS_FCAT-KEY       = 'X'.
    APPEND GS_FCAT TO GT_FCAT.
  
    CLEAR GS_FCAT.
    GS_FCAT-FIELDNAME = 'ERSDA'.
    GS_FCAT-COLTEXT   = '생성일'.
    APPEND GS_FCAT TO GT_FCAT.
  
    CLEAR GS_FCAT.
    GS_FCAT-FIELDNAME = 'ERNAM'.
    GS_FCAT-COLTEXT   = '생성자'.
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
*& Form GET_DATA
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
  FORM GET_DATA .
  
    CLEAR GT_DISP.
  
    SELECT MATNR ERSDA ERNAM
      INTO CORRESPONDING FIELDS OF TABLE GT_DISP
      FROM MARA
      UP TO 10 ROWS.
  
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