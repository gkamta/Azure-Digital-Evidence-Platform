variable "location" {
  type        = string
  description = "Azure region."
  default     = "eastus"
}

variable "project_name" {
  type        = string
  description = "Project name."
  default     = "evidence"
}

variable "environment" {
  type        = string
  description = "Environment name."
  default     = "dev"
}

variable "owner" {
  type        = string
  description = "Owning team."
  default     = "cloud-engineering"
}
