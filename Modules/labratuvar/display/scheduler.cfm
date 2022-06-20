 <div id="context-menu"></div>  
  <div id="scheduler"></div>
  
  <script>
 <cfinclude  template="schedule.js">

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