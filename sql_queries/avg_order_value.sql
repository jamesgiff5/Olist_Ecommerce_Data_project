SELECT 
  ROUND(SUM(order_total) / COUNT(*), 2) AS avg_order_value
FROM (
  SELECT 
    o.order_id,
    SUM(oi.price) AS order_total
  FROM orders o
  JOIN order_items oi ON o.order_id = oi.order_id
  WHERE o.order_status = 'delivered'
  GROUP BY o.order_id
) sub;