*&---------------------------------------------------------------------*
*& Include          ZR17_0020O01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Module STATUS_0100 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE STATUS_0100 OUTPUT.

* 만약 조회 티코드이면 저장버튼 보이지 않게
  IF SY-TCODE = 'ZR17_0020_D'.
    APPEND 'SAVE' TO GT_EXCLUDE.
  ENDIF.

  SET PF-STATUS '0100' EXCLUDING GT_EXCLUDE.
  SET TITLEBAR '0100'.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module SET_ALV_0100 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE SET_ALV_0100 OUTPUT.

  PERFORM SET_ALV_0100.

ENDMODULE.