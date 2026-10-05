# Phase 7 — Evidence Processing and AI

## Goal

Turn the infrastructure project into an actual digital-evidence processing workflow.

## Target flow

```text
Upload
  |
Blob Storage
  |
Event
  |
Queue
  |
Worker
  |
+-------------------+
|                   |
OCR             Metadata
|                   |
+---------+---------+
          |
          v
      AI analysis
          |
          v
 Classification
          |
          v
 Evidence metadata
```

## Why asynchronous processing?

Large evidence files can take time to process.

The API should not keep an HTTP request open while OCR, transcription, or AI analysis runs.

Use:

```text
API -> Queue -> Worker
```

This creates loose coupling and improves resilience.

## Step 1 — Add a queue

Use an Azure messaging service such as Storage Queue or Service Bus.

Understand the tradeoff:

### Storage Queue

Simple and inexpensive.

### Service Bus

More enterprise messaging capabilities such as sessions, richer delivery semantics, and dead-lettering.

## Step 2 — Create a worker

The worker:

1. receives message
2. retrieves blob
3. calculates metadata
4. performs synthetic classification
5. writes processing result
6. acknowledges message

## Step 3 — AI integration

For the portfolio version, use synthetic/non-sensitive files.

The AI service can produce:

```json
{
  "classification": "financial_document",
  "entities": [
    "person",
    "organization",
    "date"
  ],
  "confidence": 0.94
}
```

Use an approved Azure AI service/model when implementing this for a real environment.

## Step 4 — Failure handling

Simulate a processing failure.

Implement:

- retry
- backoff
- dead-letter handling
- logging
- status tracking

## Interview question

"Why not have the API perform the AI processing synchronously?"

Answer:

"Processing can be slow and resource-intensive. An asynchronous architecture decouples ingestion from processing, allows independent scaling, prevents long-running HTTP requests, and lets us retry failures without forcing the user to resubmit the evidence."
