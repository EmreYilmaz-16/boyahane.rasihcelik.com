
<cfquery name="getOrders" datasource="#dsn3#">
SELECT O.ORDER_HEAD
	,PO.P_ORDER_ID
	,C.NICKNAME
	,PO.QUANTITY
    ,POR.ORDER_ROW_ID
	,S.PROPERTY
	,O.ORDER_ID
	,S.STOCK_ID
	,S.PRODUCT_NAME
	,POP.P_OPERATION_ID
	,POP.OPERATION_TYPE_ID
	,WS.STATION_NAME
	,OT.OPERATION_TYPE
	,PO.PROD_ORDER_STAGE
	,PTR.STAGE
    ,PO.IS_COLLECTED
FROM catalyst_prod_1.PRODUCTION_ORDERS AS PO
LEFT JOIN catalyst_prod_1.PRODUCTION_ORDERS_ROW AS POR   ON PO.P_ORDER_ID = POR.PRODUCTION_ORDER_ID
LEFT JOIN catalyst_prod_1.ORDERS AS O ON O.ORDER_ID = POR.ORDER_ID
LEFT JOIN catalyst_prod_1.ORDER_ROW AS ORR ON ORR.ORDER_ROW_ID = POR.ORDER_ROW_ID
LEFT JOIN catalyst_prod.COMPANY AS C ON C.COMPANY_ID = O.COMPANY_ID
LEFT JOIN catalyst_prod_1.PRODUCTION_OPERATION AS POP ON POP.P_ORDER_ID = PO.P_ORDER_ID
LEFT JOIN catalyst_prod_1.STOCKS AS S ON S.STOCK_ID = PO.STOCK_ID
LEFT JOIN catalyst_prod_1.WORKSTATIONS AS WS ON WS.STATION_ID = PO.STATION_ID
LEFT JOIN catalyst_prod_1.OPERATION_TYPES AS OT ON OT.OPERATION_TYPE_ID = POP.OPERATION_TYPE_ID
LEFT JOIN catalyst_prod.PROCESS_TYPE_ROWS AS PTR ON PTR.PROCESS_ROW_ID = PO.PROD_ORDER_STAGE

</cfquery>

<cfset arr=arrayNew(1)>
<cfloop  query="getOrders" group="P_ORDER_ID">
<cfquery name="getB" datasource="#dsn3#">
    SELECT  o.ORDER_HEAD FROM catalyst_prod_1.BOYAHANE_BIRLESEN  AS BB 
INNER JOIN catalyst_prod_1.ORDERS AS O ON O.ORDER_ID =BB.ORDER_ID AND P_ORDER_ID=#P_ORDER_ID#
</cfquery>
<cfif getB.recordcount>
<cfset order_head_list=valueList(getB.ORDER_HEAD)>
<cfelse>
<cfset order_head_list=ORDER_HEAD>
</cfif>
<cfscript>
item=structNew();
item.ORDER_ID=ORDER_ID;
item.ORDER_ROW_ID=ORDER_ROW_ID;
item.P_ORDER_ID=P_ORDER_ID;
item.ORDER_HEAD=order_head_list;
item.NICKNAME=NICKNAME;
item.QUANTITY=QUANTITY;
item.STAGE=STAGE;
item.COLOR=PROPERTY;
item.PRODUCT_NAME=PRODUCT_NAME;
item.STOCK_ID=STOCK_ID;
item.IS_COLLECTED=IS_COLLECTED;
</cfscript>
<cfset tt=arrayNew(1)>
<cfloop>
    <cfscript>
    item2=structNew();
    item2.P_ORDER_ID=P_ORDER_ID;
    item2.OPERATION_TYPE=OPERATION_TYPE;
    item2.OPERATION_TYPE_ID=OPERATION_TYPE_ID;
    item2.P_OPERATION_ID=P_OPERATION_ID;
    item2.P_AMOUNT=QUANTITY;
    item2.ORDER_ID=ORDER_ID;
    item2.STOCK_ID=STOCK_ID;
    arrayAppend(tt, item2);    
    </cfscript>
</cfloop>
<cfscript>
item.Operations=tt;
arrayAppend(arr, item);
</cfscript>


</cfloop>

<cfoutput><script> grid_data= #replace(serializeJSON(arr), "//", "") #
 </script></cfoutput>
    <div id="innerAreaPlan" <cfif attributes.fuseaction neq "labratuvar.work_list"> style="display:none"</cfif>>
        <div style="display:flex;margin-top:5px">
 <!---- <button style="margin-left:2px" class="btn btn-sm btn-primary" onclick="getData(0)">Tümü</button>
            <button style="margin-left:2px" class="btn btn-sm btn-danger" onclick="getData(83)">Renksiz</button>
            <button style="margin-left:2px" class="btn btn-sm btn-warning" onclick="getData(84)">Renk Tanımlandı</button>
            <button style="margin-left:2px" class="btn btn-sm btn-success" onclick="getData(90)">Planlama Yapıldı</button>
            <button style="margin-left:2px" class="btn btn-sm btn-secondary"onclick="getData(89)">Üretim Tamamlandı</button>---->
            <div class="bg-danger" style="width:3px;margin-left:2px"></div>
            
            <button style="margin-left:2px" class="btn btn-sm btn-outline-primary"onclick="windowopen('index.cfm?fuseaction=mal_giris.emptypopup_list_party','page')">Parti Listesi</button>
        </div>
        <div id="gridContainer_work_list"></div>
        <div id="action-add"></div>
        <div id="action-add2"></div>
    </div>
    <script>
    <cfinclude  template="is_listesi.js">    
    </script>
    