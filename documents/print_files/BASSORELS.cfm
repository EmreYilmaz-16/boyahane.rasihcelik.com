<cfparam name="attributes.keyword" default="" />
<cfparam name="attributes.Aranacak" default="" />
<cfparam name="attributes.HMYM" default="0" />
<cfparam name="attributes.maxrows" default="10" />
<cfparam name="attributes.page" default="1" />
<cfparam name="attributes.form_submitted" default="0" />
<cfset attributes.startrow = (attributes.page - 1) * attributes.maxrows + 1>

<cfif attributes.form_submitted eq 1>
	<cfif attributes.keyword eq 1>

		<cfquery name="SORGU" datasource="#dsn3#">

    WITH CTE1 AS (      SELECT
        S.STOCK_CODE AS S1,
        S2.STOCK_CODE AS S2,
		S2.RECORD_DATE AS RDATE,
		S2.PRODUCT_ID AS PROID,
        PT.STOCK_ID AS STOKID,
        PT.RECORD_DATE AS KAYITTAR,
		P.PRODUCT_NAME AS PNAME,
		(select MANUFACT_CODE from #dsn1#.PRODUCT where PRODUCT_ID=S2.PRODUCT_ID) AS ManCode,
		(select PRODUCT_NAME from #dsn1#.PRODUCT where PRODUCT_ID=S2.PRODUCT_ID) AS PRNAME,
		(select PRODUCT_CATID from #dsn1#.PRODUCT where PRODUCT_ID=S2.PRODUCT_ID) AS PROCAT,
        ROW_NUMBER() OVER (
    ORDER BY
        S.STOCK_ID) AS ROWNUM
    FROM
        #dsn3#.PRODUCT_TREE AS PT,
        #dsn1#.STOCKS AS S,
        #dsn1#.STOCKS AS S2,
		#dsn1#.PRODUCT AS P
    WHERE
        PT.RELATED_ID = S.STOCK_ID
		AND S2.PRODUCT_ID=P.PRODUCT_ID
		<cfif attributes.HMYM eq 0>
		  AND S.STOCK_CODE LIKE '%01.Y.07%'
		  <cfelse>
		  AND S.STOCK_CODE LIKE '%01.H.10%'
		</cfif>      
        AND S2.STOCK_ID = PT.STOCK_ID
		<cfif attributes.Aranacak neq "">
		AND P.PRODUCT_NAME LIKE '%#attributes.Aranacak#%'
		</cfif>
        AND S2.STOCK_CODE LIKE '%01.M%'
        AND PT.QUESTION_ID IS NULL    )    SELECT
        S1,
        S2,
		PNAME,
		RDATE,
		PROID,
        STOKID,
        KAYITTAR,
		ManCode,
		PRNAME,
		PROCAT,
        ROWNUM,
        (SELECT
            COUNT(*)
        FROM
            CTE1) AS TOTALROWS
    FROM
        CTE1
    WHERE
        ROWNUM BETWEEN #attributes.startrow# AND #attributes.startrow + attributes.maxrows - 1#
		</cfquery>
	<cfelse>

		<cfquery name="SORGU" datasource="#dsn3#">

    WITH CTE1 AS (      SELECT
        S.STOCK_CODE AS S1,
        S2.STOCK_CODE AS S2,
		S2.RECORD_DATE AS RDATE,
		S2.PRODUCT_ID AS PROID,
        PT.STOCK_ID AS STOKID,
		P.PRODUCT_NAME AS PNAME,
        PT.RECORD_DATE AS KAYITTAR,
		(select MANUFACT_CODE from #dsn1#.PRODUCT where PRODUCT_ID=S2.PRODUCT_ID) AS ManCode,
		(select PRODUCT_NAME from #dsn1#.PRODUCT where PRODUCT_ID=S2.PRODUCT_ID) AS PRNAME,
		(select PRODUCT_CATID from #dsn1#.PRODUCT where PRODUCT_ID=S2.PRODUCT_ID) AS PROCAT,

        ROW_NUMBER() OVER (
    ORDER BY
        S.STOCK_ID) AS ROWNUM
    FROM
        #dsn3#.PRODUCT_TREE AS PT,
        #dsn1#.STOCKS AS S,
		#dsn1#.PRODUCT AS P,
        #dsn1#.STOCKS AS S2
    WHERE
        PT.RELATED_ID = S.STOCK_ID
		AND S2.PRODUCT_ID=P.PRODUCT_ID
				<cfif attributes.HMYM eq 0>
		  AND S.STOCK_CODE LIKE '%01.Y.06%'
		  <cfelse>
		  AND S.STOCK_CODE LIKE '%01.H.09%'
		</cfif> 
		<cfif attributes.Aranacak neq "">
		AND P.PRODUCT_NAME LIKE '%#attributes.Aranacak#%'
		</cfif>
        AND S2.STOCK_ID = PT.STOCK_ID
        AND S2.STOCK_CODE LIKE '%01.M%'
        AND PT.QUESTION_ID IS NULL    )    SELECT
        S1,
        S2,
		PNAME,
		RDATE,
		PROID,
        STOKID,
        KAYITTAR,
		ManCode,
		PRNAME,
		PROCAT,
        ROWNUM,
        (SELECT
            COUNT(*)
        FROM
            CTE1) AS TOTALROWS
    FROM
        CTE1
    WHERE
        ROWNUM BETWEEN #attributes.startrow# AND #attributes.startrow + attributes.maxrows - 1#
		</cfquery>
	</cfif>
<cfelse>
	<cfset SORGU.totalrows = 0>
	<cfset SORGU.recordcount = 0>
</cfif>
<cfset attributes.totalrecords = SORGU.totalrows>
<cfoutput>
	<cfform name="orderReport" id="orderReport" method="post" action="#request.self#?fuseaction=#attributes.fuseaction#&amp;report_id=#attributes.report_id#">
		<input type="hidden" id="form_submitted" name="form_submitted" value="1" />
		<cf_report_list_search title="Başlık/Braket Mil Boru Ayrımı Yapılmamış Ürünler">
			<cf_big_list_search_area>
						<table>
							<tr>
								<td>
									<label>
										Başlık/Braket ?
									</label>
								</td>
								<td>
									<select id="keyword" name="keyword" style="width:150px">
								<option
								<cfif attributes.keyword eq 1>
									selected
								</cfif>
								value="1">Başlıklar</option> <option
								<cfif attributes.keyword eq 2>
									selected
								</cfif>
								value="2">Braketler</option>
							</select>
								</td>
								<td>
								<label class="col col-7 font-blue-madison bold"> 
									<input type="radio" name="HMYM" id="HMYM" value="0" <cfif attributes.HMYM eq 0> checked="true" </cfif>> Yarı Mamul 
								</label>
									<label class="col col-7 font-blue-madison bold"> 
									<input type="radio" name="HMYM" id="HMYM" value="1" <cfif attributes.HMYM eq 1> checked="true" </cfif>> Ham Madde 
								</label>		
								</td>								
								<td>
									<input type="text" name="Aranacak" value="#attributes.Aranacak#" placeholder="Müşteri Kodu" style="width:150px" />
								</td>
								<td>
									<input type="text" name="maxrows" value="#attributes.maxrows#" required="yes" onKeyUp="isNumber(this)" maxlength="3" style="width:25px;" />
								</td>
								<td>
									<input class="btn green-haze" type="Submit" Value="Ara" />

								</td>
							</tr>
						</table>
			</cf_big_list_search_area>
		</cf_report_list_search>
	</cfform>
</cfoutput>
<!-----select S.STOCK_CODE,S2.STOCK_CODE AS S2 ,PT.STOCK_ID,* FROM catalystGercek_1.PRODUCT_TREE AS PT,catalystGercek_product.STOCKS AS S,catalystGercek_product.STOCKS AS S2 WHERE PT.RELATED_ID=S.STOCK_ID AND S.STOCK_CODE LIKE '%01.HM.BT%' AND S2.STOCK_ID=PT.STOCK_ID AND S2.STOCK_CODE like '%01.YM.MA%' AND PT.QUESTION_ID IS NOT NULL-------->
<cf_report_list id="Table1">
	<thead>
		<tr>
			<th>
				Sıra No
			</th>
			<th>
				Stok Kodu
			</th>
			<th>
				Üretici Kodu
			</th>
			<th>
				Müşteri Kodu
			</th>
			<th>
			Ürün Adı</th>
			<th>
				Kısa Yollar
			</th>
		</tr>
	</thead>
	<tbody>
		<cfif attributes.form_submitted eq 1>
		<cfset kayitsayisi=SORGU.RecordCount>
		<cfloop from="1" to="#kayitsayisi#" index="i" step="1">
			<cfoutput>
				<tr>
					<td>
						#SORGU.rownum[i]#
					</td>
					<td>
						#SORGU.S2[i]#
					</td>
					<td>
						#SORGU.ManCode[i]#
					</td>
					<td>
					<cfquery name="GetSupplier" datasource="#dsn1#">
					SELECT Top(1) C.FULLNAME
						,P.PRODUCT_NAME
						,P.PRODUCT_ID
						,C.MEMBER_CODE
					FROM #dsn#.COMPANY AS C
						,#dsn1#.PRODUCT AS P
					WHERE C.COMPANY_ID = P.COMPANY_ID
						AND P.PRODUCT_ID=#SORGU.PROID[i]#
					</cfquery>
					#GetSupplier.MEMBER_CODE#
					</td>
					<td>
					#SORGU.PRNAME[i]#
					</td>
					<td>
						<a  class="link-text" href="#request.self#?fuseaction=prod.list_product_tree&event=upd&stock_id=#SORGU.STOKID[i]#" target="_blank"><img src="/images/shema_list.gif"border="0">Ürün Ağacı</a> &nbsp;&nbsp;&nbsp;&nbsp;
						<a onclick="windowopen('#request.self#?fuseaction=objects.popup_list_comp_add_info&product_catid=55&info_id=#SORGU.PROID[i]#&type_id=-5','page')" href="javascript:;"><img src="/images/info_plus.gif" border="0">Ürün Ek Bilgileri</a>&nbsp;&nbsp;&nbsp;&nbsp;
					<a  href="#request.self#?fuseaction=product.list_product&event=det&pid=#SORGU.PROID[i]#" title="Ürün Kartına Git" target="_blank" ><img src="/images/edit.gif" border="0">Ürün Kartı</a>
					</td>
				</tr>
			</cfoutput>
		</cfloop>	
		<cfelse>
			<tr>
				<th colspan="5">
					<h3>Sorgulama yapınız</h3>
				</th>
			</tr>
		</cfif>
	</tbody>
</cf_report_list>
<cfset url_str = "">
<cfif attributes.form_submitted eq 1>

	<cfset url_str = "#url_str#&form_submitted=#attributes.form_submitted#">
</cfif>
<cfif len(attributes.keyword)>
	<cfset url_str = "#url_str#&keyword=#attributes.keyword#">
</cfif>
<cfif len(attributes.Aranacak)>
	<cfset url_str = "#url_str#&Aranacak=#attributes.Aranacak#">
</cfif>
<cfif len(attributes.HMYM)>
	<cfset url_str = "#url_str#&HMYM=#attributes.HMYM#">
</cfif>
<cf_paging page="#attributes.page#" maxrows="#attributes.maxrows#" totalrecords="#attributes.totalrecords#" startrow="#attributes.startrow#" adres="report.detail_report&report_id=#attributes.report_id##url_str#">
<script type="text/javascript">
	$( document ).ready(function() {
		$("#keyword").focus();
	});
</script>
