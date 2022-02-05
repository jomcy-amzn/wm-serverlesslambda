# Lambda Web Application


A sample web application along with Infrastructure as Code for demonstration a
This project aims at deploying a sample web application on a Lambda .
This  project architecture demonstrates how to use AWS Lambda in conjunction with Amazon API Gateway, Amazon DynamoDB and Amazon Cognito to build a serverless web application.
Assumptions :
As a best practise all versions are pinned


Requirements:
IaC Code for provisioning AWS Lambda
a simple web application that runs on AWS Lambda that prints the request header, method, and body.
A VPC  with  2 private subnets VPC ID : vpc-xxx as an input to make Lambda private (optional)
Role and policy for AWS Lambda function
set up a GitHub repository with the following structure:
   - A directory called src which you will store your website code.
   - A .github directory which you will then create a workflows directory in and store your GitHub Action configuration files.
   - A terraform directory where you will store your Terraform configuration files.
   a RESTful API for backend processing using Amazon API Gateway, AWS Lambda and Amazon DynamoDB

## Pre- Requisites

- A VPC  with  6 private subnets VPC ID : vpc-xxx
- Subnet IDs of web-subnet-1 and web-subnet-2 resources create our web layer in two availability zones ( private subnets in region-1a and region-1b)
- Subnet IDs of App-subnet-1 and app-subnet-2 resources create our app layer in two availability zones( private subnets in region-1a and region-1b)
- Subnet IDs of Database-subnet-A and Database-subnet-B resources create the database layer in two availability zones. (private subnet in region-1a and region-1b)

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


[comment]: # ( An optional Route53 module   to bind the domain url to privatesubnet of  We b VPC)

- Rotate Amazon RDS database credentials automatically with AWS Secrets Manager
- No elastic IPs

[comment]: # (Use user data to bootstrap web and app servers)

## Usage

- Update .config file in backend-config/ directory to set appropriate backend for each environment
- Initiate terrafrom with the configured backend using below command:

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
