variable "environment" {
  type = string
}

variable "region" {
  type = string
}

variable "lambda_function_arn" {
  type = string
}

variable "lambda_function_name" {
  type = string
}

variable "api_name" {
  type    = string
  default = "api"
}

variable "api_description" {
  type    = string
  default = "Serverless API"
}
