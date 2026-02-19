terraform {
  required_version = ">= 1.6.0"
  
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    archive = {
      source  = "hashicorp/archive"
      version = "~> 2.4"
    }
  }
}

component "s3" {
  source = "./modules/s3"
  
  inputs = {
    environment = var.environment
    region      = var.region
    bucket_name = var.bucket_name
  }
}

component "lambda" {
  source = "./modules/lambda"
  
  inputs = {
    environment    = var.environment
    region         = var.region
    s3_bucket_name = component.s3.outputs.bucket_name
    function_name  = var.function_name
    runtime        = var.lambda_runtime
    handler        = var.lambda_handler
    timeout        = var.lambda_timeout
    memory_size    = var.lambda_memory_size
  }
}

component "api_gateway" {
  source = "./modules/api_gateway"
  
  inputs = {
    environment          = var.environment
    region               = var.region
    lambda_function_arn  = component.lambda.outputs.function_arn
    lambda_function_name = component.lambda.outputs.function_name
    api_name             = var.api_name
    api_description      = var.api_description
  }
}

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
