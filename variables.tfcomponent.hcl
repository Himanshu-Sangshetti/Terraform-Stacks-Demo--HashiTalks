variable "environment" {
  type = string
}

variable "region" {
  type    = string
  default = "us-east-1"
}

variable "bucket_name" {
  type = string
}

variable "function_name" {
  type    = string
  default = "api-handler"
}

variable "lambda_runtime" {
  type    = string
  default = "python3.11"
}

variable "lambda_handler" {
  type    = string
  default = "index.handler"
}

variable "lambda_timeout" {
  type    = number
  default = 30
}

variable "lambda_memory_size" {
  type    = number
  default = 128
}

variable "api_name" {
  type    = string
  default = "api"
}

variable "api_description" {
  type    = string
  default = "Serverless API"
}
