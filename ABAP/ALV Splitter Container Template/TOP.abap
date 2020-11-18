*&---------------------------------------------------------------------*
*& Include          ZR17_0003TOP
*&---------------------------------------------------------------------*

TABLES : EKKO.

DATA : BEGIN OF GS_DISP_TOP,
         EBELN TYPE EKKO-EBELN,
         BUKRS TYPE EKKO-BUKRS,
         LIFNR TYPE EKKO-LIFNR,
       END OF GS_DISP_TOP.
DATA : GT_DISP_TOP LIKE TABLE OF GS_DISP_TOP.

DATA : BEGIN OF GS_DISP_BOTTOM,
         EBELN TYPE EKPO-EBELN,
         EBELP TYPE EKPO-EBELP,
         MATNR TYPE EKPO-MATNR,
         MENGE TYPE EKPO-MENGE,
         MEINS TYPE EKPO-MEINS,
       END OF GS_DISP_BOTTOM.
DATA : GT_DISP_BOTTOM LIKE TABLE OF GS_DISP_BOTTOM.

************************************************************************
*---- ALV 관련 선언 ----
************************************************************************
DATA : GO_DOCKING    TYPE REF TO CL_GUI_DOCKING_CONTAINER,
     GO_SPLITTER   TYPE REF TO CL_GUI_SPLITTER_CONTAINER,
     GO_CONTAINER1 TYPE REF TO CL_GUI_CONTAINER,
     GO_CONTAINER2 TYPE REF TO CL_GUI_CONTAINER,

     GO_GRID1      TYPE REF TO CL_GUI_ALV_GRID,
     GO_GRID2      TYPE REF TO CL_GUI_ALV_GRID.

DATA : GS_FCAT    TYPE LVC_S_FCAT,
     GT_FCAT1   TYPE LVC_T_FCAT,
     GT_FCAT2   TYPE LVC_T_FCAT,
     GS_LAYOUT1 TYPE LVC_S_LAYO,
     GS_LAYOUT2 TYPE LVC_S_LAYO.