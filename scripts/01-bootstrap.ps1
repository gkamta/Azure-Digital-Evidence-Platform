# Run from the repository root in PowerShell.
# This script validates that the main developer tools are installed.

$commands = @("az", "terraform", "git", "docker", "kubectl")

foreach ($command in $commands) {
    if (Get-Command $command -ErrorAction SilentlyContinue) {
        Write-Host "$command : OK"
    } else {
        Write-Host "$command : MISSING"
    }
}

Write-Host "`nAzure account:"
az account show --query "{subscription:id,tenant:tenantId,name:name}" -o table
