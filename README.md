# Quickcommerce-delivery-analysis
End-to-end data analysis of quick-commerce delivery data using MySQL, Excel and Power BI, with a documented, verified AI workflow.
# Quick-Commerce Delivery and Customer Experience Analysis

An end-to-end data analyst project built with MySQL, Excel and Power BI, with a documented and verified AI-assisted workflow.

The business question: where is a quick-commerce business losing customers and money, and what should it fix first?

## What this project is

I took a public Kaggle dataset of quick-commerce delivery orders and worked on it from start to finish, the way an entry-level analyst would on a real business problem. I profiled and documented the data, cleaned it in SQL, answered eight business questions, checked my numbers in Excel, built a four-page Power BI dashboard, and wrote a business report with recommendations. I also kept a log of every time I used AI and how I checked its output.

## The dataset

- Source: the Kaggle e-commerce delivery analytics dataset, licensed under Apache 2.0.
- Size: 100,000 orders, 9,000 customers, 3 platforms (Blinkit, JioMart, Swiggy Instamart) and 6 product categories.
- Columns: order ID, customer ID, platform, order date and time, delivery time in minutes, product category, order value in rupees, customer feedback, service rating, delivery delay, refund requested.
- The repository holds only a 100-row sample of the data. The full file is on Kaggle.

## Tools used

- MySQL for loading, cleaning and analysing the data (written and run in DBeaver on a Mac)
- Excel for profiling, a data dictionary, data quality checks, validation and the findings register
- Power BI for the dashboard
- AI (Claude) as a pair-programmer, reviewer and drafting assistant, with every use logged and checked

## How I did the project, from 0 to 100

### Stage 0: Setup and framing
I created a project folder with numbered sub-folders, installed MySQL and DBeaver, and wrote a short problem statement. I kept the raw CSV untouched and never edited it.

### Stage 1: Understanding the data (Excel)
I loaded the CSV into Excel and saved it as quickcommerce_analysis.xlsx. In that workbook I built:
- Raw_Data: the original data, plus helper columns I added later (delay flag, refund flag, refund value, feedback theme)
- Profiling: row counts, blank cells, distinct values, and minimum, maximum, average and median for the numeric columns
- Data_Dictionary: what each column means, its type, an example, distinct values, notes, planned use, valid values, and the data source and licence
- DQ_Log: six data quality checks with results and the action I took

The checks found three important things. The order date column is corrupted in the source file (only 60 distinct values), so trend and peak-hour analysis are not possible. The delay flag simply means delivery time over 40 minutes. A refund is requested exactly when the rating is 1 or 2. I also found that the "very late delivery" feedback does not line up with actual delivery times: 6,548 of 7,592 such complaints came from orders that were not delayed.

### Stage 2: SQL setup and cleaning (MySQL)
I created a database called quickcommerce, a raw table called orders_raw, and loaded all 100,000 rows with a LOAD DATA command. I confirmed the row count and compared the averages with my Excel profiling. Then I built a cleaned table called orders_clean, which adds a delay flag, a refund flag, a rating group, seven complaint themes, delivery time bands and order value bands. The corrupted date column was left out on purpose.

### Stage 3: SQL analysis
I wrote eight queries, each answering one business question:
1. Overall health of the business (headline KPIs)
2. Platform comparison
3. Category comparison
4. Delivery performance, including percentiles
5. Complaint root causes
6. Refund exposure by order size
7. Customer segments, using a customer summary view
8. Whether delivery delay affects satisfaction

These queries use grouping, CASE logic, common table expressions and window functions (running totals, ranking and quartile splitting).

### Stage 4: Validation in Excel
I rebuilt the key figures in Excel with pivot tables and formulas and compared them with the SQL results in a Reconciliation sheet. All 14 of 14 metrics matched.

### Stage 5: The Power BI dashboard
I loaded orders_clean and customer_summary into Power BI, connected them by customer ID, wrote the measures in DAX, and built four pages:
1. Executive overview: key figures, order value by category, the rating distribution and a platform comparison
2. Delivery and complaints: delivery time bands, complaint themes and whether delay changes ratings
3. Customers and refund risk: refund value by order size, a customer segment matrix and a retention watch-list of the top 10 unhappy high-value customers
4. About this report: the data, method and limitations

I checked the dashboard figures against my SQL and Excel results. The dashboard is saved as a PDF export.

### Stage 6: Insights and the business report
I wrote a findings register in Excel, where every finding has its numbers, source and caveat, and a recommendations sheet. I used those to write a business report. I then fact-checked the report against the register, and again in a fresh AI chat, and fixed what I found.

### Stage 7: Publishing
I cleaned the folder, removed personal paths from the scripts, and published the project here on GitHub.

## What is in the repository

