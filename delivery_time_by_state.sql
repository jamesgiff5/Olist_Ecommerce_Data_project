SELECT 
  c.customer_state,
  COUNT(o.order_id) AS delivered_orders,
  ROUND(AVG(EXTRACT(DAY FROM o.order_delivered_customer_date - o.order_purchase_timestamp)), 2) AS avg_delivery_days,
  ROUND(AVG(EXTRACT(DAY FROM o.order_estimated_delivery_date - o.order_delivered_customer_date)), 2) AS avg_days_early_or_late
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
WHERE o.order_status = 'delivered'
  AND o.order_purchase_timestamp >= '2017-01-01'
  AND o.order_delivered_customer_date IS NOT NULL
GROUP BY c.customer_state
ORDER BY avg_delivery_days DESC;
