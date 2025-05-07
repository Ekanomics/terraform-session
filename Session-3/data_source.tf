# Fetch Amazon Linux 2023 AMI ID
data "aws_ami" "amazon_linux_2023" {
  most_recent      = true
  owners           = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.7.*"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}


# 15 to 20 information will be fetched


# data "template_file" "user_data" {
#   template = file("userdata.sh")
#   vars = {
#     environment = var.env
#     # variable in bash = variable in terraform
#   }
# }


# This block of code works, we just tried different approach
