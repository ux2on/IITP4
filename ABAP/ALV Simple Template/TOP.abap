*&---------------------------------------------------------------------*
*& Include          ZR17_0000TOP
*&---------------------------------------------------------------------*

DATA : BEGIN OF GS_DISP,
         MATNR TYPE MARA-MATNR,
         ERSDA TYPE MARA-ERSDA,
         ERNAM TYPE MARA-ERNAM,
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