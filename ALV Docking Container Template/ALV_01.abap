*&---------------------------------------------------------------------*
*& Report ZR17_0001
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZR17_0001 MESSAGE-ID ZM17.

INCLUDE ZR17_0001TOP.
INCLUDE ZR17_0001F01.
INCLUDE ZR17_0001I01.
INCLUDE ZR17_0001O01.

START-OF-SELECTION.

  PERFORM GET_DATA.

  CALL SCREEN '0100'.