######### Root Module ##########
# ______________________________



module "sg" {
  source = "../../modules/sg"    # Where the child module is. WHen you call child module locally, you use the path
  ##### Variables #######
  name = "prod-instance-sg"
  description = "This a sg for prod instance"
  ingress_ports = [ 22 ]
  ingress_cidr = [ "10.0.0.0/32" ]
}


module "ec2" {
  source = "../../modules/ec2"
  ### variables
  env = "prod"
  instance_type = "t2.micro"
  ami = data.aws_ami.amazon_linux_2023.id         # Reference to Data Source
  vpc_security_group_ids = [module.sg.security_group_id]         # Reference to Child Module
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




