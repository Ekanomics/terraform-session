resource "aws_instance" "first_ec2" {
  count = 5 # MetaArgument
  ami           = data.aws_ami.amazon_linux_2023.id 
  instance_type = var.instance_type
  vpc_security_group_ids = [aws_security_group.my-terraform-webserver-sg.id]
  tags = {
    Name        = format("%s-instance", var.env)                  # i want name will be changed like: dev-instance, qa-instance, stage-instance, prod-instance..
    Environment = var.env
  }
  user_data = templatefile("userdata.sh", { environment = var.env })
}


# Reference to Resource
# Syntax: first_label.second_label.attribute

# Reference to Input Variable
# Syntax: var.variable_name
# Example: var.instance_type

# Reference to Data Source:
# Syntax: data.first_label.second_label.attribute
# Example: data.aws_ami.amazon_linux_2023.id 

resource "aws_security_group" "my-terraform-webserver-sg" {
  name = "my-terraform-webserver-sg"
  description = "Allow HTTP traffic"

  ingress {
    from_port        = 80                       # Numbers does not use ""
    to_port          = 80
    protocol         = "tcp"                    # Everything inside "" - string
    cidr_blocks      = ["0.0.0.0/0"]            # List of strings
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"                     # tcp, udp, icmp - all traffic (all protocols allowed in AWS security groups)
    cidr_blocks      = ["0.0.0.0/0"]
  }
}