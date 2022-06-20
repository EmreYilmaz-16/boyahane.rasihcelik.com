<cfset FORM.BARCOD = trim(FORM.BARCOD)>
<cfquery name="CHECK_CODE" datasource="#DSN1#">
	SELECT 
		STOCK_ID
	FROM 
		STOCKS 
	WHERE 
		STOCK_CODE='#trim(FORM.NEW_STOCK_CODE)#'
</cfquery>
<cfif check_code.recordcount>
	<script type="text/javascript">
		alert("<Girdiğiniz Stok Kodu Başka Bir Stok Tarafından Kullanılmakta Lütfen Başka Bir Stok Kodu Giriniz'> !");
		history.back();
	</script>
	<cfabort>
</cfif>
<cfif len(FORM.BARCOD)>
	<cfquery name="CHECK_BARCODE" datasource="#DSN1#">
		SELECT
			STOCK_ID
		FROM
			GET_STOCK_BARCODES_ALL
		WHERE
			BARCODE = '#FORM.BARCOD#'
	</cfquery>
	<cfif check_barcode.recordcount>
		<script type="text/javascript">
			alert("Girdiğiniz Barkod Başka Bir Stok Tarafından Kullanılmakta Lütfen Başka Bir Barkod Giriniz'> !");
			history.back();
		</script>
		<cfabort>
	</cfif>
</cfif>
<cflock name="#CREATEUUID()#" timeout="60">
	<cftransaction>
		<cfquery name="ADD_STOCK_CODE" datasource="#DSN1#">
			INSERT INTO 
				STOCKS 
			(
				STOCK_CODE,
				STOCK_CODE_2,
				PRODUCT_ID,
				PROPERTY,
				BARCOD,
				PRODUCT_UNIT_ID,
				MANUFACT_CODE,
				STOCK_STATUS,
				RECORD_EMP, RECORD_IP, RECORD_DATE
			)
			VALUES 
			(
				'#trim(NEW_STOCK_CODE)#',
				'#trim(STOCK_CODE_2)#',
				#FORM.PRODUCT_ID#,
				'#FORM.PROPERTY_DETAIL#',
				'#FORM.BARCOD#',
				#FORM.UNIT#,
				'#form.MANUFACT_CODE#',
				1,
				#session.ep.userid#, '#REMOTE_ADDR#', #now()#
			)
		</cfquery>
		<cfquery name="GET_MAX_STOCK" datasource="#DSN1#">
			SELECT MAX(STOCK_ID) AS MAX_STOCK FROM STOCKS
		</cfquery>
		<cfquery name="ADD_STOCK_BARCODE" datasource="#DSN1#">
			INSERT INTO
				STOCKS_BARCODES
			(
				STOCK_ID,
				BARCODE,
				UNIT_ID
			)
			VALUES 
			(
				#GET_MAX_STOCK.MAX_STOCK#,
				'#FORM.BARCOD#',
				#FORM.UNIT#
			)
		</cfquery>
		<cfif attributes.property_count gt 0>
			<cfloop from="1" to="#attributes.property_count#" index="i">
				<cfif isdefined('attributes.property_id_#i#')>
					<cfquery name="ADD_STOCK_PROPERTY" datasource="#DSN1#">
						INSERT INTO
							STOCKS_PROPERTY
						(
							STOCK_ID,
							PROPERTY_ID,
							PROPERTY_DETAIL_ID,
							PROPERTY_DETAIL,
							TOTAL_MIN,
							TOTAL_MAX			
						)
						VALUES
						(
							#get_max_stock.max_stock#,
							#evaluate('attributes.property_id_#i#')#,
							<cfif len(evaluate('attributes.sub_property_list_#i#'))>#evaluate('attributes.sub_property_list_#i#')#<cfelse>NULL</cfif>,
							'#wrk_eval('attributes.property_detail2_#i#')#',
							'#wrk_eval('attributes.total_min_#i#')#',
							'#wrk_eval('attributes.total_max_#i#')#'
							
						)
					</cfquery>
				</cfif>
			</cfloop>
		</cfif>
	</cftransaction>
</cflock>
<cfquery name="get_my_periods" datasource="#DSN#">
	SELECT * FROM SETUP_PERIOD WHERE OUR_COMPANY_ID IN (SELECT OUR_COMPANY_ID FROM #dsn1_alias#.PRODUCT_OUR_COMPANY WHERE PRODUCT_ID = #FORM.PRODUCT_ID#)
</cfquery>
<cfloop query="get_my_periods">
	<cfif 1 eq 1>
		<cfset temp_dsn = "#DSN#_#PERIOD_YEAR#_#OUR_COMPANY_ID#">
	<cfelseif 1 eq 0>
		<cfset temp_dsn = "#dsn#_#OUR_COMPANY_ID#_#right(period_year,2)#">
	</cfif>
	<cfquery name="INSRT_STK_ROW" datasource="#temp_dsn#">
		INSERT INTO 
			STOCKS_ROW 
		(
			STOCK_ID, 
			PRODUCT_ID
		)
		VALUES 
		(
			#GET_MAX_STOCK.MAX_STOCK#, 
			#FORM.PRODUCT_ID#
		)
	</cfquery>
</cfloop>

