variable "environment" {
  type = string
}

variable "region" {
  type = string
}

variable "s3_bucket_name" {
  type = string
}

variable "function_name" {
  type    = string
  default = "api-handler"
}

variable "runtime" {
  type    = string
  default = "python3.11"
}

variable "handler" {
  type    = string
  default = "index.handler"
}

variable "timeout" {
  type    = number
  default = 30
}

variable "memory_size" {
  type    = number
  default = 128
}
