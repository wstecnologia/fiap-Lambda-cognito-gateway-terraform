resource "aws_apigatewayv2_api" "wstech-api-gateway" {
  name          = "wstech-api-gateway"
  description   = "Api de validação de usuários"
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_integration" "lambda_integration" {
  api_id                 = aws_apigatewayv2_api.wstech-api-gateway.id
  integration_type       = "AWS_PROXY"
  integration_uri        = aws_lambda_function.wstech_api.invoke_arn
  payload_format_version = "2.0"
}

resource "aws_apigatewayv2_route" "get_user_route" {
  api_id             = aws_apigatewayv2_api.wstech-api-gateway.id
  route_key          = "GET /user"
  target             = "integrations/${aws_apigatewayv2_integration.lambda_integration.id}"
  #authorization_type = "JWT"
  #authorizer_id      = aws_apigatewayv2_authorizer.jwt_authorizer.id
}

resource "aws_apigatewayv2_stage" "default_stage" {
  api_id      = aws_apigatewayv2_api.wstech-api-gateway.id
  name        = "$default"
  auto_deploy = true
}

resource "aws_lambda_permission" "apigw_lambda" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.wstech_api.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.wstech-api-gateway.execution_arn}/*/GET/user"
}

# resource "aws_apigatewayv2_authorizer" "jwt_authorizer" {
#   name             = "JWTAuthorizer"
#   api_id           = aws_apigatewayv2_api.wstech-api-gateway.id
#   authorizer_type  = "JWT"
#   identity_sources = ["$request.header.Authorization"]

#   jwt_configuration {
#     issuer   = "https://cognito-idp.${var.aws_region}.amazonaws.com/${aws_cognito_user_pool.pool.id}"
#     audience = [aws_cognito_user_pool_client.client.id]

#   }
# }
