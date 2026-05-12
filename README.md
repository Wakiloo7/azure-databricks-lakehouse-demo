# Azure Databricks Medallion Lakehouse Portfolio Project

This is my customized portfolio implementation of a Medallion Lakehouse pipeline using **Azure Databricks concepts**, **PySpark**, **Delta Lake-style architecture**, **data quality checks**, **configuration-driven design**, and an optional **Azure Synapse serving-layer extension**.

The project demonstrates how raw e-commerce-style operational data can be organized into **Bronze**, **Silver**, and **Gold** layers to create analytics-ready datasets for reporting, BI, and downstream data consumers.

The main dataset contains:

- Customers
- Orders
- Products
- Regions

---

## Project Objective

The objective of this project is to demonstrate a practical lakehouse-style data engineering workflow:

1. Ingest raw source data.
2. Organize the data into Bronze, Silver, and Gold layers.
3. Clean, standardize, and validate the data.
4. Apply data quality checks.
5. Prepare curated business-ready outputs.
6. Document the pipeline structure and validation logic.
7. Extend the design with a Synapse SQL serving layer for BI and reporting access.

This project is designed as a portfolio project to demonstrate modern data engineering architecture, layered lakehouse design, PySpark transformations, data quality validation, reusable configuration, and SQL-based analytics serving.

---

## Architecture

The project follows the Medallion architecture:

```text
Source Parquet Files
        ↓
Bronze Layer
        ↓
Silver Layer
        ↓
Gold Layer
        ↓
Synapse SQL Serving Layer
        ↓
BI / Reporting / Analytics
```

### Bronze Layer

The Bronze layer stores raw ingested data with minimal transformation.

Purpose:

- Preserve the original source data.
- Provide a replayable raw layer.
- Support traceability and debugging.
- Keep source-level data available for reprocessing.

### Silver Layer

The Silver layer applies cleaning, validation, standardization, and data quality checks.

Typical operations:

- Remove duplicate records.
- Standardize column names and data types.
- Validate required fields.
- Handle invalid or missing references.
- Prepare trusted reusable datasets.

### Gold Layer

The Gold layer produces curated analytics-ready datasets.

Typical outputs:

- Customer analytics tables
- Product analytics tables
- Order analytics tables
- Sales summaries
- Region-level reporting outputs

The Gold layer is designed for BI dashboards, reporting, analytics, and downstream business users.

---

## Technology Stack

| Category | Tools / Concepts |
|---|---|
| Processing | PySpark |
| Platform | Azure Databricks concepts |
| Storage Format | Parquet / Delta Lake-style design |
| Architecture | Bronze, Silver, Gold Medallion Architecture |
| Data Quality | SQL checks, Python tests |
| Configuration | JSON configuration |
| Analytics Serving | Azure Synapse Serverless SQL extension |
| CI/CD Example | GitHub Actions workflow example |
| Documentation | README, architecture diagram, screenshots |

---

## Project Structure

```text
azure-databricks-medallion-pipeline/

├── .github/
│   └── workflows/
│       └── deploy-synapse-sql.yml
│
├── config/
│   └── pipeline_config.json
│
├── docs/
│   └── MY_CHANGES.md
│
├── notebooks/
│   ├── Bronze_Layer.ipynb
│   ├── Silver_Customers.ipynb
│   ├── Silver_Products.ipynb
│   ├── Silver_Regions.ipynb
│   ├── Gold_Customers.ipynb
│   ├── Gold Products.ipynb
│   ├── Gold Orders.ipynb
│   └── Parameters.ipynb
│
├── screenshots/
│   ├── project-1-1.png
│   ├── project-1-2.png
│   ├── project-1-3.png
│   ├── project-1-4.png
│   ├── project-1-5.png
│   ├── project-1-6.png
│   └── project-1-7.png
│
├── source_data/
│   ├── customer_first.parquet
│   ├── customers_second.parquet
│   ├── orders_first.parquet
│   ├── orders_second.parquet
│   ├── products_first.parquet
│   ├── products_second.parquet
│   └── regions.parquet
│
├── sql/
│   └── data_quality_checks.sql
│
├── synapse/
│   ├── README.md
│   ├── sql/
│   │   ├── 01_create_external_data_source.sql
│   │   ├── 02_create_gold_external_views.sql
│   │   └── 03_create_analytics_views.sql
│   └── deploy/
│       ├── deploy_synapse_sql.ps1
│       └── parameters.example.json
│
├── tests/
│   └── test_data_quality.py
│
├── architecture_design.png
├── README.md
└── .gitignore
```

---

## Source Data

The project uses sample source data stored in Parquet format.

```text
source_data/
├── customer_first.parquet
├── customers_second.parquet
├── orders_first.parquet
├── orders_second.parquet
├── products_first.parquet
├── products_second.parquet
└── regions.parquet
```

The source data represents operational e-commerce-style entities:

- Customer data
- Order data
- Product data
- Region data

The `first` and `second` files simulate multiple source batches and support demonstration of layered ingestion and transformation logic.

---

## Pipeline Workflow

### 1. Bronze Layer

Notebook:

```text
notebooks/Bronze_Layer.ipynb
```

