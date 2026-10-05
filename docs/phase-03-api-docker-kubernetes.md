# Phase 3 — Application, Docker, and Kubernetes

## Goal

Containerize the evidence API and run it on AKS.

## Application flow

```text
Client
  |
  v
Evidence API
  |
  +-- validate request
  |
  +-- create evidence ID
  |
  +-- persist metadata
  |
  v
Blob Storage
```

## Step 1 — Run locally

```bash
cd application/api

python -m venv .venv
```

Windows:

```powershell
.venv\Scripts\Activate.ps1
```

Install:

```bash
pip install -r requirements.txt
```

Run:

```bash
uvicorn main:app --reload
```

Open:

```text
http://localhost:8000/docs
```

Test:

```text
GET /health
POST /evidence
GET /evidence
```

## Step 2 — Build the container

```bash
docker build -t evidence-api:dev .
```

Run:

```bash
docker run --rm -p 8000:8000 evidence-api:dev
```

Test:

```text
http://localhost:8000/health
```

## Step 3 — Push to ACR

Login:

```bash
az acr login --name <ACR_NAME>
```

Tag:

```bash
docker tag evidence-api:dev <ACR_NAME>.azurecr.io/evidence-api:dev
```

Push:

```bash
docker push <ACR_NAME>.azurecr.io/evidence-api:dev
```

## Step 4 — Deploy to Kubernetes

Update:

```text
kubernetes/api-deployment.yaml
```

with the ACR image.

Apply:

```bash
kubectl apply -f kubernetes/namespace.yaml
kubectl apply -f kubernetes/api-deployment.yaml
kubectl apply -f kubernetes/api-service.yaml
```

Verify:

```bash
kubectl get pods -n evidence-platform
kubectl get svc -n evidence-platform
```

## Step 5 — Understand the deployment

```text
Deployment
   |
ReplicaSet
   |
Pods
   |
Containers
```

The Service provides stable networking to those pods.

## Step 6 — Troubleshoot intentionally

Break the image name.

```bash
kubectl get pods -n evidence-platform
kubectl describe pod <POD> -n evidence-platform
```

Look for:

```text
ImagePullBackOff
```

Then fix the image.

### Second exercise

Change the readiness probe path to an invalid endpoint.

Observe:

```bash
kubectl describe pod <POD> -n evidence-platform
```

Understand why Kubernetes removes an unready pod from service traffic.

## Interview question

"What is the difference between liveness and readiness probes?"

Answer:

- Readiness: should this pod receive traffic?
- Liveness: should Kubernetes restart this container?

## Senior-level troubleshooting sequence

```text
Pod
 |
Deployment
 |
Service
 |
Ingress/load balancer
 |
Network policy / NSG
 |
Application
 |
Dependencies
 |
Azure platform
```
