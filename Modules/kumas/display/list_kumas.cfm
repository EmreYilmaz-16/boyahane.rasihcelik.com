
<cfquery name="getList" datasource="#dsn#">
    SELECT S.PRODUCT_CODE,C.FULLNAME,S.STOCK_ID,S.PRODUCT_ID,PRODUCT_NAME,PB.BRAND_NAME FROM catalyst_prod_1.STOCKS AS S 
    LEFT JOIN catalyst_prod.COMPANY AS C ON S.COMPANY_ID=C.COMPANY_ID
    LEFT JOIN catalyst_prod_product.PRODUCT_BRANDS as PB ON PB.BRAND_ID=S.BRAND_ID
    WHERE IS_MAIN_STOCK =1
</cfquery>


<div style="box-shadow:1px 1px 20px 0px #c4c7ca;padding:0.5%">
        <div style="box-shadow:1px 1px 20px 0px #c4c7ca;padding:0.5%"><span style="text-shadow: 2px 1px 2px #93beff" class="text-primary fs-3">Kumaş Listesi</span></div>
<div class="dx-viewport"><div id="gridContainer_kumas"></div>
<div id="action-kumas"></div>
</div>






<cfif isDefined("attributes.sc")>
<cfscript>
structClear(SESSION);
</cfscript>
</cfif>

   <script>
        $(function() {
             $("#action-kumas").dxSpeedDialAction({
        label: "Kumaş Ekle",
        icon: "add",
        index: 1,
        onClick: function() {
            //grid.addRow();
            //grid.deselectAll();
            //window.open()
            openModal_partner("index.cfm?fuseaction=emptypopup_ajaxpage_form_add_kumas","modal-xl")
           // windowopen('index.cfm?fuseaction=emptypopup_form_add_kumas','page')
           // EmreAll(ship_id,period_id)
        }
    }).dxSpeedDialAction("instance");

    $("#gridContainer_kumas").dxDataGrid({
        dataSource: {
            store: {
                type: "odata",
                url: "/cfc/boyahane.cfc?method=getKumasLAR",
                key:"PRODUCT_ID"
            }
        },
          filterRow: {
            visible: true,
            applyFilter: "auto"
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
            mode: "single"
        },
            onSelectionChanged: function(e) {
            selectedRowIndex = e.component.getRowIndexByKey(e.selectedRowKeys[0]);
            console.log(e.selectedRowKeys[0])
            
            
        },
        onRowDblClick:function(e){
          openModal_partner("index.cfm?fuseaction=emptypopup_ajapage_form_upd_kumas&product_id="+e.key,"modal-xl")
            console.log(e)
        },
        allowColumnReordering: true,
        rowAlternationEnabled: true,
        showBorders: true,
        columns: [
                   
               {
                dataField: "PRODUCT_CODE",
                caption: "ÜRÜN KODU",
                dataType: "string"                                
            },
              {
                dataField: "PRODUCT_NAME",
                caption: "ÜRÜN ADI",
                dataType: "string"                            
            },
              {
                dataField: "BRAND_NAME",
                caption: "MARKA - SIRKET",
                dataType: "string"

            },
              {
                dataField: "PRODUCT_CAT",
                caption: "KUMAŞ TİPİ",
                dataType: "string"
                
            }
            
            /*,{
                caption:" ",
                type: "buttons",
                allowGrouping: false,
                buttons:[
                    {
                        key:"SHIP_ID",
                        
                        icon:"fas fa-pencil",
                        
                        onClick: function(e){
                            console.log(this)
                            console.log(e.row.key)
                            windowopen("index.cfm?fuseaction=mal_giris.emptypopup_upd_giris_fis&upd_id="+e.row.key,'page')
                        }
                    },
                      {
                        key:"SHIP_ID",
                        
                        icon:"fas fa-eye",
                        
                        onClick: function(e){
                            console.log(this)
                            console.log(e.row.key)
                            windowopen("index.cfm?fuseaction=mal_giris.emptypopup_upd_giris_fis&upd_id="+e.row.key,'page')
                        changeDat(e.row.key)
                        }
                    }
                ]
            }*/
            
        ],
        focusedRowEnabled: true,
          sortByGroupSummaryInfo: [{
            summaryItem: "count"
        }],
           summary: {
            groupItems: [{
                column: "OrderNumber",
                summaryType: "count",
                displayFormat: "{0} Kumaş",
            }]},
        onContentReady: function(e) {
            if(!collapsed) {
                collapsed = true;
                e.component.expandRow(["EnviroCare"]);
            }
        }
    });
});

var discountCellTemplate = function(container, options) {
    $("<div/>").dxBullet({
        onIncidentOccurred: null,
        size: {
            width: 150,
            height: 35
        },
        margin: {
            top: 5,
            bottom: 0,
            left: 5
        },
        showTarget: false,
        showZeroLevel: true,
        value: options.value * 100,
        startScaleValue: 0,
        endScaleValue: 100,
        tooltip: {
            enabled: true,
            font: {
                size: 18
            },
            paddingTopBottom: 2,
            customizeTooltip: function() {
                return { text: options.text };
            },
            zIndex: 5
        }
    }).appendTo(container);

    
};

var collapsed = false;
function updRow(ee){
    console.log(e)
}
    </script>