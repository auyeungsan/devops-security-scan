provider "aws" {
  region  = "ap-southeast-1"
  profile = "wg-dev"
}

terraform {
  backend "s3" {
    profile        = "wg-dev"
    encrypt        = true
    bucket         = "dev-wg-terraform-remote-state-storage-s3"
    dynamodb_table = "dev-wg-terraform-state-lock-dynamo"
    region         = "ap-southeast-1"
    key            = "development/lambda/infra-cloufront-ip-lambda"
  }
}
