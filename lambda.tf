data "archive_file" "wstech_api_artefact" {
  output_path = "files/wstech-api-artefact.zip"
  type        = "zip"  
  source_file = "${local.lambdas_path}/wstech-api/index.js"
}

resource "aws_lambda_function" "wstech_api" {
  function_name = "AuthClienteByCpf"
  description   = "Função para validação de usuário"
  handler       = "index.handler"
  role          = data.aws_iam_role.lab_role.arn
  runtime       = var.runtime

  filename         = data.archive_file.wstech_api_artefact.output_path
  source_code_hash = data.archive_file.wstech_api_artefact.output_base64sha256

  environment {
    variables = {
      USER_POOL_ID = aws_cognito_user_pool.pool.id
    }
  }

  timeout     = 5
  memory_size = 128

  layers = [aws_lambda_layer_version.wstech.arn]

  tags = local.common_tags

}
