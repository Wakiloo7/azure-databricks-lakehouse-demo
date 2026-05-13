\# Source Integration Strategy



This document explains how the Medallion Lakehouse project can be extended to ingest structured, semi-structured, and unstructured data from enterprise systems such as SAP, Salesforce, APIs, and external sources.



These are design examples only. They are not deployed production integrations.



\---



\## 1. Structured Data Sources



Structured data has a fixed schema and is usually stored in relational systems, enterprise applications, or tabular exports.



Examples:



\- SAP order tables

\- Salesforce account/customer objects

\- SQL databases

\- ERP exports

\- CRM exports

\- CSV or Parquet business files



Example ingestion pattern:



```text

SAP / Salesforce / SQL Database

&#x20;       ↓

Azure Data Factory Linked Service

&#x20;       ↓

ADF Copy Activity

&#x20;       ↓

ADLS Bronze structured landing zone

&#x20;       ↓

Databricks Silver validation and standardization

&#x20;       ↓

Gold analytical tables

```



Example Bronze folder structure:



```text

/bronze/sap/orders/load\_date=YYYY-MM-DD/

/bronze/salesforce/customers/load\_date=YYYY-MM-DD/

```



In this project, the ADF examples demonstrate this pattern for:



```text

adf/pipeline\_ingest\_orders\_example.json

adf/pipeline\_ingest\_customers\_example.json

```



\---



\## 2. Semi-Structured Data Sources



Semi-structured data has a flexible schema and usually comes in JSON, XML, Avro, or nested API response formats.



Examples:



\- Salesforce API JSON responses

\- External REST API payloads

\- Event data

\- Application logs

\- Webhook payloads

\- XML exports from enterprise systems



Example ingestion pattern:



```text

External API / JSON / XML / Event Payloads

&#x20;       ↓

Azure Data Factory or Event Hub

&#x20;       ↓

ADLS Bronze semi-structured landing zone

&#x20;       ↓

Databricks schema inference / schema validation

&#x20;       ↓

Flatten nested fields in Silver

&#x20;       ↓

Gold analytical outputs

```



Example Bronze folder structure:



```text

/bronze/api/customer\_events/load\_date=YYYY-MM-DD/

/bronze/salesforce/json\_accounts/load\_date=YYYY-MM-DD/

/bronze/external/xml\_exports/load\_date=YYYY-MM-DD/

```



Silver processing examples:



\- Parse JSON or XML payloads.

\- Flatten nested structures.

\- Enforce expected schema.

\- Add ingestion metadata.

\- Route malformed records to quarantine.

\- Version schema changes.



\---



\## 3. Unstructured Data Sources



Unstructured data does not have a fixed tabular schema.



Examples:



\- PDF documents

\- Text files

\- Customer support notes

\- Email bodies

\- Call center transcripts

\- Free-text comments

\- Attachments from external systems



Example ingestion pattern:



```text

PDF / Text / Notes / Emails / Attachments

&#x20;       ↓

ADF file ingestion or API ingestion

&#x20;       ↓

ADLS Bronze raw document landing zone

&#x20;       ↓

Databricks text extraction / metadata extraction

&#x20;       ↓

Silver structured metadata table

&#x20;       ↓

Gold search, analytics, or reporting outputs

```



Example Bronze folder structure:



```text

/bronze/documents/customer\_notes/load\_date=YYYY-MM-DD/

/bronze/support/tickets/load\_date=YYYY-MM-DD/

/bronze/emails/raw/load\_date=YYYY-MM-DD/

```



Silver processing examples:



\- Extract text from documents.

\- Extract metadata such as file name, source system, created date, customer ID, and document type.

\- Standardize document categories.

\- Validate required metadata.

\- Store cleaned metadata in structured Silver tables.

\- Store raw files separately for audit and reprocessing.



\---



\## 4. Ingestion Metadata



For all source types, Bronze data should include ingestion metadata.



Recommended metadata columns:



```text

source\_system

source\_entity

source\_file

source\_format

ingestion\_timestamp

pipeline\_run\_id

load\_date

record\_hash

```



Purpose:



\- Improve traceability.

\- Support debugging.

\- Enable reprocessing.

\- Support lineage tracking.

\- Detect duplicates or changed records.



\---



\## 5. Data Quality Handling



Data quality rules should be applied mainly in the Silver layer.



\### Structured Data



Examples:



\- Required business keys must not be null.

\- Duplicate keys should be detected.

\- Referential integrity should be checked.

\- Numeric values should be within valid ranges.



\### Semi-Structured Data



Examples:



\- JSON or XML must be parseable.

\- Required fields must exist.

\- Unexpected schema changes should be detected.

\- Malformed payloads should be quarantined.



\### Unstructured Data



Examples:



\- Required metadata must exist.

\- File format must be supported.

\- Empty documents should be flagged.

\- Failed text extraction should be quarantined.



Invalid records should be written to a quarantine location with:



```text

error\_reason

source\_system

source\_file

pipeline\_run\_id

ingestion\_timestamp

raw\_payload\_reference

```



\---



\## 6. Role of Azure Data Factory



Azure Data Factory would be used for:



\- Connecting to SAP, Salesforce, databases, APIs, and file sources.

\- Running scheduled or event-based ingestion.

\- Copying raw data into ADLS Bronze.

\- Passing parameters such as source system, entity, and load date.

\- Triggering Databricks notebooks or jobs after ingestion.

\- Managing retries and failure alerts.



\---



\## 7. Role of Azure Databricks



Azure Databricks would be used for:



\- Reading Bronze data from ADLS.

\- Cleaning and standardizing structured data.

\- Parsing and flattening semi-structured JSON/XML data.

\- Extracting metadata from unstructured files.

\- Applying data quality rules.

\- Producing trusted Silver tables.

\- Creating curated Gold data products.



\---



\## 8. Production Considerations



In production, this design should include:



\- Managed identities for secure access.

\- Azure Key Vault for secrets.

\- RBAC and least-privilege permissions.

\- Schema drift detection.

\- Quarantine tables or folders.

\- Monitoring and alerting.

\- Data lineage through Purview or Unity Catalog.

\- CI/CD deployment for ADF, Databricks, and Synapse artifacts.

\- Clear ownership for each source and data product.



\---



\## 9. Interview Explanation



This project currently uses structured Parquet source files. I added ADF examples for SAP and Salesforce ingestion, and this source integration strategy explains how the design can support structured, semi-structured, and unstructured enterprise data.



In production, ADF would land raw data into ADLS Bronze, and Databricks would process it through Silver and Gold layers depending on the source type and data quality rules.

