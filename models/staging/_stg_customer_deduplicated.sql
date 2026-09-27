WITH cleaned_customer AS 
(
    SELECT 
        NULLIF(TRIM(customer_id), '') as customer_id,
        NULLIF(TRIM(REGEXP_REPLACE(INITCAP(last_name), '\\s+',' ')),'') as last_name,
        NULLIF(TRIM(REGEXP_REPLACE(INITCAP(first_name), '\\s+',' ')),'') as first_name,
        NULLIF(TRIM(REGEXP_REPLACE(INITCAP(address), '\\s+',' ')),'') as address,
        NULLIF(TRIM(REGEXP_REPLACE(postal_code, '\\s+',' ')),'') as postal_code,
        NULLIF(TRIM(REGEXP_REPLACE(city, '\\s+',' ')),'') as city,
        NULLIF(TRIM(REGEXP_REPLACE(country, '\\s+',' ')),'') as country,
        NULLIF(TRIM(cd_type_customer), '') as cd_type_customer
    FROM {{source('bronze', 'customer')}}
)

SELECT *, 
    ROW_NUMBER() OVER(
        PARTITION BY customer_id 
        ORDER BY last_name, first_name
    ) AS rn
FROM cleaned_customer