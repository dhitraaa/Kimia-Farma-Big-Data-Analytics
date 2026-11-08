CREATE OR REPLACE VIEW
  `Rakamin_KF_Analytics.kimia_farma.view_business_base`
AS

WITH normalisasi AS (

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

    CASE
      WHEN discount_percentage > 1
        THEN discount_percentage / 100
      ELSE discount_percentage
    END AS discount_rate,

    persentase_gross_laba,
    rating_transaksi

  FROM
    `Rakamin_KF_Analytics.kimia_farma.tabel_analisa`

  WHERE
    date >= DATE '2020-01-01'
    AND date < DATE '2024-01-01'

)

SELECT
  *,

  actual_price * (1 - discount_rate) AS calculated_nett_sales,

  actual_price
    * (1 - discount_rate)
    * persentase_gross_laba AS calculated_nett_profit

FROM
  normalisasi;