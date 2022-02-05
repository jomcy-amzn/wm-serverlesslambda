variable "region" {
  description = "Region for deploying infrastucture"
  default     = "us-west-2"
}
variable "apigw_name" {
  description = "Name of Api gateway"
  default     = "my_lambda_api_gateway"
}
variable "lambda_name" {
  description = "Name of Lambda function"
  default     = "my_lambda_fucntion"
}
