\# Terraform Infrastructure-as-Code Template



This folder contains a Terraform Infrastructure-as-Code template for extending the Azure Databricks Medallion Lakehouse project into a production-style Azure data platform.



This is a portfolio template only. It is not deployed production infrastructure.



\---



\## Purpose



The purpose of this Terraform template is to demonstrate how the core Azure infrastructure for a modern data engineering platform could be provisioned and managed as code.



The template is aligned with the project architecture:



```text

Source Systems

&#x20;       ↓

Azure Data Factory

&#x20;       ↓

Azure Data Lake Storage Gen2

&#x20;       ↓

Azure Databricks

&#x20;       ↓

Azure Synapse

&#x20;       ↓

BI / Reporting / Analytics

```



\---



\## Target Architecture



```text

Azure Resource Group

&#x20;       ↓

Azure Data Lake Storage Gen2

&#x20;       ↓

Azure Databricks Workspace

&#x20;       ↓

Azure Synapse Workspace

&#x20;       ↓

Azure Key Vault

&#x20;       ↓

ADF / CI-CD / Monitoring Integration

```



\---



\## Included Files



```text

infra/terraform/

├── README.md

├── main.tf

├── variables.tf

└── outputs.tf

```



\---



\## Resources Represented



The template includes skeleton resources for:



\- Azure Resource Group

\- Azure Data Lake Storage Gen2

\- Azure Databricks Workspace

\- Azure Synapse Workspace

\- Azure Key Vault



\---



\## File Overview



\### main.tf



Defines the main Azure resources used by the data platform, including resource group, ADLS Gen2, Databricks workspace, Synapse workspace, and Key Vault.



\### variables.tf



Defines reusable input variables for project name, environment, Azure region, storage account name, Synapse credentials, Databricks SKU, tenant ID, and common tags.



\### outputs.tf



Defines useful outputs such as resource group name, storage account name, lakehouse container name, Databricks workspace name, Synapse workspace name, and Key Vault name.



\---



\## Environment Strategy



In a production setup, this template could be extended with separate variable files for each environment:



```text

dev.tfvars

test.tfvars

prod.tfvars

```



Example:



```powershell

terraform plan -var-file="dev.tfvars"

terraform apply -var-file="dev.tfvars"

```



This allows each environment to use different naming, sizing, credentials, and security settings.



\---



\## Security Notes



In a real production setup:



\- Secrets should be stored in Azure Key Vault.

\- Managed identities should be preferred over hardcoded credentials.

\- RBAC and least-privilege access should be applied.

\- Terraform state should be stored in a secure remote backend.

\- Sensitive variables should not be committed to Git.

\- Environment-specific values should be managed through `.tfvars` files or CI/CD secret variables.

\- Access to Databricks, Synapse, ADLS, and Key Vault should be controlled through Azure IAM.



\---



\## Example Deployment Commands



Initialize Terraform:



```powershell

terraform init

```



Validate configuration:



```powershell

terraform validate

```



Preview infrastructure changes:



```powershell

terraform plan

```



Apply infrastructure changes:



```powershell

terraform apply

```



Using an environment-specific variable file:



```powershell

terraform plan -var-file="dev.tfvars"

terraform apply -var-file="dev.tfvars"

```



\---



\## Production Extensions



For a real production deployment, this Terraform template could be extended with:



\- Azure Data Factory resources

\- Databricks clusters and job definitions

\- Databricks Unity Catalog resources

\- Synapse SQL pools or serverless configuration

\- Private endpoints and networking

\- Azure Monitor and Log Analytics

\- Key Vault access policies

\- Remote backend for Terraform state

\- Role assignments for managed identities

\- Environment-specific modules

\- CI/CD integration through Azure DevOps or GitHub Actions



\---



\## Important Clarification



This Terraform folder is a design template and skeleton.



It shows how infrastructure could be managed as code for this Azure data platform, but it has not been deployed to a production Azure environment.



The correct way to describe this in an interview is:



```text

I added a Terraform Infrastructure-as-Code template to show how the Azure data platform could be provisioned in production. It includes skeleton resources for ADLS Gen2, Azure Databricks, Synapse, Key Vault, and resource group setup. It is not a deployed production environment, but it demonstrates how I would structure IaC for this architecture.

```



\---



\## Related Project Components



This Terraform template supports the wider project structure:



```text

Azure Data Factory ingestion examples

&#x20;       ↓

Azure Databricks Medallion pipeline

&#x20;       ↓

Azure Synapse serving layer

&#x20;       ↓

CI/CD examples

&#x20;       ↓

Terraform infrastructure template

```



The goal is to show how the project could evolve from a portfolio implementation into a production-style Azure data engineering platform.

