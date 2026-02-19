deployment "dev" {
  variables = {
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
  variables = {
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
  variables = {
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
  variables = {
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

deployment_group "non-production" {
  deployments = ["dev", "east-coast"]
  
  deployment_auto_approve "no-changes" {
    condition = context.plan.changes.total == 0
  }
  
  deployment_auto_approve "low-risk-changes" {
    condition = context.plan.changes.total < 5 && 
                context.plan.changes.destroy == 0 &&
                context.plan.changes.replace == 0
  }
}

deployment_group "production" {
  deployments = ["prod", "disaster-recovery"]
}
