-- =========================================
-- Bank Customer Churn Analysis
-- =========================================
create database bank;
use bank;
-- =========================================
-- 1 creating table headers
-- =========================================
create table bank_customers (
customer_id bigint primary key,
credit_score int,
country varchar(30),
gender varchar(20),
age int,
tenure int,
balance decimal(12,2),
product_number int,
credit_card int,
active_member int,
estimated_salary decimal(12,2),
churn int );


select * from bank_customers;
-- =========================================
-- 2. Total customers and Churn rate
-- =========================================
select count(*) as total_customers,
 sum(churn) as churn_customer, 
 round(sum(churn)*100.0/count(*),2) as churn_rate
from bank_customers;

-- =========================================
-- 3. Churn by country 
-- =========================================
select country,
count(*) as total_customers,
sum(churn) as churned_customers,
round(sum(churn)*100.0/count(*),2) as churn_rate
from bank_customers 
group by country order by churned_customers desc;
-- Insights:
-- Germany has the highest churn rate compared to France and Spain.
-- This indicates that Customers in Germany are more likely to leave the bank.

-- =========================================
-- 4. Churn by gender 
-- =========================================
select gender,
count(*) as total_customers,
sum(churn) as churned_customers,
round(sum(churn)*100.0/count(*),2) as churn_rate
from bank_customers
group by gender order by churned_customers desc;
-- Insights: 
-- Female Customers has the highest churn rate than male customers.

-- =========================================
-- 5. churn by age group 
-- =========================================
select 
case 
when age < 30 then 'Young'
when age between 30 and 50 then 'Middle age'
else 'Senior'
end as age_group,
count(*) as total_customers,
sum(churn) as churned_customers,
round(sum(churn)*100.0/count(*),2) as churn_rate
from bank_customers
group by age_group;
-- Insights:
-- Senior customers has the Highest churn rate compared to young and middle aged customers.

-- =========================================
-- 6. churn by product number
-- =========================================
select product_number,
count(*) as total_customers,
sum(churn) churned_customers,
round(sum(churn)*100.0/count(*),2) as churn_rate
from bank_customers group by product_number;
-- Insights:
-- customers with two products have the lowest churn rate.
-- customers with 1 product have the moderate churn rate.
-- customers with 3 products have the very high churn rate.
-- customers with 4 products have the 100% churn rate.

-- =========================================
-- 7. Active vs Inactive members 
-- =========================================
select active_member,
count(*) total_customers,
sum(churn) churned_customers,
round(sum(churn)*100.0/count(*),2) as churn_rate
from bank_customers group by active_member;
-- Insights:
-- Inactive customers has the more churn rate compared to active customers.

-- =========================================
-- 8. credit score analysis 
-- =========================================
select
case 
when credit_score <500 then 'Low'
when credit_score between 500 and 700 then 'Medium'
else 'High'
end as credit_group,
count(*) total_customers,
sum(churn) churned_customers,
round(sum(churn)*100.0/count(*),2) as churn_rate
from bank_customers group by credit_group;
-- Insights:
-- Customers with low credit score has high churn rate compared to high and medium credit score customers.
-- This indicates customers with low credit score are more like to leave the bank.

-- =========================================
-- 9. Balance analysis
-- =========================================
select min(balance),avg(balance),max(balance) from bank_customers where churn = 1;
-- Insight:
-- The minimum balance of churned customers is 0.
-- The average balance is around 91K.
-- The maximum balance reaches about 250K.

-- =========================================
-- 10. Tenure Analysis
-- =========================================
select tenure, 
count(*) total_customers,
sum(churn) churned_customers,
round(sum(churn)*100.0/count(*),2) as churn_rate
from bank_customers group by tenure order by churn_rate desc;
-- Insights:
-- Customers with very low tenure (0–1 years) show the highest churn rate, indicating new customers are more likely to leave.
-- As tenure increases, the churn rate generally decreases.
-- Customers with higher tenure (6–10 years) tend to stay longer with the bank.
-- This suggests that customer loyalty increases over time.

-- =========================================
-- 11. credit card vs churn
-- =========================================
select credit_card,
count(*) total_customers,
sum(churn) churned_customers,
round(sum(churn)*100.0/count(*),2) as churn_rate
from bank_customers group by credit_card;
-- Insight: 
-- The churn rate is almost the same for customers with and without a credit card
-- Indicating that credit card ownership has little impact on customer churn.

-- =========================================
-- 12. Salary Analysis
-- =========================================
select
min(estimated_salary),
avg(estimated_salary),
max(estimated_salary)
from bank_customers where churn = 1;
-- Insights:
-- Churned customers have a minimum estimated salary of 11.58.
-- The average estimated salary of churned customers is approximately 101K.
-- The maximum estimated salary among churned customers is around 199K.
-- Salary does not appear to have a strong direct relationship with churn.

-- =========================================
-- 13. Final Business Insights
-- =========================================
-- 1. Germany shows the highest customer churn rate among all countries
-- 2. Female customers have a slightly higher churn rate than male customers..
-- 3. Senior customers churn more frequently than younger customers.
-- 4. Customers with either very few products (1) or many products (3–4) tend to have higher churn rates..
-- 5. Inactive customers are much more likely to leave the bank.
-- 6. Customers with low credit scores have a higher churn risk..
-- 7. New customers (low tenure score) are more likely to leave the bank.
-- 8. Credit card ownership does not significantly impact churn.
-- 9. Salary does not appear to have a strong direct relationship with churn.

