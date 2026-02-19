component "s3" {
  source = "./modules/s3"
  
  inputs = {
    environment = var.environment
    region      = var.region
    bucket_name = var.bucket_name
  }

  providers = {
    aws = provider.aws.this
  }
}

component "lambda" {
  source = "./modules/lambda"
  
  inputs = {
    environment    = var.environment
    region         = var.region
    s3_bucket_name = component.s3.bucket_name
    function_name  = var.function_name
    runtime        = var.lambda_runtime
    handler        = var.lambda_handler
    timeout        = var.lambda_timeout
    memory_size    = var.lambda_memory_size
  }

  providers = {
    aws = provider.aws.this
  }
}

component "api_gateway" {
  source = "./modules/api_gateway"
  
  inputs = {
    environment          = var.environment
    region               = var.region
    lambda_function_arn  = component.lambda.function_arn
    lambda_function_name = component.lambda.function_name
    api_name             = var.api_name
    api_description      = var.api_description
  }

  providers = {
    aws = provider.aws.this
  }
}
