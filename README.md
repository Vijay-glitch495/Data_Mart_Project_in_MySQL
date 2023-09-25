# Data_Mart_Project_in_MySQL

I'm currently engaged in the Data Dart project, and I'm seeking assistance in conducting an analysis of the sales and performance metrics for this venture. Notably, in June 2020, significant supply chain alterations were implemented at Data Dart. This overhaul involved the adoption of sustainable packaging practices for all Data Dart products, spanning from the initial farm stage to the final customer delivery. I'm doing some data cleansing and data exploration in quantifying the influence of this transition on the sales performance of Data Dart and its distinct business sectors.


SCHEMA USED: WEEKLY_SALES TABLE


Column name   Data type
week_date     date
region        varchar(20)
platform      varchar(20)
segment       varchar(10)
customer      varchar(20)
transactions  int
sales         int

## DATA CLEANSING:

$In a single query, perform the following operations and generate a new table in the data_mart schema named clean_weekly_sales:

$Add a week_number as the second column for each week_date value, for example any value from the 1st of January to 7th of January will be 1, 8th to 14th will be 2, etc.

$Add a month_number with the calendar month for each week_date value as the 3rd column

$Add a calendar_year column as the 4th column containing either 2018, 2019 or 2020 values

$Add a new column called age_band after the original segment column using the following mapping on the number inside the segment value
segment
age_band       1
Young Adults   2
Middle Aged    3 or 4
Retirees

$Add a new demographic column using the following mapping for the first letter in the segment values:
segment | demographic |
C | Couples |
F | Families |

$Ensure all null string values with an "unknown" string value in the original segment column as well as the new age_band and demographic columns

$Generate a new avg_transaction column as the sales value divided by transactions rounded to 2 decimal places for each record


## DATA EXPLORATION:

$Which week numbers are missing from the dataset?

$How many total transactions were there for each year in the dataset?

$What are the total sales for each region for each month?

$What is the total count of transactions for each platform?

$What is the percentage of sales for Retail vs Shopify for each month?

$What is the percentage of sales by demographic for each year in the dataset?

$Which age_band and demographic values contribute the most to Retail sales?






























