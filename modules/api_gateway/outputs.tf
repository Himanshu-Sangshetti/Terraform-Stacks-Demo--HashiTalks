output "api_id" {
  value = aws_apigatewayv2_api.main.id
}

output "api_endpoint" {
  value = aws_apigatewayv2_stage.main.invoke_url
}

output "api_arn" {
  value = aws_apigatewayv2_api.main.arn
}

output "stage_name" {
  value = aws_apigatewayv2_stage.main.name
}
