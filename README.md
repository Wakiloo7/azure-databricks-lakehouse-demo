# Azure Databricks Medallion Lakehouse Portfolio Project

This is my customized portfolio implementation of a medallion lakehouse pipeline using Azure Databricks, PySpark, Delta Lake concepts, and layered data engineering design.

The project demonstrates how raw e-commerce data can be organized into Bronze, Silver, and Gold layers for analytics-ready reporting.


## Architecture

The project follows the medallion architecture:

- **Bronze:** raw ingested data
- **Silver:** cleaned, validated, and standardized data
- **Gold:** business-ready analytical datasets

## Data Quality Rules

The customized version includes checks for:

- Duplicate customer records
- Orders without matching customers
- Invalid or missing order amounts
- Missing product references

## Credits

I used it as a learning reference and customized the structure, documentation, and validation logic for my own Azure Databricks portfolio project.