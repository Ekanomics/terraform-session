# resource "aws_security_group" "main" {
#   name = "${var.env}-instance-sg"
#   description = "Allow HTTP traffic"

# }

# resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
#   count = length(var.ingress_ports)
#   security_group_id = aws_security_group.main.id
#   cidr_ipv4         = element(var.ingress_cidr, count.index)
#   from_port         = element( var.ingress_ports, count.index)
#   ip_protocol       = "tcp"
#   to_port           = element( var.ingress_ports, count.index)
# }
# OLD SECURITY GROUP CREATION



# locals {
#     inbound_ports = 
# }

resource "aws_security_group" "main" {
    name = "security-group"
    description = "allow SSH and HTTP"

    dynamic "ingress" {
        for_each = var.inbound_ports
        iterator = ports
        content {
            from_port   = ports.value.port
            to_port     = ports.value.port
            protocol    = ports.value.protocol
            cidr_blocks = ports.value.cidr_blocks
        }
    }  
}

variable "inbound_ports" {
    type = list(object({
      port = number
      protocol = string
      cidr_blocks = list(string)
    }))
    default = [ 
    {
      port = 80
      protocol = "tcp"
      cidr_blocks = [ "10.0.0.1/32" ]
    },
        {
        port = 22
        protocol = "tcp"
        cidr_blocks = [ "10.0.0.10/32" ]
    },
        {
        port = 443
        protocol = "tcp"
        cidr_blocks = [ "10.0.0.100/32" ]
    } 
    ]
}