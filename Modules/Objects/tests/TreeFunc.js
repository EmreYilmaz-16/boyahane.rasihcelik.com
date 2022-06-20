var arr_1 = new Array();
var arr_2 = new Array();
$("#txt_keyword").keyup(function (e) {
    console.log(e)
    if (e.keyCode == 13) {
        var kw = $(this).val()
        SearchTree(kw)
    }
    console.log($(this).val())
})
function SearchTree(keyword) {
    var ResultArea = $("#Div_1");
    $.ajax({
        url: "cfc/boyahane.cfc?method=getProdTreeWithName_yeni&keyword=" + keyword, success: function (retdat) {
            var obj_list = JSON.parse(retdat)
            console.log(obj_list)
            ResultArea.html(DataDoldur(obj_list))
            MakeSortable()
        }
    })
}
function DataDoldur(data) {
    console.log(data)
    var e = "<ul data-id='0' class='ul_obj connected inner_o list-group'>";
    for (let i = 0; i < data.length; i++) {
        var t_1 = data[i]

        if (t_1.STOCK_ID == -2) { ssst = "<input oninput='ChangeName(this,event)'  class='txt_pname' type='text' value='" + t_1.PRODUCT_NAME + "'>" } else { ssst = "<input type='text' class='txt_pname' disabled value='" + t_1.PRODUCT_NAME + "'>" }
        console.log(t_1)
        e += "<li data-upper_id='0' data-id='" + t_1.STOCK_ID + "' class='list-group-item'><input type='text'  ondblclick='activateE(this)' class='form-control form-control-sm cls_on' style='width:30px;float:left' id='rn_" + t_1.STOCK_ID + "'>" + ssst + "<input type='text' style='width:30px;float: right;' id='rf_" + t_1.STOCK_ID + "'  class='form-control form-control-sm cls_am'><ul data-tree_id='" + t_1.STOCK_ID + "' class='ul_obj connected inner_o list-group'>"
        for (let j = 0; j < t_1.TREE.length; j++) {
            var t_2 = t_1.TREE[j]
            if (t_2.STOCK_ID == -2) { ssst1 = "<input class='txt_pname' type='text' value='" + t_2.PRODUCT_NAME + "'>" } else { ssst1 = "<input type='text' class='txt_pname' disabled value='" + t_2.PRODUCT_NAME + "'>" }
            e += "<li data-upper_id='" + t_1.STOCK_ID + "' data-id='" + t_2.STOCK_ID + "' class='list-group-item'><input type='text' ondblclick='activateE(this)'  class='form-control form-control-sm cls_on' style='width:30px;float:left' id='rn_" + t_2.STOCK_ID + "'>" + ssst1 + "<input type='text' style='width:30px;float: right;' id='rf_" + t_2.STOCK_ID + "'  class='form-control form-control-sm cls_am'><ul data-tree_id='" + t_2.STOCK_ID + "' class='ul_obj connected inner_o list-group'>"
            for (let k = 0; k < t_2.TREE.length; k++) {
                var t_3 = t_2.TREE[k]
                if (t_3.STOCK_ID == -2) { ssst2 = "<input class='txt_pname' type='text' value='" + t_3.PRODUCT_NAME + "'>" } else { ssst2 = "<input type='text' class='txt_pname' disabled value='" + t_3.PRODUCT_NAME + "'>" }
                e += "<li data-upper_id='" + t_2.STOCK_ID + "' data-id='" + t_3.STOCK_ID + "' class='list-group-item'><input type='text' ondblclick='activateE(this)' class='form-control form-control-sm cls_on' style='width:30px;float:left' id='rn_" + t_3.STOCK_ID + "'>" + ssst2 + "<input type='text' style='width:30px;float: right;' id='rf_" + t_3.STOCK_ID + "'  class='form-control form-control-sm cls_am'><ul  data-tree_id='" + t_3.STOCK_ID + "' class='ul_obj connected inner_o list-group'>"
                for (let l = 0; l < t_3.TREE.length; l++) {
                    var t_4 = t_3.TREE[l];
                    if (t_4.STOCK_ID == -2) { ssst4 = "<input class='txt_pname' type='text' value='" + t_4.PRODUCT_NAME + "'>" } else { ssst2 = "<input type='text' class='txt_pname' disabled value='" + t_4.PRODUCT_NAME + "'>" }
                    e += "<li data-upper_id='" + t_3.STOCK_ID + "' data-id='" + t_4.STOCK_ID + "' class='list-group-item'><input type='text' ondblclick='activateE(this)' class='form-control form-control-sm cls_on' style='width:30px;float:left' id='rn_" + t_4.STOCK_ID + "'>" + ssst4 + "<ul data-tree_id='" + t_4.STOCK_ID + "' class='ul_obj connected inner_o list-group'><input type='text' style='width:30px;float: right;' id='rf_" + t_4.STOCK_ID + "'  class='form-control form-control-sm cls_am'></ul></li>"
                }
                e += "</ul></li>"
            }
            e += "</ul></li>"
        }
        e += "</ul></li>"
    }
    e += "</li></ul>"

    return (e);

}
function MakeSortable() {
    $("#Div_1").sortable({

        connectWith: ".connected_2",
        over: function (ev, ui) {
            console.log(ev)
            console.log(ui)
            $(ev.target).css("background", "lightgray")

        }, receive: function (ev, ui) {
            console.log("------- Receive 1-------")
            console.log(ev)
            console.log(ui)
            Clear()
            serializeTree()
        }
    })
    $("#Div_2").sortable({
        connectWith: ".connected_2",
        over: function (ev, ui) {
            console.log(ev)
            console.log(ui)
            $(ev.target).css("background", "lightgray")


        }, receive: function (ev, ui) {
            console.log("------- Receive 2-------")
            console.log(ev)
            console.log($(ui.item))
            Clear()
            serializeTree()
        }
    })
    $(".ul_obj").sortable({
        connectWith: ".connected,.connected_2",
        over: function (ev, ui) {
            console.log(ev)
            console.log(ui)
            $(ev.target).css("background", "lightgray")

        }, receive: function (ev, ui) {
            console.log("------- Receive 3-------")
            console.log(ev)
            console.log(ui)
            console.log($(ui.item[0]).data("id"))
            var parentId = $(ui.item[0]).parent().data("tree_id")
            console.log("Parent Id=" + parentId)
            $(ui.item[0]).attr("data-upper_id", parentId)
            Clear()
            serializeTree()
        }
    })
}

