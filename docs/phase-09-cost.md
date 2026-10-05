# Phase 9 — Cost Optimization

## Goal

Demonstrate that senior cloud engineering includes financial efficiency.

## Areas

### AKS

- right-size nodes
- autoscaling
- workload requests/limits
- spot nodes for appropriate workloads

### Storage

- lifecycle policies
- tiering
- archive
- deletion/retention rules

### Compute

- right-size
- reserved capacity where appropriate
- stop non-production

### Governance

Use tags:

```text
Project
Environment
Owner
CostCenter
DataClassification
```

## Exercise

Create a simple cost review:

```text
Resource
Estimated monthly cost
Utilization
Optimization
Risk
```

## Interview question

"How would you control costs for a digital evidence platform?"

Important insight:

Storage can become one of the largest cost drivers because evidence volume grows over time.

Discuss:

- lifecycle management
- tiering
- retention
- deduplication where appropriate
- compression where appropriate
- monitoring growth
- reserved/optimized compute
- autoscaling
