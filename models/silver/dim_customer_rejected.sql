SELECT
    sc.customer_id,
    sc.last_name,
    sc.first_name,
    sc.address,
    sc.postal_code,
    sc.cd_type_customer,
    convert_timezone('Europe/Paris', current_timestamp()) AS rejected_at,
    CASE
        WHEN pc.code_commune_postal IS NULL THEN 'missing postal code'
        WHEN tc.cd_type_customer IS NULL THEN 'missing customer type'
    END AS rejected_reason
FROM {{ref("snap_customer")}} sc
    left outer join {{ref("dim_postal_code")}} pc on sc.postal_code = pc.code_commune_postal
    left outer join {{ref("dim_type_customer")}} tc on sc.cd_type_customer = tc.cd_type_customer
WHERE pc.code_commune_postal IS null OR tc.cd_type_customer IS null
