<div class="card">

<div class="card-header">Emir Birleştir</div>
<div class="card-body">
<cfdump var="#attributes#">
    <table class="table table-sm">
<tr>
<td>
<cfquery name="GetStationGroup" datasource="#dsn3#">
    SELECT * FROM WORKSTATIONS WHERE UP_STATION IS NULL
</cfquery>
<select class="form-control form-control-sm" name="up_station" id="up_station" onchange="getSubStations(this)">
<option value="">Seçiniz - İstasyon Grubu</option>
<cfoutput query="GetStationGroup">
    <option value="#STATION_ID#">#STATION_NAME#</option>
</cfoutput>
</select>
</td>
<td>
<select name="subStation" id="subStation" onchange="setWs(this)" class="form-control form-control-sm">

</select>
</td>
</tr>
<tr>
<td>
 <div class="form-group"><label>Plan Su Miktarı</label><input type="text" class="form-control form-control-sm" id="sumik" oninput="kontrolSu(this)" name="sumik"></div>
  </td>
  <td> 
   <div style="display:flex">
            <div class="form-group"><label>Maksimum</label><input readonly type="text" class="form-control form-control-sm" id="max" name="max"></div>
        
            <div class="form-group"><label>Minimum</label><input readonly type="text" class="form-control form-control-sm" id="min" name="min"></div>
        </div>
    </td>
    </tr>
    <tr>
        <td colspan="2">
            <button style="display:none" type="button" onclick="openModal_partner('/index.cfm?fuseaction=labratuvar.emptypopup_ajaxpage_emir_list&up_station='+document.getElementById('up_station').value)" id="btnemir" class="btn btn-sm btn-outline-primary">Emir Ekle</button>
            <button type="button" onclick="Birlestirrr()" class="btn btn-sm btn-outline-success">Kaydet</button>
        </td>
    </tr>    
    <tr><td colspan="2">
    <cfform id="forumEmir">
        <table  class="table table-sm table-striped">
           <thead></thead>
           <tbody id="partList"></tbody>
        </table>
    </cfform>
     </td></tr>
    </table>
    
</div>
</div>
<script>
function getSubStations(elem){
    var UpStationId=elem.value;
    var q="SELECT * FROM WORKSTATIONS WHERE UP_STATION="+UpStationId
    var query_res=wrk_query(q,"dsn3");
    var res_elem=document.getElementById("subStation")
    $(res_elem).html("")
    console.log(query_res)
    var opt=document.createElement("option");
    opt.setAttribute("value","");
    opt.innerText="Seçiniz - İstasyon";
    res_elem.appendChild(opt)
    for(let i=0;i<query_res.ACTIVE.length;i++){
        var e=document.createElement("option");
        e.setAttribute("value",query_res.STATION_ID[i])
        e.innerText=query_res.STATION_NAME[i]
        res_elem.appendChild(e)
        
    }
    $("#btnemir").hide();
}
function setWs(elem) {
    var id_ = elem.value;
    var id = list_getat(id_, 1);
    console.log(id)
    var min_max = wrk_query("SELECT WIDTH,LENGTH FROM WORKSTATIONS WHERE STATION_ID=" + id, "dsn3");
    console.log(min_max)
    $("#max").val(min_max.LENGTH[0])
    $("#min").val(min_max.WIDTH[0])
    $("#btnemir").show();
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

function Birlestirrr(){
    var form_data=$("#forumEmir").serialize();
    var st_id=$("#subStation").val()
    var plan_su_mik=$("#subStation").val()
    form_data+="&station_id="+st_id
    console.log(form_data)
windowopen("/index.cfm?fuseaction=labratuvar.emptypopup_concat_porders&"+form_data)
}
</script>