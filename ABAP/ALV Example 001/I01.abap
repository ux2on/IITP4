*&---------------------------------------------------------------------*
*& Include          ZR17_0010I01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  EXIT_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE EXIT_0100 INPUT.

  LEAVE TO SCREEN 0.

ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE USER_COMMAND_0100 INPUT.

  CASE GV_OKCODE.
    WHEN 'REGT'.
      PERFORM CALL_CREATE_SCREEN.

    WHEN 'CHGE'.
      PERFORM CALL_CHANGE_SCREEN.

    WHEN 'RET'.
      PERFORM CALL_RET_SCREEN.
  ENDCASE.

  CLEAR GV_OKCODE.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  EXIT_0200  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE EXIT_0200 INPUT.

  LEAVE TO SCREEN 0.

ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0200  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE USER_COMMAND_0200 INPUT.

  CASE GV_OKCODE.
    WHEN 'SAVE'.
      CASE GS_DISP_0200-MODE.
        WHEN GC_MODE_INSERT.
          PERFORM CREATE_DATA.    "생성일때

        WHEN GC_MODE_UPDATE.
          PERFORM UPDATE_DATA.    "변경일때

        WHEN GC_MODE_RETIRE.
          PERFORM RETIRE_DATA.    "퇴직일때

      ENDCASE.


  ENDCASE.

ENDMODULE.