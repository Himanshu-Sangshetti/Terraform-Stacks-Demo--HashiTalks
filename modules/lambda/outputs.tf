output "function_arn" {
  value = aws_lambda_function.main.arn
}

output "function_name" {
  value = aws_lambda_function.main.function_name
}

output "function_invoke_arn" {
  value = aws_lambda_function.main.invoke_arn
}

output "role_arn" {
  value = aws_iam_role.lambda.arn
}
