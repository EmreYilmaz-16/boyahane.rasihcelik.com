<cfquery name="getAyar" datasource="#dsn#">
SELECT * FROM BOYAHANE_TABLE_DESIGNER WHERE FUSEACTION='#attributes.fuseaction#' and EMPLOYEE_ID =#session.ep.USERID#
</cfquery>

    <script>
    var bo_col_list=<cfoutput>#getAyar.TABLE_COLUMNS#</cfoutput>
    </script>
    <div class="dx-viewport"><div id="gridContainer"></div>
    <div id="action-add"></div>
    <div id="action-print"></div>
    </div>
     <script>
     var gridim="";
     var genel_elemanim="";
        $(function() {
   gridim= $("#gridContainer").dxDataGrid({
        dataSource: {
            store: {
                type: "odata",
                url: "/cfc/boyahane.cfc?method=checkLogin",
                key:"SHIP_ID"
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
           export: {
            enabled: true
        },
            selection: {
            mode: "single"
        },
            onSelectionChanged: function(e) {
            selectedRowIndex = e.component.getRowIndexByKey(e.selectedRowKeys[0]);
            
            <cfif attributes.fuseaction eq 'mal_giris.mal_giris_listesi'>
                getSummary_malgiris(e)
            </cfif>
            
        },
        onContextMenuPreparing: function(e){
            if (!e.items) e.items = [];
        genel_elemanim=e;
     //   var inst=Grd_Party.dxDataGrid("instance")
        //inst.selectRowsByIndexes(genel_elemanim.rowIndex)
        if(e.target !="header"){
               e.items.push({
                    text: "Görüntüle",
                    icon:"find",
                    onItemClick: function() {
                    var row_data=e.row.data
                    openModal_partner("index.cfm?fuseaction=mal_giris.emptypopup_ajaxpage_detail_mal_giris&upd_id="+row_data.SHIP_ID+"&period="+row_data.PERIOD_ID,'modal-lg')
                    //openModal_partner("index.cfm?fuseaction=labratuvar.emptypopup_ajaxpage_remake_order_to_production&order_row_id="+row_data.ORDER_ROW_ID)
                    }
                });
                   e.items.push({
                    text: "Güncelle",
                    icon:"edit",
                    onItemClick: function() {
                    var row_data=e.row.data
                   console.log(row_data)
                    windowopen("index.cfm?fuseaction=mal_giris.emptypopup_upd_giris_fis&upd_id="+row_data.SHIP_ID+"&period="+row_data.PERIOD_ID,'page')
                    //openModal_partner("index.cfm?fuseaction=labratuvar.emptypopup_ajaxpage_remake_order_to_production&order_row_id="+row_data.ORDER_ROW_ID)
                    }
                });
                 e.items.push({
                    text: "Filtreleri Temizle",
                    icon:"find",
                    onItemClick: function() {
                    var row_data=e.row.data
                    var g=gridim.dxDataGrid("instance")
                    g.clearFilter();
                   // windowopen("index.cfm?fuseaction=mal_giris.emptypopup_upd_giris_fis&upd_id="+row_data.ORDER_ROW_ID,'page')
                    //openModal_partner("index.cfm?fuseaction=labratuvar.emptypopup_ajaxpage_remake_order_to_production&order_row_id="+row_data.ORDER_ROW_ID)
                    
                    }
                });
                 e.items.push({
                    text: "Yazdır",
                    icon:"print",
                    onItemClick: function() {
                    var row_data=e.row.data
                   console.log(row_data)
                    //var g=gridim.dxDataGrid("instance")
                   // g.clearFilter();
                   // windowopen("index.cfm?fuseaction=mal_giris.emptypopup_upd_giris_fis&upd_id="+row_data.ORDER_ROW_ID,'page')
                    //openModal_partner("index.cfm?fuseaction=labratuvar.emptypopup_ajaxpage_remake_order_to_production&order_row_id="+row_data.ORDER_ROW_ID)
                     windowopen('index.cfm?fuseaction=objects.emptypopup_print_files&module_id=2&action_id='+row_data.SHIP_ID+'&iid='+row_data.PERIOD_ID+'','page')
                    }
                });
            if(e.columnIndex==4){
             e.items.push({
                    text:"Tüm "+ e.row.data.NICKNAME+" Girişleri",
                    icon:"export",
                    onItemClick: function() {
                    var row_data=e.row.data
                //    openModal_partner("index.cfm?fuseaction=labratuvar.emptypopup_ajaxpage_remake_order_to_production&order_row_id="+row_data.ORDER_ROW_ID)
                    var g=gridim.dxDataGrid("instance")
                    g.columnOption(4,{
                    selectedFilterOperation: "=",
                    filterValue: e.row.data.NICKNAME
                    })               
                    }
                });}
                else if(e.columnIndex==7){
                   e.items.push({
                    text:"Tüm "+ e.row.data.NAME_PRODUCT+" Girişleri",
                    icon:"export",
                    onItemClick: function() {
                    var row_data=e.row.data
                //    openModal_partner("index.cfm?fuseaction=labratuvar.emptypopup_ajaxpage_remake_order_to_production&order_row_id="+row_data.ORDER_ROW_ID)
                    var g=gridim.dxDataGrid("instance")
                    g.columnOption(7,{
                    selectedFilterOperation: "=",
                    filterValue: e.row.data.NAME_PRODUCT
                    })               
                    }
                });
                }
                }
                
        },
        allowColumnReordering: true,
        rowAlternationEnabled: true,
        showBorders: true,
        columnChooser: {
      enabled: true,
    },
        columns:bo_col_list,
        focusedRowEnabled: true,
          sortByGroupSummaryInfo: [{
            summaryItem: "count"
        }],
           summary: {
            groupItems: [{
                column: "OrderNumber",
                summaryType: "count",
                displayFormat: "{0} orders",
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
    
}
    </script>