SELECT 
    ROW_NUMBER() OVER (ORDER BY cd_category) AS id_dim_category,
    cd_category,
    lib_category
FROM {{ref("_stg_category")}}