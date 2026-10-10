{% snapshot snap_product %}

{{
    config(
        target_schema='silver',
        unique_key='cd_product',
        strategy='check',
        check_cols=['lib_product', 'cd_subcategory', 'price_product']
    )
}}

SELECT 
    cd_product,
    lib_product,
    price_product,
    cd_subcategory
FROM {{ref("_stg_product")}}

{% endsnapshot %}