{{
    config(
        materialized='incremental',
        unique_key='rejected_id'
    )
}}

SELECT
    {{ dbt_utils.generate_surrogate_key(['customer_id', 'last_name', 'first_name', 'address', 'postal_code', 'city', 'country', 'cd_type_customer', 'rn']) }} AS rejected_id,
    customer_id, 
    last_name, 
    first_name, 
    address, 
    postal_code, 
    city, 
    country, 
    cd_type_customer,
    convert_timezone('Europe/Paris', current_timestamp()) as rejected_at,
    CASE
        WHEN customer_id IS NULL THEN 'missing customer code'
        WHEN last_name IS NULL THEN 'missing customer last name'
        WHEN postal_code IS NULL THEN 'missing customer postal code'
        WHEN cd_type_customer IS NULL THEN 'missing type customer'
        WHEN rn > 1 THEN 'duplicate key'
    END AS  rejected_reason
FROM {{ref('_stg_customer_deduplicated')}}
WHERE rn > 1
    OR customer_id IS NULL
    OR last_name IS NULL
    OR postal_code IS NULL
    OR cd_type_customer IS NULL