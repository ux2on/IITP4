*&---------------------------------------------------------------------*
*& Report ZR17_0000
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZR17_0000 MESSAGE-ID ZM17.

INCLUDE ZR17_0000TOP.
INCLUDE ZR17_0000F01.
INCLUDE ZR17_0000I01.
INCLUDE ZR17_0000O01.

START-OF-SELECTION.

  PERFORM GET_DATA.

  CALL SCREEN '0100'.