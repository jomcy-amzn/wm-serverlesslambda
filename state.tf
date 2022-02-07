//Use this for Github automation and comment the http backend code below
terraform {
  backend "s3" {}
}

//Use this for Gitlab and comment s3 backend code above
/*terraform {
  backend "http" {}
}*/

