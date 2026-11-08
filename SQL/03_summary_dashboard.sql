CREATE OR REPLACE VIEW
  `Rakamin_KF_Analytics.kimia_farma.view_summary`
AS

SELECT

  COUNT(DISTINCT transaction_id) AS total_transaksi,

  SUM(calculated_nett_sales) AS total_nett_sales,

  SUM(calculated_nett_profit) AS total_nett_profit,

  AVG(rating_cabang) AS rata_rata_rating_cabang,

  AVG(rating_transaksi) AS rata_rata_rating_transaksi,

  COUNT(DISTINCT branch_id) AS total_cabang,

  COUNT(DISTINCT product_id) AS total_produk,

  COUNT(DISTINCT customer_name) AS total_customer,

  MIN(date) AS tanggal_transaksi_pertama,

  MAX(date) AS tanggal_transaksi_terakhir

FROM
  `Rakamin_KF_Analytics.kimia_farma.view_business_base`;