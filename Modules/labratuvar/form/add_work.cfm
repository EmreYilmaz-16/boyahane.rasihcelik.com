

<cfquery name="getUps" datasource="#dsn3#">
   SELECT  UP_STATION FROM catalyst_prod_1.WORKSTATIONS WHERE STATION_ID=(
SELECT STATION_ID FROM  catalyst_prod_1.PRODUCTION_ORDERS
WHERE P_ORDER_ID=#attributes.P_ORDER_ID#)
</cfquery>
<div style="box-shadow:1px 1px 20px 0px #c4c7ca;padding:0.5%">
        <div style="box-shadow:1px 1px 20px 0px #c4c7ca;padding:0.5%"><span style="text-shadow: 2px 1px 2px #93beff" class="text-primary fs-3">Planla</span></div>
<cfquery name="getStations" datasource="#dsn#">
SELECT (CONVERT(VARCHAR, STATION_ID) + ',0,0,0,-1,' + CONVERT(VARCHAR, EXIT_DEP_ID) + ',' + CONVERT(VARCHAR, EXIT_LOC_ID) + ',' + CONVERT(VARCHAR, PRODUCTION_DEP_ID) + ',' + CONVERT(VARCHAR, PRODUCTION_LOC_ID)) AS STATION_ID_LIST
	,STATION_NAME,WIDTH,LENGTH
FROM catalyst_prod_1.WORKSTATIONS
WHERE UP_STATION =#getUps.UP_STATION#
</cfquery>
<cfoutput>
<input type="hidden" name="ORDER_ID" id="ORDER_ID" value="#attributes.ORDER_ID#">
<input type="hidden" name="ORDER_ROW_ID" id="ORDER_ROW_ID" value="#attributes.ORDER_ROW_ID#">
<input type="hidden" name="P_ORDER_ID" id="P_ORDER_ID" value="#attributes.P_ORDER_ID#">
<table class="table table-sm">
    <tr>
        <td>
           <div class="form-group"><label>Makina</label>
            <select class="form-select" id="STATION_ID_LIST" name="STATION_ID_LIST" onchange="setWs(this)">
                <option value="">Seçiniz</option>
                <cfloop query="getStations">
                    <option value="#STATION_ID_LIST#">#STATION_NAME#</option>
                </cfloop>
            </select></div>
        </td>
        <td>
            <div class="form-group"><label>Plan Su Miktarı</label><input type="text" class="form-control" id="sumik" oninput="kontrolSu(this)" name="sumik"></div>
        </td>
       <!--- <td>
            <div class="form-group"><label>Hesaplanan Su Miktarı</label><input type="text" class="form-control" id="hessumik" name="hessumik"></div>
        </td>  ---> 
        <td>
        <div style="display:flex">
            <div class="form-group"><label>Maksimum</label><input readonly type="text" class="form-control" id="max" name="max"></div>
        
            <div class="form-group"><label>Minimum</label><input readonly type="text" class="form-control" id="min" name="min"></div>
        </div>
        </td>                        
    </tr>
    <tr>
      
        <td style="vertical-align:bottom">
            <div class="form-check">
                <input class="form-check-input" type="checkbox" value="1" id="acil" name="acil">
                <label class="form-check-label" for="acil">
                    Acil
                </label>
            </div>
        </td>
        <td style="vertical-align:bottom" >
            <div class="form-check">
                <input class="form-check-input" type="checkbox" value="1" id="yikama" name="yikama">
                <label class="form-check-label" for="yikama">
                    Öncesinde Yıkama Yapılacak mı?                
                </label>
            </div>
        </td>        
        
        
        <td><button class="btn btn-success" onClick="UpdProd()">Kaydet</button><button style="margin-left:5px" class="btn btn-warning">Eliara Veri Gönder</button></td>
    </tr>
    
</table> 
</div>
</cfoutput>
<script>
<cfinclude  template="add_work.js">
</script>

