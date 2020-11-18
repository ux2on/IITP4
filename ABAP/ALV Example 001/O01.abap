*&---------------------------------------------------------------------*
*& Include          ZR17_0010O01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Module STATUS_0100 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE STATUS_0100 OUTPUT.
  SET PF-STATUS '0100'.
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

*&---------------------------------------------------------------------*
*& Module STATUS_0200 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE STATUS_0200 OUTPUT.
  SET PF-STATUS '0200'.
  SET TITLEBAR '0200'.
ENDMODULE.

*&---------------------------------------------------------------------*
*& Module SET_SCREEN_MODE_0200 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE SET_SCREEN_MODE_0200 OUTPUT.

  LOOP AT SCREEN INTO SCREEN.

* 수행 모드에 따른 필드 INPUT 가능여부 제어
    CASE GS_DISP_0200-MODE.
      WHEN GC_MODE_INSERT.  "등록일때 입력불가 필드 셋팅
        IF SCREEN-NAME = 'GS_DISP_0200-RETDT'.
          SCREEN-INPUT = 0.
        ENDIF.

      WHEN GC_MODE_UPDATE.  "변경일때 입력불가 필드 셋팅
        IF SCREEN-NAME = 'GS_DISP_0200-EMPNO' OR
           SCREEN-NAME = 'GS_DISP_0200-RETDT'.
          SCREEN-INPUT = 0.
        ENDIF.

      WHEN GC_MODE_RETIRE.  "퇴직일때 입력불가 필드 셋팅
        IF SCREEN-NAME = 'GS_DISP_0200-EMPNO' OR
           SCREEN-NAME = 'GS_DISP_0200-NAME' OR
           SCREEN-NAME = 'GS_DISP_0200-DEPT' OR
           SCREEN-NAME = 'GS_DISP_0200-ENTDT' OR
           SCREEN-NAME = 'GS_DISP_0200-GRADE' OR
           SCREEN-NAME = 'GS_DISP_0200-PHONE' OR
           SCREEN-NAME = 'GS_DISP_0200-ADDR_H' OR
           SCREEN-NAME = 'GS_DISP_0200-ADDR_W' OR
           SCREEN-NAME = 'GS_DISP_0200-SALARY'.

          SCREEN-INPUT = 0.
        ENDIF.
    ENDCASE.

* 수행 모드에 따른 필수 필드 제어
    CASE GS_DISP_0200-MODE.
      WHEN GC_MODE_INSERT.
        IF SCREEN-NAME = 'GS_DISP_0200-ENTDT'.
          SCREEN-REQUIRED = '1'.
        ENDIF.

      WHEN GC_MODE_UPDATE.
        IF SCREEN-NAME = 'GS_DISP_0200-ENTDT'.
          SCREEN-REQUIRED = '1'.
        ENDIF.

      WHEN GC_MODE_RETIRE.
        IF SCREEN-NAME = 'GS_DISP_0200-RETDT'.
          SCREEN-REQUIRED = '1'.
        ENDIF.
    ENDCASE.

    MODIFY SCREEN FROM SCREEN.

    
  ENDLOOP.


ENDMODULE.