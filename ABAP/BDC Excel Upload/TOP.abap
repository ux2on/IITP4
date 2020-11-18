*&---------------------------------------------------------------------*
*& Include          ZR17_0070TOP
*&---------------------------------------------------------------------*

DATA : BEGIN OF GS_DISP,
         STAT   TYPE ICON-ID,
         MATNR  TYPE MARA-MATNR,
         MAKTX  TYPE MAKT-MAKTX,
         MTART  TYPE MARA-MTART,
         MBRSH  TYPE MARA-MBRSH,
         MEINS  TYPE MARA-MEINS,
         RESULT TYPE CHAR200,
       END OF GS_DISP.
DATA : GT_DISP LIKE TABLE OF GS_DISP.

DATA : BEGIN OF GS_EXCEL,
         MATNR  TYPE CHAR40,
         MAKTX  TYPE CHAR40,
         MTART  TYPE CHAR04,
         MBRSH  TYPE CHAR01,
         MEINS  TYPE CHAR03,
       END OF GS_EXCEL.
DATA : GT_EXCEL LIKE TABLE OF GS_EXCEL.

DATA : GV_OKCODE TYPE SY-UCOMM.


************************************************************************
*---- BDC 관련 선언 ----
************************************************************************
DATA : GT_BDC TYPE TABLE OF BDCDATA,
       GS_BDC TYPE          BDCDATA,
       GS_OPT TYPE          CTU_PARAMS,
       GT_MSG TYPE TABLE OF BDCMSGCOLL,
       GS_MSG TYPE          BDCMSGCOLL.

************************************************************************
*---- ALV 관련 선언 ----
************************************************************************
DATA : GO_CONTAINER TYPE REF TO CL_GUI_CUSTOM_CONTAINER,
       GO_GRID      TYPE REF TO CL_GUI_ALV_GRID.

DATA : GT_FCAT  TYPE LVC_T_FCAT,
       GS_FCAT   TYPE LVC_S_FCAT,
       GS_LAYOUT TYPE LVC_S_LAYO.