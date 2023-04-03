variable "debian_ami" {
  description = "Default Debian ami for region Frankfurt"
  type        = string
  default     = "ami-0adb6517915458bdb"
}

variable "ip" {
  description = "Authorized IP"
  type        = string
  default     = "0.0.0.0"
}

variable "public_key" {
  description = "Public key"
  type        = string
  default     = "your_public_key"
}

variable "tags" {
  description = "Default tags to apply to all resources."
  type        = map(any)
  default = {
    archuuid = "aa655a4c-4df8-471f-ac56-01627cbd4379"
    env      = "Development"
  }
}

