-- Overtime vs attrition
SELECT
    overtime,
    COUNT(*) AS headcount,
    ROUND(SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 1) AS attrition_rate_pct
FROM employees_clean
GROUP BY overtime;

-- Job satisfaction vs attrition
SELECT
    job_satisfaction,
    COUNT(*) AS headcount,
    ROUND(SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 1) AS attrition_rate_pct
FROM employees_clean
GROUP BY job_satisfaction
ORDER BY job_satisfaction;

-- Work-life balance vs attrition
SELECT
    worklife_balance,
    COUNT(*) AS headcount,
    ROUND(SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 1) AS attrition_rate_pct
FROM employees_clean
GROUP BY worklife_balance
ORDER BY worklife_balance;

-- Combined: overtime + low satisfaction, in Customer Support specifically
SELECT
    department,
    overtime,
    CASE WHEN job_satisfaction <= 2 THEN 'Low (1-2)' ELSE 'High (3-4)' END AS satisfaction_band,
    COUNT(*) AS headcount,
    ROUND(SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 1) AS attrition_rate_pct
FROM employees_clean
WHERE department = 'Customer Support'
GROUP BY department, overtime, satisfaction_band
ORDER BY attrition_rate_pct DESC;
