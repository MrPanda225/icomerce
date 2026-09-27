---CATEGORY
WITH cleaned_category AS 
(
    SELECT NULLIF(TRIM(cd_category), '') as cd_category,
       NULLIF(TRIM(REGEXP_REPLACE(INITCAP(lib_category), '\\s+',' ')),'') as lib_category
    FROM {{source('bronze', 'category')}}
)


SELECT *, 
    row_number() over(
        partition by cd_category 
        order by lib_category
    ) as rn
FROM cleaned_category