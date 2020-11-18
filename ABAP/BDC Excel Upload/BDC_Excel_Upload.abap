*&---------------------------------------------------------------------*
*& Report ZR17_0070
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZR17_0070 MESSAGE-ID ZM17.

INCLUDE ZR17_0070TOP.
INCLUDE ZR17_0070SEL.
INCLUDE ZR17_0070F01.
INCLUDE ZR17_0070I01.
INCLUDE ZR17_0070O01.

INITIALIZATION.
  "SELECTION-SCREEN 출력 이전에 수행되며 초기값 셋팅을 주로 함

AT SELECTION-SCREEN OUTPUT.
  "출력화면 모드 제어(INPUT, DISPLAY)

AT SELECTION-SCREEN ON VALUE-REQUEST FOR P_PATH.
  PERFORM GET_FILE_PATH.

START-OF-SELECTION.

  PERFORM UPLOAD_FROM_EXCEL.

  PERFORM CONVERT_TO_DISPLAY_FORMAT.

  CALL SCREEN '0100'.