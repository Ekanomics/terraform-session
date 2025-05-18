resource "aws_instance" "main" {
  ami           = data.aws_ami.amazon_linux_2023.id 
  instance_type = "t2.micro"
  tags = {
    Name        = "Session-9-instance"
    Environment = "dev"
  }
}



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


resource "aws_sqs_queue" "main" {
  name = "session-9-sqs"  
}



# resource "aws_dynamodb_table" "dynamodb-terraform-lock" {
#    name = "terraform-lock"
#    hash_key = "LockID"
#    read_capacity = 20
#    write_capacity = 20

#    attribute {
#       name = "LockID"
#       type = "S"
#    }

#    tags = {
#      Name = "Terraform Lock Table"
#    }
# }