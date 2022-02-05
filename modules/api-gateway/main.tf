#create an aws api

resource "aws_apigatewayv2_api" "wm-api-gateway" {
  name          = "wm-serverless_lambda"
  protocol_type = "HTTP"
  description   = "Api access to lambda"
}
resource "aws_apigatewayv2_stage" "lambda-stage" {
  api_id      = aws_apigatewayv2_api.wm-api-gateway.id
  name        = "serverless_lambda_dev"
  auto_deploy = true
}

resource "aws_apigatewayv2_integration" "lambda-integration" {
  api_id = aws_apigatewayv2_api.wm-api-gateway.id


  connection_type      = "INTERNET"
  description          = "serverless_lambda for WM"
  integration_type     = "AWS_PROXY"
  integration_method   = "POST"
  integration_uri      = var.integration_uri
  passthrough_behavior = "WHEN_NO_MATCH"

}

resource "aws_apigatewayv2_route" "lambda-route" {
  api_id    = aws_apigatewayv2_api.wm-api-gateway.id
  route_key = "GET /hello" //"$default"
  target    = "integrations/${aws_apigatewayv2_integration.lambda-integration.id}"
}

resource "aws_lambda_permission" "api-gw" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:invokeFunction"
  function_name = var.lambda_arn
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.wm-api-gateway.execution_arn}/*/*/*"
}


/*
resource "aws_api_gateway_rest_api_policy" "test" {
  rest_api_id = aws_apigatewayv2_api.wm-api-gateway.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "*"
      },
      "Action": "execute-api:Invoke",
      "Resource": "${aws_apigatewayv2_api.wm-api-gateway.execution_arn}",
      "Condition": {
        "IpAddress": {
          "aws:SourceIp": "123.123.123.123/32"
        }
      }
    }
  ]
}
EOF
}*/
