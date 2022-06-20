<cfparam  name="attributes.action" default="mal_giris.emptypopup_ajaxpage_giris_listesi">
<cfparam  name="attributes.id" default="1">
<cfoutput><div id="res_#attributes.id#"></div></cfoutput>
<cfoutput>
<script>
    $(document).ready(function(){
        $.ajax({
            url:"index.cfm?fuseaction=#attributes.action#",
            
        }).done(function(ret_dat){
            //console.log(ret_dat)
            $("##res_#attributes.id#").html(ret_dat)
        })
    })
</script>
</cfoutput>
<cfchart format="html" chartWidth="600" chartHeight="400" pieSliceStyle="sliced">
    <cfchartseries type="pie" serieslabel="Website Traffic 2016">
        <cfchartdata item="January" value="#randRange(500000,1000000)#">
        <cfchartdata item="February" value="#randRange(500000,1000000)#">
        <cfchartdata item="March" value="#randRange(500000,1000000)#">
        <cfchartdata item="April" value="#randRange(500000,1000000)#">
        <cfchartdata item="May" value="#randRange(500000,1000000)#">
        <cfchartdata item="June" value="#randRange(500000,1000000)#">
    </cfchartseries>
</cfchart>

<!-----

<cfquery name="getOrders" datasource="#dsn3#">
SELECT O.ORDER_HEAD
	,PO.P_ORDER_ID
	,C.NICKNAME
	,PO.QUANTITY
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

<cfoutput><script> data= #replace(serializeJSON(arr), "//", "") #
 </script></cfoutput>

<div id="gridContainer_work_list"></div>
<div id="action-add"></div>
<div id="action-add2"></div>
<script>
getData()
var sel_count=0;
var add_sta
var add_sta2
function getData(){
       add_sta= $("#action-add").dxSpeedDialAction({
        label: "Birleştir",
        icon: "add",
        position:"left",        
        index: 1,
        visible:false,
        onClick: function() {
          var data=birlesen_kontrol()
          console.log(data)
          data=JSON.stringify(data)
           console.log(data)
           windowopen("index.cfm?fuseaction=test_page_6&operation_data="+data)
        }
    }).dxSpeedDialAction("instance");
          add_sta2= $("#action-add2").dxSpeedDialAction({
        label: "Birleştir",
        icon: "add",
        position:"left",        
        index: 1,
        visible:false,
        onClick: function() {
          var data=data_grid.getSelectedRowsData()
          console.log(data)
          data=JSON.stringify(data)
           console.log(data)
        }
    }).dxSpeedDialAction("instance");

    data_grid= $("#gridContainer_work_list").dxDataGrid({
        dataSource: data,
       
          filterRow: {
            visible: true,
            applyFilter: "auto",
            key:"P_ORDER_ID"
        },
        paging: {
            pageSize: 10
        },
        pager: {
            showPageSizeSelector: true,
            allowedPageSizes: [10, 25, 50, 100]
        },
        remoteOperations: false,

        groupPanel: { visible: true },
        grouping: {
            autoExpandAll: false
        },
            selection: {
            mode: "multiple"
        },
            onSelectionChanged: function(e) {
         console.log("onSelectionChanged")
            var selected=data_grid.getSelectedRowsData()
            if(selected.length>1){
                console.log("Seçilenler: ")
                console.log(selected)
                add_sta.option("visible",true)
            }else{
                add_sta.option("visible",false)
            }
            
        },
        onRowDblClick:function(e){
            
            console.log(e)
            if(e.data.IS_COLLECTED ==1){
                 openModal_partner("index.cfm?fuseaction=labratuvar.emptypopup_ajaxpage_get_birlesen_orders&P_ORDER_ID="+e.data.P_ORDER_ID+"&ORDER_ROW_ID="+e.data.ORDER_ROW_ID+"&AMOUNT="+e.data.AMOUNT)
            }else{

          openModal_partner("index.cfm?fuseaction=labratuvar.emptypopup_ajaxpage_planlama_ekle&ORDER_ID="+e.key+"&ORDER_ROW_ID="+e.data.ORDER_ROW_ID+"&AMOUNT="+e.data.AMOUNT)
            }
  
        },        
        allowColumnReordering: true,
        rowAlternationEnabled: true,
        showBorders: true,
        columns: [
                   
               {
                dataField: "ORDER_HEAD",
                caption: "PARTİ KODU",
                dataType: "string"                                
            },
              {
                dataField: "PRODUCT_NAME",
                caption: "ÜRÜN ADI",
                dataType: "string"                            
            },
              {
                dataField: "STAGE",
                caption: "DURUM",
                dataType: "string"

            }          
        ],
         masterDetail: {
            enabled: true,
            template: function(container, options) { 
                var currentEmployeeData = options.data;
                console.log("container Start ----")
                console.log(container)
                console.log("----container End ")
                console.log(options),
                console.log("currentEmployeeData Start ----")
                console.log(currentEmployeeData);
                 console.log("----currentEmployeeData End ")        
             var grd=   $("<div id='dv_"+currentEmployeeData.P_ORDER_ID+"'>")
                    .dxDataGrid({
                        dataSource:getRowData(currentEmployeeData.P_ORDER_ID),
                        columnAutoWidth: true,
                        showBorders: true,
                        columns:[{
                            dataField: "OPERATION_TYPE",
                            caption: "Operasyon",
                            dataType: "string" 
                        }],
                        
            selection: {
            mode: "multiple"
        },  
           onSelectionChanged: function(e) {
        
            birlesen_kontrol()
            
        }                                                    
                    }).appendTo(container);
            }
        },                
   
    }).dxDataGrid("instance");

}
function getRowData(order_id){

return data.filter(p=>p.P_ORDER_ID==order_id)[0].OPERATIONS
}
function birlesen_kontrol(){
    var arr=new Array();
    for(let i =0;i<data.length;i++){
        var elem=document.getElementById("dv_"+data[i].P_ORDER_ID)
        console.log(elem)
        if(elem != null){
            $(elem).dxDataGrid("instance").getSelectedRowKeys()
            arr.push($(elem).dxDataGrid("instance").getSelectedRowKeys())
        }

    }
    console.log(arr)
if(arr[0].length==1 && arr[1].length==1){
 add_sta.option("visible",true)
}else{
add_sta.option("visible",false)    
}
return arr
}
   var selectedRowIndex = -1;



    var deleteSDA = $("#action-remove").dxSpeedDialAction({
        icon: "trash",
        label: "Delete row",
        index: 2,
        visible: false,
        onClick: function() {
            grid.deleteRow(selectedRowIndex);
            grid.deselectAll();
        }
    }).dxSpeedDialAction("instance");


</script>---------->