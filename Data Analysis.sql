select * from dbo.Medical_costs;

--Data Quality Checks:

--Count Null Values in Each Column:
SELECT
    SUM(CASE WHEN Id IS NULL THEN 1 ELSE 0 END) AS null_id,
    SUM(CASE WHEN age IS NULL THEN 1 ELSE 0 END) AS null_age,
    SUM(CASE WHEN sex IS NULL THEN 1 ELSE 0 END) AS null_sex,
    SUM(CASE WHEN bmi IS NULL THEN 1 ELSE 0 END) AS null_bmi,
    SUM(CASE WHEN children IS NULL THEN 1 ELSE 0 END) AS null_children,
    SUM(CASE WHEN smoker IS NULL THEN 1 ELSE 0 END) AS null_smoker,
    SUM(CASE WHEN region IS NULL THEN 1 ELSE 0 END) AS null_region,
    SUM(CASE WHEN charges IS NULL THEN 1 ELSE 0 END) AS null_charges
FROM Medical_costs;

--Check for Rows with Null Values:
SELECT * FROM Medical_costs WHERE Id IS NULL OR age IS NULL OR sex IS NULL OR bmi IS NULL OR children IS NULL OR smoker IS NULL OR region IS NULL OR charges IS NULL;

--Verify Transformation Logic:
SELECT
    Id,
    age,
    sex,
    bmi,
    children,
    smoker,
    region,
    charges,
    -- Add transformed columns using the same logic
    CASE WHEN  bmi> 0 THEN 1 ELSE 0 END AS new_column
FROM Medical_costs;

-- Check for duplicate rows in the dataset
SELECT Id, COUNT(*) AS count   
FROM Medical_costs
GROUP BY Id
HAVING COUNT(*) > 1;

-- Check for outliers in the 'age' column
SELECT MAX(age) AS max_age, MIN(age) AS min_age
FROM Medical_costs;

-- Check the distribution of 'region' values
SELECT region, COUNT(*) AS count
FROM Medical_costs
GROUP BY region;

-- Check if any required columns have NULL values
SELECT COUNT(*) AS num_missing_data
FROM Medical_costs
WHERE Id IS NULL OR age IS NULL OR sex IS NULL OR bmi IS NULL;


--SQL Queries:

--Retrieve Basic Information:
--Get the first 5 rows of the dataset:
SELECT TOP 5 * FROM Medical_costs;

--Calculate the average age, BMI, and charges in the dataset:
SELECT AVG(age) AS average_age, AVG(bmi) AS average_bmi, AVG(charges) AS average_charges FROM Medical_costs;

--Retrieve information about individuals who are smokers:
SELECT * FROM Medical_costs WHERE smoker = '1';

--Find the average charges for each region:
SELECT region, AVG(charges) AS avg_charges FROM Medical_costs GROUP BY region;

--Get the top 10 most expensive charges in the dataset:
SELECT TOP 10 * FROM Medical_costs ORDER BY charges DESC;

--Check the distribution of ages in the dataset:
SELECT age, COUNT(*) AS count FROM Medical_costs GROUP BY age ORDER BY age;

--Count the number of male and female smokers and non-smokers:
SELECT sex, smoker, COUNT(*) AS count FROM Medical_costs GROUP BY sex, smoker;

--Calculate Average Charges by Age Group:
SELECT
    CASE
        WHEN age BETWEEN 18 AND 30 THEN '18-30'
        WHEN age BETWEEN 31 AND 45 THEN '31-45'
        WHEN age BETWEEN 46 AND 60 THEN '46-60'
        ELSE '61+'
    END AS age_group,
    AVG(charges) AS avg_charges
FROM Medical_costs
GROUP BY age
ORDER BY age;

--Identify High BMI Individuals by Region:
SELECT
    region,
    COUNT(*) AS high_bmi_count
FROM Medical_costs
WHERE bmi > 30
GROUP BY region
ORDER BY high_bmi_count DESC;

--Calculate Average Charges for Smokers vs. Non-Smokers:
SELECT
    smoker,
    AVG(charges) AS avg_charges
FROM Medical_costs
GROUP BY smoker;

--Calculate the Ratio of Male to Female Smokers:
SELECT
    sex,
    SUM(CASE WHEN smoker = '1' THEN 1 ELSE 0 END) AS smokers,
    SUM(CASE WHEN smoker = '0' THEN 1 ELSE 0 END) AS non_smokers
FROM Medical_costs
GROUP BY sex;

--Identify Individuals with High Charges and High BMI:
SELECT id, age, bmi, charges
FROM Medical_costs
WHERE charges > 30000 AND bmi > 30
ORDER BY charges DESC;

--Count the Number of Children by Age Group:
SELECT
    CASE
        WHEN age BETWEEN 18 AND 30 THEN '18-30'
        WHEN age BETWEEN 31 AND 45 THEN '31-45'
        WHEN age BETWEEN 46 AND 60 THEN '46-60'
        ELSE '61+'
    END AS age_group,
    SUM(children) AS total_children
FROM Medical_costs
GROUP BY age
ORDER BY age;

--The top 5 avenues (combinations of health insurance plan, age group, and state) 
SELECT
    region,
    age,
    COUNT(*) AS num_customers,
    AVG(charges) AS avg_charges
FROM Medical_costs
GROUP BY region, age
ORDER BY region, age;

--To find the top 5 avenues with the highest average charges
SELECT TOP 5
    region,
    age,
    AVG(charges) AS avg_charges
FROM Medical_costs
GROUP BY region, age
ORDER BY avg_charges DESC;



