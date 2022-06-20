<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-giJF6kkoqNQ00vy+HMDP7azOuL0xtbfIcaT9wjKHr8RbDVddVHyTfAAsrekwKmP1" crossorigin="anonymous">
<style>
.coal{
    background: #EB5757 !important;background: -webkit-linear-gradient(to right, #000000, #EB5757) !important;background: linear-gradient(to right, #000000, #EB5757) !important;
}
.bluew{
    background: #06beb6 !important;background: -webkit-linear-gradient(to right, #06beb6, #48b1bf) !important; background: linear-gradient(to right, #06beb6, #48b1bf) !important;
}
.orca{
    background: #44A08D !important;  /* fallback for old browsers */
background: -webkit-linear-gradient(to right, #093637, #44A08D) !important;  /* Chrome 10-25, Safari 5.1-6 */
background: linear-gradient(to right, #093637, #44A08D) !important; /* W3C, IE 10+/ Edge, Firefox 16+, Chrome 26+, Opera 12+, Safari 7+ */

}
.ibiza{
    background: #ee0979 !important;  /* fallback for old browsers */
background: -webkit-linear-gradient(to right, #ff6a00, #ee0979) !important;  /* Chrome 10-25, Safari 5.1-6 */
background: linear-gradient(to right, #ff6a00, #ee0979) !important; /* W3C, IE 10+/ Edge, Firefox 16+, Chrome 26+, Opera 12+, Safari 7+ */

}
.custom{
background: rgb(5,255,244) !important;
background: linear-gradient(90deg, rgba(5,255,244,1) 0%, rgba(255,0,134,1) 25%, rgba(255,235,0,1) 65%, rgba(71,62,0,1) 100%) !important;
}
</style>
<cfif isDefined("attributes.fuseaction")><cfelse><cfset attributes.fuseaction=""></cfif>
<cfoutput><form method="post" action="#request.self#?fuseaction=#attributes.fuseaction#">
<input type="hidden" name="is_submit" value="1">
<div style="width:400px;height:350px;border:none;  position: fixed;  position: fixed;top: 50%;left: 50%;transform: translate(-50%, -50%);">
<table class="table table-borderless" style="margin-top:20px;border:solid 1px gray">
<tr>
<td colspan="2" class="custom">
<span style="color:white;font-weight:normal;font-size:14pt !important;float:left">Partner Boyahane</span><span style="color:white;font-weight:normal;font-size:14pt !important;float:right">2021</span>
</td></tr>
<tr>
<td colspan="2" style="text-align:center"><img src="/contents/images/mmcolor.png" style="height:100px"></td>
</tr>
<tr>
<td><span style="color:black;font-weight:normal;font-size:14pt !important">Kullanıcı Adı</span></td><td><input type="text" name="username" class="form-control"></td>

</tr>
<tr>
<td><span style="color:black;font-weight:normal;font-size:14pt !important">Şifre</span></td><td><input type="password" name="pword" class="form-control"></td>
</tr>
<tr>
<td colspan="2" style="text-align:right"><input type="submit" value="Giriş Yap" class="btn btn-outline-primary"></td>

</tr>
</table>
</div>
<form></cfoutput>

<cfif isDefined("attributes.is_submit") and attributes.is_submit eq 1>
<cfset temp=attributes.pword>
<cfset cryptedPassword = hash(temp, "SHA-256", "UTF-8")>
<cfquery name="getUser" datasource="#dsn#">
select E.*,EP.POSITION_CODE,MS.LANGUAGE_ID,MS.TIME_ZONE FROM  
catalyst_prod.EMPLOYEES AS E LEFT JOIN catalyst_prod.EMPLOYEE_POSITIONS AS EP ON EP.EMPLOYEE_ID=E.EMPLOYEE_ID 
LEFT JOIN catalyst_prod.MY_SETTINGS AS MS ON MS.EMPLOYEE_ID=E.EMPLOYEE_ID
where E.EMPLOYEE_USERNAME='#attributes.username#' and E.EMPLOYEE_PASSWORD='#cryptedPassword#'
</cfquery>
<cfquery name="getComp" datasource="#dsn#">
SELECT * FROM catalyst_prod.OUR_COMPANY where COMP_ID=1
</cfquery>
<cfif getUser.recordcount>
<cfset session.ep.USERID=getUser.EMPLOYEE_ID>
<cfset session.ep.OUR_COMPANY_INFO.SPECT_TYPE=0>
<cfset session.ep.MONEY="TL">
<cfset session.ep.MONEY2="USD">
<cfset session.ep.COMPANY_ID =1>
<cfset session.ep.POSITION_CODE =getUser.POSITION_CODE>
<cfset session.ep.company =getComp.COMPANY_NAME>
<cfset session.ep.COMPANY_EMAIL  =getComp.EMAIL>
<cfquery name="getcurrrentPeriod" datasource="#dsn#">
SELECT * FROM catalyst_prod.SETUP_PERIOD WHERE OUR_COMPANY_ID=1 AND PERIOD_YEAR=YEAR(GETDATE())
</cfquery>
<cfset session.ep.PERIOD_YEAR=getcurrrentPeriod.PERIOD_YEAR>
<cfquery name="getUserLevels" datasource="#dsn#">
SELECT USER_GROUP_ID ,USER_GROUP_PERMISSIONS,POWERUSER,REPORT_USER_LEVEL FROM catalyst_prod.USER_GROUP WHERE USER_GROUP_ID IN (SELECT USER_GROUP_ID FROM catalyst_prod.USER_GROUP_EMPLOYEE WHERE EMPLOYEE_ID=#getUser.EMPLOYEE_ID# )
</cfquery>
<cfset session.ep.PERIOD_ID =getcurrrentPeriod.PERIOD_ID>
<cfset session.ep.LANGUAGE =getUser.LANGUAGE_ID>
<cfset session.ep.TIME_ZONE  =getUser.TIME_ZONE>
<cfset session.ep.POWER_USER  =getUserLevels.USER_GROUP_ID>
<cfset session.ep.POWER_USER_LEVEL_ID  =getUserLevels.POWERUSER>
<cfset session.ep.REPORT_USER_LEVEL  =getUserLevels.REPORT_USER_LEVEL>
<cfset session.ep.USER_LEVEL  =getUserLevels.USER_GROUP_PERMISSIONS>
<script>
window.location.href="index.cfm?fuseaction=home.display_welcome";
</script>
</cfif>

</cfif>