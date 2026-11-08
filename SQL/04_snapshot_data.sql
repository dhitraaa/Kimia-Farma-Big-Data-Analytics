CREATE OR REPLACE VIEW
  `Rakamin_KF_Analytics.kimia_farma.view_snapshot`
AS

SELECT

  EXTRACT(YEAR FROM date) AS tahun,

  COUNT(DISTINCT transaction_id) AS total_transaksi,

  SUM(calculated_nett_sales) AS total_nett_sales,

  SUM(calculated_nett_profit) AS total_nett_profit,

  COUNT(DISTINCT branch_id) AS total_cabang,

  COUNT(DISTINCT customer_name) AS total_customer,

  AVG(rating_cabang) AS rata_rata_rating_cabang,

  AVG(rating_transaksi) AS rata_rata_rating_transaksi

FROM
  `Rakamin_KF_Analytics.kimia_farma.view_business_base`

GROUP BY
  tahun

ORDER BY
  tahun;