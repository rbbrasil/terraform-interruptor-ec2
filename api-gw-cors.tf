resource "aws_api_gateway_method" "method_options" {
  rest_api_id   = aws_api_gateway_rest_api.api_gateway.id
  resource_id   = aws_api_gateway_resource.resource.id
  http_method   = "OPTIONS"
  authorization = "NONE"
}

resource "aws_api_gateway_method_response" "method_response_options" {
  rest_api_id     = aws_api_gateway_rest_api.api_gateway.id
  resource_id     = aws_api_gateway_resource.resource.id
  http_method     = aws_api_gateway_method.method_options.http_method
  status_code     = 200
  response_models = { "application/json" = "Empty" }

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = true,
    "method.response.header.Access-Control-Allow-Methods" = true,
    "method.response.header.Access-Control-Allow-Origin"  = true
  }

  depends_on = [aws_api_gateway_method.method_options]
}

resource "aws_api_gateway_integration" "options_integration" {
  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  resource_id = aws_api_gateway_resource.resource.id
  http_method = aws_api_gateway_method.method_options.http_method
  type        = "MOCK"
  request_templates = {
    "application/json" = <<PARAMS
{ "statusCode": 200 }
PARAMS
  }

  depends_on = [aws_api_gateway_method.method_options]
}

resource "aws_api_gateway_integration_response" "options_integration_response" {
  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  resource_id = aws_api_gateway_resource.resource.id
  http_method = aws_api_gateway_method.method_options.http_method
  status_code = aws_api_gateway_method_response.method_response_options.status_code

  response_templates = { "application/json" = "Empty" }

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'",
    "method.response.header.Access-Control-Allow-Methods" = "'GET,OPTIONS,POST,PUT'",
    "method.response.header.Access-Control-Allow-Origin"  = "'*'"
  }

  depends_on = [aws_api_gateway_method_response.method_response_options]
}
