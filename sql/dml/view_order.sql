CREATE OR ALTER VIEW  DELIVERY.V_ORDERS 
AS
SELECT order_id,
    orders.store_id,
    CAST(orders.store_id as int) as n_store_id,
    channel_id,
    orders.payment_order_id,
    delivery_order_id,
    order_status,
    order_delivery_fee,
    order_created_hour,
    order_created_minute,
    order_created_day,
    order_created_month,
    order_created_year,
    order_delivery_cost,
    ROUND(order_amount, 2) as order_amount,
    FORMAT(
        CONVERT(date, order_moment_created),
        'dd-MM-yyyy'
    ) as date,
    FORMAT(
        CONVERT(datetime, order_moment_created, 101),
        'HH:mm:ss'
    ) as horas,
    CONVERT (datetime, order_moment_created, 101) as order_moment_created,
    CONVERT(datetime, order_moment_accepted, 101) as order_moment_accepted,
    CONVERT(datetime, order_moment_collected, 101) as order_moment_collected,
    CONVERT(datetime, order_moment_in_expedition, 101) as order_moment_in_expedition,
    CONVERT(datetime, order_moment_delivering, 101) as order_moment_delivering,
    CONVERT(datetime, order_moment_delivered, 101) as order_moment_delivered,
    CONVERT(datetime, order_moment_finished, 101) as order_moment_finished,
   -- ROUND(order_metric_collected_time, 2) as order_metric_collected_time,
   -- ROUND(order_metric_paused_time, 2) as order_metric_paused_time,
    order_metric_production_time,
   -- ROUND(order_metric_production_time, 2) as order_metric_production_time,
   -- ROUND(order_metric_walking_time, 2) as order_metric_walking_time,
   -- round(order_metric_expediton_speed_time, 2) as order_metric_expediton_speed_time,
   -- round(order_metric_transit_time, 2) as order_metric_transit_time,
    ROUND(order_metric_cycle_time, 2) as order_metric_cycle_time,
   -- CAST(s.hub_latitude as DECIMAL(10,6)) as hub_latitude,
   -- CAST(s.hub_longitude as DECIMAL(10,6)) as hub_longitude,
   -- CAST(s.store_latitude as DECIMAL(10,6)) as store_latitude,
   -- CAST(s.store_longitude as DECIMAL(10,6)) as store_longitude,
   -- s.hub_name,
    REPLACE(s.hub_city, '?', 'Ã') as hub_city, 
    CASE WHEN s.hub_name = 'SAMPA SHOPPING' THEN 'QUARK'
    WHEN s.hub_name = 'RAP SHOPPING' THEN 'BYTEX'
    WHEN s.hub_name = 'SQL SHOPPING' THEN 'ZEPHYR'
    WHEN s.hub_name = 'R SHOPPING' THEN 'NEXUS'
    WHEN s.hub_name = 'HIP HOP SHOPPING' THEN 'ZENITH'
    WHEN s.hub_name = 'PURPLE SHOPPING' THEN 'VORTEX'
    WHEN s.hub_name = 'GREEN SHOPPING' THEN 'INTERP COM'
    WHEN s.hub_name = 'BLACK SHOPPING' THEN 'NEW BLAZE'
    WHEN s.hub_name = 'PAGODE SHOPPING' THEN 'METRICA BLAZE'
    WHEN s.hub_name = 'PYTHON SHOPPING' THEN 'BREEZE'ELSE s.hub_name END hub_name,
    s.hub_state,
    s.store_segment,
    s.store_name
FROM (
        SELECT o.*
        from delivery.orders o
    ) orders
    JOIN (
        SELECT s.*,
             h.hub_latitude,
             h.hub_name,
             h.hub_city,
             h.hub_state,
             h.hub_longitude
        FROM DELIVERY.STORES s
            LEFT JOIN DELIVERY.HUBS h ON s.hub_id = h.hub_id
    ) s ON orders.store_id = s.store_id;