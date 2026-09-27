WITH cleaned_detail_sale AS 
(
    SELECT 
        NULLIF(TRIM(sale_id), '') as sale_id,
        NULLIF(TRIM(cd_product), '') as cd_product,
        NULLIF(REPLACE(TRIM(REGEXP_REPLACE(INITCAP(quantity_sold), '\\s+',' ')),',','.'),'')::numeric(16,0) as quantity_sold,
        NULLIF(REPLACE(TRIM(REGEXP_REPLACE(INITCAP(sale_price), '\\s+',' ')),',','.'),'')::numeric(16, 4) as sale_price
    FROM {{source('bronze', 'detail_sale')}}
)


SELECT *, 
    ROW_NUMBER() OVER (
        PARTITION BY sale_id, cd_product
        ORDER BY quantity_sold
    ) AS rn
FROM cleaned_detail_sale