The Bronze layer loads raw source Parquet files and organizes them into the first lakehouse layer.

Key purpose:

- Ingest raw customers, orders, products, and regions.
- Preserve source data structure.
- Provide a raw foundation for downstream transformations.

Interview explanation:

```text
Bronze is the raw landing layer. I keep the data close to the original source so that if any issue appears in Silver or Gold, I can trace it back and reprocess from the raw layer.
```

---

### 2. Silver Layer

Notebooks:

```text
notebooks/Silver_Customers.ipynb
notebooks/Silver_Products.ipynb
notebooks/Silver_Regions.ipynb
```

The Silver layer cleans and standardizes the data.

Typical checks and transformations:

- Remove duplicate customers.
- Validate required customer IDs.
- Standardize product and region fields.
- Check missing or invalid references.
- Cast columns to the correct data types.
- Prepare trusted reusable datasets.

Interview explanation:

```text
Silver is the trusted layer. I clean, validate, deduplicate, and standardize the raw data so that downstream Gold tables are built from reliable inputs.
```

---

### 3. Gold Layer

Notebooks:

```text
notebooks/Gold_Customers.ipynb
notebooks/Gold Products.ipynb
notebooks/Gold Orders.ipynb
```

The Gold layer prepares business-ready analytical outputs.

Possible Gold outputs:

- Customer-level analytical tables
- Product-level reporting tables
- Order-level business tables
- Sales summaries
- Region-based aggregations

Interview explanation:

```text
Gold contains curated business-ready tables. These outputs are designed for BI, reporting, and analytics users.
```

---

## Data Quality Rules

The customized version includes data quality checks for:

- Duplicate customer records
- Orders without matching customers
- Invalid or missing order amounts
- Missing product references
- Null business keys
- Referential integrity between orders, customers, products, and regions
- Invalid numeric values
- Unexpected missing values in important columns

Data quality logic is included in:

```text
sql/data_quality_checks.sql
tests/test_data_quality.py
```

---

## Data Quality Examples

### Duplicate Customer Check

Purpose:

```text
Detect customer records where the same customer_id appears more than once.
```

### Missing Customer Reference Check

Purpose:

```text
Detect orders where customer_id does not exist in the customer table.
```

### Invalid Order Amount Check

Purpose:

```text
Detect orders with null, zero, or negative amount values where business rules require valid positive amounts.
```

### Missing Product Reference Check

Purpose:

```text
Detect orders where product_id does not exist in the product table.
```

---

## Testing

The project includes automated validation logic under:

```text
tests/test_data_quality.py
```

The goal of the test layer is to demonstrate how data engineering pipelines can be validated before publishing curated outputs.

Typical test categories:

- Non-null checks
- Duplicate checks
- Referential integrity checks
- Valid numeric value checks
- Expected column checks
- Data consistency checks

---

## Configuration

The project includes configuration under:

```text
config/pipeline_config.json
```

The purpose of the configuration file is to avoid hardcoding pipeline parameters and make the project easier to maintain.

Configuration-driven design supports:

- Environment-specific paths
- Reusable parameters
- Easier migration from development to production
- Cleaner notebooks
- Better maintainability

---

## Azure Synapse Serving Layer Extension

This project includes an Azure Synapse serving-layer extension under:

```text
synapse/
```

The Synapse extension demonstrates how curated Gold-layer outputs from the Databricks Medallion Lakehouse can be exposed through **Azure Synapse Serverless SQL views** for BI, reporting, and downstream analytics.

The design pattern is:

```text
Databricks Bronze/Silver/Gold pipeline
        ↓
Gold-layer data in ADLS-compatible storage
        ↓
Synapse Serverless SQL external views
        ↓
Power BI / Reporting / Analytics consumers
```

Included Synapse components:

```text
synapse/
├── README.md
├── sql/
│   ├── 01_create_external_data_source.sql
│   ├── 02_create_gold_external_views.sql
│   └── 03_create_analytics_views.sql
└── deploy/
    ├── deploy_synapse_sql.ps1
    └── parameters.example.json
```

---

## Synapse SQL Scripts

### 01_create_external_data_source.sql

Creates the external data source and Parquet file format required to query curated Gold-layer files from ADLS-compatible storage.

### 02_create_gold_external_views.sql

Creates Synapse views over Gold-layer outputs:

- Gold customers
- Gold products
- Gold orders
- Gold regions

### 03_create_analytics_views.sql

Creates business-ready analytical views:

- Sales by region
- Customer sales summary
- Product sales summary

---

## Synapse Deployment Script

The deployment script is located at:

```text
synapse/deploy/deploy_synapse_sql.ps1
```

It uses `sqlcmd` to execute Synapse SQL scripts against a Synapse SQL endpoint.

Example deployment command:

```powershell
.\synapse\deploy\deploy_synapse_sql.ps1 `
  -SqlEndpoint "your-workspace-ondemand.sql.azuresynapse.net" `
  -Database "lakehouse_gold_serving" `
  -SqlUser "your-user" `
  -SqlPassword "your-password"
```

