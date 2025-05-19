# When we manage infra across multiple Terraform configs or layers, it's important to share values between them (like VPC IDs, subnet IDs).
# No need to create the same VPC or subnets, Just use the ones already defined and managed.



data "terraform_remote_state" "vpc" {                       # declares a data block named "vpc", pulling in the remote state from another Terraform config
  backend = "s3"                                            # Shows that the state is stored in S3 bucket

  config = {
    bucket = "terraform-session-backend-bucket-erkin"       # Name of the S3 bucket, that contains remote Terraform state file
    key = "session-5-hw/terraform.tfstate"                  # path
    region = "us-west-2"                                    # specifies AWS region where S3 bucket located
    encrypt = true                                          # ensures that .tfstate file is automatically encrypted at rest using SSE-S3 encryption
  }
}



# vpc_id             = data.terraform_remote_state.vpc.outputs.vpc_id
# public_subnet_ids  = data.terraform_remote_state.vpc.outputs.public_subnet_ids
# private_subnet_ids = data.terraform_remote_state.vpc.outputs.private_subnet_ids





# AMI data source
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners = ["amazon"]

  filter{
    name = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter{
    name = "virtualization-type"
    values = ["hvm"]
  }
}



data "aws_route53_zone" "existing_zone" {
  name         = var.domain_name
  private_zone = false
}
