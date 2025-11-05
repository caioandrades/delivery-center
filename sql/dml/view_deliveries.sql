CREATE OR ALTER VIEW DELIVERY.V_DELIVERIES
AS
SELECT 
    DISTINCT(order_id)
    , COUNT(DISTINCT(order_id)) as quantity
    , store_id
    , n_store_id
    , d.delivery_order_id
    , hub_name
    , hub_city
    , order_created_hour
    , hub_state
    , store_name
    , store_segment
    , order_moment_created
    , order_moment_in_expedition
    , DATEADD(MINUTE, 51, order_moment_created) AS order_moment_estimated
    , CASE WHEN order_moment_finished <= DATEADD(MINUTE, 51, order_moment_created) THEN 'TRUE' ELSE 'FALSE' END is_checked
    , CASE WHEN order_status =  'CANCELED' THEN 1 ELSE 0 END is_checked_in_full
    , COALESCE(
        CASE
            WHEN order_moment_created > order_moment_finished THEN order_moment_created
            ELSE order_moment_finished
        END
        , order_moment_created
    ) AS order_moment_finished
    , date
    , horas
    , order_status
    , d.delivery_status
    , order_amount
    , order_delivery_fee
    , order_metric_production_time
    , delivery_distance_meters
    , COALESCE(
        order_delivery_cost
        , 0
    ) AS order_delivery_cost
    , COALESCE(
        order_metric_cycle_time
        , 0
    ) AS order_metric_cycle_time
    , DATEDIFF(SECOND, order_moment_created, COALESCE(order_moment_finished, order_moment_created)) AS order_metric_cycle_time_second
    , AVG(DATEDIFF(MINUTE, order_moment_created, order_moment_finished))  AS avg_cicle_life
    ,
    --- CONVERTE A DISTANCIA DE METROS PARA KILOMETROS
    (
        delivery_distance_meters / 1000
    ) / DATEDIFF(MINUTE, order_moment_created, COALESCE(order_moment_finished, order_moment_created)) * 3.6 AS avg_velocity_km_per_hour
FROM
    DELIVERY.DELIVERIES d
LEFT JOIN DELIVERY.V_ORDERS o
    ON
    d.delivery_order_id = o.payment_order_id
WHERE
    DATEDIFF(MINUTE, order_moment_created, order_moment_finished) < 60
    AND DATEDIFF(MINUTE, order_moment_created, COALESCE(order_moment_finished, order_moment_created)) > 0
    --  AND order_status <> 'CANCELED'
GROUP BY
    order_id
    , delivery_id
    , store_id
    , n_store_id
    , order_created_hour
    , d.delivery_order_id
    , hub_name
    , hub_city
    , store_name
    , store_segment
    , order_moment_created
    , order_moment_in_expedition
    , date
    , horas
    , hub_state
    , order_moment_finished
    , order_status
    , delivery_status
 --   , driver_type
    , order_amount
    , order_delivery_fee
--    , driver_modal
    , order_metric_production_time
    , delivery_distance_meters
    , order_delivery_cost
    , order_metric_cycle_time