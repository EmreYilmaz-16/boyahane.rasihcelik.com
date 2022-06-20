<cfquery name="getModules" datasource="#dsn#">
    SELECT * FROM BOYAHANE_SUB_MODULES where MODULE_ID=#attributes.module_id#
</cfquery>


<table class="table compact striped table-border cell-border ">
<thead><tr><th>Modül</th><th>Menü</th><th><cfoutput><a href="index.cfm?fuseaction=dev.add_sub_module&module_id=#attributes.module_id#" class="btn btn-sm btn-outline-success"><i class="fas fa-folder-plus"></i></a></cfoutput></th></tr></thead>
<tbody>
<cfoutput query="getModules">
    <tr>
        <td>#MODULE#</td><td>#IS_MENU#</td>
        <td>
            <a href="index.cfm?fuseaction=dev.list_pages&module_id=#ID#" class="btn btn-sm btn-outline-primary"><i class="fas fa-angle-double-down"></i></a>
            <a href="index.cfm?fuseaction=dev.upd_sub_module&module_id=#ID#" class="btn btn-sm btn-outline-warning"><i class="fas fa-recycle"></i></a>
        </td>
 
    </tr>
</cfoutput>
</tbody>
</table>