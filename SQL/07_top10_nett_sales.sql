CREATE OR REPLACE VIEW
  `Rakamin_KF_Analytics.kimia_farma.view_top10_nett_sales`
AS

SELECT

  branch_id,

  branch_name,

  kota,

  provinsi,

  COUNT(DISTINCT transaction_id) AS total_transaksi,

  SUM(calculated_nett_sales) AS total_nett_sales,

  SUM(calculated_nett_profit) AS total_nett_profit

FROM
  `Rakamin_KF_Analytics.kimia_farma.view_business_base`

GROUP BY
  branch_id,
  branch_name,
  kota,
  provinsi

ORDER BY
  total_nett_sales DESC

LIMIT 10;