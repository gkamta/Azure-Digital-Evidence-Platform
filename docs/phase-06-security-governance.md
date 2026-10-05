# Phase 6 — Identity, Governance, and Security

## Goal

Build security controls into the platform rather than bolting them on afterward.

## Identity hierarchy

```text
Entra ID
 |
 +-- Groups
 |
 +-- Managed identities
 |
 +-- Workload identities
 |
 +-- RBAC
 |
 +-- PIM
```

## Step 1 — RBAC

Understand scopes:

```text
Management Group
      |
Subscription
      |
Resource Group
      |
Resource
```

Grant the minimum role at the narrowest practical scope.

## Step 2 — Key Vault

Store:

- API secrets if unavoidable
- certificates
- encryption keys where appropriate

Prefer identity-based access.

Never put:

```text
password
client_secret
storage_key
```

in Git.

## Step 3 — Azure Policy

Create policies for:

- allowed locations
- required tags
- approved resource types
- secure storage
- diagnostic settings
- public network restrictions

Understand:

```text
Policy definition
       |
Initiative
       |
Assignment
       |
Scope
```

## Step 4 — Defender for Cloud

Learn:

- Secure Score
- recommendations
- vulnerability assessment
- regulatory/compliance views

## Step 5 — Federal security mapping

Research and map technical controls to:

- NIST SP 800-53
- RMF
- STIG
- vulnerability management
- continuous monitoring

Do not claim the demo is an authorized government system.

It is a reference architecture.

## Interview question

"How would you approach an ATO for this platform?"

Answer structure:

1. Understand authorization boundary.
2. Identify applicable controls.
3. Design infrastructure to satisfy controls.
4. Implement controls.
5. Generate evidence.
6. Remediate findings.
7. Support assessment.
8. Maintain continuous monitoring.

## Security exercise

Find three intentionally weak settings in the development environment and improve them.

Examples:

- public storage access
- overly broad RBAC
- unprotected pipeline credentials

Document:

```text
Finding
Risk
Remediation
Validation
```

That becomes an excellent interview artifact.
