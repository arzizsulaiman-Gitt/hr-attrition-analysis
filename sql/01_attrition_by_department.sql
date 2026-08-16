
WITH dept_stats AS (
    SELECT
        department,
        COUNT(*) AS headcount,
        SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) AS leavers,
        ROUND(AVG(tenure_years), 1) AS avg_tenure_years,
        ROUND(AVG(monthly_income), 0) AS avg_monthly_income
    FROM employees_clean
    GROUP BY department
)
SELECT
    department,
    headcount,
    leavers,
    ROUND(leavers * 100.0 / headcount, 1) AS attrition_rate_pct,
    avg_tenure_years,
    avg_monthly_income,
    RANK() OVER (ORDER BY leavers * 1.0 / headcount DESC) AS attrition_rank
FROM dept_stats
ORDER BY attrition_rate_pct DESC;
