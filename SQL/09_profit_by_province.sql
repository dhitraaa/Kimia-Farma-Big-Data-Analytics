CREATE OR REPLACE VIEW
  `Rakamin_KF_Analytics.kimia_farma.view_profit_province`
AS

SELECT

  provinsi,

  COUNT(DISTINCT branch_id) AS total_cabang,

  COUNT(DISTINCT transaction_id) AS total_transaksi,

  SUM(calculated_nett_sales) AS total_nett_sales,

  SUM(calculated_nett_profit) AS total_nett_profit,

  AVG(rating_cabang) AS rata_rata_rating_cabang,

  AVG(rating_transaksi) AS rata_rata_rating_transaksi

FROM
  `Rakamin_KF_Analytics.kimia_farma.view_business_base`

WHERE
  provinsi IS NOT NULL

GROUP BY
  provinsi

ORDER BY
  total_nett_profit DESC;