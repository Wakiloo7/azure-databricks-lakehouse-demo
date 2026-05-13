\# Data Modeling Design



This document explains the data modeling approach used in the Azure Databricks Medallion Lakehouse project.



The project uses customer, order, product, and region data to demonstrate how operational data can be transformed into analytics-ready data products.



These are portfolio design examples and can be extended for production use.



\---



\## 1. Modeling Objective



The objective of the Gold layer is to prepare business-ready data for reporting, BI, and analytics.



The Gold layer should be:



\- Easy for analysts to query

\- Optimized for reporting

\- Business-friendly

\- Reusable across dashboards and downstream use cases

\- Consistent with defined business rules



\---



\## 2. Dimensional Modeling



Dimensional modeling is suitable for analytics and reporting because it organizes data into fact and dimension tables.



In this project, the Gold layer can follow a star-schema-style design.



\---



\## 3. Fact Table



\### FactOrders



The orders table acts as the central fact table because it contains measurable business events.



Example measures:



\- Quantity

\- Unit price

\- Total amount

\- Order count

\- Sales amount



Example keys:



\- order\_id

\- customer\_id

\- product\_id

\- region\_id

\- order\_date



Example structure:



```text

FactOrders

├── order\_id

├── customer\_id

├── product\_id

├── region\_id

├── order\_date

├── quantity

├── unit\_price

└── total\_amount

```



\---



\## 4. Dimension Tables



Dimension tables provide descriptive context for the fact table.



\### DimCustomer



```text

DimCustomer

├── customer\_id

├── customer\_name

├── customer\_segment

├── region\_id

├── created\_date

└── updated\_date

```



\### DimProduct



```text

DimProduct

├── product\_id

├── product\_name

├── product\_category

├── product\_price

├── created\_date

└── updated\_date

```



\### DimRegion



```text

DimRegion

├── region\_id

├── region\_name

├── country

└── market

```



\### DimDate



```text

DimDate

├── date\_key

├── date

├── year

├── month

├── quarter

├── week

└── day\_of\_week

```



\---



\## 5. Star Schema Design



The Gold layer can be represented as:



```text

&#x20;            DimCustomer

&#x20;                 |

DimProduct -- FactOrders -- DimRegion

&#x20;                 |

&#x20;              DimDate

```



This model supports analytical questions such as:



\- Total sales by region

\- Total orders by customer

\- Sales by product category

\- Average order value by customer segment

\- Monthly sales trend



\---



\## 6. Entity-Relationship Model



An ER model represents operational relationships between entities.



Example relationships:



```text

Customer 1 ──── \* Orders

Product  1 ──── \* Orders

Region   1 ──── \* Customers

Region   1 ──── \* Orders

```



ER modeling is useful for understanding source-system relationships before transforming the data into analytical models.



\---



\## 7. Data Vault Extension



Data Vault can be used when the priority is auditability, scalability, source-system integration, and historical tracking.



A possible Data Vault design for this project:



\### Hubs



```text

HubCustomer

├── customer\_hash\_key

├── customer\_id

├── load\_timestamp

└── source\_system

```



```text

HubProduct

├── product\_hash\_key

├── product\_id

├── load\_timestamp

└── source\_system

```



```text

HubOrder

├── order\_hash\_key

├── order\_id

├── load\_timestamp

└── source\_system

```



\### Links



```text

LinkOrderCustomerProduct

├── link\_hash\_key

├── order\_hash\_key

├── customer\_hash\_key

├── product\_hash\_key

├── load\_timestamp

└── source\_system

```



\### Satellites



```text

SatCustomerDetails

├── customer\_hash\_key

├── customer\_name

├── customer\_segment

├── region\_id

├── effective\_timestamp

├── load\_timestamp

└── source\_system

```



```text

SatProductDetails

├── product\_hash\_key

├── product\_name

├── product\_category

├── product\_price

├── effective\_timestamp

├── load\_timestamp

└── source\_system

```



\---



\## 8. When to Use Each Model



\### Dimensional Model



Use when the main goal is:



\- BI reporting

\- Dashboards

\- Aggregations

\- Business-friendly queries

\- Fast analytical access



\### Data Vault



Use when the main goal is:



\- Enterprise integration

\- Historical tracking

\- Multiple source systems

\- Auditability

\- Long-term scalability



\### ER Model



Use when the main goal is:



\- Operational system design

\- Source-system understanding

\- Normalized relational design



\---



\## 9. Modeling Approach in This Project



This portfolio project mainly demonstrates a dimensional-style Gold layer.



The source data is processed through:



```text

Raw source data

&#x20;       ↓

Bronze layer

&#x20;       ↓

Silver cleaned and validated data

&#x20;       ↓

Gold dimensional analytical outputs

```



In production, the same project could be extended with Data Vault modeling if multiple source systems, full historical tracking, and auditability were required.



\---



\## 10. Interview Explanation



This project uses a dimensional modeling approach in the Gold layer. Orders act as the fact table because they contain measurable business events such as quantity and amount. Customers, products, regions, and dates act as dimensions because they provide descriptive context for reporting.



I would use Data Vault if the requirement was enterprise-level historical tracking and integration across multiple systems.

