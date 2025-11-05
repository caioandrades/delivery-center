CREATE TABLE DELIVERY.CHANNELS(
channel_id  int primary key not null,
channel_name varchar(500),
channel_type varchar(500)
)

CREATE TABLE DELIVERY.HUBS(
hub_id INT PRIMARY KEY not null,
hub_name VARCHAR(500),
hub_city VARCHAR(500),
hub_state VARCHAR(500),
hub_latitude BIGINT,
hub_longitude BIGINT
)

CREATE TABLE DELIVERY.STORES(
store_id INT PRIMARY KEY NOT NULL,
hub_id INT ,
store_name varchar(500),
store_segment varchar(500),
store_plan_price varchar(500),
store_latitude bigint,
store_longitude bigint,
--CONSTRAINT fk_hub FOREIGN KEY (hub_id) REFERENCES DELIVERY.HUBS(hub_id)
)

CREATE TABLE DELIVERY.DRIVERS(
driver_id INT PRIMARY KEY not null,
driver_modal varchar(500),
driver_type varchar(500)
)

CREATE TABLE DELIVERY.DELIVERIES(
delivery_id int primary key not null,
delivery_order_id int,
driver_id int,
delivery_distance_meters int,
delivery_status varchar(500)
)


CREATE TABLE DELIVERY.PAYMENTS(
payment_id int primary key not null,
payment_order_id int, 
payment_amount float,
payment_fee float,
payment_method varchar(500),
payment_status varchar(50)
);

CREATE TABLE DELIVERY.ORDERS ( 
order_id INT PRIMARY KEY,
store_id INT,
channel_id INT,
payment_order_id INT,
delivery_order_id INT,
order_status VARCHAR(50),
order_amount FLOAT,
order_delivery_fee FLOAT,
order_delivery_cost FLOAT,
order_created_hour INT,
order_created_minute INT,
order_created_day INT,
order_created_month INT,
order_created_year INT,
order_moment_created DATETIME,
order_moment_accepted DATETIME,
order_moment_ready DATETIME,
order_moment_collected DATETIME,
order_moment_in_expedition DATETIME,
order_moment_delivering DATETIME,
order_moment_delivered DATETIME,
order_moment_finished DATETIME,
order_metric_collected_time float,
order_metric_paused_time float,
order_metric_production_time float,
order_metric_walking_time float, 
order_metric_expediton_speed_time float,
order_metric_transit_time float,
order_metric_cycle_time float,
-- CONSTRAINT fk_store FOREIGN KEY (store_id) REFERENCES DELIVERY.STORES(store_id),
-- CONSTRAINT fk_channel FOREIGN KEY (channel_id) REFERENCES DELIVERY.CHANNELS(channel_id)
-- CONSTRAINT fk_payment_order FOREIGN KEY (payment_order_id) REFERENCES DELIVERY.PAYMENTS(payment_order_id), não pode ser chave foránea (não tem valores únicos e faltam valores em reção a ORDERS)
-- CONSTRAINT fk_delivery_order FOREIGN KEY (delivery_order_id) REFERENCES DELIVERY.DELIVERIES(delivery_order_id) não pode ser chave foránea (não tem valores únicos e faltam valores em reção a ORDERS)
);

