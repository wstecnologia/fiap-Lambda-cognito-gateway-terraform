resource "null_resource" "install_layer_deps" {
  triggers = {
    layer_build = filemd5("${local.layers_path}/wstech/nodejs/package.json")
  }

  provisioner "local-exec" {
    working_dir = "${local.layers_path}/wstech/nodejs"
    command     = "npm install"
  }
}

data "archive_file" "wstech_layer" {
  output_path = "files/wstech-layer.zip"
  type        = "zip"
  source_dir  = "${local.layers_path}/wstech"

  depends_on = [null_resource.install_layer_deps]
}

resource "aws_lambda_layer_version" "wstech" {
  layer_name          = "wstech-layer"
  description         = "^11.8.2"
  filename            = data.archive_file.wstech_layer.output_path
  source_code_hash    = data.archive_file.wstech_layer.output_base64sha512
  compatible_runtimes = [var.runtime]
}