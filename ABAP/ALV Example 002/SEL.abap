*&---------------------------------------------------------------------*
*& Include          ZR17_0020SEL
*&---------------------------------------------------------------------*
SELECTION-SCREEN BEGIN OF BLOCK BL1 WITH FRAME TITLE TEXT-T01.
  SELECT-OPTIONS : S_EMPNO  FOR ZT17_0010-EMPNO,
                   S_DEPT   FOR ZT17_0010-DEPT,
                   S_ENTDT  FOR ZT17_0010-ENTDT,
                   S_GRADE  FOR ZT17_0010-GRADE,
                   S_STATUS FOR ZT17_0010-STATUS.
SELECTION-SCREEN END OF BLOCK BL1.