


  
	 <cffunction name="writeTree_order" returntype="void">
            <cfargument name="spect_main_id">
            <cfargument name="old_amount">
            <cfscript>
                var i = 1;
				var sub_products = get_subs_order(spect_main_id);
				for (i=1; i lte listlen(sub_products,'█'); i = i+1)
				{
					_next_amount_ = ListGetAt(ListGetAt(sub_products,i,'█'),1,'§');//alt+987 = █ --//alt+789 = §
					_next_spect_id_ = ListGetAt(ListGetAt(sub_products,i,'█'),2,'§');
					_next_stock_id_ = ListGetAt(ListGetAt(sub_products,i,'█'),3,'§');
					_next_line_number_ = ListGetAt(ListGetAt(sub_products,i,'█'),4,'§');
					phantom_spec_main_id_list = listappend(phantom_spec_main_id_list,_next_spect_id_,',');
					phantom_stock_id_list = listappend(phantom_stock_id_list,_next_stock_id_,',');
					phantom_line_number_list = listappend(phantom_line_number_list,_next_line_number_,',');
					if(_next_spect_id_ gt 0)
					{
						'multipler_#_next_spect_id_#' = _next_amount_*old_amount;
						writeTree_order(_next_spect_id_,_next_amount_*old_amount);
					}
				 }
            </cfscript>
        </cffunction>

	      <cffunction name="get_subs_operation" returntype="any">
            <cfargument name="next_stock_id">
            <cfargument name="next_spec_id">
            <cfargument name="next_product_tree_id">
            <cfargument name="type">
     		<cfscript>
				if(type eq 0) where_parameter = 'PT.STOCK_ID = #next_stock_id#'; else where_parameter = 'RELATED_PRODUCT_TREE_ID = #next_product_tree_id#';							
				SQLStr = "
						SELECT
							PRODUCT_TREE_ID,
							AMOUNT,
							ISNULL(SPECT_MAIN_ID,0) SPECT_MAIN_ID,
							ISNULL(RELATED_ID,0) STOCK_ID,
							ISNULL(PT.OPERATION_TYPE_ID,0) OPERATION_TYPE_ID
						FROM
							PRODUCT_TREE PT
						WHERE
							#where_parameter#
						ORDER BY LINE_NUMBER ASC
					";
				query1 = cfquery(SQLString : SQLStr, Datasource : dsn3);
				stock_id_ary='';
				'type_#attributes.deep_level_op#' = type;
				for (str_i=1; str_i lte query1.recordcount; str_i = str_i+1)
				{
					stock_id_ary=listappend(stock_id_ary,query1.PRODUCT_TREE_ID[str_i],'█');
					stock_id_ary=listappend(stock_id_ary,query1.SPECT_MAIN_ID[str_i],'§');
					stock_id_ary=listappend(stock_id_ary,query1.STOCK_ID[str_i],'§');
					stock_id_ary=listappend(stock_id_ary,query1.AMOUNT[str_i],'§');
					stock_id_ary=listappend(stock_id_ary,query1.OPERATION_TYPE_ID[str_i],'§');
					stock_id_ary=listappend(stock_id_ary,attributes.deep_level_op,'§');
				}
			 </cfscript>
             <cfreturn stock_id_ary>
        </cffunction>	
		 	<cffunction name="get_subs_order" returntype="any" >
            <cfargument name="spect_id">
            <cfscript>
                SQLStr = "
                        SELECT
                            AMOUNT,
                            ISNULL(RELATED_MAIN_SPECT_ID,0) RELATED_MAIN_SPECT_ID,
                            ISNULL(STOCK_ID,0) STOCK_ID,
                            ISNULL(LINE_NUMBER, 0) LINE_NUMBER
                        FROM 
                            SPECT_MAIN_ROW SM
                        WHERE
                            SPECT_MAIN_ID = #arguments.spect_id#
                            AND IS_PHANTOM = 1
                    ";
                query1 = cfquery(SQLString : SQLStr, Datasource : dsn3);
                stock_id_ary='';
                for (str_i=1; str_i lte query1.recordcount; str_i = str_i+1)
                {
                    stock_id_ary=listappend(stock_id_ary,query1.AMOUNT[str_i],'█');
                    stock_id_ary=listappend(stock_id_ary,query1.RELATED_MAIN_SPECT_ID[str_i],'§');
                    stock_id_ary=listappend(stock_id_ary,query1.STOCK_ID[str_i],'§');
                    stock_id_ary=listappend(stock_id_ary,query1.LINE_NUMBER[str_i],'§');
                }
            </cfscript>
            <cfreturn stock_id_ary>
        </cffunction>
	   <cffunction name="writeTree_operation" returntype="void">
            <cfargument name="next_stock_id">
            <cfargument name="next_spec_id">
            <cfargument name="next_product_tree_id">
            <cfargument name="type">
     		<cfscript>
				var i = 1;
				var sub_products = get_subs_operation(next_stock_id,next_spec_id,next_product_tree_id,type);
				attributes.deep_level_op = attributes.deep_level_op + 1;
				for (i=1; i lte listlen(sub_products,'█'); i = i+1)
				{
					_next_product_tree_id_ = ListGetAt(ListGetAt(sub_products,i,'█'),1,'§');//alt+987 = █ --//alt+789 = §
					_next_spect_id_ = ListGetAt(ListGetAt(sub_products,i,'█'),2,'§');
					_next_stock_id_ = ListGetAt(ListGetAt(sub_products,i,'█'),3,'§');
					_next_amount_ = ListGetAt(ListGetAt(sub_products,i,'█'),4,'§');
					_next_operation_id_ = ListGetAt(ListGetAt(sub_products,i,'█'),5,'§');
					_next_deep_level_ = ListGetAt(ListGetAt(sub_products,i,'█'),6,'§');
					product_tree_id_list = listappend(product_tree_id_list,_next_product_tree_id_,',');
					operation_type_id_list = listappend(operation_type_id_list,_next_operation_id_,',');
					amount_list = listappend(amount_list,_next_amount_,',');
					"deep_level_#_next_operation_id_#" = _next_deep_level_;
					deep_level_list = listappend(deep_level_list,_next_deep_level_,',');
					if(_next_operation_id_ gt 0) type_=3;else type_=0;
		
					if(attributes.deep_level_op lt 40)
					{
						writeTree_operation(_next_stock_id_,_next_spect_id_,_next_product_tree_id_,type_);
					}
				 }
			 </cfscript>
        </cffunction>

        <cfscript>
	deep_level = 0;
	deep_level_p = 0;
	function get_subs(spect_main_id,production_tree_id,type)
	{
		SQLStr = "
		SELECT * FROM
		(
			SELECT
					S.STOCK_CODE,
					ISNULL(S.IS_PURCHASE,0) IS_PURCHASE,
					ISNULL(S.IS_PRODUCTION,0)IS_PRODUCTION,
					ISNULL(SMR.RELATED_MAIN_SPECT_ID,0)AS RELATED_ID,
					SMR.STOCK_ID,
					SMR.AMOUNT,
					S.PRODUCT_NAME,
					ISNULL(SMR.IS_PHANTOM,0) AS IS_PHANTOM,
					ISNULL(SMR.LINE_NUMBER,0) AS LINE_NUMBER,
					0 AS OPERATION_TYPE_ID,
					ISNULL(RELATED_TREE_ID,0) AS RELATED_TREE_ID
				FROM 
					SPECT_MAIN_ROW SMR,
					STOCKS S
				WHERE 
					S.STOCK_ID = SMR.STOCK_ID AND
					SPECT_MAIN_ID = #spect_main_id# AND 
					SMR.STOCK_ID IS NOT NULL AND
					IS_PROPERTY IN (0,4) --SADECE SARFLAR GELSİN
			UNION ALL
				SELECT 
					'&nbsp;' AS STOCK_CODE,
					0 AS IS_PURCHASE,
					0 AS IS_PRODUCTION,
					0 AS RELATED_ID,
					0 AS STOCK_ID,
					1 AS AMOUNT,
					'<font color=purple>'+OP.OPERATION_TYPE+'</font>' AS PRODUCT_NAME,
					ISNULL(SMR.IS_PHANTOM,0) AS IS_PHANTOM,
					ISNULL(SMR.LINE_NUMBER,0) AS LINE_NUMBER,
					ISNULL(OP.OPERATION_TYPE_ID,0) AS OPERATION_TYPE_ID,
					ISNULL(SMR.RELATED_TREE_ID,0) AS RELATED_TREE_ID
				FROM 
					OPERATION_TYPES OP,
					SPECT_MAIN_ROW SMR
				WHERE
					OP.OPERATION_TYPE_ID = SMR.OPERATION_TYPE_ID AND 
					SPECT_MAIN_ID = #spect_main_id# AND 
					OP.OPERATION_TYPE_ID IS NOT NULL AND
					IS_PROPERTY IN(3,4) -- OPERASYONLAR GELSİN
		) TABLE_1
		ORDER BY
			LINE_NUMBER,
			STOCK_ID DESC,
			PRODUCT_NAME
		";
		query1 = cfquery(SQLString : SQLStr, Datasource : dsn3);
		stock_id_ary='';
		for (str_i=1; str_i lte query1.recordcount; str_i = str_i+1)
		{
			stock_id_ary=listappend(stock_id_ary,query1.RELATED_ID[str_i],'█');
			stock_id_ary=listappend(stock_id_ary,query1.STOCK_ID[str_i],'§');
			stock_id_ary=listappend(stock_id_ary,query1.AMOUNT[str_i],'§');
			stock_id_ary=listappend(stock_id_ary,query1.IS_PRODUCTION[str_i],'§');
			stock_id_ary=listappend(stock_id_ary,query1.IS_PHANTOM[str_i],'§');
			stock_id_ary=listappend(stock_id_ary,query1.RELATED_TREE_ID[str_i],'§');
			stock_id_ary=listappend(stock_id_ary,query1.OPERATION_TYPE_ID[str_i],'§');
			stock_id_ary=listappend(stock_id_ary,query1.PRODUCT_NAME[str_i],'§');
		}
		return stock_id_ary;
	}
	function writeTree(next_spect_main_id,production_tree_id,type,is_phantom)
	{
		var i = 1;
		var sub_products = get_subs(next_spect_main_id,production_tree_id,type);
		deep_level = deep_level + 1;
		if(is_phantom neq 1)
			deep_level_p = deep_level_p + 1;
		if(deep_level gt 50) abort('Sipariş : [#_ORDER_NUMBER_#] Spec : [#next_spect_main_id#] 50 Kırılımdan Fazla Bir Ürün Ağacı Varmış Gibi Görünüyor...');
		for (i=1; i lte listlen(sub_products,'█'); i = i+1)
		{
			_next_spect_main_id_ = ListGetAt(ListGetAt(sub_products,i,'█'),1,'§');//alt+987 = █ --//alt+789 = §
			_next_stock_id_ = ListGetAt(ListGetAt(sub_products,i,'█'),2,'§');
			_next_stock_amount_ = ListGetAt(ListGetAt(sub_products,i,'█'),3,'§');
			_next_is_production_ = ListGetAt(ListGetAt(sub_products,i,'█'),4,'§');
			_next_is_phantom_ = ListGetAt(ListGetAt(sub_products,i,'█'),5,'§');
			_next_related_tree_id_ = ListGetAt(ListGetAt(sub_products,i,'█'),6,'§');
			_next_operation_type_id_ = ListGetAt(ListGetAt(sub_products,i,'█'),7,'§');	
			//nnnnn = ListGetAt(ListGetAt(sub_products,i,'█'),8,'§');	
			//writeoutput("#deep_level_p#___#nnnnn#<br>");
			//tanımlamalar
				if(deep_level eq 1)
					'product_amount_#prod_ind#_#deep_level#' = '#attributes.order_amount#*#_next_stock_amount_#';// satır bazında malzeme ihtiyaçları
				else
					'product_amount_#prod_ind#_#deep_level#' = '#Evaluate('product_amount_#prod_ind#_#deep_level-1#')#*#_next_stock_amount_#';
				if(_next_is_production_ eq 1 and _next_is_phantom_ eq 0)//eğer ürünümüz üretilen bir ürün ise bağlı bulunduğu istasyonu bu ürünün ağacından alıyoruz
				{
					production_row_count = production_row_count+1;
					"attributes.product_values_#prod_ind#_#production_row_count#" = "#_next_stock_id_#,#_next_spect_main_id_#,#deep_level#,#production_row_count#";
					"attributes.product_amount_#prod_ind#_#production_row_count#" = Evaluate(Evaluate("product_amount_#prod_ind#_#deep_level#"));
					SQL_PRODUCT_STATION_ID ='SELECT WS_P_ID,STATION_ID,STATION_NAME,PRODUCTION_TYPE,MIN_PRODUCT_AMOUNT,SETUP_TIME,ISNULL(WS.EXIT_DEP_ID,0) AS EXIT_DEP_ID,ISNULL(WS.EXIT_LOC_ID,0) AS EXIT_LOC_ID,ISNULL(WS.PRODUCTION_DEP_ID,0) AS PRODUCTION_DEP_ID,ISNULL(WS.PRODUCTION_LOC_ID,0) AS PRODUCTION_LOC_ID FROM WORKSTATIONS_PRODUCTS WSP,WORKSTATIONS WS WHERE WS.STATION_ID = WSP.WS_ID AND WSP.STOCK_ID = #_next_stock_id_#';
					GET_PRODUCT_STATION_ID = cfquery(SQLString : SQL_PRODUCT_STATION_ID, Datasource : dsn3);
					if(GET_PRODUCT_STATION_ID.recordcount)
						"attributes.station_id_#prod_ind#_#production_row_count#" = "#GET_PRODUCT_STATION_ID.STATION_ID#,0,1,1,0,#GET_PRODUCT_STATION_ID.EXIT_DEP_ID#,#GET_PRODUCT_STATION_ID.EXIT_LOC_ID#,#GET_PRODUCT_STATION_ID.PRODUCTION_DEP_ID#,#GET_PRODUCT_STATION_ID.PRODUCTION_LOC_ID#";//elle verildi düzeltilecek..
					else
						"attributes.station_id_#prod_ind#_#production_row_count#" = "0,0,1,1,0,0,0,0,0";//elle verildi düzeltilecek..
					if(isdefined("attributes.is_select_sub_product") and attributes.is_select_sub_product == 1)
					"attributes.product_is_production_#prod_ind#_#production_row_count#" = 1;
				}
			//tanımlamalar bitti
			if((isdefined("attributes.stage_info") and len(attributes.stage_info) and attributes.stage_info gt 0 and deep_level lt attributes.stage_info) or not (isdefined("attributes.stage_info") and len(attributes.stage_info)))
			{
				if(_next_spect_main_id_ gt 0 and _next_is_production_ eq 1 and _next_stock_id_ gt 0)
				{
					writeTree(_next_spect_main_id_,0,0,_next_is_phantom_);
				}	
				else if	(_next_related_tree_id_ gt 0 and _next_operation_type_id_ gt 0){
					writeTree(_next_spect_main_id_,_next_related_tree_id_,3,_next_is_phantom_);
				}
			}
		 }
		deep_level = deep_level-1;
		deep_level_p = deep_level_p-1;
	}
</cfscript>