
output "execution-arn" {
  value = aws_apigatewayv2_api.wm-api-gateway.execution_arn
}
output "arn" {
  value = aws_apigatewayv2_api.wm-api-gateway.arn
}

output "invoke_url_get" {
  value = "${aws_apigatewayv2_stage.lambda-stage.invoke_url}/api"
}
