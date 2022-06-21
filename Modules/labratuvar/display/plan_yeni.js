var UpStationId = "1";
var grid_data = [];
var data = new Array();
var gununTarihi = new Date();
var genel_donen = "";
var station_list = [];
var appointmentClassName = ".dx-scheduler-appointment";
var cellClassName = ".dx-scheduler-date-table-cell";

/*
Ekran Yüklemesi Tamamlandığında Boya İstasyonuna Ait Plan Listesini ve 
Scheduler'i Doldurur.
*/
$(document).ready(function () {
    var e = document.getElementById("UPSTATION")
    console.warn("document_ready_ basladi sheduledata yüklemeden öncesi - " + new Date)
    GET_SHEDULE_DATA(e)
    console.warn("document_ready_ bitti - " + new Date)
    get_stations(UpStationId)

   /* MyInterval = setInterval(function () {
        console.warn("Myİnterval - " + new Date)
        
    }, 6000);*/
})
/**
 * 
 * @param {HTMLElement} elem  İstasyon Grubu Seçimi
 * @since 10.07.2021
 * @summary İstasyon Grubu Seçimi İçin Kullanılır
 */
function GET_SHEDULE_DATA(elem) {
    console.warn("GET_SHEDULE_DATA - " + new Date)
    UpStationId = elem.value

    //console.log(UpStationId)
    $.ajax({
        url: "/cfc/boyahane.cfc?method=getWorksWithStationGroup&up_station_id=" + UpStationId,
        success: function (retdat) {
            var olist = JSON.parse(retdat)
            grid_data = olist;
            console.warn("ajax başarılı durumda - " + new Date)
            LoadGridData()
            //LoadData('','',UpStationId,0)
            console.warn("Burada İstasyon İçin İstek Yaptı - " + new Date)
            get_stations(UpStationId)
            //

        }
    }).done(function (retdat) {
        console.warn("ajax bitmiş durumda - " + new Date)

    })
}
/**
 * @summary DataGride Veri Doldurur
 */
