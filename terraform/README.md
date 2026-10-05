# Terraform

The completed project should evolve toward:

```text
terraform/
├── modules/
│   ├── network/
│   ├── aks/
│   ├── acr/
│   ├── storage/
│   ├── keyvault/
│   ├── monitoring/
│   └── policy/
└── environments/
    ├── dev/
    ├── test/
    └── prod/
```

Build each module only after understanding the Azure resource it represents.
