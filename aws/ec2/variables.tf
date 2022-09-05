variable "region" {
  description = "Região do recurso"
  default     = "us-east-1"
}

variable "config-profile" {
  type    = string
  default = "$HOME/.aws/config"
}

//variable "config-credentials" {
//  type    = string
//  default = "$HOME/.aws/credentials"
//}

variable "profile" {
  type    = string
  default = "default"

}

variable "ec2" {
  type    = string
  default = "ami-05fa00d4c63e32376"
}

variable "instance_type" {
  type    = string
  default = "t3.micro"

}