This is a deployable portfolio extension. It requires a real Azure Synapse workspace, ADLS storage account, configured credentials, and valid SQL endpoint to run in a live Azure environment.

---

## CI/CD Example

A GitHub Actions workflow example is included at:

```text
.github/workflows/deploy-synapse-sql.yml
```

The workflow demonstrates how Synapse SQL scripts could be deployed automatically when SQL or deployment files are changed.

Expected GitHub secrets:

```text
SYNAPSE_SQL_ENDPOINT
SYNAPSE_DATABASE
SYNAPSE_SQL_USER
SYNAPSE_SQL_PASSWORD
```

The CI/CD example demonstrates:

- Git-based deployment structure
- SQL script automation
- Environment-specific secret handling
- Repeatable deployment pattern for Synapse SQL serving layer

---

## Architecture Diagram

The project includes an architecture diagram:

```text
architecture_design.png
```

This diagram visually represents the Medallion Lakehouse flow from raw source data through Bronze, Silver, and Gold layers.

---

## Screenshots

The `screenshots/` folder contains evidence of the implementation and outputs.

```text
screenshots/
├── project-1-1.png
├── project-1-2.png
├── project-1-3.png
├── project-1-4.png
├── project-1-5.png
├── project-1-6.png
└── project-1-7.png
```

These screenshots help reviewers understand the pipeline execution and project structure without needing to run the full environment.

---

## How to Explain This Project in an Interview

Short explanation:

```text
This is my Azure Databricks Medallion Lakehouse portfolio project. It uses customer, order, product, and region data to demonstrate Bronze, Silver, and Gold architecture. Bronze stores raw source data, Silver applies cleaning, validation, and standardization, and Gold creates analytics-ready outputs for reporting. I also added SQL data quality checks, Python tests, configuration, documentation, screenshots, and a Synapse serving-layer extension for querying Gold outputs through Synapse Serverless SQL views.
```

Technical explanation:

```text
The project uses PySpark notebooks to process source Parquet files through Medallion layers. The Bronze layer keeps raw data, the Silver layer validates and standardizes it, and the Gold layer prepares curated business outputs. Data quality checks detect duplicates, missing references, invalid order amounts, and referential integrity issues. I also added a Synapse SQL extension showing how Gold-layer outputs can be exposed as SQL views for BI and analytics.
```

If asked whether this is production deployed:

```text
This is a portfolio implementation and deployable design extension, not a full production deployment. The project structure demonstrates how the pipeline and Synapse serving layer would be organized, and the deployment scripts can be adapted to a real Azure environment with the correct workspace, storage, and credentials.
```

---

## How This Project Aligns With Data Engineering Roles

This project demonstrates experience with:

- Azure Databricks concepts
- Medallion Lakehouse architecture
- PySpark transformations
- Bronze, Silver, and Gold data layers
- Data quality checks
- Data validation
- Data modelling for analytics
- SQL-based validation
- Testing data pipelines
- Configuration-driven pipeline design
- Documentation
- Synapse SQL serving-layer design
- CI/CD deployment structure
- BI/reporting consumption patterns

---

## Production Improvements

In a production environment, this project could be extended with:

1. **Databricks Autoloader**  
   For scalable incremental file ingestion into the Bronze layer.

2. **Delta Lake Tables**  
   For ACID transactions, schema enforcement, time travel, and reliable lakehouse storage.

3. **Databricks Workflows / Jobs**  
   For scheduled execution of Bronze, Silver, and Gold transformations.

4. **Unity Catalog**  
   For centralized governance, permissions, lineage, and table management.

5. **Microsoft Purview**  
   For enterprise data cataloging, classification, and lineage across Azure services.

6. **Azure Data Factory**  
   For orchestration and ingestion from SAP, Salesforce, APIs, databases, and external systems.

7. **Azure DevOps CI/CD**  
   For automated testing, validation, and deployment across dev, test, and production.

8. **Terraform**  
   For infrastructure-as-code deployment of storage, Databricks, Synapse, and access policies.

9. **Monitoring and Alerting**  
   For pipeline failures, freshness issues, data quality failures, and SLA tracking.

10. **Data Quality Frameworks**  
    Such as Great Expectations or Deequ for reusable and configurable validation rules.

---

## Important Clarification

This project demonstrates a portfolio-level implementation of Azure Databricks Medallion architecture and an Azure Synapse serving-layer deployment structure.

It should be described as:

```text
Azure Databricks Medallion Lakehouse project with a Synapse serving-layer extension.
```

It should not be described as:

```text
A fully deployed production Synapse pipeline.
```

---

## Key Skills Demonstrated

- Data Engineering
- Azure Databricks concepts
- PySpark development
- Medallion Lakehouse architecture
- Bronze/Silver/Gold design
- Data quality validation
- SQL validation checks
- Python-based testing
- Data modelling for analytics
- Configuration-driven design
- Documentation
- Synapse Serverless SQL design
- BI/reporting serving layer
- CI/CD deployment structure
- Cloud data architecture thinking

---

## Author

**Md Wakil Ahmad**

GitHub: `https://github.com/Wakiloo7`  
LinkedIn: `https://www.linkedin.com/in/md-wakil-ahmad`