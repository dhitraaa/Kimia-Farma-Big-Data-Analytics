CREATE OR REPLACE VIEW
  `Rakamin_KF_Analytics.kimia_farma.view_annual_revenue`
AS

WITH revenue_tahunan AS (

  SELECT

    EXTRACT(YEAR FROM date) AS tahun,

    COUNT(DISTINCT transaction_id) AS total_transaksi,

    SUM(calculated_nett_sales) AS nett_sales,

    SUM(calculated_nett_profit) AS nett_profit

  FROM
    `Rakamin_KF_Analytics.kimia_farma.view_business_base`

  GROUP BY
    tahun

)

SELECT

  tahun,

  total_transaksi,

  nett_sales,

  nett_profit,

  LAG(nett_sales) OVER (
    ORDER BY tahun
  ) AS nett_sales_tahun_sebelumnya,

  SAFE_DIVIDE(
    nett_sales - LAG(nett_sales) OVER (
      ORDER BY tahun
    ),
    LAG(nett_sales) OVER (
      ORDER BY tahun
    )
  ) * 100 AS pertumbuhan_pendapatan_persen

FROM
  revenue_tahunan

ORDER BY
  tahun;