WITH cleaned_sub_category AS 
(
    SELECT 
        NULLIF(TRIM(cd_subcategory), '') as cd_subcategory,
        NULLIF(TRIM(REGEXP_REPLACE(INITCAP(lib_subcategory), '\\s+',' ')),'') as lib_subcategory,
        NULLIF(TRIM(cd_category),'') AS cd_category
    FROM {{source('bronze', 'sub_category')}}
)

SELECT *, 
    row_number() over(
        partition by cd_subcategory 
        order by lib_subcategory
    ) as rn
FROM cleaned_sub_category