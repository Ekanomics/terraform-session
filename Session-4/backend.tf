terraform {
  backend "s3" {
    bucket         = "terraform-session-backend-bucket-erkin"
    key            = "session-4/terraform.tfstate"
    region         = "us-west-2"
    encrypt        = true
  }
}
