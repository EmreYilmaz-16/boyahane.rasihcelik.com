<style>
@media print
{    
    .no-print, .no-print *
    {
        display: none !important;
    }
}
</style>

<div class="no-print" id="header_area">
<div style="display:flex;justify-content: flex-end;padding-bottom:5px">
<cfquery name="getPfiles" datasource="#dsn#">
    SELECT * FROM BOYAHANE_PRINT_FILES where MODULE_ID=#attributes.module_id#
</cfquery>

   
<a style="margin-right:5px" onclick="document.getElementById('ifrm1').contentWindow.print()"><i class="fas fa-print"></i></a>
<select onchange="SetSablon(this)" id="pfil">

<cfif getPfiles.recordcount>
<cfset def_adres="index.cfm?fuseaction=object.emptypopup_print_files_inner&print_id=#QueryFilter(getPfiles,function(obj){return obj.IS_DEFAULT EQ 1}).ID#">
<cfif isDefined("attributes.action_id")><cfset def_adres="#def_adres#&action_id=#attributes.action_id#"></cfif>
<cfif isDefined("attributes.iid")><cfset def_adres="#def_adres#&iid=#attributes.iid#"></cfif>
<cfif isDefined("attributes.action_ids")><cfset def_adres="#def_adres#&action_ids=#attributes.action_ids#"></cfif>
<cfif isDefined("attributes.iids")><cfset def_adres="#def_adres#&iids=#attributes.iids#"></cfif>
  
<cfoutput query="getPfiles">
<option value="#ID#">#HEAD#</option>
</cfoutput>
<cfelse>
<option value="">Şablon Bulunamadı</option>
</cfif>
</select>
</div>
<cf_prt_page_header>
</div>

<div id="printArea">

<iframe id="ifrm1" name="ifrm1" style="width:100%;height:100vh"  src="<cfoutput>#def_adres#</cfoutput>"></iframe>
</div>
<script>
    function SetSablon(elem){
        var e=document.getElementById("ifrm1");
        var adres="index.cfm?fuseaction=object.emptypopup_print_files_inner"
        let params = (new URL(document.location)).searchParams;
        let param1 = params.get('action_id'); // is the string "Jonathan Smith".
        let param2 = params.get('iid'); // is the string "Jonathan Smith".
        let param3 = params.get('action_ids'); // is the string "Jonathan Smith".
        let param4 = params.get('iids'); // is the string "Jonathan Smith".
        adres+="&action_id="+param1
        adres+="&iid="+param2
        adres+="&action_ids="+param3
        adres+="&iids="+param4
        adres+="&print_id="+elem.value
        e.setAttribute("src",adres)
    }
</script>