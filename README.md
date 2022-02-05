# Lambda Web Application


A sample web application along with Infrastructure as Code for demonstration a
This project aims at deploying a sample web application on a Lambda .
This  project architecture demonstrates how to use AWS Lambda in conjunction with Amazon API Gateway, Amazon DynamoDB and Amazon Cognito to build a serverless web application.
Assumptions :
As a best practise all versions are pinned

**Requirements:**
IaC Code for provisioning AWS Lambda
a simple web application that runs on AWS Lambda that prints the request header, method, and body.
A VPC  with  2 private subnets VPC ID : vpc-xxx as an input to make Lambda private (optional)
Role and policy for AWS Lambda function
set up a GitHub repository with the following structure:
   - Root directory to store your main terraform code.
   - A .github directory which you will then create a workflows directory in and store your GitHub Action configuration files.
   - A .terraform directory where you will store your Terraform configuration files.
   a RESTful API for backend processing using Amazon API Gateway, AWS Lambda and Amazon DynamoDB

## Pre- Requisites
 - An AWS Account with user credentials with permission to deploy AWS resources ( Eg: Attach role: Administrator)
 - A Github/GitLab account
 - Secret variables added for AWS credentials ,Please refer[this page](https://docs.github.com/en/actions/security-guides/encrypted-secrets)
 -

Step 1:
configure Terraform to reference your AWS account
## Modules

- app-layer : creates app layer which includes a private Classic Load balancer, Application EC2 servers with an autoscaling group and associated security group.
- web-layer : creates web layer which includes a private CLassic Load balanecr, Web EC2 servers with an autoscaling group and associated security group.
- database-layer : creates database layer which includes a Postgres DB with associated security group.

## Features

- deploy ec2 instance with auto scaling and classic loabalancer in the application layer  
- deploy ec2 instance with auto scaling and classic loabalancer in the Web layer
- deploy RDS instance in the DB layer
- Security Group for the application layer
- Security Group for the Web layer
- Security Group for the DB layer
- RDS has Multi-AZ set to true for high availability


## Test case
curl --header "Content-Type: application/json" --data '{"username":"xyz","password":"xyz"}' http://${URL}:${PORT}/api
Response:

Welcome to our demo API, here are the details of your request:

Headers: Content-Type: application/json

Method: Get Body: {"username":"xyz", "password":"xyz"}

For Verify the code functionality , Execute the below code
```shell script
$ curl $(terraform output -raw wm-read_url)
```


[comment]: # ( An optional Route53 module   to bind the domain url to privatesubnet of  We b VPC)


## Usage

- Update .config file in backend-config/ directory to set appropriate backend for each environment
- Initiate terraform with the configured backend using below command:

~~~
terraform init -backend-config=backend-configs/dev.config
~~~

- Update .tfvars present in environments directory with VPC ,subnet and other details
- Based on the environment execute below commands to plan or deploy the infrastucture

~~~
terraform plan -var-file=environments/dev.tfvars
terraform apply -var-file=environments/dev.tfvars
~~~

- When not required feel free to destroy the infrastucture as shown below

~~~
terraform destroy -var-file=environments/dev.tfvars
~~~

# Doc Generated automatically from Terraform Docs

<!--- BEGIN_TF_DOCS --->


<!--- END_TF_DOCS --->


<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | 1.1.5 |
| <a name="requirement_archive"></a> [archive](#requirement\_archive) | 2.2.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 3.74.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 3.74.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 3.74.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_wm-apigw"></a> [wm-apigw](#module\_wm-apigw) | ./modules/api-gateway | n/a |
| <a name="module_wm-lambda"></a> [wm-lambda](#module\_wm-lambda) | ./modules/lambda | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/3.74.0/docs/data-sources/caller_identity) | data source |
| [aws_partition.current](https://registry.terraform.io/providers/hashicorp/aws/3.74.0/docs/data-sources/partition) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/3.74.0/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_apigw_name"></a> [apigw\_name](#input\_apigw\_name) | Name of Api gateway | `string` | `"my_lambda_api_gateway"` | no |
| <a name="input_lambda_name"></a> [lambda\_name](#input\_lambda\_name) | Name of Lambda function | `string` | `"my_lambda_fucntion"` | no |
| <a name="input_region"></a> [region](#input\_region) | Region for deploying infrastucture | `string` | `"us-west-2"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_wm-read_url"></a> [wm-read\_url](#output\_wm-read\_url) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
