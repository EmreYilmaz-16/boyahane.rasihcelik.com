var row_num = 0;
var OperationModal = new bootstrap.Modal(document.getElementById('exampleModalScrollable'))
var ProductModal = new bootstrap.Modal(document.getElementById('exampleModalScrollable_1'))
var denememem = "";
function OpenOperationPopup() {
    OperationModal.show()
}
function SearchProd() {
    var ResultArea = $("#Div_1");
    var keyword = $("#Modkeyword").val();
    $.ajax({
        url: "cfc/boyahane.cfc?method=getProdTreeWithName_yeni&keyword=" + keyword, success: function (retdat) {
            var obj_list = JSON.parse(retdat)
            SatirDoldur(obj_list)

        }
    })
}
function SatirDoldur(data) {
    DonecekData = "";
    for (let i = 0; i < data.length; i++) {
        var Urun = "<ul class='list-group'>";
        Urun += "<li class='list-group-item'>" + data[i].PRODUCT_NAME
        Urun += "<button style='float:right' class='btn btn-sm btn-danger'onclick='AgacaEkle(" + data[i].STOCK_ID + ")'>+</button>"
        var o_lvl_1 = data[i].TREE;
        if (o_lvl_1.length) {
            Urun += "<ul>";
            for (let j = 0; j < o_lvl_1.length; j++) {
                Urun += "<li>" + o_lvl_1[j].PRODUCT_NAME
                Urun += "</li>"
            }
            Urun += "</ul>";
        }
        Urun += "</li>"
        Urun += "</ul>";
        DonecekData += Urun;
    }

    $("#Div_1").html(DonecekData)

}
function SatirDoldur_1(data) {
    DonecekData = "";
    for (let i = 0; i < data.length; i++) {
        var Urun = "<ul class='list-group'>";
        Urun += "<li data-id='" + data[i].STOCK_ID + "' data-parent='0' data-row='" + row_num + "' class='list-group-item'><input type='text' id='line_order_" + row_num + "_" + data[i].STOCK_ID + "' value='" + row_num + "'>" + data[i].PRODUCT_NAME
        Urun += "<button style='float:right' class='btn btn-sm btn-warning'onclick='remProd(this," + data[i].STOCK_ID + "," + row_num + ")'>-</button><button style='float:right' class='btn btn-sm btn-primary'onclick='OpenProductpopup(" + data[i].STOCK_ID + "," + row_num + ")'>+</button>"
        var o_lvl_1 = data[i].TREE;
        if (o_lvl_1.length) {
            Urun += "<ul class='urun_agac_liste' style='margin-top:15px' id='urun_" + row_num + "_" + data[i].STOCK_ID + "'>";
            for (let j = 0; j < o_lvl_1.length; j++) {
                Urun += "<li style='margin-top:5px' data-id='" + o_lvl_1[j].STOCK_ID + "' data-parent='" + data[i].STOCK_ID + "' ><div style='display:flex'><input type='text' style='width:25px' id='line_order_" + row_num + "_" + o_lvl_1[j].STOCK_ID + "' value='" + o_lvl_1[j].LINE_NUMBER + "'>" + o_lvl_1[j].PRODUCT_NAME
                Urun += "<button style='float:right; margin-inline-start: auto' class='btn btn-sm btn-danger'onclick='reminner(this," + data[i].STOCK_ID + "," + row_num + ")'>-</button><input type='number' class='form-control form-control-sm RT_" + o_lvl_1[j].TIP + "' onchange='RenkHesapla()' style='width:70px' id='amount_" + row_num + "_" + o_lvl_1[j].STOCK_ID + "' value='" + o_lvl_1[j].AMOUNT + "'></div></li>"
            }
            Urun += "</ul>";
        }
        Urun += "</li>"
        Urun += "</ul>";
        DonecekData += Urun;
        $("#urun_" + row_num + "_" + data[i].STOCK_ID).sortable({});
    }
    $("#CurrentTree").append(DonecekData)

    row_num++;

}
function SatirDoldur_2(data) {
    DonecekData = "";
    for (let i = 0; i < data.length; i++) {
        var Urun = "<ul class='list-group'>";
        Urun += "<li class='list-group-item'>" + data[i].PRODUCT_NAME
        Urun += "<button style='float:right' class='btn btn-sm btn-danger'onclick='icineEkle(" + data[i].STOCK_ID + ")'>+</button>"
        var o_lvl_1 = data[i].TREE;
        if (o_lvl_1.length) {
            Urun += "<ul>";
            for (let j = 0; j < o_lvl_1.length; j++) {
                Urun += "<li>" + o_lvl_1[j].PRODUCT_NAME
                Urun += "</li>"
            }
            Urun += "</ul>";
        }
        Urun += "</li>"
        Urun += "</ul>";
        DonecekData += Urun;
    }

    $("#Div_1_PROD").html(DonecekData)

}
function AgacaEkle(stock_id) {
    $.ajax({
        url: "cfc/boyahane.cfc?method=getProdTreeWithName_yeni&stock_id=" + stock_id, success: function (retdat) {
            var obj_list = JSON.parse(retdat)
            console.log(retdat)
            SatirDoldur_1(obj_list)

        }
    })
}
function SearchProd_2() {
    var ResultArea = $("#Div_1_PROD");
    var keyword = $("#Prokeyword").val();
    $.ajax({
        url: "cfc/boyahane.cfc?method=getProdTreeWithName_yeni&keyword=" + keyword, success: function (retdat) {
            var obj_list = JSON.parse(retdat)
            SatirDoldur_2(obj_list)

        }
    })
}
function OpenProductpopup(sid, rown) {
    $("#tx_1").val(sid)
    $("#rowx_1").val(rown)
    ProductModal.show()
}
function icineEkle(stock_id) {
    var amk = $("#tx_1").val()
    var amk2 = $("#rowx_1").val()
    $.ajax({
        url: "cfc/boyahane.cfc?method=getProdTreeWithName_yeni&stock_id=" + stock_id, success: function (retdat) {
            var obj_list = JSON.parse(retdat)
            console.log(retdat)
            var eek = "<li style='margin-top:5px'  data-id='" + obj_list[0].STOCK_ID + "' data-parent='" + amk + "'><div style='display:flex'><input type='text' style='width:25px' class='' id='line_order_" + amk2 + "_" + obj_list[0].STOCK_ID + "' value='" + obj_list[0].LINE_NUMBER + "'>" + obj_list[0].PRODUCT_NAME + "<button style='float:right; margin-inline-start: auto' class='btn btn-sm btn-danger'onclick='reminner(this,1,2)'>-</button><input type='number' class='form-control form-control-sm RT_" + obj_list[0].TIP + "' onchange='RenkHesapla()' style='width:70px' id='amount_" + amk2 + "_" + obj_list[0].STOCK_ID + "' value='" + obj_list[0].AMOUNT + "'></div></li>"
            console.log(eek)
            $("#urun_" + amk2 + "_" + amk).append(eek)
            $(".urun_agac_liste").sortable();
            RenkHesapla();
        }
    })
}

