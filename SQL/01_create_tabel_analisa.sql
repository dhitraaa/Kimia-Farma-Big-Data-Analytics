CREATE OR REPLACE TABLE
  `Rakamin_KF_Analytics.kimia_farma.tabel_analisa` AS
WITH transaksi AS (

  SELECT
    transaction_id,

    COALESCE(
      SAFE_CAST(date AS DATE),
      SAFE.PARSE_DATE('%m/%d/%Y', CAST(date AS STRING)),
      DATE(SAFE_CAST(date AS TIMESTAMP))
    ) AS date,

    CAST(branch_id AS STRING) AS branch_id,

    customer_name,

    CAST(product_id AS STRING) AS product_id,

    SAFE_CAST(price AS NUMERIC) AS actual_price,

    SAFE_CAST(discount_percentage AS NUMERIC)
      AS discount_percentage,
    SAFE_CAST(rating AS FLOAT64) AS rating_transaksi

  FROM
    `Rakamin_KF_Analytics.kimia_farma.kf_final_transaction`

),

cabang AS (

  SELECT
    CAST(branch_id AS STRING) AS branch_id,

    branch_name,

    kota,

    provinsi,

    SAFE_CAST(rating AS FLOAT64) AS rating_cabang

  FROM
    `Rakamin_KF_Analytics.kimia_farma.kf_kantor_cabang`

),

produk AS (

  SELECT
    CAST(product_id AS STRING) AS product_id,

    product_name,

    SAFE_CAST(price AS NUMERIC) AS product_price

  FROM
    `Rakamin_KF_Analytics.kimia_farma.kf_product`

),

data_gabungan AS (

  SELECT

    t.transaction_id,

    t.date,

    t.branch_id,

    c.branch_name,

    c.kota,

    c.provinsi,

    c.rating_cabang,

    t.customer_name,

    t.product_id,

    p.product_name,

    COALESCE(
      t.actual_price,
      p.product_price
    ) AS actual_price,

    t.discount_percentage,

    t.rating_transaksi

  FROM
    transaksi AS t

  LEFT JOIN
    cabang AS c
    ON t.branch_id = c.branch_id

  LEFT JOIN
    produk AS p
    ON t.product_id = p.product_id

),

perhitungan_laba AS (

  SELECT
    *,

    CASE

      WHEN actual_price <= 50000
        THEN 0.10

      WHEN actual_price > 50000
        AND actual_price <= 100000
        THEN 0.15

      WHEN actual_price > 100000
        AND actual_price <= 300000
        THEN 0.20

      WHEN actual_price > 300000
        AND actual_price <= 500000
        THEN 0.25

      WHEN actual_price > 500000
        THEN 0.30

      ELSE NULL

    END AS persentase_gross_laba

  FROM
    data_gabungan

),

hasil_analisa AS (

  SELECT

    transaction_id,

    date,

    branch_id,

    branch_name,

    kota,

    provinsi,

    rating_cabang,

    customer_name,

    product_id,

    product_name,

    actual_price,

    discount_percentage,

    persentase_gross_laba,

    actual_price * (
      1 - discount_percentage
    ) AS nett_sales,

    (
      actual_price * (1 - discount_percentage)
    ) * persentase_gross_laba AS nett_profit,

    rating_transaksi

  FROM
    perhitungan_laba

)

SELECT
  *
FROM
  hasil_analisa;