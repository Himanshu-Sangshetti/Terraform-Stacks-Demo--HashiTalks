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
  deployment_group = deployment_group.non_production
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
  deployment_group = deployment_group.production
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
  deployment_group = deployment_group.non_production
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
  deployment_group = deployment_group.production
}

deployment_auto_approve "no_changes" {
  check {
    condition = context.plan.changes.total == 0
    reason    = "Plan contains changes and requires manual approval."
  }
}

deployment_auto_approve "low_risk_changes" {
  check {
    condition = (context.plan.changes.total < 5) && (context.plan.changes.destroy == 0) && (context.plan.changes.replace == 0)
    reason    = "Plan contains too many changes, destroys, or replaces for automatic approval."
  }
}

deployment_group "non_production" {
  auto_approve_checks = [
    deployment_auto_approve.no_changes,
    deployment_auto_approve.low_risk_changes
  ]
}

deployment_group "production" {
}
