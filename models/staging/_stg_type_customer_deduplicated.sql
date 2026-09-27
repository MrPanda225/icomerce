WITH cleaned_type_customer AS 
(
    SELECT 
        NULLIF(TRIM(cd_type_customer), '') as cd_type_customer,
        NULLIF(TRIM(REGEXP_REPLACE(INITCAP(lib_type_customer), '\\s+',' ')),'') as lib_type_customer
    FROM {{source('bronze', 'type_customer')}}
)

SELECT *, 
    ROW_NUMBER() OVER(
        PARTITION BY cd_type_customer 
        ORDER BY lib_type_customer
    ) AS rn
FROM cleaned_type_customer