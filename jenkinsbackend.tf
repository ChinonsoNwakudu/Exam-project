terraform {
  backend "s3" {
    bucket = "exam-bucket"
    region = "eu-west-2"
    key = "exam-server/terraform.tfstate"
  }
}