SELECT 
    ROW_NUMBER() OVER (ORDER BY code_commune_postal) AS id_dim_postal_code,
    code_commune_postal,
    postal_commune_name,
    id_dim_department
FROM {{ref("_stg_file_zone_geographique")}} z
    INNER JOIN {{ref("dim_department")}} d ON z.code_department = d.cd_department;