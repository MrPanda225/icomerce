{{ 
    config(
        materialized='incremental',
        unique_key='rejected_id'
    ) 
}}

SELECT
    {{ dbt_utils.generate_surrogate_key(['cd_subcategory', 'lib_subcategory', 'cd_category', 'rn']) }} AS rejected_id,
    cd_subcategory, 
    lib_subcategory, 
    cd_category,
    convert_timezone('Europe/Paris', current_timestamp()) as rejected_at,
    CASE
        WHEN cd_subcategory IS NULL THEN 'missing subcategory code'
        WHEN lib_subcategory IS NULL THEN 'missing subcategory description'
        WHEN cd_category IS NULL THEN 'missing category description'
        WHEN rn > 1 THEN 'duplicate key'
    END AS  rejected_reason
FROM {{ref('_stg_subcategory_deduplicated')}}
WHERE rn > 1
    OR cd_subcategory IS NULL
    OR lib_subcategory IS NULL
    OR cd_category IS NULL