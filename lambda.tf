resource "aws_lambda_function" "lambda_function" {
  function_name = var.lambda_nome
  role          = aws_iam_role.lambda_iam.arn
  handler       = "main.lambda_handler"
  filename      = "./lambda_function/lambda.zip"
  runtime       = "python3.8"

}

// TODO - rever essa role, acho que ta errada
resource "aws_iam_role" "lambda_iam" {
  name = "Role_${var.lambda_nome}"

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
				{
					 "Action": "sts:AssumeRole",
					 "Principal": {
					 "Service": "lambda.amazonaws.com"
					 },
					 "Effect": "Allow",
					 "Sid": ""
				}
			]
}
EOF
}

resource "aws_iam_policy" "restart_ec2" {
  name        = "ReiniciarEC2"
  description = "Politica para iniciar e para instancias EC2"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "ec2:Start*",
                "ec2:Stop*"
            ],
            "Resource": "*"
        }
			]
}
EOF
}

resource "aws_iam_role_policy_attachment" "reiniciar_ec2" {
  role       = aws_iam_role.lambda_iam.name
  policy_arn = aws_iam_policy.restart_ec2.arn
}

resource "aws_lambda_permission" "invocacao_api_lambda" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_nome
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.api_gateway.execution_arn}/*/*"
}