function Clear() {
    // $("#Div_1").html("");
    //$("#Div_2").html("");
    $(".connected_2").css("background", "white")
    $(".connected").css("background", "white")
}

function serializeTree() {
    var e = $("#Div_2").children();
    var retArr = new Array();
    var siram = 1;
    for (let i = 0; i < e.length; i++) {
        var obj = new Object();
        obj.SID = $(e[i]).data("id")

        var d = $(e[i]).children().children();
        var A1 = $(e[i]).find(".cls_on");
        if (A1.attr("readonly") != "readonly") {
            $(A1[0]).val(siram)
            siram++;
        }
        var siram2 = 1;
        var M1 = $(e[i]).find(".cls_am");

        obj.TREE_ORDER = $(A1[0]).val();
        obj.TREE_AMOUNT = $(M1[0]).val();
        var N1 = $(e[i]).find(".txt_pname");
        obj.PRODUCT_NAME = $(N1[0]).val();
        if (d.length) {
            var arr0 = new Array();
            for (let j = 0; j < d.length; j++) {
                var arr1 = new Array();
                var f = $(d[j]).children().children();
                var A2 = $(d[j]).find(".cls_on");
                if (A2.attr("readonly") != "readonly") {
                    $(A2[0]).val(siram2)
                    siram2++;
                }
                var M2 = $(d[j]).find(".cls_am");
                var siram3 = 1;
                var obj_1 = new Object();
                obj_1.SID = $(d[j]).data("id")
                obj_1.TREE_ORDER = $(A2[0]).val();
                obj_1.TREE_AMOUNT = $(M2[0]).val();
                var N2 = $(d[j]).find(".txt_pname");
                obj_1.PRODUCT_NAME = $(N2[0]).val();
                if (f.length) {
                    for (let k = 0; k < f.length; k++) {
                        var obj_2 = new Object();
                        obj_2.SID = $(f[k]).data("id")
                        var A3 = $(f[k]).find(".cls_on");
                        if (A2.attr("readonly") != "readonly") {
                            $(A3[0]).val(siram3)
                            siram3++;
                        }
                        var M3 = $(f[k]).find(".cls_am");
                        obj_2.TREE_ORDER = $(A3[0]).val();
                        obj_2.TREE_AMOUNT = $(M3[0]).val();
                        var N3 = $(f[k]).find(".txt_pname");
                        obj_2.PRODUCT_NAME = $(N3[0]).val();
                        arr1.push(obj_2)
                    }
                    obj_1.TREE = arr1;
                }
                arr0.push(obj_1)
            }

            obj.TREE = arr0
        }
        retArr.push(obj)
    }
    return retArr
}
function activateE(elem) {
    console.log(elem)
    var a = $(elem).attr("readonly");

    if (a == "readonly") { $(elem).removeAttr("readonly") } else { $(elem).attr("readonly", "readonly") }
    console.log(a)

}
function deactivateE(elem) {
    console.log("Deak")
    console.log(elem)
    $(elem).attr("readonly", "readonly")

}
function RenkGrubu(tip) {
    if (tip == 1) {
        var a = [{

            AMOUNT: 1,
            IS_DIRECTORY: 0,
            MAIN_UNIT: "",
            PARENT_ID: "",
            PRODUCT_CODE: "",
            PRODUCT_NAME: "Yeni Renk Grubu",
            PRODUCT_UNIT_ID: "",
            STOCK_ID: "-1",
            TREE: [],

        }]
    } else {
        var a = [{

            AMOUNT: 1,
            IS_DIRECTORY: 0,
            MAIN_UNIT: "",
            PARENT_ID: "",
            PRODUCT_CODE: "",
            PRODUCT_NAME: "Yeni Grup",
            PRODUCT_UNIT_ID: "",
            STOCK_ID: "-2",
            TREE: [],

        }]
    }
    console.log(a);
    var ResultArea = $("#Div_1");
    ResultArea.html(DataDoldur(a))
    MakeSortable()

}
function ChangeName(el, event) {
    var SentData = serializeTree();
    console.log(SentData);
}
function KayitEt(el, event) {
    var SentData = serializeTree();
    var Obje=new Object();
    Obje.CUSTOMER_ID=$("#company_id").val();
    Obje.CartelaDate=$("#txt_kartela_tarihi").val();
    Obje.ColorName=$("#product_name").val();
    Obje.Kumas=$("#product_id").val();
    Obje.Agac=SentData;
    console.log(Obje);
    $.ajax({
        url: "cfc/boyahane.cfc?method=AgacKayitEt",
        data: JSON.stringify(Obje),
        contentType: 'application/json; charset=utf-8',
        dataType: 'json',
        success: function (retdat) {
           // var obj_list = JSON.parse(retdat)
            console.log(retdat)
           // ResultArea.html(DataDoldur(obj_list))
            //MakeSortable()
        }
    })

}