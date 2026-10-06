import os
from datetime import datetime, timezone
from hashlib import sha256
from uuid import uuid4

from azure.identity import DefaultAzureCredential
from azure.storage.blob import BlobServiceClient
from fastapi import FastAPI, File, HTTPException, UploadFile

app = FastAPI(
    title="Digital Evidence API",
    version="0.3.0",
)

STORAGE_ACCOUNT = os.getenv("AZURE_STORAGE_ACCOUNT")
CONTAINER_NAME = "evidence"

if not STORAGE_ACCOUNT:
    raise RuntimeError(
        "AZURE_STORAGE_ACCOUNT environment variable is not configured."
    )

account_url = f"https://{STORAGE_ACCOUNT}.blob.core.windows.net"

credential = DefaultAzureCredential()

blob_service_client = BlobServiceClient(
    account_url=account_url,
    credential=credential,
)

evidence_store = {}


@app.get("/health")
def health():
    return {
        "status": "healthy",
        "service": "evidence-api",
    }


@app.post("/evidence")
async def upload_evidence(file: UploadFile = File(...)):
    try:
        content = await file.read()

        if not content:
            raise HTTPException(
                status_code=400,
                detail="Uploaded evidence file is empty.",
            )

        evidence_id = f"EV-{uuid4().hex[:8].upper()}"
        file_hash = sha256(content).hexdigest()
        blob_name = f"{evidence_id}/{file.filename}"

        blob_client = blob_service_client.get_blob_client(
            container=CONTAINER_NAME,
            blob=blob_name,
        )

        blob_client.upload_blob(
            content,
            overwrite=False,
            metadata={
                "evidence_id": evidence_id,
                "sha256": file_hash,
            },
        )

        record = {
            "evidence_id": evidence_id,
            "filename": file.filename,
            "blob_name": blob_name,
            "content_type": file.content_type,
            "size_bytes": len(content),
            "sha256": file_hash,
            "uploaded_at": datetime.now(timezone.utc).isoformat(),
            "status": "received",
        }

        evidence_store[evidence_id] = record
        return record

    except HTTPException:
        raise

    except Exception as exc:
        raise HTTPException(
            status_code=500,
            detail=f"Evidence upload failed: {str(exc)}",
        )


@app.get("/evidence/{evidence_id}")
def get_evidence(evidence_id: str):
    record = evidence_store.get(evidence_id)

    if not record:
        raise HTTPException(
            status_code=404,
            detail="Evidence record not found",
        )

    return record


@app.get("/evidence")
def list_evidence():
    return list(evidence_store.values())