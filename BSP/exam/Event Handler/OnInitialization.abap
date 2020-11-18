
  DATA: L_COND TYPE STRING.
  CONCATENATE ` mandt = '` SY-MANDT `'` INTO L_COND.

  IF P_NAME IS NOT INITIAL.
    CONCATENATE L_COND ` and NAME like '%` p_name `%'` INTO L_COND.
  ENDIF.

  SELECT * INTO CORRESPONDING FIELDS OF TABLE GT_ZEXAM
    FROM ZEXAM
   WHERE (L_COND) " mandt = 'sy-mandt' and ID like '%p_id%'
    ORDER BY ID.