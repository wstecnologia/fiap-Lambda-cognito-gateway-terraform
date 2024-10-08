variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "runtime" {
  type    = string
  default = "nodejs20.x"
}

variable "domain_name" {
  type        = string
}

variable "name" {
  type        = string    
}

variable "user_pool_name" {
  type = string
}

variable "client_name" {
  type = string
}

variable "user_pool_domain" {
  type = string
}
