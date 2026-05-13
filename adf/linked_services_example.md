\# Azure Data Factory Linked Services Design Example



This document describes the linked services that would be used in a production Azure Data Factory ingestion layer for this Medallion Lakehouse project.



These are design examples only. They are not deployed production linked services.



\---



\## 1. Salesforce Linked Service



\### Purpose



Connect Azure Data Factory to Salesforce or a CRM system to extract customer/account data.



\### Example Usage



```text

Source: Salesforce Account / Customer objects

Target: ADLS Bronze customers folder

Pipeline: pipeline\_ingest\_customers\_example.json

```



\### Security



\- Use OAuth or secure credential integration.

\- Store secrets in Azure Key Vault.

\- Avoid hardcoding credentials in ADF pipeline JSON.



\---



\## 2. SAP Linked Service



\### Purpose



Connect Azure Data Factory to SAP or ERP systems to extract order/transaction data.



\### Example Usage



```text

Source: SAP Orders table or ERP order extract

Target: ADLS Bronze orders folder

Pipeline: pipeline\_ingest\_orders\_example.json

```



\### Security



\- Use managed identity or secure credential storage where possible.

\- Store credentials in Azure Key Vault.

\- Apply least-privilege access.



\---



\## 3. ADLS Gen2 Linked Service



\### Purpose



Connect Azure Data Factory to Azure Data Lake Storage Gen2 for landing raw Bronze data.



\### Example Folder Structure



```text

adls://lakehouse/bronze/salesforce/customers/load\_date=YYYY-MM-DD/

adls://lakehouse/bronze/sap/orders/load\_date=YYYY-MM-DD/

```



\### Recommended Pattern



\- Partition data by source system, entity, and load date.

\- Store raw data in Parquet where possible.

\- Add ingestion metadata such as `source\_system`, `source\_file`, `load\_timestamp`, and `pipeline\_run\_id`.



\---



\## 4. Azure Databricks Linked Service



\### Purpose



Trigger Databricks notebooks or jobs after ADF ingestion completes.



\### Example Usage



```text

ADF Copy Activity lands data in ADLS Bronze.

ADF Databricks Notebook Activity triggers Bronze/Silver processing.

```



\### Production Recommendation



\- Use job clusters where possible.

\- Pass parameters from ADF into Databricks notebooks.

\- Use environment-specific configuration for dev, test, and prod.



\---



\## 5. Azure Key Vault Linked Service



\### Purpose



Store and retrieve secrets securely for ADF pipelines.



\### Examples



\- Salesforce client secret

\- SAP credentials

\- Databricks token

\- Storage account secrets if managed identity is not used



\### Production Recommendation



\- Prefer managed identity where possible.

\- Use Key Vault for secrets.

\- Avoid hardcoded passwords, tokens, and connection strings.

