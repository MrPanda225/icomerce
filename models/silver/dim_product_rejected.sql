SELECT 
    sp.cd_product,
    sp.lib_product,
    sp.price_product,
    sc.cd_subcategory,
    convert_timezone('Europe/Paris', current_timestamp()) AS rejected_at,
    CASE
        WHEN sc.cd_subcategory IS NULL THEN 'missing subcategory'
    END AS rejected_reason
FROM {{ref("snap_product")}} sp
    LEFT OUTER JOIN {{ref("dim_subcategory")}} sc ON sp.cd_subcategory = sc.cd_subcategory
WHERE sc.cd_subcategory IS null