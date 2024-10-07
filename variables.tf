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
  description = "DNS domain in the AWS account which you own or is linked via NS records to a DNS zone you own."
  default     = ""
}

variable "name" {
  type        = string
  description = "The string that is used in the `name` filed or equivalent in most resources."
  default     = ""
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
