*&---------------------------------------------------------------------*
*& Report ZR17_0010
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZR17_0010 MESSAGE-ID ZM17.

INCLUDE ZR17_0010TOP.
INCLUDE ZR17_0010SEL.
INCLUDE ZR17_0010F01.
INCLUDE ZR17_0010I01.
INCLUDE ZR17_0010O01.

START-OF-SELECTION.

  PERFORM GET_DATA.

  CALL SCREEN '0100'.