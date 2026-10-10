{% snapshot snap_customer %}

{{
    config(
        target_schema='silver',
        unique_key='customer_id',
        strategy='check',
        check_cols=['last_name', 'first_name', 'address', 'postal_code', 'cd_type_customer']
    )
}}

SELECT 
    customer_id,
    last_name,
    first_name,
    address,
    postal_code,
    cd_type_customer
FROM {{ref("_stg_customer")}}

{% endsnapshot %}