{{ 
    config(
        materialized='incremental',
        unique_key='rejected_id'
    ) 
}}

SELECT
    {{ dbt_utils.generate_surrogate_key(['cd_type_customer', 'lib_type_customer', 'rn']) }} AS rejected_id,
    cd_type_customer, 
    lib_type_customer, 
    convert_timezone('Europe/Paris', current_timestamp()) as rejected_at,
    CASE
        WHEN cd_type_customer IS NULL THEN 'missing type customer code'
        WHEN lib_type_customer IS NULL THEN 'missing type customer description'
        WHEN rn > 1 THEN 'duplicate key'
    END AS  rejected_reason
FROM {{ref('_stg_type_customer_deduplicated')}}
WHERE rn > 1
    OR cd_type_customer IS NULL
    OR lib_type_customer IS NULL