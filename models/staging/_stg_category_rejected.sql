{{ 
    config(
        materialized='incremental',
        unique_key='rejected_id'
    ) 
}}

SELECT 
    {{ dbt_utils.generate_surrogate_key(['cd_category', 'lib_category', 'rn']) }} AS rejected_id,
    cd_category, lib_category,
    convert_timezone('Europe/Paris', current_timestamp()) AS rejected_at,
    CASE
        WHEN cd_category IS NULL THEN 'missing category code'
        WHEN lib_category IS NULL THEN 'missing category description'
        WHEN rn > 1 THEN 'duplicate key'
    END AS rejected_reason
FROM {{ ref('_stg_category_deduplicated') }}
WHERE rn > 1
   OR cd_category IS NULL
   OR lib_category IS NULL