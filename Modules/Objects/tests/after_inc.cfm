            <cfset attributes.DELIVER_DATE_1="#dateformat(data.ev.endDate,'yyyy-mm-dd')#">
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
            <cfset attributes.FINISH_DATE_1="#dateformat(data.ev.endDate,'yyyy-mm-dd')#">
            <cfset attributes.START_DATE_1="#dateformat(data.ev.endDate,'yyyy-mm-dd')#">
<cfset attributes.station_id_1_0="#data.ev.STATION_ID#,0,0,0,-1,4,4,4,4">
<cfoutput>
<CFSET START_DATE=dateAdd("h", 3, data.ev.endDate)>
<cfdump  var="#attributes#">
<cfswitch expression="#data.type.tip#">
<cfcase value="0">
<cfquery name="getOp" datasource="#dsn3#">
    select PT.STOCK_ID,OT.O_MINUTE,SM.SPECT_MAIN_ID from catalyst_prod_1.PRODUCT_TREE AS PT 
LEFT JOIN catalyst_prod_1.OPERATION_TYPES AS OT ON OT.OPERATION_TYPE_ID=7
LEFT JOIN catalyst_prod_1.SPECT_MAIN AS SM ON SM.STOCK_ID=PT.STOCK_ID
where PT.OPERATION_TYPE_ID=7
</cfquery>
</cfcase>
<cfcase value="1">
<cfquery name="getOp" datasource="#dsn3#">
    select PT.STOCK_ID,OT.O_MINUTE,SM.SPECT_MAIN_ID from catalyst_prod_1.PRODUCT_TREE AS PT 
LEFT JOIN catalyst_prod_1.OPERATION_TYPES AS OT ON OT.OPERATION_TYPE_ID=8
LEFT JOIN catalyst_prod_1.SPECT_MAIN AS SM ON SM.STOCK_ID=PT.STOCK_ID
where PT.OPERATION_TYPE_ID=8
</cfquery>
</cfcase>
<cfcase value="2">
<cfquery name="getOp" datasource="#dsn3#">
    select PT.STOCK_ID,OT.O_MINUTE,SM.SPECT_MAIN_ID from catalyst_prod_1.PRODUCT_TREE AS PT 
LEFT JOIN catalyst_prod_1.OPERATION_TYPES AS OT ON OT.OPERATION_TYPE_ID=9
LEFT JOIN catalyst_prod_1.SPECT_MAIN AS SM ON SM.STOCK_ID=PT.STOCK_ID
where PT.OPERATION_TYPE_ID=9
</cfquery>
</cfcase>

</cfswitch>
<CFSET END_DATE=dateAdd("N", getOp.O_MINUTE, START_DATE)>

</cfoutput>
<cfset attributes.FINISH_H_1="#hour(END_DATE)#">
<cfset attributes.FINISH_M_1="#minute(END_DATE)#">
<cfset attributes.START_H_1="#hour(START_DATE)#">
<cfset attributes.START_M_1="#minute(START_DATE)#">
 <cfset attributes.DELIVER_DATE_1=END_DATE>
<cfset attributes.PRODUCT_VALUES_1_0="#getOp.STOCK_ID#,0,0,0,#getOp.SPECT_MAIN_ID#">

