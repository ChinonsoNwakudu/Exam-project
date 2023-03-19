terraform {
  backend "s3" {
    bucket = "exam-bucket"
    region = "us-west-2"
    key = "jenkins-server/terraform.tfstate"
  }
}