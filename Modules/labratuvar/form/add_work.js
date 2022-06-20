var hata = "";
function saatKontrol() {

    var durum = true;

    var start_date = document.getElementById("start_date").value
    var end_date = document.getElementById("end_date").value
    var start_hour = document.getElementById("bas_saat").value
    var start_minute = document.getElementById("bas_dakika").value
    var end_hour = document.getElementById("bit_saat").value
    var end_minute = document.getElementById("bit_dakika").value
    var tar1 = start_date + " " + start_hour + ":" + start_minute
    var d = new Date(tar1)
    var tar2 = end_date + " " + end_hour + ":" + end_minute
    var d2 = new Date(tar2)

    start_date = new Date(start_date)
    end_date = new Date(end_date)
    return {
        status: durum,
        error_message: hata
    }
}

function saveWork(el) {
    var a = saatKontrol();
    if (a.status) {
        var form_data = $("#order_form").serialize();

        var e = document.getElementsByClassName("modal")[0]
        var mym = bootstrap.Modal.getInstance(e)
        mym.hide()
        //windowopen("index.cfm?fuseaction=labratuvar.emptypopup_add_production&"+form_data)
    } else {
        alert(a.error_mesage)
    }
}
function getLastTime() {
    var elem = document.getElementsByName("STATION_ID_LIST")[0]
    var station_id = elem.value.substring(0, 1)

    var r = wrk_query("select DATEPART(HOUR,FINISH_DATE) AS SAAT ,DATEPART(MINUTE,FINISH_DATE) DAKIKA from catalyst_prod_1.PRODUCTION_ORDERS where CONVERT(date,FINISH_DATE)=CONVERT(DATE,GETDATE()) AND STATION_ID=" + station_id);
    var S=new Object();
    if (r.RECORDCOUNT > 0) {
        //$("#bas_saat").val(r.SAAT[0]);
        S.SAAT=r.SAAT[0];
        //$("#bas_dakika").val(r.DAKIKA[0]);
        S.DAKIKA=r.DAKIKA[0];
    } else {
        var d = new Date()
     //   $("#bas_saat").val(d.getHours())
       // $("#bas_dakika").val(d.getMinutes());
       S.SAAT=d.getHours();
       S.DAKIKA=d.getMinutes();
       
    }
    return S
}
function setWs(elem) {
    var id_ = elem.value;
    var id = list_getat(id_, 1);
    console.log(id)
    var min_max = wrk_query("SELECT WIDTH,LENGTH FROM WORKSTATIONS WHERE STATION_ID=" + id, "dsn3");
    console.log(min_max)
    $("#max").val(min_max.LENGTH[0])
    $("#min").val(min_max.WIDTH[0])
}

function kontrolSu(elem) {
    var v = parseInt(elem.value);
    var min = parseInt($("#min").val());
    var max = parseInt($("#max").val());
    console.log(v)
    console.log(min)
    console.log(max)

    if (min > v || isNaN(v)) { hata = "Minumun Miktardan Küçük Olamaz"; } else if (max < v || isNaN(v)) { hata = "Maksimum Miktardan Küçük Olamaz" } else { hata = "" }
    console.log(hata)
    // {hata="Maksimum Miktardan Küçük Olamaz";}else{hata=""}
    console.log(hata)
    if (hata.length) { elem.setAttribute("style", "background:red;color:white;font-weight:bold") } else { elem.setAttribute("style", "background:green;color:white;font-weight:bold"); hata = "" }
}

function UpdProd() {
    kontrolSu(document.getElementById('sumik'));
    var o = new Object();
    o.station_id = "";
    o.plan_su = "";
    o.acil = "";
    o.yikama = "";
    o.order_id="";
    o.order_row_id="";
    o.p_order_id="";
    if (hata.length == 0) {
        var station_id = document.getElementById("STATION_ID_LIST").value
        var plan_su = document.getElementById("sumik").value
        var order_id = document.getElementById("ORDER_ID").value
        var order_row_id = document.getElementById("ORDER_ROW_ID").value
        var p_order_id = document.getElementById("P_ORDER_ID").value
        if (document.getElementById('acil').checked) { var acil = 1; } else { var acil = 0 }
        if (document.getElementById('yikama').checked) { var yikama = 1; } else { var yikama = 0 }
        o.station_id = station_id;
        o.plan_su = plan_su;
        o.acil = acil;
        o.yikama = yikama;
        o.order_id = order_id;
        o.order_row_id = order_row_id;
        o.p_order_id = p_order_id;
        o.start_HOUR=getLastTime().SAAT;
        o.start_MINUTE=getLastTime().DAKIKA;
        $.ajax({
            url: "/cfc/boyahane.cfc?method=UpdateProductionOrders",
            dataType: "application/json",
            data:o,
            success: function (retData) {
          
          console.log(retData)      // console.log(retData)
             // var resp=Jquery(jqXHR.responseText)
              //var respS=resp.filter("script");
              //Jquery.each(respS, function(idx,val){eval(val.text)})
             // ModalOlustur(retData)
             // wrk_query_handler(arr)
            }

        });
    }
   //<cf console.log(o)
   return o

}

