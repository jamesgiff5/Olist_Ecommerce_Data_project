SELECT 
  sub.customer_state,
  COUNT(DISTINCT CASE WHEN sub.order_count = 1 THEN sub.customer_unique_id END) AS one_time,
  COUNT(DISTINCT CASE WHEN sub.order_count > 1 THEN sub.customer_unique_id END) AS repeat,
  COUNT(DISTINCT sub.customer_unique_id) AS total_customers,
  ROUND(100.0 * COUNT(DISTINCT CASE WHEN sub.order_count > 1 THEN sub.customer_unique_id END) /
        COUNT(DISTINCT sub.customer_unique_id), 2) AS repeat_rate_pct
FROM (
  SELECT 
    c.customer_unique_id, 
    c.customer_state, 
    COUNT(o.order_id) AS order_count
  FROM orders o
  JOIN customers c ON o.customer_id = c.customer_id
  WHERE o.order_status = 'delivered'
    AND o.order_purchase_timestamp >= '2017-01-01'
  GROUP BY c.customer_unique_id, c.customer_state
) sub
GROUP BY sub.customer_state
ORDER BY repeat_rate_pct DESC;