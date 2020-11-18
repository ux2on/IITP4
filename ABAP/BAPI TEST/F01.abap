*&---------------------------------------------------------------------*
*& Include          ZR17_0040F01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Form CHANGE_SALES_PERSON
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM CHANGE_SALES_PERSON .

    DATA : LT_RETURN  TYPE TABLE OF BAPIRET2,
           LS_RETURN  TYPE          BAPIRET2,
           LS_HEADER  TYPE BAPIMEPOHEADER,
           LS_HEADERX TYPE BAPIMEPOHEADERX.
  
    LS_HEADER-SALES_PERS  = P_VERKF.
    LS_HEADERX-SALES_PERS = 'X'.
  
    CALL FUNCTION 'BAPI_PO_CHANGE'
      EXPORTING
        PURCHASEORDER = P_EBELN
        POHEADER      = LS_HEADER
        POHEADERX     = LS_HEADERX
      TABLES
        RETURN        = LT_RETURN.
    READ TABLE LT_RETURN INTO LS_RETURN
                         WITH KEY TYPE = 'E'.
    IF SY-SUBRC NE 0.
      CALL FUNCTION 'BAPI_TRANSACTION_COMMIT'
        EXPORTING
          WAIT          = 'X'.
*     IMPORTING
*       RETURN        =
                .
  
    ELSE.
  
    ENDIF.
  
  ENDFORM.