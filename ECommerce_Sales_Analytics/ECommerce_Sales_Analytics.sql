SELECT * FROM ecommerce_sales;

# Does exist seasonality?
SELECT CONCAT_WS('_', YEAR(order_date_new), MONTH(order_date_new)) AS yearmonth, SUM(revenue) AS revenue_yearmonth
FROM ecommerce_sales 
GROUP BY CONCAT_WS('_', YEAR(order_date_new), MONTH(order_date_new));

# Sales volume ranking 
SELECT product_category, SUM(quantity) AS Sales_total FROM ecommerce_sales GROUP BY product_category ORDER BY SUM(quantity) DESC;

# Sales revenue ranking
SELECT product_category, ROUND(SUM(revenue),0) AS Total_revenue FROM ecommerce_sales GROUP BY product_category ORDER BY SUM(revenue) DESC;

# qual produto/ categoria se destaca em cada região
SELECT region, product_category, sum(revenue), count(order_id) FROM ecommerce_sales GROUP BY region, product_category order by region;

# Contagem de pedidos por região
SELECT region, COUNT(order_id) FROM ecommerce_sales GROUP BY region;

# Which region has the highest average delivery time?
SELECT region, ROUND(AVG(delivery_days), 2) AS Average_delivery_time FROM ecommerce_sales GROUP BY region ORDER BY AVG(delivery_days) DESC;

# Which product category has the highest average delivery time?
SELECT product_category, ROUND(AVG(delivery_days), 2) AS Average_delivery FROM ecommerce_sales GROUP BY product_category ORDER BY AVG(delivery_days) DESC;

# How much each payment method did yeld
SELECT payment_method, ROUND(SUM(revenue),0) AS payment_method_revenue FROM ecommerce_sales GROUP BY payment_method ORDER BY SUM(revenue) DESC;

# medium ticket
SELECT ROUND(SUM(revenue)/ COUNT(order_id), 1) AS Medium_ticket FROM ecommerce_sales;

# medium ticket monthly
SELECT yearmonth, ROUND((revenue_yearmonth/ id_counter), 1) as medium_ticket_monthly FROM
	(SELECT CONCAT_WS('_', YEAR(order_date_new), MONTH(order_date_new)) AS yearmonth, SUM(revenue) AS revenue_yearmonth, COUNT(order_id) as id_counter
	FROM ecommerce_sales 
	GROUP BY CONCAT_WS('_', YEAR(order_date_new), MONTH(order_date_new))) AS yearmonth_query;
    
#top 10 most valuable clients
SELECT customer_id, SUM(revenue) AS client_revenue FROM ecommerce_sales GROUP BY customer_id ORDER BY SUM(revenue) DESC LIMIT 10;

#Qual a participação de cada faixa de avaliação no faturamento total
###  NECESSARIO WINDOW FUNCTION ###

#como é a distribuição de receita por clientes(espersa ou concentrada?)
### RESPONDER NO PYTHON ###

#ticket medio das regioes
SELECT region, ROUND(SUM(revenue)/ COUNT(order_id), 1) AS Medium_ticket FROM ecommerce_sales GROUP BY region ORDER BY SUM(revenue)/ COUNT(order_id) DESC;

#ticket médio por categoria
SELECT product_category, ROUND(SUM(revenue)/ COUNT(order_id), 1) AS Medium_ticket FROM ecommerce_sales GROUP BY product_category ORDER BY SUM(revenue)/ COUNT(order_id) DESC;
