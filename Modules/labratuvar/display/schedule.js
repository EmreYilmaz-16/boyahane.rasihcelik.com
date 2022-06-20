var data = new Array();
var gununTarihi = new Date();
LoadData('', '')
var genel_donen = "";
var appointmentClassName = ".dx-scheduler-appointment";
var cellClassName = ".dx-scheduler-date-table-cell";
$(function () {
    schedule = $("#scheduler").dxScheduler({
        timeZone: "Europe/Istanbul",
        dataSource: data,
        views: ["timelineDay", {
            type: "day",
            cellDuration: 60,
            timeCellTemplate: function (data, index, element) {
                element.text(data.text)
                    .css('color', 'green')
                    .css('font-style', 'italic');
            },
            appointmentTemplate: function (model, index, element) {
                console.log(model)
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
        cellDuration: 60,
        resources: [
            {
                dataSource: new DevExpress.data.DataSource({
                    store: {
                        type: "odata",
                        url: "/cfc/boyahane.cfc?method=getWorkStations&UpStationId=1",
                        key: "STATION_ID"
                    }
                }),
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
            console.log(e.appointmentData);    
            console.log(e.targetedAppointmentData);      
        },
        onAppointmentContextMenu: function (e) {
            updateContextMenu(false, appointmentContextMenuItems, appointmentClassName, 'item', onItemClick(e));

        },
        onCellContextMenu: function (e) {
            updateContextMenu(false, cellContextMenuItems, cellClassName, 'item', onItemClick(e));
        },
        onAppointmentUpdated: function (e) {
            console.log("onAppointmentUpdated")
            windowopen("index.cfm?fuseaction=test_page_2&app_data=" + JSON.stringify(e.appointmentData))
        }, onAppointmentDeleted: function (e) {
            console.log("onAppointmentDeleted")
            console.log(e)
        },
        onOptionChanged: function (e) {            
            console.log(e)
            if (e.name == "currentDate") {
            }
        },
        onContentReady: function (e) {
            console.log(e)
        }


    }).dxScheduler('instance');

    function getMovieById(id) {
        return DevExpress.data.query(priorityData)
            .filter("id", id)
            .toArray()[0];
    }

});
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
    console.log(e)
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
    console.log(obj)
   windowopen("index.cfm?fuseaction=test_page_4&data="+JSON.stringify(obj),"page")
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

function LoadData(date, date1) {
    var dddd = new Date();
    console.log(dddd + "--Çalıştı")
    $.ajax({
        url: "/cfc/boyahane.cfc?method=getWorks&work_start_date=" + date + "&work_end_date=" + date1,
        dataType: "json",
        success: function (retData, text_status, jqXHR) {
            console.log(retData)
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
                $("#scheduler").dxScheduler("instance").option("dataSource", data)
            }
        }

    });
}
$(document).ready(function () {
    MyInterval = setInterval(function () {
        LoadData('', '')

    }, 60000);
})
