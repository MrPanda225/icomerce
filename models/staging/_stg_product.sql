SELECT 
    cd_product, 
    lib_product,
    price_product,
    cd_subcategory
FROM {{ref('_stg_product_deduplicated')}}
WHERE rn = 1
    AND cd_product IS NOT NULL
    AND lib_product IS NOT NULL
    AND price_product IS NOT NULL
    AND cd_subcategory IS NOT NULL