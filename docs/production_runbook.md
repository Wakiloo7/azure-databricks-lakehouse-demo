\# Production Runbook



This document describes how common production issues could be handled for the Azure Databricks Medallion Lakehouse project.



This is a portfolio runbook example. It is not connected to a live production monitoring system.



\---



\## 1. Runbook Objective



The objective of a production runbook is to provide clear steps for diagnosing and resolving pipeline issues.



The runbook should help with:



\- Faster incident response

\- Clear ownership

\- Consistent troubleshooting

\- Reduced downtime

\- Better communication with stakeholders

\- Reliable data recovery



\---



\## 2. Pipeline Components



Main components in the architecture:



```text

Azure Data Factory

&#x20;       ↓

ADLS Bronze

&#x20;       ↓

Azure Databricks Bronze/Silver/Gold

&#x20;       ↓

Azure Synapse SQL Serving Layer

&#x20;       ↓

BI / Reporting / Analytics

```



\---



\## 3. Common Incident: ADF Copy Activity Failed



\### Symptoms



\- ADF pipeline failed.

\- Data did not arrive in Bronze.

\- Copy activity shows error.



\### Checks



\- Check source system availability.

\- Check linked service connection.

\- Check credentials or Key Vault reference.

\- Check source query or API response.

\- Check ADLS permissions.

\- Check retry attempts and error message.



\### Resolution



\- Fix connection or credential issue.

\- Rerun the failed ADF activity.

\- If source was unavailable, rerun after source recovery.

\- Confirm files landed in Bronze.

\- Trigger downstream Databricks processing.



\---



\## 4. Common Incident: Databricks Notebook Failed



\### Symptoms



\- Databricks job failed.

\- Silver or Gold output not updated.

\- Error appears in notebook/job logs.



\### Checks



\- Check job run logs.

\- Identify failed cell or transformation step.

\- Check input path availability.

\- Check schema changes.

\- Check data quality failures.

\- Check cluster availability.



\### Resolution



\- Fix transformation logic or input issue.

\- Rerun the notebook/job.

\- If only one partition is affected, rerun only that partition where possible.

\- Validate output row counts and quality checks.



\---



\## 5. Common Incident: Schema Mismatch



\### Symptoms



\- Pipeline fails during read or transformation.

\- New column appears.

\- Data type changed.

\- Required column missing.



\### Checks



\- Compare current schema with expected schema.

\- Check source system changes.

\- Check Bronze raw data.

\- Identify whether change is compatible or breaking.



\### Resolution



\- Allow compatible nullable new columns if business-approved.

\- For breaking changes, fail validation and send affected records to quarantine.

\- Update schema version and transformation logic.

\- Communicate change to downstream consumers if needed.



\---



\## 6. Common Incident: Data Quality Failure



\### Symptoms



\- Data quality test fails.

\- Invalid rows detected.

\- Gold output not published or flagged.



\### Checks



\- Identify failed rule.

\- Check affected dataset and column.

\- Review invalid records.

\- Check source file or source system.

\- Check recent transformation changes.



\### Resolution



\- Write invalid records to quarantine.

\- Fix source data or transformation logic.

\- Rerun affected partition or dataset.

\- Re-run data quality checks.

\- Publish corrected output only after validation passes.



\---



\## 7. Common Incident: Unexpected Data Volume Drop



\### Symptoms



\- Record count drops suddenly.

\- Dashboard shows missing data.

\- Daily load is much smaller than expected.



\### Checks



\- Compare current row count with historical average.

\- Check source extraction logs.

\- Check ADF copy activity metrics.

\- Check filters and watermarks.

\- Check source availability.

\- Check partition paths.



\### Resolution



\- If source issue, wait for source correction and rerun ingestion.

\- If pipeline filter issue, fix logic and backfill affected data.

\- Notify stakeholders if reporting is impacted.

\- Add alert threshold for future detection.



\---



\## 8. Common Incident: Synapse View Fails



\### Symptoms



\- BI query fails.

\- Synapse view returns error.

\- External data path not found.



\### Checks



\- Check ADLS path.

\- Check external data source definition.

\- Check file format.

\- Check permissions.

\- Check whether Gold output was produced.



\### Resolution



\- Fix external path or view definition.

\- Recreate or alter the Synapse view.

\- Validate query manually.

\- Confirm Power BI or reporting connection works.



\---



\## 9. Common Incident: Slow Spark Job



\### Symptoms



\- Databricks job runs longer than expected.

\- Cluster usage is high.

\- Job stages show long shuffle time.



\### Checks



\- Check Spark UI.

\- Check shuffle read/write.

\- Check data skew.

\- Check number of partitions.

\- Check join strategy.

\- Check input file count and size.



\### Resolution



\- Filter early.

\- Select only required columns.

\- Broadcast small dimensions.

\- Repartition by useful keys if needed.

\- Avoid unnecessary wide transformations.

\- Optimize file sizes in production.



\---



\## 10. Common Incident: CI/CD Deployment Failed



\### Symptoms



\- Azure DevOps or GitHub Actions pipeline failed.

\- SQL scripts or templates were not deployed.

\- Validation stage failed.



\### Checks



\- Review pipeline logs.

\- Check changed files.

\- Validate JSON/YAML syntax.

\- Validate SQL scripts.

\- Check secrets and environment variables.

\- Check service connection permissions.



\### Resolution



\- Fix failed validation.

\- Update secrets or permissions if needed.

\- Re-run pipeline.

\- If production deployment failed, rollback to previous stable version.



\---



\## 11. Backfill and Reprocessing Strategy



Backfill should be controlled and idempotent.



Recommended approach:



```text

Identify affected date/entity

&#x20;       ↓

Fix data or logic

&#x20;       ↓

Rerun ingestion/transformation for affected partition

&#x20;       ↓

Run data quality checks

&#x20;       ↓

Republish Silver/Gold output

&#x20;       ↓

Validate downstream views and reports

```



Important principles:



\- Avoid full reload unless required.

\- Reprocess only affected partitions where possible.

\- Track backfill runs with pipeline\_run\_id.

\- Communicate impact to stakeholders.



\---



\## 12. Monitoring Recommendations



In production, monitor:



```text

pipeline status

record counts

data freshness

data quality failures

schema changes

runtime duration

cost metrics

failed records

Synapse query failures

CI/CD deployment status

```



Alerts should be configured for:



\- Pipeline failure

\- Missing data

\- Large volume drop

\- Data quality failure

\- Schema mismatch

\- SLA breach



\---



\## 13. Stakeholder Communication



When an incident affects reporting or downstream users, communicate:



```text

what happened

which dataset is affected

business impact

expected resolution time

temporary workaround

final root cause

preventive action

```



\---



\## 14. Interview Explanation



A production runbook helps operate the pipeline reliably after deployment. For this project, I documented common failures such as ADF copy failure, Databricks notebook failure, schema mismatch, data quality failure, Synapse view failure, slow Spark jobs, and CI/CD deployment failure.



In production, I would combine this runbook with monitoring, alerting, audit logs, and clear ownership so issues can be resolved quickly and safely.

