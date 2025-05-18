# Data Analytics Assessment - README

## Question 1
**Approach:**  
- Joined `users_customuser` with `plans_plan` to identify customers with both savings and investment plans.  
- Filtered out deleted and archived plans.  
- Counted plans per type and summed deposits.  
- Returned users having at least one savings and one investment plan.

**Challenges:**  
- Many plans were deleted or archived; filtering was necessary to get relevant data.  
- Verified that `cowry_amount` > 0 was crucial for accurate counts.

---

## Question 2
**Approach:**  
- Calculated monthly transaction counts per customer for successful transactions.  
- Computed average monthly transactions per customer.  
- Categorized customers by frequency: High, Medium, Low.  
- Used transaction statuses found in data rather than only 'confirmed'.

**Challenges:**  
- Initial filtering on `transaction_status = 'confirmed'` returned no data.  
- Adjusted the filter to include relevant success statuses found in data exploration.

---

## Question 3
**Approach:**  
- Identified the latest transaction date per plan.  
- Listed plans with no transactions or inactivity over one year.  
- Classified plan types (Savings, Investment, Other).  
- Filtered out deleted and archived plans.

**Challenges:**  
- Handling plans without any transactions required careful LEFT JOIN logic.  
- Ensured plans with NULL last transactions were included as inactive.

---

## Question 4
**Approach:**  
- Summarized total transactions and values per customer for valid successful transactions.  
- Calculated tenure in months.  
- Estimated Customer Lifetime Value (CLV) with transaction frequency and value metrics.  
- Ordered customers by estimated CLV descending.

**Challenges:**  
- Determining the appropriate `transaction_status` values required exploration.  
- Handled division and tenure calculation to avoid zero or invalid values.

---

## General Notes
- Used database: `adashi_staging`.  
- All queries exclude deleted and archived records where relevant.  
- Filters adjusted based on dataset nuances to ensure meaningful results.  
- Queries are optimized for readability and clarity per assessment requirements.
