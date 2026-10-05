# Phase 10 — Interview Demonstration

## 10-minute demo structure

### Minute 1 — Mission

"I built a reference Azure platform for secure digital evidence ingestion and processing."

### Minute 2 — Architecture

Show:

```text
GitHub
 -> Terraform
 -> Azure
 -> AKS
 -> Storage
 -> Processing
 -> Monitoring
```

### Minutes 3-4 — IaC

Show Terraform modules.

Explain:

- reusable modules
- environments
- state
- plan/apply
- CI/CD

### Minutes 5-6 — AKS

Show:

```bash
kubectl get nodes
kubectl get pods -n evidence-platform
```

Explain:

- deployment
- replicas
- readiness
- service
- scaling

### Minute 7 — Security

Show:

- managed identity
- Key Vault
- RBAC
- Policy
- private endpoints

### Minute 8 — Processing

Upload synthetic evidence.

Show:

```text
received
processing
classified
complete
```

### Minute 9 — Operations

Show:

- Log Analytics
- Application Insights
- alerts
- troubleshooting

### Minute 10 — Engineering judgment

Explain what you would change for production:

- multi-region
- stronger private networking
- full policy initiative
- SIEM integration
- formal RMF/ATO
- immutable evidence controls
- enterprise identity
- DR testing
- cost governance

## Questions to ask the interviewer

1. "What stage is the Azure platform currently in?"
2. "Are you establishing the landing zone from scratch or integrating with an existing enterprise landing zone?"
3. "What is the authorization boundary for the digital evidence platform?"
4. "Is AKS the primary application platform?"
5. "How are Terraform modules and state managed today?"
6. "Are you using Azure DevOps, GitHub Actions, or both?"
7. "What are the biggest technical risks during accreditation?"
8. "What does success look like for the first 90 days?"
