Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

Set-Location "$PSScriptRoot\..\terraform\environments\dev"

terraform fmt -recursive
terraform init
terraform validate
terraform plan
terraform apply
