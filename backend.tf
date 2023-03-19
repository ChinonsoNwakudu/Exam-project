terraform {
  backend "s3" {
    bucket = "exam-bucket"
    region = "eu-west-2"
    key = "jenkins-server/terraform.tfstate"
  }
}