function LoadGridData() {
    console.warn("Grid Verileri Yüklendi - " + new Date)
    data_grid = $("#plan_list").dxDataGrid({
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
            //   console.log("onSelectionChanged")
            var selected = data_grid.getSelectedRowsData()
            // console.log(e)
            if (selected.length > 1) {
                //    console.log("Seçilenler: ")
                //   console.log(selected)
                //   add_sta.option("visible", true)
            } else {
                //  add_sta.option("visible", false)
            }
        },
        onRowDblClick: function (e) {
            //  console.log("onRowDblClick")
            //   console.log(e)
            if (e.data.IS_COLLECTED == 1) {
                openModal_partner("index.cfm?fuseaction=labratuvar.emptypopup_ajaxpage_get_birlesen_orders&P_ORDER_ID=" + e.data.P_ORDER_ID + "&ORDER_ROW_ID=" + e.data.ORDER_ROW_ID + "&AMOUNT=" + e.data.AMOUNT)
            } else {
                openModal_partner("index.cfm?fuseaction=labratuvar.emptypopup_ajaxpage_planlama_ekle&P_ORDER_ID=" + e.data.P_ORDER_ID + "&ORDER_ID=" + e.data.ORDER_ID + "&ORDER_ROW_ID=" + e.data.ORDER_ROW_ID + "&AMOUNT=" + e.data.AMOUNT)
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

    return grid_data.filter(p => p.P_ORDER_ID == order_id)[0].OPERATIONS
}
function birlesen_kontrol() {
    var arr = new Array();
    for (let i = 0; i < grid_data.length; i++) {
        var elem = document.getElementById("dv_" + grid_data[i].P_ORDER_ID)
        console.log(elem)
        if (elem != null) {
            $(elem).dxDataGrid("instance").getSelectedRowKeys()
            arr.push($(elem).dxDataGrid("instance").getSelectedRowKeys())
        }

    }
    console.log(arr)
    if (arr[0].length == 1 && arr[1].length == 1) {
        //   add_sta.option("visible", true)
    } else {
        //  add_sta.option("visible", false)
    }
    return arr
}
var selectedRowIndex = -1;



var deleteSDA = $("#action-remove").dxSpeedDialAction({
    icon: "trash",
    label: "Delete row",
    index: 2,
    visible: false,
    onClick: function () {
        grid.deleteRow(selectedRowIndex);
        grid.deselectAll();
    }
}).dxSpeedDialAction("instance");
function get_stations(UpStationId) {
    console.warn("İstasyonları Getirdi - " + new Date)
    $.ajax({
        url: "/cfc/boyahane.cfc?method=getWorkStations&UpStationId=" + UpStationId,
        success: function (retdat) {
            console.warn("istasyonlar ajaxtan döndü - " + new Date)
            //  console.log(retdat)
            var olist = JSON.parse(retdat)
            //  console.log(olist)
            station_list = olist;
            // LoadGridData()
            // LoadData('','',UpStationId,0)
            //getLData();
            //LoadData('','',UpStationId,1)
            getLData();
            LoadData('', '', UpStationId, 1)

        }
    })
}
// var data = new Array();
// var gununTarihi = new Date();
// //LoadData('', '')
// var genel_donen = "";
// var appointmentClassName = ".dx-scheduler-appointment";
// var cellClassName = ".dx-scheduler-date-table-cell";
function getLData() {
    console.warn("sheduledata objesi- " + new Date)
    schedule = $("#scheduler").dxScheduler({
      //  timeZone: "Europe/Istanbul",
        dataSource: data,
        views: ["timelineDay", {
            type: "day",
            cellDuration: 30,
            timeCellTemplate: function (data, index, element) {
                element.text(data.text)
                    .css('color', 'green')
                    .css('font-style', 'italic');
            },
            appointmentTemplate: function (model, index, element) {
                // console.log(model)
                var movieInfo = getMovieById(model.appointmentData.PARTNER_WORK_STAGE) || {};
                var d1 = model.appointmentData.startDate
                var d2 = model.appointmentData.endDate
                d1_saat = d1.getHours().toString();
                d1_dakika = d1.getMinutes().toString();
                d2_saat = d2.getHours().toString();
                d2_dakika = d2.getMinutes().toString();
                if (d1_saat.length == 1) { d1_saat = "0" + d1_saat }
                if (d1_dakika.length == 1) { d1_dakika = "0" + d1_dakika }
                if (d2_saat.length == 1) { d2_saat = "0" + d2_saat }
                if (d2_dakika.length == 1) { d2_dakika = "0" + d2_dakika }
                element.append("<span>" + model.appointmentData.text + "-" + d1_saat + ":" + d1_dakika + "- " + d2_saat + ":" + d2_dakika + "</span>");
                element.append("<p>Durum: " + movieInfo.text + " </p>");
                element.append("<p>" + model.appointmentData.NICKNAME + "</p>")
            },
        }, "week", "agenda"],
        currentView: "timelineDay",
        currentDate: new Date(),
        firstDayOfWeek: 0,

        groups: ["STATION_ID"],
        cellDuration: 30,
        resources: [
            {
                dataSource: station_list,

                /* new DevExpress.data.DataSource({
                    store: {
                        type: "odata",
                        url: "/cfc/boyahane.cfc?method=getWorkStations&UpStationId="+UpStationId,
                        key: "STATION_ID"
                    }
                }),*/
                fieldExpr: "STATION_ID",
                displayExpr: "STATION_NAME",
                valueExpr: "STATION_ID",
                label: "Makina"

            }, {
                fieldExpr: "PARTNER_WORK_STAGE",
                allowMultiple: false,
                dataSource: priorityData,
                label: "Durum",
                useColorAsDefault: true
            }],
        height: 580,
        onAppointmentClick: function (e) {
            // console.log(e.appointmentData);
            // console.log(e.targetedAppointmentData);
        },
        onAppointmentContextMenu: function (e) {
            updateContextMenu(false, appointmentContextMenuItems, appointmentClassName, 'item', onItemClick(e));

        },
        onCellContextMenu: function (e) {
            updateContextMenu(false, cellContextMenuItems, cellClassName, 'item', onItemClick(e));
        },
        onAppointmentUpdated: function (e) {
            //console.log("onAppointmentUpdated")
            windowopen("index.cfm?fuseaction=test_page_2&app_data=" + JSON.stringify(e.appointmentData))
        }, onAppointmentDeleted: function (e) {
            // console.log("onAppointmentDeleted")
            // console.log(e)
        },
        onOptionChanged: function (e) {
            //console.log(e)
            if (e.name == "currentDate") {
            }
        },
        onContentReady: function (e) {
            //console.log(e)
        }


    }).dxScheduler('instance');

    function getMovieById(id) {
        return DevExpress.data.query(priorityData)
            .filter("id", id)
            .toArray()[0];
    }

}
var contextMenuInstance = $("#context-menu").dxContextMenu({
    width: 200,
    dataSource: [],
    disabled: true,
    target: appointmentClassName,
}).dxContextMenu("instance");

var updateContextMenu = function (disable, dataSource, target, itemTemplate, onItemClick) {
    contextMenuInstance.option({
        dataSource: dataSource,
        target: target,
        itemTemplate: itemTemplate,
        onItemClick: onItemClick,
        disabled: disable,
    });
}

var itemTemplate = function (itemData) {
    return getAppointmentMenuTemplate(itemData);
}

var onItemClick = function (contextMenuEvent) {
    return function (e) {
        genel_donen = e.itemData;
        e.itemData.onItemClick(contextMenuEvent, e);

    }
}

var createAppointment = function (e) {
    //console.log(e)
};

var createRecurringAppointment = function (e) {
    e.component.showAppointmentPopup({
        startDate: e.cellData.startDate,
        recurrenceRule: "FREQ=DAILY"
    }, true);
};

var groupCell = function (e) {
    var scheduler = e.component;

    if (scheduler.option("groups")) {
        scheduler.option({ crossScrollingEnabled: false, groups: undefined });
    } else {
        scheduler.option({ crossScrollingEnabled: true, groups: ["roomId"] });
    }
};
var yikamaEkle = function (e) {
    if (e.cellData) {
        var obj = {
            type: genel_donen.detay,
            ev: e.cellData
        }
    } else {
        var obj = {
            type: genel_donen.detay,
            ev: e.appointmentData
        }
    }
    //console.log(obj)
    windowopen("index.cfm?fuseaction=test_page_4&data=" + JSON.stringify(obj), "page")
}
var cellContextMenuItems = [
    {
        text: 'Yıkama Ekle', items: [
            {
                text: "Açık Renk Yıkama", onItemClick: yikamaEkle, detay: {
                    pos: "current",
                    tip: 0
                }
            },
            {
                text: "Orta Renk Yıkama", onItemClick: yikamaEkle, detay: {
                    pos: "current",
                    tip: 1
                }
            },
            {
                text: "Koyu Renk Yıkama", onItemClick: yikamaEkle, detay: {
                    pos: "current",
                    tip: 2
                }
            }
        ]
    }
];

var appointmentContextMenuItems = [
    {
        text: 'Öncesine Yıkama Ekle', items: [
            {
                text: "Açık Renk Yıkama", onItemClick: yikamaEkle, detay: {
                    pos: "before",
                    tip: 0
                }
            },
            {
                text: "Orta Renk Yıkama", onItemClick: yikamaEkle, detay: {
                    pos: "before",
                    tip: 1
                }
            },
            {
                text: "Koyu Renk Yıkama", onItemClick: yikamaEkle, detay: {
                    pos: "before",
                    tip: 2
                }
            }
        ]
    },
    {
        text: 'Sonrasına Yıkama Ekle', items: [
            {
                text: "Açık Renk Yıkama", onItemClick: yikamaEkle, detay: {
                    pos: "after",
                    tip: 0
                }
            },
            {
                text: "Orta Renk Yıkama", onItemClick: yikamaEkle, detay: {
                    pos: "after",
                    tip: 1
                }
            },
            {
                text: "Koyu Renk Yıkama", onItemClick: yikamaEkle, detay: {
                    pos: "after",
                    tip: 2
                }
            }
        ]
    },

];

function LoadData(date, date1, station_id = UpStationId, tyke) {
    var dddd = new Date();
    //console.log(dddd + "--Çalıştı")
    $.ajax({
        url: "/cfc/boyahane.cfc?method=getWorks&work_start_date=" + date + "&work_end_date=" + date1 + "&up_station_id=" + station_id,
        dataType: "json",
        success: function (retData, text_status, jqXHR) {
            //      console.log(retData)
            data.splice(0, data.length)
            for (let i = 0; i < retData.length; i++) {
                var item = {
                    text: retData[i].SPECT_VAR_NAME,
                    STATION_ID: retData[i].STATION_ID,
                    startDate: new Date(retData[i].START_DATE),
                    endDate: new Date(retData[i].FINISH_DATE),
                    P_ORDER_ID: retData[i].P_ORDER_ID,
                    PARTNER_WORK_STAGE: retData[i].PARTNER_WORK_STAGE,
                    NICKNAME: retData[i].NICKNAME,
                    PROPERTY: retData[i].PROPERTY,
                }
                data.push(item);
                if (tyke != 0) { $("#scheduler").dxScheduler("instance").option("dataSource", data) }
            }
        }

    });
}
