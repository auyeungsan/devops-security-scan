locals {
  default_tags = {
    BillingTag : "team-infra",
    Billing : "team-infra",
    Team : "infra",
    env : "dev"
  }


  lambda-function-name = "dev-infra-cloufront-ip-lambda"
  scg-lambda-function = "scg-dev-cloufront-ip-lambda"
  role-name = "dev-infra-cloufront-ip-lambda-role"
  iam-logging-policy-name = "dev-cloufront-ip-lambda-logging"
  iam-waf-policy-name = "dev-cloufront-ip-lambda-waf-policy"
  lambda_event_description    = "Development cloudfront ip update lambda function event"
  subnet_ids = ["subnet-02a7bc17eb38301ef","subnet-0e0ce2c76de834f14"]

}
data "aws_vpc" "dev" {
  tags = {
    Name = "wg-development-cluster-vpc"
  }
}