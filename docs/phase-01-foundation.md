# Phase 1 — Azure Foundation

## Goal

Learn how Terraform turns an architecture into repeatable Azure infrastructure.

## Concepts

You should understand:

- Azure Resource Groups
- Storage Accounts
- Blob containers
- Key Vault
- Log Analytics
- Application Insights
- Terraform provider
- Terraform state
- variables / locals / outputs

## Step 1 — Install locally

Install:

- Azure CLI
- Terraform
- Git
- Docker Desktop
- kubectl

Verify:

```bash
az version
terraform version
git --version
docker version
kubectl version --client
```

## Step 2 — Authenticate

```bash
az login
az account show
az account list -o table
```

Select the subscription you will use:

```bash
az account set --subscription "<SUBSCRIPTION_ID>"
```

Then:

```bash
az account show -o table
```

### Learning check

Ask yourself:

1. What is a tenant?
2. What is a subscription?
3. What is a resource group?
4. Why should production and non-production normally be separated?

## Step 3 — Inspect the Terraform

Go to:

```text
terraform/environments/dev
```

Read:

- providers.tf
- variables.tf
- main.tf
- outputs.tf

Do not run apply yet.

Understand the dependency chain:

```text
Resource Group
      |
      +---- Storage
      |
      +---- Log Analytics
      |         |
      |         +---- Application Insights
      |
      +---- Key Vault
```

## Step 4 — Format and validate

```bash
cd terraform/environments/dev

terraform fmt -recursive
terraform init
terraform validate
terraform plan
```

## Step 5 — Deploy

```bash
terraform apply
```

Review the plan and type:

```text
yes
```

## Step 6 — Verify Azure

```bash
az group list -o table
az storage account list -o table
az keyvault list -o table
```

## Step 7 — Learn the state

```bash
terraform state list
terraform show
```

Understand that Terraform state is how Terraform tracks the relationship between configuration and deployed resources.

### Interview question

"Why should Terraform state not be committed to Git?"

Expected concepts:

- It can contain sensitive information.
- It can expose infrastructure metadata.
- Teams need shared state.
- State needs controlled access and locking/concurrency protection.

## Step 8 — Destroy when finished

```bash
terraform destroy
```

Do not destroy anything you did not create or that belongs to another environment.

## Troubleshooting exercise

Intentionally change the storage account name to an invalid value and run:

```bash
terraform validate
terraform plan
```

Observe the difference between syntax/configuration validation and Azure deployment validation.

## Interview talking point

"I started the platform by defining the foundation as code so infrastructure changes are repeatable, reviewable, and auditable. I used Terraform variables, locals, outputs, and state rather than manually creating resources."
