
<div style="box-shadow:1px 1px 20px 0px #c4c7ca;padding:0.5%">
        <div style="box-shadow:1px 1px 20px 0px #c4c7ca;padding:0.5%;margin-bottom:10px"><span style="text-shadow: 2px 1px 2px #93beff" class="text-primary fs-3">Birleşen Operasyon Listesi</span></div>
<cfquery name="getBirlesen" datasource="#dsn3#">
SELECT 
BB.ID,
PO.P_ORDER_NO as ON1,
PO.SPECT_VAR_NAME AS SN1,
PO.P_ORDER_ID AS PID1,
PO2.SPECT_VAR_NAME AS SN2,
PO2.P_ORDER_ID AS PID2,
PO2.P_ORDER_NO AS ON2,
POR.ORDER_ID,
O.ORDER_NUMBER,
O.ORDER_HEAD,
C.NICKNAME,
PO.QUANTITY AS QUA1,
OT.OPERATION_TYPE_ID,
PO2.QUANTITY AS QUA2 FROM catalyst_prod_1.BOYAHANE_BIRLESEN AS BB
LEFT JOIN catalyst_prod_1.PRODUCTION_ORDERS AS PO ON PO.P_ORDER_ID=BB.ORDER_ID
LEFT JOIN catalyst_prod_1.PRODUCTION_ORDERS AS PO2 ON PO2.P_ORDER_ID=BB.P_ORDER_ID
LEFT JOIN catalyst_prod_1.OPERATION_TYPES AS OT ON OT.OPERATION_TYPE_ID=BB.OPERATION_TYPE_ID
LEFT JOIN catalyst_prod_1.PRODUCTION_ORDERS_ROW AS POR ON POR.PRODUCTION_ORDER_ID=PO.P_ORDER_ID
LEFT JOIN catalyst_prod_1.ORDERS AS O ON O.ORDER_ID=POR.ORDER_ID
LEFT JOIN catalyst_prod.COMPANY AS C ON C.COMPANY_ID=O.COMPANY_ID WHERE PO2.P_ORDER_ID=#ATTRIBUTES.P_ORDER_ID#
</cfquery>

<table class="table table-sm">

<cfoutput query="getBirlesen">
<tr>
<td>#NICKNAME#</td>
<td>#ORDER_HEAD#</td>
<td>#ORDER_NUMBER#</td>
<td>#ON1#</td>
<td>#QUA1#</td>
<td>#SN1#</td>
<td>#SN2#</td>
<td>#QUA2#</td>
<td><a class="btn btn-sm btn-outline-danger" onclick="openModal_partner('index.cfm?fuseaction=del_birlesen&id=#ID#&qua=#QUA1#&order_1=#PID1#&order_2=#PID2#&ot_id=#OPERATION_TYPE_ID#')"><i class="fas fa-unlink" style="font-size: 48px;"></i></a></td>
</tr>
</cfoutput>
</table>
</div>