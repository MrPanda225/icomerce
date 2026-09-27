--- List category
SELECT cd_category, lib_category
FROM {{ref('_stg_category_deduplicated')}}
WHERE rn=1
    AND cd_category is not null
    AND lib_category is not null