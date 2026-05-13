\# Azure Data Factory Ingestion Design Examples



This folder contains Azure Data Factory ingestion design examples for extending the Azure Databricks Medallion Lakehouse project.



These are design examples only. They are not deployed production ADF pipelines.



\---



\## Purpose



In a production Azure data platform, Azure Data Factory can be used to ingest structured data from systems such as Salesforce, SAP, databases, APIs, or external file drops into an ADLS Bronze landing zone.



After ingestion, Azure Databricks can process the data through Bronze, Silver, and Gold layers.



\---



\## Example Architecture



```text

SAP / Salesforce / External Systems

&#x20;       ↓

Azure Data Factory Linked Services

&#x20;       ↓

ADF Pipelines and Copy Activities

&#x20;       ↓

ADLS Bronze Landing Zone

&#x20;       ↓

Azure Databricks Bronze / Silver / Gold Pipeline

&#x20;       ↓

Azure Synapse SQL Serving Layer

&#x20;       ↓

BI / Reporting / Analytics

```



\---



\## Included Files



```text

adf/

├── README.md

├── linked\_services\_example.md

├── pipeline\_ingest\_customers\_example.json

└── pipeline\_ingest\_orders\_example.json

```



\---



\## Pipeline Examples



\### pipeline\_ingest\_customers\_example.json



This pipeline design demonstrates customer data ingestion from Salesforce or a CRM system into an ADLS Bronze landing zone.



Main steps:



\- Read customer/account data from Salesforce.

\- Apply an incremental filter using `LastModifiedDate`.

\- Write output to ADLS Bronze in Parquet format.

\- Trigger a Databricks Bronze notebook after successful ingestion.



\### pipeline\_ingest\_orders\_example.json



This pipeline design demonstrates order data ingestion from SAP or an ERP system into an ADLS Bronze landing zone.



Main steps:



\- Read order/transaction data from SAP.

\- Apply an incremental filter using `LAST\_MODIFIED\_DATE`.

\- Write output to ADLS Bronze in Parquet format.

\- Trigger a Databricks Bronze notebook after successful ingestion.



\---



\## Linked Services



The linked services design is documented in:



```text

adf/linked\_services\_example.md

```



It includes example connection patterns for:



\- Salesforce

\- SAP / ERP systems

\- ADLS Gen2

\- Azure Databricks

\- Azure Key Vault



\---



\## Security Pattern



The ADF design follows these security principles:



\- Use managed identity where possible.

\- Store secrets in Azure Key Vault.

\- Avoid hardcoded credentials in pipeline JSON.

\- Apply least-privilege access.

\- Separate source, storage, and compute permissions.

\- Use environment-specific configuration for dev, test, and production.



\---



\## Production Extension



In a real Azure environment, these ADF templates would be connected to actual linked services, datasets, triggers, credentials, and ADLS paths.



They would also be integrated with CI/CD deployment using Azure DevOps or GitHub Actions.

