<cfquery name="getController" datasource="#dsn#">
    SELECT CONTROLLER_PATH FROM BOYAHANE_PAGES WHERE FUSEACTION=#attributes.fuseaction#
</cfquery>
<cfinclude  template="/controller/#getController.CONTROLLER_PATH#">
