SELECT cd_subcategory, lib_subcategory, cd_category
FROM {{ref('_stg_subcategory_deduplicated')}}
WHERE rn = 1
    AND cd_subcategory IS NOT NULL
    AND lib_subcategory IS NOT NULL
    AND cd_category IS NOT NULL