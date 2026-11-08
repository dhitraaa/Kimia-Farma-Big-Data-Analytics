CREATE OR REPLACE VIEW
  `Rakamin_KF_Analytics.kimia_farma.view_top5_rating`
AS

WITH rating_cabang AS (

  SELECT

    branch_id,

    branch_name,

    kota,

    provinsi,

    AVG(rating_cabang) AS rata_rata_rating_cabang,

    AVG(rating_transaksi) AS rata_rata_rating_transaksi,

    COUNT(DISTINCT transaction_id) AS total_transaksi

  FROM
    `Rakamin_KF_Analytics.kimia_farma.view_business_base`

  GROUP BY
    branch_id,
    branch_name,
    kota,
    provinsi

)

SELECT

  *,

  RANK() OVER (
    ORDER BY
      rata_rata_rating_cabang DESC,
      rata_rata_rating_transaksi ASC
  ) AS ranking_cabang

FROM
  rating_cabang

ORDER BY
  rata_rata_rating_cabang DESC,
  rata_rata_rating_transaksi ASC

LIMIT 5;