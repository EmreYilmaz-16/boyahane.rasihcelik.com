getData()
var sel_count = 0;
var add_sta
var add_sta2
function getData() {
 /*   add_sta = $("#action-add").dxSpeedDialAction({
        label: "Birleştir",
        icon: "add",
        position: "left",
        index: 1,
        visible: false,
        onClick: function () {
            var data = birlesen_kontrol()
            console.log(data)
            data = JSON.stringify(data)
            console.log(data)
            windowopen("index.cfm?fuseaction=test_page_6&operation_data=" + data)
        }
    }).dxSpeedDialAction("instance");
    add_sta2 = $("#action-add2").dxSpeedDialAction({
        label: "Birleştir",
        icon: "add",
        position: "left",
        index: 1,
        visible: false,
        onClick: function () {
            var data = data_grid.getSelectedRowsData()
            console.log(data)
            data = JSON.stringify(data)
            console.log(data)
        }
    }).dxSpeedDialAction("instance");
*/
    data_grid = $("#gridContainer_work_list").dxDataGrid({
        dataSource: grid_data,

        filterRow: {
            visible: true,
            applyFilter: "auto",
            key: "P_ORDER_ID"
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
        onSelectionChanged: function (e) {
            console.log("onSelectionChanged")
            var selected = data_grid.getSelectedRowsData()
            console.log(e)
            if (selected.length > 1) {
                console.log("Seçilenler: ")
                console.log(selected)
                add_sta.option("visible", true)
            } else {
                add_sta.option("visible", false)
            }

        },
        onRowDblClick: function (e) {
            console.log("onRowDblClick")
            console.log(e)
            if (e.data.IS_COLLECTED == 1) {
                openModal_partner("index.cfm?fuseaction=labratuvar.emptypopup_ajaxpage_get_birlesen_orders&P_ORDER_ID=" + e.data.P_ORDER_ID + "&ORDER_ROW_ID=" + e.data.ORDER_ROW_ID + "&AMOUNT=" + e.data.AMOUNT)
            } else {

                openModal_partner("index.cfm?fuseaction=labratuvar.emptypopup_ajaxpage_planlama_ekle&P_ORDER_ID="+e.data.P_ORDER_ID+"&ORDER_ID=" + e.data.ORDER_ID + "&ORDER_ROW_ID=" + e.data.ORDER_ROW_ID + "&AMOUNT=" + e.data.AMOUNT)
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
            template: function (container, options) {
                var currentEmployeeData = options.data;
                console.log("container Start ----")
                console.log(container)
                console.log("----container End ")
                console.log(options),
                    console.log("currentEmployeeData Start ----")
                console.log(currentEmployeeData);
                console.log("----currentEmployeeData End ")
                var grd = $("<div id='dv_" + currentEmployeeData.P_ORDER_ID + "'>")
                    .dxDataGrid({
                        dataSource: getRowData(currentEmployeeData.P_ORDER_ID),
                        columnAutoWidth: true,
                        showBorders: true,
                        columns: [{
                            dataField: "OPERATION_TYPE",
                            caption: "Operasyon",
                            dataType: "string"
                        }],

                        selection: {
                            mode: "multiple"
                        },
                        onSelectionChanged: function (e) {

                            birlesen_kontrol()

                        }
                    }).appendTo(container);
            }
        },

    }).dxDataGrid("instance");

}
function getRowData(order_id) {
var return_data=grid_data.filter(p => p.P_ORDER_ID == order_id)[0].OPERATIONS
console.log("row_Data")
console.log(return_data)
    return return_data
}
function birlesen_kontrol() {
    var arr = new Array();
    for (let i = 0; i < data.length; i++) {
        var elem = document.getElementById("dv_" + data[i].P_ORDER_ID)
        console.log(elem)
        if (elem != null) {
            $(elem).dxDataGrid("instance").getSelectedRowKeys()
            arr.push($(elem).dxDataGrid("instance").getSelectedRowKeys())
        }

    }
    console.log(arr)
    if (arr[0].length == 1 && arr[1].length == 1) {
        add_sta.option("visible", true)
    } else {
        add_sta.option("visible", false)
    }
    return arr
}

