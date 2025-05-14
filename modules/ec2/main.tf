resource "aws_instance" "main" {
  ami           = var.ami
  instance_type = var.instance_type
  tags = {
    Name = "${var.env}-instance"
    Name        = format("%s-instance", var.env)                  # i want name will be changed like: dev-instance, qa-instance, stage-instance, prod-instance..
    Environment = var.env
  }
  vpc_security_group_ids = var.vpc_security_group_ids
}

