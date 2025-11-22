USE toy_store;

SELECT * FROM orders;
SELECT * FROM order_items;
SELECT * FROM order_item_refunds;
SELECT * FROM products;
SELECT * FROM website_sessions;
SELECT * FROM website_pageviews;


-- Total items Purchased 
SELECT 
	SUM(o.items_purchased) AS [Total Items Purchased],
	p.product_name
FROM 
	orders o inner join products p
ON
	p.product_id = o.primary_product_id
GROUP BY 
	p.product_name
ORDER BY
	SUM(o.items_purchased) DESC;


-- Percentage of sales in each month
SELECT
	DATEPART(year, created_at) AS year_,
	DATEPART(Month, created_at) AS month_,
	SUM(price_usd) AS [Total Sales],
	CAST(ROUND(SUM(price_usd) * 100.0/(SUM(SUM(price_usd)) OVER()), 2) AS decimal(3, 2)) AS [Percent of total sales]
FROM 
	orders
GROUP BY
	DATEPART(Month, created_at),
	DATEPART(year, created_at)
ORDER BY
	DATEPART(year, created_at),
	DATEPART(Month, created_at);


-- Percentage of sales for each year
SELECT
	DATEPART(year, created_at) AS year_,
	SUM(price_usd) AS [Total Sales],
	ROUND(SUM(price_usd) * 100.0/(SUM(SUM(price_usd)) OVER()), 2) AS [Percent of total sales]
FROM 
	orders
GROUP BY
	DATEPART(year, created_at)
ORDER BY
	DATEPART(year, created_at);


-- Total Revenue
SELECT
	SUM(price_usd) AS [Total Revenue]
FROM 
	orders;


-- Average Order Value
SELECT 
	CAST(ROUND(SUM(price_usd) / Count(order_id), 2) AS decimal(4, 2)) AS [Average Order Value]
FROM	
	orders;


-- Gross Profit Margin
SELECT 
	CAST(ROUND(((SUM(price_usd) - SUM(cogs_usd)) / SUM(price_usd) * 100), 2) AS decimal(4, 2)) AS [Gross Profit Margin]
FROM
	orders;


-- Revenue by Product
SELECT 
	p.product_name,
	SUM(o.price_usd) AS [Revenue by product]
FROM
	orders o inner join order_items i
ON
	o.order_id = i.order_id
INNER JOIN products p
ON
	i.product_id = p.product_id
GROUP BY
	P.product_name
ORDER BY
	[Revenue by product] DESC;


-- Total Online orders
SELECT 
	COUNT(o.order_id) AS [Total Online Orders]
FROM
	orders o inner join website_sessions w
ON
	w.website_session_id = o.website_session_id;


-- Total Refund Amount for each product
SELECT
	p.product_name,
	SUM(r.refund_amount_usd) AS [Total Refund Amount],
	SUM(o.price_usd) AS [Total Price],
	CAST(ROUND((SUM(r.refund_amount_usd) / (SUM(o.price_usd))) * 100, 2) AS decimal(4, 2)) AS [Refund rate percentage]
FROM
	order_item_refunds r inner join orders o
ON
	r.order_id= o.order_id
inner join order_items i
ON
	o.order_id = i.order_id
INNER JOIN products p
ON
	i.product_id = p.product_id
GROUP BY 
	p.product_name
ORDER BY 
	[Total Refund Amount] DESC;


-- Tracking total sales for products in each year
SELECT 
	DATEPART(year, o.created_at) AS year_,
	p.product_name,
	SUM(o.price_usd) AS [Total Sales]
FROM
	orders o inner join order_items i
ON
	o.order_id = i.order_id
INNER JOIN products p
ON
	i.product_id = p.product_id
GROUP BY
	DATEPART(year, o.created_at),
	p.product_name
ORDER BY
	DATEPART(year, o.created_at);


-- The most platforms get customers
SELECT
	s.utm_source,
	COUNT(o.order_id) AS [Total orders]
FROM
	website_sessions s inner join orders o
ON
	s.website_session_id = o.website_session_id
GROUP BY
	s.utm_source
ORDER BY
	[Total orders] DESC;


-- The campaign increases sales
SELECT
	s.utm_campaign,
	Count(o.order_id) AS [Total Orders]
FROM 
	website_sessions s inner join orders o
ON
	s.website_session_id = o.website_session_id
GROUP BY
	s.utm_campaign
ORDER BY 
	[Total Orders] DESC;


-- Targeted item or not
SELECT
	i.is_primary_item,
	COUNT(s.website_session_id) AS [Total Website Visits]
FROM
	website_sessions s inner join orders o
ON 
	s.website_session_id = o.website_session_id
INNER JOIN order_items i
ON
	o.order_id = i.order_id
GROUP BY
	i.is_primary_item;


-- Products that not targeted but have bought
SELECT 
	p.product_name,
	Count(i.product_id) AS [Total Amount of Products],
	i.is_primary_item
FROM
	order_items i INNER JOIN products p
ON
	i.product_id = p.product_id
GROUP BY
	p.product_name,
	i.is_primary_item;


-- Device type and its affect
SELECT 
	s.device_type,
	COUNT(o.order_id) AS [Total Orders]
FROM
	website_sessions s INNER JOIN orders o
ON 
	s.website_session_id = o.website_session_id
GROUP BY
	s.device_type;


-- How many times user repeat visit to website
SELECT
	user_id,
	COUNT(is_repeat_session) As [Repeated_visit]
FROM
	website_sessions
GROUP BY
	user_id;


-- How many times user repeat visit to website and buy a product
SELECT
	o.user_id,
	COUNT(is_repeat_session) As [Repeated_visit]
FROM
	website_sessions s INNER JOIN orders o
ON
	s.website_session_id = o.website_session_id
GROUP BY
	o.user_id
HAVING
	COUNT(is_repeat_session) > 1;