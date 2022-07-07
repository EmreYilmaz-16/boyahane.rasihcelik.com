<cfset attributes.DELIVER_DATE_1="#dateformat(START_DATE,'yyyy-mm-dd')#">
<cfset attributes.DETAIL="">
<cfset attributes.ORDER_ID_1="">
<cfset attributes.ORDER_ROW_ID_1="">
<cfset attributes.IS_LINE_NUMBER_1="0">
<cfset attributes.IS_OPERATOR_DISPLAY_1="1">
<cfset attributes.PRODUCTION_ROW_COUNT_1="0">
<cfset attributes.STOCK_RESERVED="1">
<cfset attributes.SHOW_LOT_NO_COUNTER="0">
<cfset attributes.PRODUCT_AMOUNT_1_0="1">
<cfset attributes.IS_STAGE="4">
<cfset attributes.PROJECT_ID_1="">
<cfset attributes.PROCESS_STAGE="59">
<cfset attributes.IS_TIME_CALCULATION_1="0">
<cfset attributes.LOT_NO="#getLot.PRODUCTION_LOT_NO#-#getLot.PRODUCTION_LOT_NUMBER+1#">
<cfset attributes.FINISH_DATE_1="#dateformat(FINISH_DATE,'yyyy-mm-dd')#">
<cfset attributes.START_DATE_1="#dateformat(START_DATE,'yyyy-mm-dd')#">
<cfset attributes.station_id_1_0="#data.ev.STATION_ID#,0,0,0,-1,4,4,4,4">


<cfset attributes.FINISH_H_1="#hour(FINISH_DATE)#">
<cfset attributes.FINISH_M_1="#minute(FINISH_DATE)#">
<cfset attributes.START_H_1="#hour(START_DATE)#">
<cfset attributes.START_M_1="#minute(START_DATE)#">
 <cfset attributes.DELIVER_DATE_1=NEW_START_DATE>
<cfset attributes.PRODUCT_VALUES_1_0="#getOperationTime.STOCK_ID#,0,0,0,#getOperationTime.SPECT_MAIN_ID#">