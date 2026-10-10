SELECT 
    ROW_NUMBER() OVER (ORDER BY sc.dbt_scd_id) AS id_dim_customer,
    sc.dbt_valid_from AS valid_from,
    sc.dbt_valid_to AS valid_to,
    CASE WHEN sc.dbt_valid_to IS NULL THEN 1 ELSE 0 END AS is_current_version,
    sc.customer_id,
    sc.last_name,
    sc.first_name,
    sc.address,
    pc.id_dim_postal_code,
    tc.id_dim_type_customer
FROM {{ref("snap_customer")}} sc
    left outer join {{ref("dim_postal_code")}} pc on sc.postal_code = pc.code_commune_postal
    left outer join {{ref("dim_type_customer")}} tc on sc.cd_type_customer = tc.cd_type_customer
WHERE tc.id_dim_type_customer IS NOT null AND pc.id_dim_postal_code IS NOT null