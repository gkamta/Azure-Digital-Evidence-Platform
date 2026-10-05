# Phase 2 — Networking, ACR, and AKS

## Goal

Learn how a production-style Azure application platform is connected and how AKS fits into the architecture.

## Target architecture

```text
                    Hub / Platform Network
                            |
                      Azure Firewall
                            |
                       Spoke VNet
                            |
                 +----------+----------+
                 |                     |
             AKS subnet           Private endpoints
                 |                     |
              AKS nodes           Storage / KV / ACR
                 |
             Kubernetes
```

## Concepts to learn first

### VNet

Logical network boundary in Azure.

### Subnet

Smaller address range within the VNet.

### NSG

Filters network traffic at subnet/NIC level.

### Route table

Controls packet routing.

### Private Endpoint

Provides private connectivity to supported Azure PaaS services.

### Private DNS

Allows private endpoint names to resolve correctly.

### ACR

Private/controlled registry for container images.

### AKS

Managed Kubernetes service.

## Step 1 — Design your address space

Example:

```text
VNet: 10.20.0.0/16

AKS subnet:       10.20.1.0/24
Private endpoints:10.20.2.0/24
Application:      10.20.3.0/24
```

Understand CIDR before deploying.

## Step 2 — Add Terraform networking module

Create:

```text
terraform/modules/network/
    main.tf
    variables.tf
    outputs.tf
```

The module should eventually create:

- VNet
- AKS subnet
- private endpoint subnet
- NSGs
- route tables

## Step 3 — Add ACR

Create an Azure Container Registry using Terraform.

Learn:

- SKU
- image repository
- tags
- authentication
- role assignments

## Step 4 — Add AKS

Start with a small development cluster.

Understand:

```text
AKS
 |
 +-- Control plane (managed by Azure)
 |
 +-- Node pool
      |
      +-- Node
      |    +-- Pod
      |         +-- Container
      |
      +-- Node
```

## Step 5 — Connect ACR to AKS

Preferred pattern:

```text
AKS managed identity
        |
        v
 AcrPull role
        |
        v
       ACR
```

Avoid hardcoding registry passwords.

## Step 6 — Deploy

```bash
terraform plan
terraform apply
```

Then retrieve AKS credentials:

```bash
az aks get-credentials \
  --resource-group <RESOURCE_GROUP> \
  --name <AKS_NAME>
```

Verify:

```bash
kubectl get nodes
kubectl get namespaces
```

## Learning exercise

Run:

```bash
kubectl describe node <NODE_NAME>
kubectl get pods -A
```

Identify:

- system pods
- namespaces
- node status
- networking information

## Troubleshooting exercise

Run:

```bash
kubectl get nodes
kubectl get pods -A
kubectl describe node <NODE_NAME>
```

Explain what you would investigate if a node becomes NotReady.

Think in layers:

```text
Azure VM / node
   |
network
   |
kubelet
   |
container runtime
   |
Kubernetes control plane
```

## Interview question

"Why use AKS instead of deploying containers directly to VMs?"

Strong themes:

- orchestration
- declarative deployments
- scaling
- service discovery
- rolling deployments
- self-healing
- standardized container platform
- reduced control-plane management

## Senior-level caveat

Do not say Kubernetes automatically makes everything better. It adds operational complexity. Use it when workload requirements justify orchestration, portability, scaling, and deployment capabilities.
