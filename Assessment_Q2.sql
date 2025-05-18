-- Assessment_Q2.sql
-- Classify customers by their average monthly transaction frequency.
WITH monthly_txn AS (
    SELECT 
        owner_id,
        DATE_FORMAT(transaction_date, '%Y-%m') AS txn_month,
        COUNT(*) AS txn_count
    FROM 
        savings_savingsaccount
    WHERE 
        transaction_status IN ('success', 'monnify_success', 'successful')
    GROUP BY 
        owner_id, txn_month
),
avg_txn AS (
    SELECT 
        owner_id,
        AVG(txn_count) AS avg_txn_per_month
    FROM 
        monthly_txn
    GROUP BY owner_id
)
SELECT 
    CASE 
        WHEN avg_txn_per_month >= 10 THEN 'High Frequency'
        WHEN avg_txn_per_month BETWEEN 3 AND 9 THEN 'Medium Frequency'
        ELSE 'Low Frequency'
    END AS frequency_category,
    COUNT(*) AS customer_count,
    ROUND(AVG(avg_txn_per_month), 1) AS avg_transactions_per_month
FROM 
    avg_txn
GROUP BY frequency_category;
