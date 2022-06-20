<cfdump  var="#attributes#">

<cfset dsn1="#dsn#_product">
<cfset dsn1_ALIAS="#dsn#_product">
<cfset dsn_ALIAS="#dsn#">
<cfset dsn3="#dsn#_1">
<cfdump  var="#attributes#">
<cfdump  var="#getHTTPRequestData()#">
<cfset EKLENECEK=deserializeJSON(attributes.eklenecek)>
<cfdump  var="#EKLENECEK.URUN_ID#">
<cfdump  var="#EKLENECEK#">
<cfset ppd="">

<cfquery name="getCatList" datasource="#dsn1#">
   SELECT LIST_ORDER_NO,DETAIL FROM #dsn1#.PRODUCT_CAT WHERE DETAIL='SAXOFOFN'
   <cfloop array="#EKLENECEK.RENKSISTEMI#" item="item"> 
    UNION
   SELECT LIST_ORDER_NO,DETAIL FROM #dsn1#.PRODUCT_CAT WHERE DETAIL='#item#'
   </cfloop>
   ORDER BY LIST_ORDER_NO
</cfquery>
<cfdump  var="#getCatList#">
<cfloop query="getCatList">
<CFSET PPD="#ppd##DETAIL#">
</cfloop>
<cfdump  var="#ppd#">
<cfquery name="getPPdDet" datasource="#dsn1#">
select * from #dsn1#.PRODUCT_PROPERTY_DETAIL WHERE PROPERTY_DETAIL_CODE='#ppd#'
</cfquery>

<cfif findNoCase("form_upd", getHTTPRequestData().headers.referer)>


<cfquery name="depProductTree" datasource="#dsn3#">
    DELETE FROM PRODUCT_TREE WHERE STOCK_ID=#attributes.stock_id#
</cfquery> 
<cfdump  var="#getHTTPRequestData().headers.referer#">

<cfelse>
<cfinclude  template="stokc_import_params.cfm">
<cfinclude  template="add_stock_code.cfm">
<cfset attributes.stock_id = GET_MAX_STOCK.MAX_STOCK>

<cfif isDefined("EKLENECEK.FLATTE")><cfelse>
<cfset EKLENECEK.FLATTE="">
</cfif>

<cfquery name="insertinfoPlus" datasource="#dsn3#">
    INSERT INTO PRTOTM_STOCK_INFO_PLUS (STOCK_ID,PROPERTY1,PROPERTY2,PROPERTY3,PROPERTY4,PROPERTY5,PROPERTY6,PROPERTY7) VALUES (#attributes.stock_id#,'#EKLENECEK.RENK_TONU#','#EKLENECEK.BOYA_DERECESI#'
    ,'#EKLENECEK.FLATTE#','#EKLENECEK.KARTELA#','#EKLENECEK.KARTELA_TARIHI#','#EKLENECEK.HAZIR#','#EKLENECEK.ACIKLAMA#')
</cfquery>
</cfif>








<cfset product_tree_id_list = ''>
<cfset spec_main_id_list =''>
<cfset X_IS_PHANTOM_TREE="0">
<cfset attributes.process_stage=61>
<cfset attributes.old_main_spec_id =0>
<cfset PARENT_SID_LIST ="">
<cfloop array="#EKLENECEK.AGAC#" item="item">
    <cfloop array="#item.Tree#" item="treeitem">
        <cfdump  var="#treeitem#">
        <cfquery name="GET_PID_INFO" datasource="#dsn3#">
            SELECT * FROM STOCKS WHERE STOCK_ID=#treeitem.Sid#
        </cfquery>
        <cfset attributes.PRODUCT_ID=GET_PID_INFO.PRODUCT_ID>
        <cfset attributes.add_stock_id=GET_PID_INFO.STOCK_ID>
        <cfset attributes.AMOUNT=treeitem.Miktar>
        <cfset attributes.UNIT_ID=GET_PID_INFO.PRODUCT_UNIT_ID>
        <cfset attributes.line_number=treeitem.SiraNo>
        <cfset attributes.detail="#treeitem.ParentRow#-#treeitem.PARENT_SID#">
        <cfinclude  template="tree_import.cfm">
        <cfscript>
      PARENT_SID_LIST= listAppend(PARENT_SID_LIST, treeitem.PARENT_SID);
        </cfscript>   
    </cfloop>
</cfloop>
<cfquery name="getOPt" datasource="#dsn3#">
    SELECT * FROM #dsn3#.PRODUCT_TREE WHERE STOCK_ID IN(#PARENT_SID_LIST#) AND OPERATION_TYPE_ID IS NOT NULL
</cfquery>
<cfloop query="getOPt">
    <cfquery name="ins_tree" datasource="#dsn3#">
        INSERT INTO #dsn3#.PRODUCT_TREE  (IS_TREE,AMOUNT,IS_CONFIGURE,IS_SEVK,OPERATION_TYPE_ID,IS_PHANTOM,PROCESS_STAGE,RECORD_EMP,IS_FREE_AMOUNT,STOCK_ID)VALUES(
            #IS_TREE#,
            #AMOUNT#,
            #IS_CONFIGURE#,
            #IS_SEVK#,
            #OPERATION_TYPE_ID#,
            #IS_PHANTOM#,
            #PROCESS_STAGE#,
            #RECORD_EMP#,
            #IS_FREE_AMOUNT#,
            #attributes.stock_id#
            ) 
    </cfquery>
</cfloop>
<cfquery name="getStations" datasource="#dsn3#">
    SELECT STATION_ID FROM #dsn3#.WORKSTATIONS WHERE UP_STATION=1
</cfquery>
<cfloop query="getStations">
    <cfquery name="setStations" datasource="#dsn3#">
        INSERT INTO #dsn3#.WORKSTATIONS_PRODUCTS (
WS_ID,
STOCK_ID,
CAPACITY,
PRODUCTION_TIME,
PRODUCTION_TIME_TYPE,
SETUP_TIME,
MIN_PRODUCT_AMOUNT,
PRODUCTION_TYPE
,MAIN_STOCK_ID
) 
VALUES(
#STATION_ID#,
#attributes.stock_id#,
60,
1,
1,
0,
1,
0,
#attributes.stock_id#
)
</cfquery>
</cfloop>
<cfif len(getPPdDet.PRPT_ID)><cfset PRPT_ID=getPPdDet.PRPT_ID><cfelse><cfset PRPT_ID="NULL"></cfif>
<cfif len(getPPdDet.PROPERTY_DETAIL_ID)><cfset PROPERTY_DETAIL_ID=getPPdDet.PROPERTY_DETAIL_ID><cfelse><cfset PROPERTY_DETAIL_ID="NULL"></cfif>
<cfquery name="insertStokProperty" datasource="#dsn1#">
INSERT INTO #dsn1#.STOCKS_PROPERTY (STOCK_ID,PROPERTY_ID,PROPERTY_DETAIL_ID) VALUES(#attributes.stock_id#,#PRPT_ID#,#PROPERTY_DETAIL_ID#)
</cfquery>

<cfset treeefunk = createObject("component", "cfc.mmfunctions")>
<cfinclude  template="add_spect_main_ver.cfm">
