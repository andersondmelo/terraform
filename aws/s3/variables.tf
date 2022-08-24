variable "region" {
  description = "Região do recurso"
  default     = "us-east-1"
}

variable "config-profile" {
  type = string
  default = "$HOME/.aws/config"
}

variable "profile" {
  type = string
  default = "acm"
  
}