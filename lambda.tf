data "archive_file" "wstech_api_artefact" {
  type        = "zip"
  source_dir  = "${local.lambdas_path}/wstech-api" # Diretório contendo o código da função
  output_path = "${path.module}/files/wstech-api-artefact.zip"
}

resource "aws_lambda_function" "wstech_api" {
  function_name = "wstech_api"
  description   = "Função para validação de usuário"
  handler       = "index.handler"
  role          = data.aws_iam_role.lab_role.arn
  runtime       = var.runtime

  filename         = data.archive_file.wstech_api_artefact.output_path
  source_code_hash = data.archive_file.wstech_api_artefact.output_base64sha256

  timeout     = 5
  memory_size = 128

  layers = [aws_lambda_layer_version.wstech.arn]

  tags = local.common_tags

}
