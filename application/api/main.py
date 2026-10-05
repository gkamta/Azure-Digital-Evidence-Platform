from datetime import datetime, timezone
from hashlib import sha256
from uuid import uuid4

from fastapi import FastAPI, File, UploadFile

app = FastAPI(
    title="Digital Evidence API",
    version="0.2.0",
)

evidence_store = {}


@app.get("/health")
def health():
    return {"status": "healthy"}


@app.post("/evidence")
async def upload_evidence(file: UploadFile = File(...)):
    content = await file.read()
    evidence_id = f"EV-{uuid4().hex[:8].upper()}"

    record = {
        "evidence_id": evidence_id,
        "filename": file.filename,
        "content_type": file.content_type,
        "size_bytes": len(content),
        "sha256": sha256(content).hexdigest(),
        "uploaded_at": datetime.now(timezone.utc).isoformat(),
        "status": "received",
    }

    evidence_store[evidence_id] = record
    return record


@app.get("/evidence/{evidence_id}")
def get_evidence(evidence_id: str):
    return evidence_store.get(
        evidence_id,
        {"error": "Evidence record not found"},
    )


@app.get("/evidence")
def list_evidence():
    return list(evidence_store.values())
