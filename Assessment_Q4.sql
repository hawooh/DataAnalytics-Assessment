-- Assessment_Q4.sql
-- Estimate customer lifetime value (CLV) based on transaction history and tenure.
WITH txn_summary AS (
    SELECT 
        owner_id,
        COUNT(*) AS total_transactions,
        SUM(confirmed_amount) AS total_value
    FROM 
        savings_savingsaccount
    WHERE 
        transaction_status IN ('success', 'successful', 'monnify_success')
    GROUP BY owner_id
)
SELECT 
    u.id AS customer_id,
    u.name,
    TIMESTAMPDIFF(MONTH, u.date_joined, CURDATE()) AS tenure_months,
    t.total_transactions,
    ROUND(
        (t.total_transactions / TIMESTAMPDIFF(MONTH, u.date_joined, CURDATE())) * 12 * 
        (0.001 * t.total_value / t.total_transactions), 2
    ) AS estimated_clv
FROM 
    users_customuser u
JOIN 
    txn_summary t ON u.id = t.owner_id
WHERE 
    TIMESTAMPDIFF(MONTH, u.date_joined, CURDATE()) > 0
ORDER BY 
    estimated_clv DESC;
