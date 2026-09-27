{{config(
    materialized='incremental',
    unique_key='rejected_id'
)}}

SELECT
    {{ dbt_utils.generate_surrogate_key(['cd_product', 'lib_product', 'price_product', 'cd_subcategory', 'rn']) }} AS rejected_id,
    cd_product, 
    lib_product,
    price_product,
    cd_subcategory,
    convert_timezone('Europe/Paris', current_timestamp()) as rejected_at,
    CASE
        WHEN cd_product IS NULL THEN 'missing product code'
        WHEN lib_product IS NULL THEN 'missing product description'
        WHEN price_product IS NULL THEN 'missing product price'
        WHEN cd_subcategory IS NULL THEN 'missing product subcategory'
        WHEN rn > 1 THEN 'duplicate key'
    END AS  rejected_reason
FROM {{ref('_stg_product_deduplicated')}}
WHERE rn > 1
    OR cd_product IS NULL
    OR lib_product IS NULL
    OR price_product IS NULL
    OR cd_subcategory IS NULL
