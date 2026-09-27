{{
    config(
        materialized='incremental',
        unique_key='rejected_id'
    )   
}}

SELECT
    {{ dbt_utils.generate_surrogate_key(['sale_id', 'dt_sale', 'customer_id', 'rn']) }} AS rejected_id,
    sale_id, 
    dt_sale, 
    customer_id,
    convert_timezone('Europe/Paris', current_timestamp()) as rejected_at,
    CASE
        WHEN sale_id IS NULL THEN 'missing sale code'
        WHEN dt_sale IS NULL THEN 'missing date sale'
        WHEN customer_id IS NULL THEN 'missing customer id'
        WHEN rn > 1 THEN 'duplicate key'
    END AS  rejected_reason
FROM {{ref('_stg_sale_deduplicated')}}
WHERE rn > 1
    OR sale_id IS NULL
    OR dt_sale IS NULL
    OR customer_id IS NULL