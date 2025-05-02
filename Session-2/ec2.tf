resource "aws_instance" "first_ec2" {
  ami           = "ami-07b0c09aab6e66ee9"
  instance_type = "t2.micro"
  tags = {
    Name        = "testing"
    Environment = "dev"
  }
}

resource "aws_instance" "second_ec2" {
  ami           = "ami-07b0c09aab6e66ee9"
  instance_type = "t2.micro"
  tags = {
    Name        = "testing"
    Environment = "dev"
  }
}

resource "aws_security_group" "simple_sg" {
  name = "simple-sg"
  description = "This is a test security group"

  ingress {
    from_port        = 22                       # Numbers does not use ""
    to_port          = 22
    protocol         = "tcp"                    # Everything inside "" - string
    cidr_blocks      = ["0.0.0.0/0"]            # List of string
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"                     # tcp, udp, icmp - all traffic (all protocols allowed in AWS security groups)
    cidr_blocks      = ["0.0.0.0/0"]
  }
}

# Interpolation

# Block & Argument
# Terraform has 2 main blocks (resource vs data source)
# Resource block = create and manage resources
# Resource block has 2 labels = first_label and second_label
# FIRST_LABEL = indicates the resource that you want to create or manage, defined by Hashicorp
# SECOND_LABEL = indicates logical name or logical ID for your Terraform resource, unique within your working directory, defined by Author(by us) (not the name of EC2 instance, it's the name of the block in Terraform)
# Arguments  = configuration of your resource


# Provider block is MUST (providers.tf) - is the first file to create

# Versions file is the second file



