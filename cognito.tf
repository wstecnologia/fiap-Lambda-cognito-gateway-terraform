resource "aws_cognito_user_pool_client" "client" {
  name                         = var.client_name
  generate_secret              = true
  user_pool_id                 = aws_cognito_user_pool.pool.id
  supported_identity_providers = ["COGNITO"]
  callback_urls                = var.callback_urls
  

  allowed_oauth_flows                  = ["code"]           
  allowed_oauth_scopes                 = ["email", "openid"] 
  allowed_oauth_flows_user_pool_client = true
  explicit_auth_flows = [
    "ALLOW_USER_SRP_AUTH",
    "ALLOW_USER_PASSWORD_AUTH",
    "ALLOW_REFRESH_TOKEN_AUTH"
  ]

  token_validity_units {
    access_token  = "minutes"
    id_token      = "minutes"
    refresh_token = "days"
  }

  access_token_validity  = 60 # 1 hora
  id_token_validity      = 60
  refresh_token_validity = 30 # 30 dias

}

resource "aws_cognito_user_pool" "pool" {
  name = var.user_pool_name

  password_policy {
    minimum_length    = 8
    require_uppercase = false
    require_lowercase = false
    require_numbers   = false
    require_symbols   = false
  }

  auto_verified_attributes = ["email"]

  admin_create_user_config {
    allow_admin_create_user_only = false
  }

 schema {
    name     = "cpf"
    attribute_data_type = "String"
    required = false
    mutable  = false

    string_attribute_constraints {
      min_length = 11
      max_length = 14
    }
  }

    schema {
    name     = "name"
    attribute_data_type = "String"
    required = true
    mutable  = true
  }

  schema {
    name     = "email"
    attribute_data_type = "String"
    required = true
    mutable  = true
  }

  account_recovery_setting {
    recovery_mechanism {
      name     = "verified_email"
      priority = 1
    }
  }
}


resource "aws_cognito_user_group" "main" {
  name         = "user-group-wstech"
  user_pool_id = aws_cognito_user_pool.pool.id
  description  = "Managed by Terraform"
  precedence   = 42
}

resource "aws_cognito_user_pool_domain" "user_pool_domain" {
  domain       = var.user_pool_domain
  user_pool_id = aws_cognito_user_pool.pool.id
}

