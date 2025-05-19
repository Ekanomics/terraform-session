# __________________________
# SG Launch template

resource "aws_security_group" "lt_sg" {
  name   = "lt-sg"                                                  # Creating sg for instances launched via the launch template
  vpc_id = data.terraform_remote_state.vpc.outputs.vpc_id           # vpc_id is pulled from the remote VPC module

  ingress {                                                         # Allowing incoming HTTP traffic on port 80, only from the ALB's security group
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.alb_sg.id]
  }

  egress {                                                          # Allowing all outbound traffic
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "lt-sg"
  }
}



# ___________________________
# Launch Template
resource "aws_launch_template" "app_lt" {
  name          = "${var.env}-app-lt"
  image_id      = data.aws_ami.amazon_linux.id                      # Specifying which AMI to use (Amazon Linux 2023)
  instance_type = var.instance_type

  network_interfaces {
    security_groups             = [aws_security_group.lt_sg.id]     #Assigning EC2 security group, which we created
    associate_public_ip_address = false                             # These EC2instances will not get public IPs (false), since they're in private subnets
  }

  user_data = base64encode(templatefile("${path.module}/user_data.sh", {
    environment = var.env
  }))

  tags = {
    Name = "app-lt"
  }
}



# Created a SG and launch template for EC2 Instances to be deployed in private subnets