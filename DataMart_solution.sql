use case1;
SELECT*FROM weekly_sales limit 10;
SELECT COUNT(*)FROM weekly_sales;
## Data cleansing

CREATE TABLE clean_weekly_sales as
SELECT week_date,week(week_date) as week_number,
month(week_date) as month_number,
year(week_date) as calender_year,
platform, region,
case
when segment=null then 'Unknown'
else segment
end as segment,
case
    when right(segment,1)='1' then 'Young_age'
    when right(segment,1)='2' then 'Middle_age'
    when right(segment,1) in ('3','4') then 'Retired'
    else 'Unknown'
    end as age_band,
case
    when left(segment,1)='C' then 'Couples'
    when left(segment,1)='F' then 'Families'
    else 'Unknown'
    end as demographics,
customer_type,sales,transactions,
round(sales/transactions,2) as 'avg transaction'
FROM weekly_sales;

SELECT*FROM clean_weekly_sales limit 10;
 
 
 ## Data exploration
 # 1.Which week numbers are missing from the dataset?
 
CREATE TABLE seq100(x int auto_increment primary key);
INSERT INTO seq100 values (),(),(),(),(),(),(),(),(),();
INSERT INTO seq100 values (),(),(),(),(),(),(),(),(),();
INSERT INTO seq100 values (),(),(),(),(),(),(),(),(),();
INSERT INTO seq100 values (),(),(),(),(),(),(),(),(),();
INSERT INTO seq100 values (),(),(),(),(),(),(),(),(),();
INSERT INTO seq100 select x+50 from seq100;

SELECT*FROM seq100;

CREATE TABLE seq52 as (select x from seq100 limit 52);

SELECT DISTINCT x as dist_week_day FROM seq52
WHERE x not in (SELECT DISTINCT week_number FROM clean_weekly_sales);

SELECT DISTINCT week_number FROM clean_weekly_sales;

# 2.How many total transactions were there for each year in the dataset?

SELECT calender_year,SUM(transactions) as total_transactions
FROM clean_weekly_sales group by calender_year order by calender_year ASC;

# 3.What are the total sales for each region for each month?

SELECT region,month_number,SUM(transactions) as total_transactions
FROM clean_weekly_sales group by region,month_number order by month_number ASC;

# 4.What is the total count of transactions for each platform?

SELECT platform, sum(transactions) as total_transactions FROM  clean_weekly_sales
GROUP BY platform ORDER BY platform;

#5.What is the percentage of sales for Retail vs Shopify for each month?
         #we are creating temporary table
WITH cte_monthly_platform_sales AS (SELECT month_number,calender_year,platform,
SUM(sales) AS monthly_sales
FROM clean_weekly_sales
GROUP BY month_number,calender_year, platform)

SELECT month_number,calender_year,
ROUND(100 * MAX(CASE WHEN platform = 'Retail' THEN monthly_sales ELSE NULL END) /SUM(monthly_sales),2) AS retail_percentage,
ROUND(100 * MAX(CASE WHEN platform = 'Shopify' THEN monthly_sales ELSE NULL END) /SUM(monthly_sales),2) AS shopify_percentage
FROM cte_monthly_platform_sales
GROUP BY month_number,calender_year
ORDER BY month_number,calender_year;


# 6.What is the percentage of sales by demographic for each year in the dataset?
 
SELECT calender_year,demographics,
SUM(SALES) AS yearly_sales,
ROUND((100 * SUM(sales)/SUM(SUM(SALES)) OVER (PARTITION BY demographics)),2) AS percentage
FROM clean_weekly_sales
GROUP BY calender_year,demographics
ORDER BY calender_year,demographics;
 

# 7.Which age_band and demographic values contribute the most to Retail sales?

SELECT age_band,demographics,SUM(sales) AS total_sales
FROM clean_weekly_sales
WHERE platform = 'Retail'
GROUP BY age_band, demographics
ORDER BY total_sales DESC;
