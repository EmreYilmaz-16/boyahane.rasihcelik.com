<style>.dx-data-row .cell-highlighted {
    color: #0d6efd;
    cursor: pointer;
}
.dx-data-row .cell-highlighted:hover {
    color: darkblue;
    cursor: pointer;
    font-weight:bold;
}
 
</style>

<div id="dx_grid_2"></div>
<div  class="modal fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="staticBackdropLabel">Renk Seç</h5>
        <button  type="button" class="btn btn-sm btn-outline-secondary " data-bs-dismiss="modal" aria-label="Close"><i class="fas fa-times"></i></button>
      </div>
      <div id="mdl_11" class="modal-body">
        ...
      </div>
      <div class="modal-footer">
       
      </div>
    </div>
  </div>
</div>
<script>
var myModal = new bootstrap.Modal(document.getElementById('staticBackdrop'))
var Grd_Party="";
var genel_elemanim="";
function changeDat(ship_id,period_id){

     Grd_Party= $("#dx_grid_2").dxDataGrid({
        dataSource: {
            store: {
                type: "odata",
                url: "/cfc/boyahane.cfc?method=getRelatedParties&SHIP_ID="+ship_id+"&PERIOD_ID="+period_id,
                key:"ORDER_ROW_ID"
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
           

            
        },
        allowColumnReordering: true,
        rowAlternationEnabled: true,
        showBorders: true,
        columns: [
                   
               {
                dataField: "AMOUNT2",
                caption: "Metre",
                dataType: "number",
                
                alignment: "right",
            },
              {
                dataField: "AMOUNT",
                caption: "K.G.",
                dataType: "number",
                
                alignment: "right",
            },      
            {
                dataField: "ORDER_NUMBER",
                caption: "PARTİ NO",   
                dataType: "string",
                width: 150
            },
              {
                dataField: "PRODUCT_NAME2",
                caption: "RENK AÇIKLAMA",
                dataType: "string",
                width: 150
            },
            {
                dataField: "RECORD_DATE",
                 caption: "KAYIT TARİHİ",
                dataType: "string"
            }
            ,       
            {
                dataField: "STOCK_CODE_2",
                 caption: "RENK",
                dataType: "string",
                cssClass: "cell-highlighted",
                width: 150,
                buttons:[
                    {  key:"ORDER_ROW_ID",
                        text:"STOCK_CODE_2",
                              onClick: function(e){
                         
                            windowopen("index.cfm?fuseaction=mal_giris.emptypopup_upd_giris_fis&upd_id="+e.row.key,'page')
                        }
                    }
                ]
            },   {
                dataField: "STAGE",
                 caption: "DURUM",
                dataType: "string",
                width: 150
            }
            
        ],
          sortByGroupSummaryInfo: [{
            summaryItem: "count"
        }],
           summary: {
            groupItems: [{
                column: "ORDER_NUMBER",
                summaryType: "count",
                displayFormat: "{0} orders",
            }]},
        onContentReady: function(e) {
            if(!collapsed) {
                collapsed = true;
                e.component.expandRow(["EnviroCare"]);
            }
        },
        onContextMenuPreparing: function(e){
            if (!e.items) e.items = [];
        genel_elemanim=e;
        var inst=Grd_Party.dxDataGrid("instance")
        inst.selectRowsByIndexes(genel_elemanim.rowIndex)
        if(e.target !="header"){
             e.items.push({
                    text: "Yeniden Oluştur",
                    icon:"export",
                    onItemClick: function() {
                    var row_data=e.row.data
                    openModal_partner("index.cfm?fuseaction=labratuvar.emptypopup_ajaxpage_remake_order_to_production&order_row_id="+row_data.ORDER_ROW_ID)
                    }
                });
                  e.items.push({
                    text: "Renk Oluştur",
                    icon:"fill",
                    onItemClick: function() {
                    var row_data=e.row.data
                   windowopen("index.cfm?fuseaction=color.emptypopup_form_add_color&order_row_id="+row_data.ORDER_ROW_ID,'page')
                    //openModal_partner("index.cfm?fuseaction=labratuvar.emptypopup_ajaxpage_remake_order_to_production&order_row_id="+row_data.ORDER_ROW_ID)
                    }
                });
                  e.items.push({
                    text: "Yazdır",
                    icon:"print",
                    onItemClick: function() {
                    var row_data=e.row.data
                     windowopen("index.cfm?fuseaction=objects.emptypopup_print_files&module_id=11&action_id="+row_data.ORDER_ROW_ID,'page')
                    //openModal_partner("index.cfm?fuseaction=labratuvar.emptypopup_ajaxpage_remake_order_to_production&order_row_id="+row_data.ORDER_ROW_ID)
                    }
                });
                  e.items.push({
                    text: "Görüntüle",
                    icon:"find",
                    onItemClick: function() {
                    var row_data=e.row.data
                    windowopen("index.cfm?fuseaction=mal_giris.emptypopup_upd_giris_fis&upd_id="+row_data.ORDER_ROW_ID,'page')
                    //openModal_partner("index.cfm?fuseaction=labratuvar.emptypopup_ajaxpage_remake_order_to_production&order_row_id="+row_data.ORDER_ROW_ID)
                    }
                });
                 e.items.push({
                    text: "Düzenle",
                    icon:"edit",
                    onItemClick: function() {
                    var row_data=e.row.data
                    windowopen("index.cfm?fuseaction=mal_giris.emptypopup_upd_giris_fis&upd_id="+row_data.ORDER_ROW_ID,'page')
                    //openModal_partner("index.cfm?fuseaction=labratuvar.emptypopup_ajaxpage_remake_order_to_production&order_row_id="+row_data.ORDER_ROW_ID)
                    }
                });}
        },
        onCellClick: function(e){
           if(e.columnIndex ==5){console.log(e.key)
          
                $.ajax({
            url: "/index.cfm?fuseaction=color.emptypopup_ajaxpage_form_select_color&att_ship_id=" + ship_id+"&att_period_id="+period_id+"&key="+e.key,
            success: function (retData) {
            
                $("#mdl_11").html(retData)
                 myModal.show()
            }

        });
           
           }
        }
    })

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
    }
function ReUp(ship_id,period_id){
 $("#action-add").dxSpeedDialAction({
        label: "Parti Ekle",
        icon: "add",
        index: 1,
        onClick: function() {
            //grid.addRow();
            //grid.deselectAll();
            //window.open()
            
            EmreAll(ship_id,period_id)
        }
    }).dxSpeedDialAction("instance");
    //  $("#action-print").dxSpeedDialAction({
    //     label: "Yazdır",
    //     icon: "print",
        
    //     onClick: function() {
    //         //grid.addRow();
    //         //grid.deselectAll();
    //         //window.open()
    //        windowopen('index.cfm?fuseaction=objects.emptypopup_print_files&module_id=2&action_id='+ship_id+'&iid='+period_id+'','page')
    //       //  EmreAll(ship_id,period_id)
    //     }
    // }).dxSpeedDialAction("instance");

    }
    function EmreAll(ship_id,period_id){
        windowopen("index.cfm?fuseaction=mal_giris.emptypopup_add_party&ship_id="+ship_id+"&period_id="+period_id,'page');
    }
    </script>