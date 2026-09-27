SELECT 
    sale_id, 
    cd_product,
    quantity_sold,
    sale_price
FROM {{ref('_stg_detail_sale_deduplicated')}}
WHERE rn = 1
    AND sale_id IS NOT NULL
    AND cd_product IS NOT NULL
    AND quantity_sold IS NOT NULL
    AND sale_price IS NOT NULL