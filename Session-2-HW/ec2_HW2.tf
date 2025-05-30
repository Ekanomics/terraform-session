resource "aws_instance" "first_ec2" {
  ami           = "ami-07b0c09aab6e66ee9" 
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.my-terraform-webserver-sg.id]
  tags = {
    Name        = "my-terraform-webserver"
  }
  user_data = <<-EOF
              #!/bin/bash
              dnf install -y httpd
              systemctl enable httpd
              systemctl start httpd
              echo "<html><body><h1>Session-2 homework is complete! </h1></body></html>" > /var/www/html/index.html
              EOF
}


resource "aws_security_group" "my-terraform-webserver-sg" {
  name = "my-terraform-webserver-sg"
  description = "Allow HTTP traffic"

  ingress {
    from_port        = 80                       # Numbers does not use ""
    to_port          = 80
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