require("dotenv").config()
const AWS = require("aws-sdk")
const cognito = new AWS.CognitoIdentityServiceProvider()

exports.handler = async (event) => {
  const { cpf } = JSON.parse(event.body)

  try {
    const params = {
      UserPoolId: process.env.USER_POOL_ID,
      Username: cpf,
    }

    const user = await cognito.adminGetUser(params).promise()

    return {
      statusCode: 200,
      body: JSON.stringify({
        message: "Usuário autenticado",
        user: user,
      }),
    }
  } catch (error) {
    return {
      statusCode: 400,
      body: JSON.stringify({
        message: "Erro de autenticação",
        error: error.message,
      }),
    }
  }
}
