*&---------------------------------------------------------------------*
*& Report ZR17_0050
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZR17_0050 MESSAGE-ID ZM17.

INCLUDE ZR17_0050TOP.
INCLUDE ZR17_0050CLS.
INCLUDE ZR17_0050SEL.
INCLUDE ZR17_0050F01.
INCLUDE ZR17_0050I01.
INCLUDE ZR17_0050O01.

START-OF-SELECTION.

  PERFORM GET_DATA.

  CALL SCREEN '0100'.