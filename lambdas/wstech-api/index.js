exports.handler = async (event) => {
  // Mensagem que será retornada
  const cpf = event.userName
  const mensagem = "Olá, Mundo!"

  // Retorno da resposta no formato esperado pela Lambda
  return {
    statusCode: 200, // Código de status HTTP
    body: JSON.stringify({
      message: cpf,
    }),
  }
}

function isValidCPF(cpf) {
  cpf = cpf.replace(/[^\d]+/g, "")
  if (cpf.length !== 11 || /^(\d)\1+$/.test(cpf)) return false

  let sum = 0
  for (let i = 0; i < 9; i++) {
    sum += parseInt(cpf.charAt(i)) * (10 - i)
  }
  let rev = 11 - (sum % 11)
  if (rev === 10 || rev === 11) rev = 0
  if (rev !== parseInt(cpf.charAt(9))) return false

  sum = 0
  for (let i = 0; i < 10; i++) {
    sum += parseInt(cpf.charAt(i)) * (11 - i)
  }
  rev = 11 - (sum % 11)
  if (rev === 10 || rev === 11) rev = 0
  if (rev !== parseInt(cpf.charAt(10))) return false

  return true
}