Folder 01_data
- sample_100_rows.csv: a 100-row sample of the dataset

Folder 02_sql (run in this order)
- 01_create_database.sql
- 02_create_tables.sql
- 03_load_data.sql
- 04_first_reconciliation.sql
- 05_feedback_list.sql
- 06_create_orders_clean.sql
- 07_headline_kpis.sql
- 08_platform_comparison.sql
- 09_category_comparison.sql
- 10_delivery_performance.sql
- 11_complaint_root_causes.sql
- 12_refund_exposure.sql
- 13_customer_summary_view.sql
- 14_customer_segments.sql
- 15_delay_vs_satisfaction.sql

Folder 03_excel
- quickcommerce_analysis.xlsx: the workbook with Raw_Data, Profiling, Data_Dictionary, DQ_Log, Pivot_Platform, Pivot_Category, Theme_Map, Reconciliation, Findings_Register, Recommendations and AI_Usage_Log

Folder 04_powerbi
- the dashboard exported as a PDF, plus page screenshots

Folder 05_docs
- the business report (PDF and Word)
- AI_Usage_Log: the log of how I used AI and how I checked it

## Key findings

1. Ratings are polarised, not average. 45.82% of orders are rated 1 to 2 stars and 46.48% are rated 4 to 5 stars. The average of 3.24 hides two opposite groups.
2. The three platforms perform almost identically. Average delivery time is 29.47 to 29.63 minutes and the refund rate is 45.71% to 45.93%.
3. Order value is concentrated in two categories. Personal Care and Grocery make up 53.45% of order value from 33.27% of orders.
4. Order accuracy is the largest complaint theme at 33.77% of 45,819 unhappy orders. This theme combines two complaint messages (wrong item and missing items), so I treat it with care.
5. Refund money is concentrated in larger orders. Refund requests cover about 2.71 crore rupees (45.91% of order value). The refund rate is flat across order sizes, but High and Premium orders are 29.65% of orders and 56.17% of refund value.
6. A group of valuable customers is unhappy. 572 customers in the top 25% by spend have an average rating below 3, and they hold about 55.6 lakh rupees of spend.
7. Delay does not change satisfaction in this data. The average rating is 3.24 for on-time orders and 3.23 for delayed ones.

## Recommendations

1. Reduce order-accuracy complaints, starting by checking whether picking and packing is the source.
2. Review refund requests for High and Premium orders first, because each one is worth more.
3. Contact the 572 unhappy top-spend customers.
4. Fix the data foundations: capture real timestamps, promised delivery time and refund status.
5. Do not invest in platform-specific fixes or speed-ups on this evidence alone.
6. Investigate how refund is recorded, because a 46% refund rate is unrealistic.

## Limitations

- The order date column is corrupted at the source, so there is no trend or peak-hour analysis.
- The data looks synthetic. Platforms and categories perform alike, refund requests follow ratings exactly, and feedback text does not match delivery times. The patterns may not reflect a real business.
- "Delayed" means over 40 minutes, because no promised delivery time is recorded.
- Refund figures are refunds requested, not confirmed losses.
- "At risk" customers are defined by ratings only, because there are no usable dates to measure churn.

## How I used AI, and how I checked it

I used AI to help write SQL and DAX, review my data dictionary, draft the report and fact-check it. Every use is recorded in the AI usage log, with the prompt, the output, how I verified it, any problem I found and what I changed.

AI made mistakes, and I caught them by checking against my own results:
- A SQL script had blank lines inside a CREATE TABLE statement, so the table was never created. I saw that the table did not exist and rewrote the script.
- A drafted finding gave 25.4% as the share of top-tier spend. I re-ran the SQL: the spend share is 25.3%, and 25.4% was the share of customers.
- Two Power BI share measures showed 100% after I changed a chart axis. I rewrote them to clear filters on the whole table.

How I verified AI output: I compared every number with SQL results, with an Excel reconciliation, or with the findings register. I also asked AI in a fresh chat to fact-check the report. It raised 14 flags, none of which was a wrong number, but several pieces of wording overclaimed, and I fixed them.

Only public data was used with AI tools.

## How to run it yourself

1. Install MySQL and create the database with 01_create_database.sql.
2. Create the tables with 02_create_tables.sql.
3. Download the full CSV from Kaggle, edit the file path in 03_load_data.sql, and run it.
4. Run 06_create_orders_clean.sql, then the analysis scripts 07 to 15 in order.

## Skills this project shows

SQL (CTEs, window functions, views), Excel (pivot tables, lookups, reconciliation), Power BI (data model, DAX, report design), data quality auditing, business storytelling, and checking AI output critically.

## About me

Shivani Sunarkari | https://www.linkedin.com/in/shivani-sunarkari-873266252/
