USE toy_store;

SELECT * FROM order_item_refunds;
SELECT * FROM order_items;
SELECT * FROM orders;
SELECT * FROM products;
SELECT * FROM website_pageviews;
SELECT * FROM website_sessions;

alter table order_item_refunds
ADD constraint pk_order_item_refunds primary key(order_item_refund_id); 

alter table order_items
ADD constraint pk_order_items primary key(order_item_id); 

alter table orders
ADD constraint pk_orders primary key(order_id);

alter table products
ADD constraint pk_product primary key(product_id);

alter table website_pageviews
ADD constraint pk_website_pageview primary key(website_pageview_id);

alter table website_sessions
ADD constraint pk_website_session primary key(website_session_id);

alter table order_item_refunds
ADD constraint fk_order_item foreign key(order_item_id) references order_items(order_item_id);

alter table order_item_refunds
ADD constraint fk_order foreign key(order_id) references orders(order_id);

alter table order_items
ADD constraint fk_order_orderitems foreign key(order_id) references orders(order_id);

alter table order_items
ADD constraint fk_product_items foreign key(product_id) references products(product_id);

alter table orders
ADD constraint fk_orders_website foreign key(website_session_id) references website_sessions(website_session_id);

alter table website_pageviews
ADD CONSTRAINT fk_session_pageview foreign key(website_session_id) references website_sessions(website_session_id);
