*&---------------------------------------------------------------------*
*& Include          ZR17_0010TOP
*&---------------------------------------------------------------------*

TABLES : ZT17_0010.

CONSTANTS : GC_DOM_DEPT       TYPE DOMNAME          VALUE 'ZD17_DEPT',
            GC_DOM_GRADE      TYPE DOMNAME          VALUE 'ZD17_GRADE',
            GC_DOM_STATUS     TYPE DOMNAME          VALUE 'ZD17_STATUS',
            GC_STATUS_DEFAULT TYPE ZT17_0010-STATUS VALUE '1',  "재직
            GC_STATUS_RETIRE  TYPE ZT17_0010-STATUS VALUE '3',  "퇴직
            GC_WAERS_DEFAULT  TYPE ZT17_0010-WAERS  VALUE 'JPY',
            GC_MODE_INSERT    TYPE C                VALUE 'I',  "등록
            GC_MODE_UPDATE    TYPE C                VALUE 'U',  "변경
            GC_MODE_RETIRE    TYPE C                VALUE 'R'.  "퇴직

* 화면출력 용(SCREEN 100)
DATA : BEGIN OF GS_DISP.
         INCLUDE STRUCTURE ZT17_0010.
DATA :   DEPT_T   TYPE DD07T-DDTEXT,
         GRADE_T  TYPE DD07T-DDTEXT,
         STATUS_T TYPE DD07T-DDTEXT,
       END OF GS_DISP.
DATA : GT_DISP LIKE TABLE OF GS_DISP.

* 화면출력 용(SCREEN 200)
DATA : BEGIN OF GS_DISP_0200.
         INCLUDE STRUCTURE ZT17_0010.
DATA :   MODE  TYPE C,
         INDEX TYPE LVC_S_ROID-ROW_ID,
       END OF GS_DISP_0200.

* 도메인 텍스트 처리 용
DATA : BEGIN OF GS_TEXT,
         CODE TYPE DD07T-DOMVALUE_L,
         TEXT TYPE DD07T-DDTEXT,
       END OF GS_TEXT.
DATA : GT_DEPT   LIKE TABLE OF GS_TEXT,   "부서내역
       GT_GRADE  LIKE TABLE OF GS_TEXT,   "직급내역
       GT_STATUS LIKE TABLE OF GS_TEXT.   "재직구분 내역

DATA : GV_OKCODE TYPE SY-UCOMM.

************************************************************************
*---- ALV 관련 선언 ----
************************************************************************
DATA : GO_CONTAINER TYPE REF TO CL_GUI_CUSTOM_CONTAINER,
       GO_GRID      TYPE REF TO CL_GUI_ALV_GRID.

DATA : GT_FCAT  TYPE LVC_T_FCAT,
       GS_FCAT   TYPE LVC_S_FCAT,
       GS_LAYOUT TYPE LVC_S_LAYO.