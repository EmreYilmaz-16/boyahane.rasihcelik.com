
<cfquery name="getModules" datasource="#dsn#">
    SELECT * FROM BOYAHANE_PAGES where MODULE_ID=#attributes.module_id#
</cfquery>


<table class="table compact striped table-border cell-border ">
<thead><tr><th>HEAD</th><th>Menü</th><th>FULL FUESEACTION</th><th>PATH</th><th><cfoutput><a href="index.cfm?fuseaction=dev.add_page&module_id=#attributes.module_id#" class="btn btn-sm btn-outline-success"><i class="fas fa-folder-plus"></i></a></cfoutput></th></tr></thead>
<tbody>
<cfoutput query="getModules">
    <tr><td>#HEAD#</td><td>#IS_MENU#</td><td>#getModules.FULL_FUESEACTION#</td><td>#FILE_PATH#</td><td>
    <a href="index.cfm?fuseaction=dev.upd_page&page_id=#ID#"class="btn btn-sm btn-outline-warning"><i class="fas fa-recycle"></i></a></td></tr>
</cfoutput>
</tbody>
</table>