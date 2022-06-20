
<cfquery name="getf" datasource="#dsn#">
SELECT * FROM catalyst_prod.BOYAHANE_PRINT_FILES WHERE ID=#attributes.print_id#
</cfquery>

<cfinclude  template="/documents/print_files/#getf.PRINT_PATH#">