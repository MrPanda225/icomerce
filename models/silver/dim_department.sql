WITH distinct_department AS 
(
    SELECT 
        DISTINCT code_department,
        department_name,
        code_region
    FROM {{ref("_stg_file_zone_geographique")}}
),
deduplicated_department AS 
(
    SELECT
        code_department,
        department_name,
        code_region,
        ROW_NUMBER() OVER (PARTITION BY code_department ORDER BY department_name) AS rn 
    FROM distinct_department
)

SELECT 
     ROW_NUMBER() OVER (ORDER BY code_department) AS id_dim_department,
    code_department AS cd_department,
    department_name,
    id_dim_region
FROM deduplicated_department d
    INNER JOIN {{ref("dim_region")}} r ON d.code_region = r.cd_region
WHERE rn =1