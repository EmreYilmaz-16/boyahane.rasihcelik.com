<cfquery name="setinf" datasource="catalyst_prod_1">
    
INSERT INTO catalyst_prod_1.ORDER_INFO_PLUS (
PROPERTY1,--KARTELA TARİHİ
PROPERTY2,--KARTELA
PROPERTY3,--TOP
PROPERTY4,---EN
PROPERTY5,--TUŞE
PROPERTY6,--ÇEKME
PROPERTY7,--İSTENEN
PROPERTY8,--SARIM
PROPERTY9,--AMBALAJ
PROPERTY10,--ISI
PROPERTY11,--HIZ,
PROPERTY12,-- BESLEME AYARI
PROPERTY13,--KULLANILAN KİMYASAL
PROPERTY14,--BATCH NO
PROPERTY15,--RENK CEMIK
PROPERTY16,--RENK CEMIK
ORDER_ID)
VALUES(
    '#attributes.CART_D#',
    '#attributes.CART#',
    '#attributes.TOP#',
    '#attributes.EN#',
    '#attributes.TUSE#',
    '#attributes.CEKME#',
    '#attributes.ISTENEN_GR#',
    '#attributes.SARIM#',
    '#attributes.AMBALAJ#',
    '#attributes.HEAT#',
    '#attributes.SPEED#',
    '#attributes.BACKFEED#',
    '#attributes.CHEMICAL#',
    '#attributes.BATCH#',
    '#attributes.PRODUCT_NAME2#',
    '#attributes.KK_ACIKLAMA#',
    #GET_MAX_ORDER.MAX_ID#
)

</cfquery>