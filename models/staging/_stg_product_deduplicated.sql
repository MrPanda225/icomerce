WITH cleaned_product AS 
(
    SELECT 
        NULLIF(TRIM(cd_product), '') AS cd_product,
        NULLIF(TRIM(REGEXP_REPLACE(INITCAP(lib_product), '\\s+',' ')),'') AS lib_product,
        NULLIF(REPLACE(TRIM(REGEXP_REPLACE(INITCAP(price_product), '\\s+',' ')),',','.'),'')::numeric(16, 4) AS price_product,
        NULLIF(TRIM(cd_subcategory),'') as cd_subcategory
    FROM {{source('bronze', 'product')}}
)


SELECT *, 
    ROW_NUMBER() OVER(
        PARTITION BY cd_product 
        ORDER BY lib_product
    ) AS rn
FROM cleaned_product