SELECT 
    customer_id, 
    last_name, 
    first_name, 
    address, 
    postal_code, 
    city, 
    country, 
    cd_type_customer
FROM {{ref('_stg_customer_deduplicated')}}
WHERE rn = 1
    AND customer_id IS NOT NULL
    AND last_name IS NOT NULL
    AND postal_code IS NOT NULL
    AND cd_type_customer IS NOT NULL