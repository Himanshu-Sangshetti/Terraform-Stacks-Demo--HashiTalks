resource "aws_apigatewayv2_api" "main" {
  name          = "${var.environment}-${var.api_name}"
  description   = var.api_description
  protocol_type = "HTTP"
  version       = "1.0"

  tags = {
    Name        = "${var.environment}-${var.api_name}"
    Environment = var.environment
    Component   = "api_gateway"
  }
}

resource "aws_apigatewayv2_integration" "lambda" {
  api_id = aws_apigatewayv2_api.main.id

  integration_type   = "AWS_PROXY"
  integration_method = "POST"
  integration_uri    = var.lambda_function_arn
}

resource "aws_apigatewayv2_route" "main" {
  api_id    = aws_apigatewayv2_api.main.id
  route_key = "$default"
  target    = "integrations/${aws_apigatewayv2_integration.lambda.id}"
}

resource "aws_apigatewayv2_stage" "main" {
  api_id      = aws_apigatewayv2_api.main.id
  name        = var.environment
  auto_deploy = true

  tags = {
    Name        = "${var.environment}-${var.api_name}-stage"
    Environment = var.environment
    Component   = "api_gateway"
  }
}

resource "aws_lambda_permission" "api_gateway" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.main.execution_arn}/*/*"
}
