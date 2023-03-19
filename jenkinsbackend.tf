terraform {
  backend "s3" {
    bucket = "exam-bucket"
    region = "eu-east-2"
    key = "exam-server/terraform.tfstate"
  }
}