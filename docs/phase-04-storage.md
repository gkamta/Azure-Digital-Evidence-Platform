# Phase 4 — Evidence Storage

## Goal

Connect the API to Azure Blob Storage and understand why object storage is appropriate for evidence.

## Design

```text
Evidence API
     |
     v
Azure Blob Storage
     |
     +-- evidence/
     |
     +-- metadata/
```

## Security concepts

Use:

- private containers
- TLS
- encryption
- versioning
- lifecycle management
- retention
- immutability where required
- RBAC
- managed identity
- audit logging

## Step 1 — Learn Blob Storage

Understand:

```text
Storage Account
   |
Blob Container
   |
Blob
```

## Step 2 — Create an application identity

The API should not use an account key.

Target pattern:

```text
AKS Workload Identity
       |
       v
Azure role assignment
       |
       v
Storage Blob Data Contributor
       |
       v
Evidence container
```

For read-only processing workers, use a narrower role.

## Step 3 — Update the API

Use the Azure SDK and DefaultAzureCredential.

Conceptually:

```python
from azure.identity import DefaultAzureCredential
from azure.storage.blob import BlobServiceClient

credential = DefaultAzureCredential()

client = BlobServiceClient(
    account_url=STORAGE_ACCOUNT_URL,
    credential=credential
)
```

## Step 4 — Upload

The API should:

1. Generate evidence ID.
2. Validate filename/content type.
3. Calculate a SHA-256 hash.
4. Upload the blob.
5. Store metadata.
6. Return the evidence ID.

## Evidence integrity

Hash:

```text
SHA-256(file bytes)
```

Store:

```text
evidence_id
filename
timestamp
SHA-256
uploader
content type
size
processing status
```

This allows you to demonstrate evidence integrity concepts.

## Interview question

"How would you protect digital evidence from unauthorized modification?"

Discuss:

- RBAC
- least privilege
- managed identities
- immutable storage/retention controls
- versioning
- encryption
- audit logs
- hashes
- separation of duties
- monitoring

Do not claim a simple SHA-256 hash alone proves legal chain of custody. It is one technical control within a broader process.
