
module "wm-lambda" {
  source      = "./modules/lambda"
  fn_name     = "jm-test_function"
  account_id  = data.aws_caller_identity.current.account_id
  region      = data.aws_region.current.id
  description = "jm-test Lambda"
  source_arn  = "${module.wm-apigw.execution-arn}/*/GET/hello" //"${aws_api_gateway_rest_api api_gateway.execution_arn}/*/GET/hello"
  //subnet_ids        = module.vpc.private_subnets
  //worker_security_group_id

}

module "wm-apigw" {
  source          = "./modules/api-gateway"
  integration_uri = module.wm-lambda.invoke-arn
  lambda_arn      = module.wm-lambda.arn
}
