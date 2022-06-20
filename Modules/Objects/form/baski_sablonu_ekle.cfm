
<cfparam  name="attributes.event" default="add">
<div style="box-shadow:1px 1px 20px 0px #c4c7ca;padding:0.5%">
        <div style="box-shadow:1px 1px 20px 0px #c4c7ca;padding:0.5%;margin-bottom:10px"><span style="text-shadow: 2px 1px 2px #93beff" class="text-primary fs-3">Baskı Şablonları</span></div>
<div class="row">
<div class="col-3">
<cfquery name="getPrintFiles" datasource="#dsn#">
select * from BOYAHANE_PRINT_FILES
</cfquery>
<cfquery name="getModules" datasource="#dsn#">
select * from BOYAHANE_SUB_MODULES
</cfquery>
<table class="table table-striped table-hover">
<tr><th style="text-align:right"><a href="<cfoutput>#request.self#?fuseaction=#attributes.fuseaction#&event=add</cfoutput>"><i class="fas fa-plus-square"></i></a></th></tr>
<cfoutput query="getPrintFiles">
<tr><td> <a href="index.cfm?fuseaction=#attributes.fuseaction#&event=upd&print_id=#ID#">#HEAD#</a></td></tr>
</cfoutput>
</table>
</div> 
<div class="col-9">
<cfif attributes.event eq "add">
<cfform method="post" action="#request.self#?fuseaction=#attributes.fuseaction#" enctype="multipart/form-data">
<input type="hidden" value="1" name="is_submit">
<input type="hidden" value="add" name="event">
<table class="table">
<tr>
<td>Dosya Adı</td>
<td>
<input class="form-control" type="text" name="HEAD"></td>
</tr>
<tr>
<td>Modül</td>
<td>
<select class="form-control" name="module_id">
<option value="">Seçiniz</option>
<cfoutput query="getModules">
<option value="#ID#">#Module#</option>
</cfoutput>
</tr>
<tr>
<td>Dosya</td>
<td>
<input class="form-control" type="file" name="FileContents" id="FileContents"></td>
<input type="hidden"  name="FileName" id="FileName">
</tr>
<tr>
<td>Standart Seçenek</td>
<td>
<input class="form-check" type="checkbox" name="is_default" value="1"></td>
</tr>
<tr><td colspan="2"><input class="btn btn-success" type="submit"></td></tr>
</table>
</cfform>
<cfelse>
<cfform method="post" action="#request.self#?fuseaction=#attributes.fuseaction#" enctype="multipart/form-data">
<cfquery name="getPf" dbtype="query">
    SELECT * FROM getPrintFiles WHERE ID = #attributes.print_id#
</cfquery>

<cfoutput >
<input type="hidden" value="1" name="is_submit">
<input type="hidden" value="upd" name="event">
<input type="hidden" value="#attributes.print_id#" name="PRINT_ID">
<table class="table">
<tr>
<td>Dosya Adı</td>
<td>
<input class="form-control" type="text" name="HEAD" value="#getPf.HEAD#"></td>
</tr>
<tr>
<td>Modül</td>
<td>
<select class="form-control" name="module_id">
<option value="">Seçiniz</option>
<cfloop query="getModules">
<option <cfif ID  eq getPf.MODULE_ID>selected</cfif>  value="#ID#">#Module#</option>
</cfloop>
</tr>
<tr>
<td>Dosya</td>
<td>
<input class="form-control" type="file" name="FileContents" id="FileContents">
<code>documents/printfiles/#getPf.PRINT_PATH#</code>
</td>
<input type="hidden"  name="FileName" id="FileName" value="#getPf.PRINT_PATH#">
</tr>
<tr>
<td>Standart Seçenek</td>
<td>
<input <cfif getPf.IS_DEFAULT eq 1>checked</cfif> class="form-check" type="checkbox" name="is_default" value="1"></td>
</tr>
<tr><td colspan="2"><input class="btn btn-success" type="submit"></td></tr>
</table>
</cfoutput>
</cfform>
</cfif>
<cfdump  var="#expandPath("./documents/print_files")#">
</div>
</div>
<cfif isDefined("attributes.is_submit")>
<cfif attributes.event eq "add">


    <cffile action = "upload" result="resfile"
    fileField = "FileContents"
    destination = "#expandPath("./documents/print_files")#" 
    nameConflict = "Overwrite"> 
<cfdump  var="#resfile#">

              
              
              <cfset yeni_ad= createUUID()&'.'&resfile.SERVERFILEEXT>
              <cffile action="rename" source="#resfile.SERVERDIRECTORY#\#resfile.SERVERFILE#" destination="#resfile.SERVERDIRECTORY#\#yeni_ad#">
              <cfquery name="insertPr" datasource="#dsn#">
                INSERT INTO BOYAHANE_PRINT_FILES (HEAD,PRINT_PATH,MODULE_ID,IS_DEFAULT) VALUES ('#attributes.head#','#yeni_ad#',#attributes.module_id#,
                <cfif isDefined("attributes.is_default")>1<cfelse>0</cfif>
                )
              </cfquery>
<cfelse>
<cfdump  var="#attributes#">
<cfif len(attributes.FILECONTENTS)>
  <cffile action = "upload" result="resfile"
    fileField = "FileContents"
    destination = "#expandPath("./documents/print_files")#" 
    nameConflict = "Overwrite"> 
      <cfset yeni_ad= createUUID()&'.'&resfile.SERVERFILEEXT>
              <cffile action="rename" source="#resfile.SERVERDIRECTORY#\#resfile.SERVERFILE#" destination="#resfile.SERVERDIRECTORY#\#yeni_ad#">
              <cfelse><cfset yeni_ad=attributes.FILENAME>
    </cfif>
<cfquery name="updPrint" datasource="#dsn#">
UPDATE BOYAHANE_PRINT_FILES SET HEAD='#attributes.head#',PRINT_PATH='#yeni_ad#',MODULE_ID=#attributes.module_id#,IS_DEFAULT=<cfif isDefined("attributes.is_default")>1<cfelse>0</cfif> WHERE ID =#attributes.PRINT_ID#
</cfquery>

</cfif></cfif>
</div>
</div>
<script>
    $('#FileContents').change(function(e){
    var fileName = e. target. files[0]. name;
    $("#FileName").val(fileName)
    });
    $("#Aksiyon").change(function(){
        var a=$(this).val()
       if(a==2){
           $("#HdDiv").show()
           $("#submit").html("Sil")
           $("#FileContents").attr("disabled","true")
       }else if(a==1){
           $("#HdDiv").hide()
            $("#submit").html("İçeri Aktar")
             $("#FileContents").removeAttr("disabled")
       } else if(a==3){
           $("#HdDiv").hide()
            $("#submit").html("Karşılaştır")
             $("#FileContents").removeAttr("disabled")
       }else if(a==4){
           $("#HdDiv").hide()
            $("#submit").html("Karşılaştır")
             $("#FileContents").removeAttr("disabled")
       }
    })
</script>
