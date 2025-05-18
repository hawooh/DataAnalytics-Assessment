-- Assessment_Q1.sql
-- Identify users with both savings and investment plans with non-zero deposits.

SELECT 
    u.id AS owner_id,
    u.name,
    COUNT(DISTINCT CASE WHEN p.is_regular_savings = 1 THEN p.id END) AS savings_count,
    COUNT(DISTINCT CASE WHEN p.is_a_fund = 1 THEN p.id END) AS investment_count
FROM 
    users_customuser u
JOIN 
    plans_plan p ON u.id = p.owner_id
WHERE 
    p.is_deleted = 0 AND p.is_archived = 0
GROUP BY 
    u.id, u.name
HAVING 
    savings_count >= 1 AND investment_count >= 1
ORDER BY 
    savings_count + investment_count DESC
LIMIT 100;
