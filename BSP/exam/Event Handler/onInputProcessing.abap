* ★★★★★ 코드 수정중 ★★★★★ 

DATA WA_CHART TYPE ZEXAM.

IF EVENT_ID EQ 'chart'.

  SELECT SINGLE *
    FROM ZEXAM
    INTO WA_CHART
    WHERE ID = P_CHART_ID.

  CHART_1 = WA_CHART-MTEST1.
  CHART_2 = WA_CHART-FTEST1.
  CHART_3 = WA_CHART-MTEST2.
  CHART_4 = WA_CHART-FTEST2.

ENDIF.