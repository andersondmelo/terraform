variable "region" {
  description = "Região do recurso"
  type    = string
  default     = "us-east-1"
}

variable "config-profile" {
  type    = string
  default = "$HOME/.aws/config"
}

variable "config-credentials" {
  type    = string
  default = "$HOME/.aws/credentials"
}

variable "profile" {
  type    = string
  default = "default"

}
