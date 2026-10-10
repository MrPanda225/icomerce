SELECT 
    ROW_NUMBER() OVER (ORDER BY sp.dbt_scd_id) AS id_dim_product,
    sp.dbt_valid_from AS valid_from,
    sp.dbt_valid_to AS valid_to,
    CASE WHEN sp.dbt_valid_to IS NULL THEN 1 ELSE 0 END AS is_current_version,
    sp.cd_product,
    sp.lib_product,
    sp.price_product,
    sc.id_dim_subcategory
FROM {{ref("snap_product")}} sp
    LEFT OUTER JOIN {{ref("dim_subcategory")}} sc ON sp.cd_subcategory = sc.cd_subcategory
WHERE sc.id_dim_subcategory IS NOT null