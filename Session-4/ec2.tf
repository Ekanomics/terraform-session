resource "aws_instance" "first_ec2" {
  ami           = data.aws_ami.amazon_linux_2023.id 
  instance_type = var.instance_type
  vpc_security_group_ids = [aws_security_group.main.id]
  tags = {
    Name        = format("%s-instance", var.env)                  # i want name will be changed like: dev-instance, qa-instance, stage-instance, prod-instance..
    Environment = var.env
  }
  user_data = templatefile("userdata.sh", { environment = var.env })
}



################ Security Group #################

resource "aws_security_group" "main" {
  name = "${var.env}-instance-sg"
  description = "Allow HTTP traffic"

}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
  count = length(var.ingress_ports)
  security_group_id = aws_security_group.main.id
  cidr_ipv4         = element(var.ingress_cidr, count.index)
  from_port         = element( var.ingress_ports, count.index)
  ip_protocol       = "tcp"
  to_port           = element( var.ingress_ports, count.index)
}



# Syntax: element(list, index)




# 22, 80, 443 i wanna open these "ingress" ports

# count = 3
# count.index = 0, 1, 2

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.main.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}





# With count meta argument, each second label gets indexed (unique)
# aws_instance.first_ec2[0]
# aws_instance.first_ec2[1]
# aws_instance.first_ec2[2]
# aws_instance.first_ec2[3]
# aws_instance.first_ec2[4]

