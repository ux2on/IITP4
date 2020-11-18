*&---------------------------------------------------------------------*
*& Include          ZR17_0060F01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Form CREATE_MATERIAL
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM CREATE_MATERIAL .

    CLEAR : GT_BDC.
  
    PERFORM SET_BDC_TAB USING : 'SAPLMGMM' '0060' 'X' '' '',
                                '' '' '' 'BDC_OKCODE' '=ENTR',
                                '' '' '' 'RMMG1-MATNR' P_MATNR,
                                '' '' '' 'RMMG1-MBRSH' 'M',
                                '' '' '' 'RMMG1-MTART' 'FERT'.
  
    PERFORM SET_BDC_TAB USING : 'SAPLMGMM' '0070' 'X' '' '',
                                '' '' '' 'BDC_OKCODE' '=ENTR',
                                '' '' '' 'MSICHTAUSW-KZSEL(01)' 'X'.
  
    PERFORM SET_BDC_TAB USING : 'SAPLMGMM' '4004' 'X' '' '',
                                '' '' '' 'BDC_OKCODE' '=BU',
                                '' '' '' 'MAKT-MAKTX' P_MAKTX,
                                '' '' '' 'MARA-MEINS' 'EA'.
  
  
    CLEAR GS_OPT.
    GS_OPT-DISMODE = 'N'.   "N, E
    GS_OPT-UPDMODE = 'S'.
  
    CALL TRANSACTION 'MM01' USING GT_BDC
                            OPTIONS FROM GS_OPT
                            MESSAGES INTO GT_MSG.
    READ TABLE GT_MSG INTO GS_MSG WITH KEY MSGID = 'M3'
                                           MSGNR = '800'.
    IF SY-SUBRC = 0.
      "성공처리
      MESSAGE S009 WITH P_MATNR.  "자재코드 & 가 생성되었습니다.
    ELSE.
      "실패처리
    ENDIF.
  
  
  ENDFORM.
*&---------------------------------------------------------------------*
*& Form SET_BDC_TAB
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*      -->P_       text
*      -->P_       text
*      -->P_       text
*      -->P_       text
*      -->P_       text
*&---------------------------------------------------------------------*
  FORM SET_BDC_TAB  USING    P_PROGRAM
                             P_DYNPRO
                             P_DYNBEGIN
                             P_FNAM
                             P_FVAL.
  
    CLEAR GS_BDC.
    GS_BDC-PROGRAM  = P_PROGRAM.
    GS_BDC-DYNPRO   = P_DYNPRO.
    GS_BDC-DYNBEGIN = P_DYNBEGIN.
    GS_BDC-FNAM     = P_FNAM.
    GS_BDC-FVAL     = P_FVAL.
  
    APPEND GS_BDC TO GT_BDC.
  
  
  ENDFORM.