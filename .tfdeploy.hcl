deployment "dev" {
  inputs = {
    environment       = "dev"
    region           = "us-east-1"
    bucket_name      = "demo-app-data"
    function_name    = "api-handler"
    lambda_runtime   = "python3.11"
    lambda_handler   = "index.handler"
    lambda_timeout   = 30
    lambda_memory_size = 128
    api_name         = "demo-api"
    api_description  = "Development API"
  }
}

deployment "prod" {
  inputs = {
    environment       = "prod"
    region           = "us-east-1"
    bucket_name      = "demo-app-data"
    function_name    = "api-handler"
    lambda_runtime   = "python3.11"
    lambda_handler   = "index.handler"
    lambda_timeout   = 60
    lambda_memory_size = 256
    api_name         = "demo-api"
    api_description  = "Production API"
  }
}

deployment "east-coast" {
  inputs = {
    environment       = "east-coast"
    region           = "us-east-1"
    bucket_name      = "demo-app-data"
    function_name    = "api-handler"
    lambda_runtime   = "python3.11"
    lambda_handler   = "index.handler"
    lambda_timeout   = 30
    lambda_memory_size = 128
    api_name         = "demo-api"
    api_description  = "East Coast Regional API"
  }
}

deployment "disaster-recovery" {
  inputs = {
    environment       = "disaster-recovery"
    region           = "us-west-2"
    bucket_name      = "demo-app-data"
    function_name    = "api-handler"
    lambda_runtime   = "python3.11"
    lambda_handler   = "index.handler"
    lambda_timeout   = 30
    lambda_memory_size = 128
    api_name         = "demo-api"
    api_description  = "Disaster Recovery API"
  }
}
