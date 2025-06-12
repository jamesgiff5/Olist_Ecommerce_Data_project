SELECT 
  c.customer_state AS state,
  ROUND(AVG(order_total), 2) AS avg_order_value
FROM (
  SELECT 
    o.order_id,
    o.customer_id,
    SUM(oi.price) AS order_total
  FROM order_items oi
  JOIN orders o ON oi.order_id = o.order_id
  GROUP BY o.order_id, o.customer_id
) AS order_prices
JOIN customers c ON order_prices.customer_id = c.customer_id
GROUP BY c.customer_state;