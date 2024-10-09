##Output Lambda function
output "layers" {
  value = [{
    wstech = [{
      arn         = aws_lambda_layer_version.wstech.arn
      name        = aws_lambda_layer_version.wstech.layer_name
      description = aws_lambda_layer_version.wstech.description
      created_at  = aws_lambda_layer_version.wstech.created_date
    }]
  }]

}

output "lambdas" {
  value = [{
    arn           = aws_lambda_function.wstech_api.arn
    name          = aws_lambda_function.wstech_api.function_name
    description   = aws_lambda_function.wstech_api.description
    version       = aws_lambda_function.wstech_api.version
    last_modified = aws_lambda_function.wstech_api.last_modified
  }]
}


##Output Cognito
output "user_pool_id" {
  value = aws_cognito_user_pool.pool.id
}
output "user_pool_client_id" {
  value = aws_cognito_user_pool_client.client.id
}

output "api_endpoint" {
  description = "Endpoint da API Gateway"
  value       = aws_apigatewayv2_api.wstech-api-gateway.api_endpoint
}
