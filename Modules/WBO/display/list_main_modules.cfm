
<cfquery name="getMain" datasource="#dsn#">
    SELECT * FROM BOYAHANE_MODULES 
</cfquery>
<table class="table compact striped table-border cell-border ">
<thead><tr><th>Modül</th><th>Menü</th><th><cfoutput><a href="index.cfm?fuseaction=dev.add_main_module" class="btn btn-sm btn-outline-success"><i class="fas fa-folder-plus"></i></a></cfoutput></th></tr></thead>
<tbody>
<cfoutput query="getMain">
    <tr>
        <td>#MODULE#</td><td>#IS_MENU#</td>
        <td>
            <a href="index.cfm?fuseaction=dev.list_sub_modules&module_id=#ID#" class="btn btn-sm btn-outline-primary"><i class="fas fa-angle-double-down"></i></a>
            <a href="index.cfm?fuseaction=dev.upd_main_module&module_id=#ID#" class="btn btn-sm btn-outline-warning"><i class="fas fa-recycle"></i></a>
        </td>
    
    
    </tr>
</cfoutput>
</tbody>
</table>


