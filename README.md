# Azure Digital Evidence Platform — Senior Azure Engineer Lab

A hands-on portfolio/reference architecture designed to demonstrate senior Azure engineering skills for a Federal digital-evidence platform.

## What you will learn

- Azure landing-zone concepts
- Terraform modules and remote state
- Azure networking and private endpoints
- Azure Container Registry
- AKS architecture and operations
- Docker/containerization
- Python/FastAPI
- Managed identities and workload identity
- Key Vault
- Azure RBAC
- Azure Policy
- CI/CD with GitHub Actions
- Security scanning
- Monitoring and troubleshooting
- Evidence integrity and retention
- Asynchronous processing
- AI-assisted evidence classification
- Cost optimization
- Disaster recovery
- Federal accreditation concepts

## Final architecture

```text
                         GitHub
                            |
                     Pull Request / Push
                            |
                     GitHub Actions
             +--------------+---------------+
             |                              |
      Terraform pipeline              Application pipeline
             |                              |
             v                              v
       Azure Platform                  Docker -> ACR
             |                              |
     +-------+---------+                    v
     |                 |                   AKS
     v                 v              +-----+------+
  Networking       Security           |            |
     |             Key Vault       Evidence API  Worker
     |                 |                |            |
     +-----------------+----------------+------------+
                                      |
                                      v
                                Azure Storage
                                  Evidence
                                      |
                                      v
                              Event-driven workflow
                                      |
                                      v
                                  AI/ML
                                      |
                                      v
                              Metadata / Search

                    Azure Monitor / Log Analytics
                              |
                              v
                       Alerts / Operations
```

## Phase map

| Phase | Outcome |
|---|---|
| 1 | Azure foundation |
| 2 | Network + ACR + AKS |
| 3 | Containerized API on AKS |
| 4 | Blob evidence storage |
| 5 | CI/CD automation |
| 6 | Identity, Key Vault, Policy |
| 7 | Processing + AI |
| 8 | Monitoring, security, DR |
| 9 | Cost optimization |
| 10 | Interview demonstration |

## Safety / cost

This lab creates Azure resources that can incur charges. Start with small development SKUs, destroy resources when finished, and use Azure Cost Management budgets/alerts.

Do not upload real sensitive, classified, PII, law-enforcement, or government evidence. Use synthetic test files only.
