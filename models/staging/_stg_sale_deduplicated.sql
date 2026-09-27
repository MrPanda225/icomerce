WITH cleaned_sale AS 
(
    SELECT 
        NULLIF(TRIM(sale_id), '') as sale_id,
        COALESCE(
            TRY_TO_DATE(REPLACE(TRIM(dt_sale),'/','-'), 'YYYY-MM-DD'),
            TRY_TO_DATE(REPLACE(TRIM(dt_sale),'/','-'), 'DD-MM-YYYY'),
            TRY_TO_DATE(REPLACE(TRIM(dt_sale),'/','-'), 'MM-DD-YYYY')
        ) AS dt_sale,
        NULLIF(TRIM(customer_id),'') AS customer_id
    FROM {{source('bronze', 'sale')}}
)

SELECT *, 
    row_number() over(
        partition by sale_id 
        order by dt_sale
    ) as rn
FROM cleaned_sale