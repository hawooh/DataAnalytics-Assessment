-- Assessment_Q3.sql
-- List plans with no transaction or inactive for over one year.
WITH latest_txn AS (
    SELECT 
        plan_id,
        MAX(transaction_date) AS last_transaction_date
    FROM 
        savings_savingsaccount
    WHERE 
        confirmed_amount > 0
    GROUP BY plan_id
)
SELECT 
    p.id AS plan_id,
    p.owner_id,
    CASE 
        WHEN p.is_regular_savings = 1 THEN 'Savings'
        WHEN p.is_a_fund = 1 THEN 'Investment'
        ELSE 'Other'
    END AS type,
    lt.last_transaction_date,
    DATEDIFF(CURDATE(), lt.last_transaction_date) AS inactivity_days
FROM 
    plans_plan p
LEFT JOIN 
    latest_txn lt ON p.id = lt.plan_id
WHERE 
    p.is_deleted = 0 
    AND p.is_archived = 0
    AND (
        lt.last_transaction_date IS NULL 
        OR DATEDIFF(CURDATE(), lt.last_transaction_date) > 365
    );
