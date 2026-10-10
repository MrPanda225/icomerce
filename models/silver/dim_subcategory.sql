SELECT 
    ROW_NUMBER() OVER (ORDER BY cd_subcategory) AS id_dim_subcategory,
    cd_subcategory,
    lib_subcategory,
    id_dim_category
FROM {{ref("_stg_subcategory")}} SC
    LEFT OUTER JOIN {{ref("dim_category")}} c ON sc.cd_category = c.cd_category
WHERE c.cd_category IS NOT null