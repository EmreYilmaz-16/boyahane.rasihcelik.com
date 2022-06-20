#EMRE_URUN_AYDI# -- ürün id
<cfquery name="InsProd" datasouRce="#dsn#">
    INSERT INTO catalyst_prod_1.PRODUCT_INFO_PLUS 
    (
        PROPERTY1,
        PROPERTY2,
        PROPERTY3,
        PROPERTY4,
        PROPERTY5,
        PROPERTY6,
        PROPERTY7,
        PROPERTY8,
        PROPERTY9,
        PROPERTY10,
        PRODUCT_ID,
        PRO_INFO_ID
    )
    VALUES (
        '#En#',
        '#Tuse#',
        '#Cekme#',
        '#Gramaj#',
        '#Isi#',
        '#Hiz#',
        '#Besleme#',
        '#Kimyasal#',
        '#BirimCarpan#',
        '#MuhStockCode#',
         #EMRE_URUN_AYDI#,
         3
        
    )
</cfquery>