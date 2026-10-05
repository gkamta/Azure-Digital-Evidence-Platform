# Phase 5 — CI/CD

## Goal

Build two pipelines:

1. Infrastructure pipeline
2. Application pipeline

## Infrastructure pipeline

```text
Pull Request
   |
Terraform fmt
   |
Terraform validate
   |
Security scan
   |
Terraform plan
   |
Approval
   |
Terraform apply
```

## Application pipeline

```text
Commit
 |
Tests
 |
Docker build
 |
Image scan
 |
Push to ACR
 |
Deploy to AKS
 |
Smoke test
```

## Step 1 — Understand Git branching

Recommended:

```text
main
 |
 +-- feature/*
 |
 +-- pull request
```

Protect main.

Require:

- PR
- review
- successful checks

## Step 2 — Terraform pipeline

Use GitHub Actions.

Do not initially give the workflow permanent subscription-wide credentials.

Target architecture:

```text
GitHub
  |
OIDC
  |
Azure federated identity
  |
Azure RBAC
```

This eliminates long-lived Azure client secrets.

## Step 3 — Application pipeline

Steps:

```yaml
- checkout
- test
- build
- scan
- login to Azure
- push to ACR
- update AKS
- smoke test
```

## Step 4 — Deployment strategy

Start with rolling deployment.

Later understand:

- blue/green
- canary
- rollback

## Exercise

Make a harmless application change.

Push it.

Watch:

```text
GitHub Actions
  |
  +-- build
  +-- push
  +-- deploy
```

Then:

```bash
kubectl rollout status deployment/evidence-api -n evidence-platform
```

## Rollback exercise

```bash
kubectl rollout history deployment/evidence-api -n evidence-platform
kubectl rollout undo deployment/evidence-api -n evidence-platform
```

## Interview question

"How would you prevent a bad deployment from reaching production?"

Discuss:

- PR reviews
- automated tests
- Terraform plan
- image scanning
- approvals
- environment separation
- health checks
- staged rollout
- rollback
- monitoring
