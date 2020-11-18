*&---------------------------------------------------------------------*
*& Report ZR17_0020
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZR17_0020 MESSAGE-ID ZM17.

INCLUDE ZR17_0020TOP.
INCLUDE ZR17_0020CLS.
INCLUDE ZR17_0020SEL.
INCLUDE ZR17_0020F01.
INCLUDE ZR17_0020I01.
INCLUDE ZR17_0020O01.

START-OF-SELECTION.

  PERFORM GET_DATA.

  CALL SCREEN '0100'.