{{
    config(
        materialized='incremental',
        unique_key='rejected_id'
    )
}}

SELECT
    {{ dbt_utils.generate_surrogate_key(['sale_id', 'cd_product', 'rn']) }} AS rejected_id,
    sale_id, 
    cd_product,
    quantity_sold,
    sale_price,
    convert_timezone('Europe/Paris', current_timestamp()) as rejected_at,
    CASE
        WHEN sale_id IS NULL THEN 'missing sale id'
        WHEN cd_product IS NULL THEN 'missing product code'
        WHEN quantity_sold IS NULL THEN 'missing quatity product'
        WHEN sale_price IS NULL THEN 'missing product price'
        WHEN rn > 1 THEN 'duplicate key'
    END AS  rejected_reason
FROM {{ref('_stg_detail_sale_deduplicated')}}
WHERE rn > 1
    OR sale_id IS NULL
    OR cd_product IS NULL
    OR quantity_sold IS NULL
    OR sale_price IS NULL