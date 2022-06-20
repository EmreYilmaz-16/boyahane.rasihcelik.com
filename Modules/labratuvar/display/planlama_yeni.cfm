<cfquery NAME="GETuPsTATIONS" DATASOURCE="#DSN3#">
select STATION_ID,UP_STATION,STATION_NAME from WORKSTATIONS where UP_STATION IS NULL
</cfquery>
<SELECT class="form-control form-control-sm" NAME="UPSTATION" ID="UPSTATION" ONCHANGE="GET_SHEDULE_DATA(this)">
<cfoutput QUERY="GETuPsTATIONS">
    <OPTION VALUE="#STATION_ID#">#STATION_NAME#</OPTION>
</cfoutput>
</SELECT>

<div class="row">
<div class="col col-sm-12 col-md-12 col-lg-4">
<div class="card">
  <div class="card-header">
    <h3 class="card-title">İş Listesi</h3>
    <div class="card-tools">  
    <button type="button" class="btn btn-tool" onclick='openModal_partner("/index.cfm?fuseaction=labratuvar.emptypopup_ajaxpage_concat_p_orders","modal-xl")'><i class="fas fa-link"></i></button>
      <button type="button" class="btn btn-tool" data-card-widget="maximize"><i class="fas fa-expand"></i></button>
      <button type="button" class="btn btn-tool" data-card-widget="collapse"><i class="fas fa-minus"></i></button>
    </div>  
  </div>  
  <div class="card-body">
    <div id="plan_list"></div>
    <div id="action-add"></div>
<div id="action-add2"></div>
  </div>  
</div>
</div>
<div class="col col-sm-12 col-md-12 col-lg-8">
<div class="card">
  <div class="card-header">
    <h3 class="card-title">Planlama</h3>
    <div class="card-tools">  
      <button type="button" class="btn btn-tool" data-card-widget="maximize"><i class="fas fa-expand"></i></button>
      <button type="button" class="btn btn-tool" data-card-widget="collapse"><i class="fas fa-minus"></i></button>
      
    </div>  
  </div>  
  <div class="card-body">
  
  <script>
 

 <cfquery name="getDurumList" datasource="#dsn3#">
    SELECT * FROM PARTNER_WORK_STAGE_COLOR
</cfquery>

var priorityData = [
   <cfoutput query="getDurumList">
    {
        text: "#STAGE#",
        id: #STAGE_ID#,
        color: "#COLOR#"
    },
   </cfoutput>

];

  </script>
     <div id="context-menu"></div>  
  <div id="scheduler"></div>
  </div>  
</div>
</div>
</div>

<script>
<cfinclude template="plan_yeni.js">
</script>