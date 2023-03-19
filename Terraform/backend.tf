terraform {
  backend "s3" {
    bucket = "exam-server"
    region = "eu-west-2"
    key = "exam-server/terraform.tfstate"
  }
}