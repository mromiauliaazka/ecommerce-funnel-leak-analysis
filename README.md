# E-Commerce Funnel Leak: Investigating 18K Checkout Cancellations

## 📌 Project Overview
This project investigates a critical business challenge for a global e-commerce retailer: a high volume of checkout cancellations (18,273 cancelled orders vs. 31,028 completed transactions). 

Instead of jumping to intuitive assumptions, this analysis systematically tests multiple business hypotheses using SQL to isolate the root cause of the funnel leak and provide data-driven recommendations.

## 🛠️ Tech Stack & Skills Demonstrated
*   **Database Engine:** PostgreSQL
*   **SQL Concepts:** Multi-table Joins, Common Table Expressions (CTEs), Conditional Aggregations (`CASE WHEN`), Window Functions (`OVER()`), Date/Time Extraction (Epoch conversion).
*   **Methodology:** Hypothesis Testing, Data-Driven Skepticism, Root-Cause Analysis.

## 📈 Analytical Journey & Key Findings

### Phase 1: Disproving the Product & Price Hypotheses
*   **Hypothesis:** Customers cancel orders because items are too expensive or carts are overloaded.
*   **Finding:** Disproved. The average item price for cancelled orders (\$59.13) was nearly identical to completed orders (\$59.41). Both groups averaged exactly 1.90 items per cart. Cancellation rates were also structurally uniform (12-13%) across all apparel categories.
*   *Script:* `01_hypothesis_testing.sql`

### Phase 2: Auditing Internal Fulfillment Performance
*   **Hypothesis:** Internal warehouse packaging speed is causing delivery delays, leading to cancellations.
*   **Finding:** Disproved. Internal shipping prep times across all distribution centers were exceptionally efficient, ranging tightly from 0.52 to 0.56 days (a tight 1-hour spread). Operational logistics are highly optimized.
*   *Script:* `02_shipping_delays.sql`

### Phase 3: Isolating the Logistics Bottleneck
*   **Hypothesis:** External third-party courier transit times are causing delivery lag.
*   **Finding:** **Validated.** Once orders leave the warehouse, courier transit takes an average of 2.49 days globally. 
*   *Script:* `03_delivery_transit_time.sql`

### Phase 4: Geographical Variance & Anomaly Detection
*   Using SQL Window Functions to benchmark regional performance against the global average, severe geographical anomalies were detected. 
*   **Austria** showed a massive variance of **+1.94 days** above the global shipping average, identifying a critical supply chain disruption in Western Europe.
*   *Script:* `04_geographical_delivery_performance.sql`

## 💡 Business Recommendations
1.  **Courier SLA Review:** Re-negotiate contracts with regional third-party logistics (3PL) providers in high-variance countries like Austria and Poland.
2.  **Checkout Transparency:** Implement dynamic, transparent estimated delivery dates at checkout to manage customer expectations and reduce anxiety-driven cancellations.
