# Phase 8 — Monitoring, Security Operations, and Resilience

## Goal

Operate the platform rather than simply deploy it.

## Observability

Three pillars:

```text
Logs
Metrics
Traces
```

Use:

- Azure Monitor
- Log Analytics
- Application Insights
- AKS metrics
- alerts

## Step 1 — Create dashboards

Track:

- API requests
- error rate
- response latency
- pod restarts
- CPU
- memory
- node health
- storage growth
- queue depth

## Step 2 — Create alerts

Examples:

- API 5xx rate
- high CPU
- high memory
- AKS node failure
- storage capacity
- failed processing jobs

## Step 3 — Practice an incident

Break the application.

Example:

- invalid environment variable
- wrong storage endpoint
- bad image
- readiness failure

Observe the incident through logs and metrics.

Document:

```text
Detection
Impact
Root cause
Remediation
Prevention
```

## Step 4 — Resilience

Learn:

- Availability Zones
- zone-redundant services
- backups
- geo-redundant storage
- RTO
- RPO

### RTO

How quickly must the service be restored?

### RPO

How much data loss is acceptable?

## Step 5 — Disaster recovery design

Document:

```text
Primary Azure region
        |
        +---- replicated storage
        |
        +---- infrastructure code
        |
        v
Secondary region
```

Terraform should make rebuilding the environment repeatable.

## Interview question

"How would you design for disaster recovery?"

Start with business requirements:

1. RTO
2. RPO
3. data criticality
4. regional requirements
5. recovery dependencies

Then select the architecture.
