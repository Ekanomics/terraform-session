data "terraform_remote_state" "vpc" {
  backend = "s3"

  config = {
    bucket = "terraform-session-backend-bucket-erkin"
    key = "session-5-hw/terraform.tfstate"
    region = "us-west-2"
    encrypt = true
  }
}


vpc_id             = data.terraform_remote_state.vpc.outputs.vpc_id
public_subnet_ids  = data.terraform_remote_state.vpc.outputs.public_subnet_ids
private_subnet_ids = data.terraform_remote_state.vpc.outputs.private_subnet_ids





# AMI data source
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners = ["amazon"]

  filter{
    name = "aws_ami"
    values = ["amzn2-avi-hvm-8-x86_64-gp2"]
  }
}