function remProd(elem, a, b) {
    $(elem).parent().parent().remove();
    RenkHesapla();
}
function reminner(elem, a, b) {
    $(elem).parent().parent().remove();
    RenkHesapla();
}
function RenkHesapla() {
    var oranlarL = $(".RT_0")
    var orant = 0;
    for (let i = 0; i < oranlarL.length; i++) {
        orant += parseFloat($(oranlarL[i]).val())
    }
    console.log(orant)
    var RenkTonu = 1;
    if (orant < 0.2) { } else if (orant < 0.5) { RenkTonu = 2 } else if ( orant < 1) { RenkTonu = 3 }else if (orant < 2) { RenkTonu = 4 }else if (orant < 3) { RenkTonu = 5 }else if (orant > 3) { RenkTonu = 6 }
    console.log(RenkTonu)
    $("#Rtone").val(RenkTonu)
}
function Serialize_Product_Tree() {
    var Liste = new Array();
    var Gidecek = $("#CurrentTree")
    var ilkSeviye = Gidecek.children()
    for (let i = 0; i < ilkSeviye.length; i++) {
        var icerik = $(ilkSeviye[i]).children();
        var Obje = new Object();
        Obje.Sira = $(icerik.find("input")[0]).val()
        Obje.SID_=$(icerik).data("id")
        var inner = $(icerik.find("ul")[0]).children()
        var Agac = new Array();
        for (let j = 0; j < inner.length; j++) {
            var o2 = new Object();
            o2.ParentRow = Obje.Sira;
            o2.Sid = $(inner[j]).data("id")
            o2.SiraNo = $(inner[j]).find("input")[0].value
            o2.PARENT_SID= Obje.SID_;
            o2.Miktar = $(inner[j]).find("input")[1].value
            Agac.push(o2)
        }
        Obje.Tree = Agac;
        Liste.push(Obje)
    }
    return Liste

}

function Renk_Kaydet() {
    var cart_date = $("#cart_date").val();
    var cartlea = $("#cartlea").val();
    var hazir = $("#flexSwitchCheckDefault").val();
    var Rtone = $("#Rtone").val();
    var paint_degree = $("#paint_degree").val();
    var company_name = $("#company_name").val();
    var company_id = $("#company_id").val();
    var partner_id = $("#partner_id").val();
    var product_id = $("#product_id").val();
    var stock_id = $("#stock_id").val();
    var color_code = $("#color_code").val();
    var color_name = $("#color_name").val();
    var information = $("#information").val();
    var flatte= $("#flote").val();
    var Obje = new Object();
    Obje.KARTELA_TARIHI = cart_date;
    Obje.KARTELA = cartlea;
    Obje.HAZIR = hazir;
    Obje.RENK_TONU = Rtone;
    Obje.BOYA_DERECESI = paint_degree;
    Obje.MUSTERI_ADI = company_name;
    Obje.MUSTERI_ID = company_id;
    Obje.PARTNER_ID = partner_id;
    Obje.URUN_ID = product_id;
    Obje.STOK_ID = stock_id;
    Obje.RENK_KODU = color_code;
    Obje.RENK_ADI = color_name;
    Obje.ACIKLAMA = information;
    Obje.FLATTE  = flatte;
    Obje.AGAC = Serialize_Product_Tree()
    console.log(Obje);
    var dataJSON = JSON.stringify(Obje);
    var form = document.createElement('form');
    form.setAttribute('method', 'post');
    form.setAttribute('action', '/index.cfm?fuseaction=test_page_3');

    // create hidden input containing JSON and add to form
    var hiddenField = document.createElement("input");
    hiddenField.setAttribute("type", "hidden");
    hiddenField.setAttribute("name", "eklenecek");
    hiddenField.setAttribute("value", dataJSON);
    form.appendChild(hiddenField);

    // add form to body and submit
    document.body.appendChild(form);
    form.submit();

}