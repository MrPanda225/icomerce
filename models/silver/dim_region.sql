WITH distinct_category AS 
(
    SELECT 
        DISTINCT code_region,
        region_name,
    FROM {{ref("_stg_file_zone_geographique")}}
),
deduplicated_region AS 
(
    SELECT
        code_region,
        region_name,
        ROW_NUMBER() OVER (PARTITION BY code_region ORDER BY region_name) AS rn 
    FROM distinct_category
)

SELECT 
     ROW_NUMBER() OVER (ORDER BY code_region) AS id_dim_region,
    code_region AS cd_region,
    region_name,
    1 AS id_dim_country
FROM deduplicated_region
WHERE rn =1