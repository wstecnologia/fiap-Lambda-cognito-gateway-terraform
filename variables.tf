variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "runtime" {
  type    = string
  default = "nodejs20.x"
}

variable "user_pool_name" {
  type    = string
  default = "wstech_pool"
}

variable "client_name" {
  type    = string
  default = "wstech_client"
}

variable "user_pool_domain" {
  type    = string
  default = "fiap-wstech-techchallenger"
}
