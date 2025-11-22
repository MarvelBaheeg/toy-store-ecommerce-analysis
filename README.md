# End-to-End Toy Store E-commerce Analysis using SQL + Power BI
This Project analyzes an E-Commerce Toy Store dataset from [Maven Analytics] (https://mavenanalytics.io/data-playground/toy-store-e-commerce-database). 
It designed to help businesses understand purchaseing pattern, Customer behaviour, and website peformance.

### Tools Used:
- SQL Server: Transformation and Analysis 
- Power BI: Data modeling + Dashboard
- Github: Project documentation & version control

### Dataset Tables:
The database contains 6 relational tables:
| Table                  | Description                                          |
| ---------------------- | ---------------------------------------------------- |
| **orders**             | Order-level details                                  |
| **order_items**        | Item-level details for each product in an order      |
| **order_item_refunds** | Refund amount per item                               |
| **products**           | Product catalog                                      |
| **website_sessions**   | User sessions including device, UTM source, campaign |
| **website_pageviews**  | Pages visited per session                            |

### Key Business Questions Answered:
- What are the Total Revenue and the Average Order Value (AOV), both overall and broken down by year?
- Which product generates the highest sales?
- What is the refund rate for each product?
- What is the customer conversion rate?
- Which marketing channels bring the most customers?
- Which Compaign brings in the most customers? 
- What devices (mobile/desktop) convert better?
- Which products are the customer’s primary choices and which are not?

### Key Insights:
- Total Revenue: 1.94M
- Average Order Value (AOV): 59.99
- Total Orders: 32K
- Refund Rate: 4.40%
- Best-selling Product: The Original Mr. Fuzzy
- Top Traffic Campaign: "nonbrand" = 23K
- Top Traffic Platform: "gsearch" = 21K
- Conversion Rate: 6.83%
- Device Performance: Desktop (86.05% - 28K), Mobile (13.95% - 5K)
- Repeated Visitors: about 6K
