*&---------------------------------------------------------------------*
*& Include          ZR17_0050TOP
*&---------------------------------------------------------------------*

TABLES : EKKO.

DATA : BEGIN OF GS_DISP,
         STAT   TYPE ICON-ID,
         EBELN  TYPE EKKO-EBELN,
         BUKRS  TYPE EKKO-BUKRS,
         BSART  TYPE EKKO-BSART,
         ERNAM  TYPE EKKO-ERNAM,
         LIFNR  TYPE EKKO-LIFNR,
         ZTERM  TYPE EKKO-ZTERM,
         VERKF  TYPE EKKO-VERKF,
         TELF1  TYPE EKKO-TELF1,
         RESULT TYPE CHAR200,
       END OF GS_DISP.
DATA : GT_DISP LIKE TABLE OF GS_DISP.

DATA : GV_OKCODE TYPE SY-UCOMM.

************************************************************************
*---- ALV 관련 선언 ----
************************************************************************
DATA : GO_CONTAINER TYPE REF TO CL_GUI_CUSTOM_CONTAINER,
       GO_GRID      TYPE REF TO CL_GUI_ALV_GRID.

DATA : GT_FCAT  TYPE LVC_T_FCAT,
       GS_FCAT   TYPE LVC_S_FCAT,
       GS_LAYOUT TYPE LVC_S_LAYO.