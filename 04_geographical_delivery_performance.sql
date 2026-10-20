WITH country_delivery_stats AS (
    SELECT 
        u.country AS customer_country,
        COUNT(DISTINCT o.id) AS total_successful_orders,
        ROUND(AVG(EXTRACT(EPOCH FROM (o.delivered_at - o.shipped_at)) / 86400), 2) AS avg_delivery_days
    FROM orders o
    JOIN users u ON o.user_id = u.id
    WHERE o.status = 'Complete'
    GROUP BY u.country
)
SELECT 
    customer_country,
    total_successful_orders,
    avg_delivery_days,
    -- WINDOW FUNCTION: Menghitung benchmark rata-rata dari seluruh baris negara
    ROUND(AVG(avg_delivery_days) OVER(), 2) AS global_avg_delivery_days,
    -- Menghitung deviasi/varian jarak antara negara tersebut dengan rata-rata global
    ROUND(avg_delivery_days - AVG(avg_delivery_days) OVER(), 2) AS variance_from_global_avg
FROM country_delivery_stats
ORDER BY avg_delivery_days DESC;
