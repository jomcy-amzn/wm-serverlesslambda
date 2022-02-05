data "archive_file" "wm-webpage" {
  type        = "zip"
  source_file = "${path.module}/templates/webpage.js"
  output_path = "./webpage.zip"
}


# lambda assume role policy
# trust relationships
data "aws_iam_policy_document" "lambda_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

/*resource "aws_iam_role" "lambda_role" {
  name               = "${var.fn_name}-lambda-role" //"${var.project_name}-lambda-role"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role_policy.json
}*/

resource "aws_iam_role" "lambda-execution-role" {
  name = "${var.fn_name}-lambda-execution-role"

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

resource "aws_iam_role_policy" "lambda-execution-policy" {
  name = "${var.fn_name}-lambda-execution-policy"

  role = aws_iam_role.lambda-execution-role.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "Stmt1644059439728",
      "Action": "cloudwatch:*",
      "Effect": "Allow",
      "Resource": "*"
    },
    {
      "Sid": "Stmt1644059595654",
      "Action": [
        "apigateway:GET"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}
//"Resource": "arn:aws:apigateway:${Region}::${ApiGatewayResourcePath}."
resource "aws_iam_role_policy_attachment" "AWSLambdaVPCAccessExecutionRole" {
  role       = aws_iam_role.lambda-execution-role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"
}

//Creates a Lambda Function
resource "aws_lambda_function" "wm-lambda" {
  function_name    = "${var.fn_name}-LambdaProxyIntegration"
  description      = var.description
  filename         = "webpage.zip"
  role             = aws_iam_role.lambda-execution-role.arn
  source_code_hash = filebase64sha256(data.archive_file.wm-webpage.output_path)
  handler          = "webpage.handler"
  runtime          = "nodejs12.x"

  /*  vpc_config {
    subnet_ids         = var.subnet_ids
    security_group_ids = [var.worker_security_group_id]
  }*/
  environment {
    variables = {

      region = var.region
    }
  }
  tracing_config {
    mode = "Active"
  }
}

resource "aws_lambda_alias" "alias_dev" {
  name             = "dev"
  description      = "dev"
  function_name    = aws_lambda_function.wm-lambda.arn
  function_version = "$LATEST"
}
resource "aws_lambda_alias" "alias_prod" {
  name             = "prod"
  description      = "prod"
  function_name    = aws_lambda_function.wm-lambda.arn
  function_version = "$LATEST"
}

resource "aws_lambda_permission" "lambda_permission" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.wm-lambda.function_name
  principal     = "apigateway.amazonaws.com"

  # The "/*/*" portion grants access from any method on any resource
  # within the API Gateway REST API.
  source_arn = var.source_arn
}
resource "aws_lambda_permission" "permission_dev" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.wm-lambda.function_name}:dev"
  principal     = "apigateway.amazonaws.com"

  # The "/*/*" portion grants access from any method on any resource
  # within the API Gateway REST API.
  source_arn = var.source_arn //"${aws_api_gateway_rest_api.api_gateway.execution_arn}/*/GET/hello"
}

resource "aws_lambda_permission" "permission_prod" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.wm-lambda.function_name}:prod"
  principal     = "apigateway.amazonaws.com"

  # The "/*/*" portion grants access from any method on any resource
  # within the API Gateway REST API.
  source_arn = var.source_arn
}
