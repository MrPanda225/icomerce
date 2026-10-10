SELECT ROW_NUMBER() OVER (ORDER BY cd_type_customer) AS id_dim_type_customer,
    cd_type_customer,
    lib_type_customer
FROM {{ref('_stg_type_customer')}}