# GitLab demo on Auto deployment for Lambda Web Application
This pattern demonstrates a GitOps approach with IaC using Gitlab CI/CD.
This shows an example of how to automate the build and deployment of an IaC code for provisioning AWS Lamnda and API Gateway for deploying  a sevrerless web application using gitlab cicd
Using Gitlab for Terraform state management which allows multiple engineers to work together to develop the infrastructure
Validation checks for the code
 Note : This pattern needs Gitlab version 14.5 or above

## Pre- Requisites
 - An AWS Account with user credentials with permission to deploy AWS resources ( Eg: Attach role: Administrator)
 - configure Terraform to reference your AWS account
 - A GitLab.com account reference your AWS account

### Step 1: Clone this repo

## Step 2: Create a new git repo in your GitLab group and copy files from examples/advanced/gitlab-ci-cd folder to the root of your new GitLab repo
    cd examples/gitlab-example
    cp . $YOUR_GITLAB_REPO_ROOT

## Step 3: Update project settings-> CI/CD ->Variables
 - Login to the GitLab console, Open your repo and navigate to `settings->ci_cd->Variables`
 - Update the following variables as Key Value pairs  before triggering the pipeline

        AWS_ACCESS_KEY_ID           e.g., access key from devops admin iam role
        AWS_SECRET_ACCESS_KEY       e.g., secret key from devops admin iam role
        AWS_REGION                  e.g., eu-west-1

## Step 4: Update variables in input.tfvars file

## Step5: Commit changes and push to verify the pipeline
Manually trigger the `tf-apply` to provision the resources

## Step6: Verify whether the state file update happened in your project (Infrastructure->Terraform-states)

## Step7: (Optional)  Manually Install, Configure and Run GitLab Agent for Kubernetes (“Agent”, for short) is your active in-cluster.
This is for or connecting Kubernetes clusters to GitLab. Refer https://docs.gitlab.com/ee/user/clusters/agent/install/index.html
## Step8: Cleanup the deployed resources
Manually trigger the `tf-destroy` stage in the GitLab Ci/CD pipeline to destroy your deployment.



## Features
A sample web application as a serverless worklload with its Infrastructure as Code for demonstrationcontinuos deployment
This project will deploy following AWS services
  1. A Lambda function with a function which prints the request header, method, and body
  2. Role and policy for AWS Lambda function
  3. An API Gateway integrate with Lambda function

This project also has a .github directory which defines a CICD pipeline to build and deploy the terraform code
- .gitlab.yaml defines a gitlab build an deployment pipeline for the project

## Test case
curl --header "Content-Type: application/json" --data '{"username":"xyz","password":"xyz"}' http://${URL}:${PORT}/api
Response:



Headers: Content-Type: application/json



For Verify the code functionality , Execute the below code
```shell script
$ curl $(terraform output -raw wm-read_url)
```


[comment]: # ( An optional Route53 module   to bind the domain url to privatesubnet of  We b VPC)


## Usage

- Update .config file in backend-config/ directory to set appropriate backend for each environment
- Initiate terraform with the configured backend using below command:
##Feature branch workflow
####1. Clone project:
    ```shell script
    git clone https://github.com/jomcy-amzn/wm-serverlesslambda.git
    ```
####2.Create branch with your feature:
   ```shell script
    git checkout -b feature_name
  ```

####3. Write code. Commit changes:
   ```shell script
   git commit -am "My feature is ready"
   ```
####4. Run and validate the deployments
   - Update .tfvars present in environments directory with VPC ,subnet and other details
   - Based on the environment execute below commands to plan or deploy the infrastucture

```shell script
   terraform init -backend-config=backend-configs/dev.config
   terraform plan -var-file=dev.tfvars
   terraform apply -var-file=dev.tfvars
```

 - For clean up destroy the infrastucture as shown below
   ~~~
   terraform destroy -var-file=environments/dev.tfvars
   ~~~
####5. Push your branch to GitLab:
```shell script
git push origin feature_name
```
####6. Review your code on commits page.

####7. Create a merge request.

####8. Let our team lead reviews the code and merges it to the main branch.


## Details
This session is autogenerated by terraform-docs

<!--- BEGIN_TF_DOCS --->


<!--- END_TF_DOCS --->


<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_wm-gitlab-demo"></a> [wm-gitlab-demo](#module\_wm-gitlab-demo) | git::https://github.com/jomcy-amzn/wm-serverlesslambda.git | n/a |

## Resources

No resources.

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|

| <a name="output_wm_get_url"></a> [wm\_get\_url](#output\_wm\_get\_url) | n/a |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## FAQ
- ### What's gitlab-terraform?

    - `gitlab-terraform` is a thin wrapper around the `terraform` binary. as part of the [GitLab Terraform docker image](https://gitlab.com/gitlab-org/terraform-images) used in `.gitlab-ci.yml`.
- ### In case your tf-apply stage is failed in between
    -  Correct the source code ,commit and push the code  or ensure you manually trigger tf-destroy stage and cleanup the provisioned resources
