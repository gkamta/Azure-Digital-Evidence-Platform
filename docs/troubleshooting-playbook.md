# Troubleshooting Playbook

## General method

Do not start by changing random resources.

Use:

```text
Symptom
  |
Scope
  |
Recent change?
  |
Logs / metrics
  |
Dependency chain
  |
Root cause
  |
Safe remediation
  |
Validation
  |
Prevention
```

## AKS

```bash
kubectl get pods -A
kubectl describe pod <pod> -n evidence-platform
kubectl logs <pod> -n evidence-platform
kubectl get events -n evidence-platform --sort-by=.lastTimestamp
```

## Deployment

```bash
kubectl rollout status deployment/evidence-api -n evidence-platform
kubectl rollout history deployment/evidence-api -n evidence-platform
```

## Azure

```bash
az resource list -o table
az monitor activity-log list --max-events 20 -o table
```

## Terraform

```bash
terraform fmt -check
terraform validate
terraform plan
terraform state list
terraform show
```

## Common failures

### ImagePullBackOff

Check:

- image name
- tag
- ACR exists
- AKS identity
- AcrPull role
- network path

### CrashLoopBackOff

Check:

- application logs
- environment variables
- dependency connectivity
- container command
- resource limits

### 503

Check:

- readiness probe
- Service selectors
- endpoints
- ingress
- application health
- network policy

### Terraform drift

Run:

```bash
terraform plan
```

Understand why the real Azure configuration differs from desired configuration.
