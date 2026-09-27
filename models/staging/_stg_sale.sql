SELECT 
    sale_id, 
    dt_sale, 
    customer_id
FROM {{ref('_stg_sale_deduplicated')}}
WHERE rn = 1
    AND sale_id IS NOT NULL
    AND dt_sale IS NOT NULL
    AND customer_id IS NOT NULL