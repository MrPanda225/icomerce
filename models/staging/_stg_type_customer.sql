SELECT 
    cd_type_customer, 
    lib_type_customer
FROM {{ref('_stg_type_customer_deduplicated')}}
WHERE rn = 1
    AND cd_type_customer IS NOT NULL
    AND lib_type_customer IS NOT NULL