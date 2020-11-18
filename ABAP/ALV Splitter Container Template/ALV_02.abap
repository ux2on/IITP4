*&---------------------------------------------------------------------*
*& Report ZR17_0003
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZR17_0003 MESSAGE-ID ZM17.

INCLUDE ZR17_0003TOP.
INCLUDE ZR17_0003CLS.
INCLUDE ZR17_0003SEL.
INCLUDE ZR17_0003F01.
INCLUDE ZR17_0003I01.
INCLUDE ZR17_0003O01.

START-OF-SELECTION.

  PERFORM GET_DATA.

  CALL SCREEN '0100'.