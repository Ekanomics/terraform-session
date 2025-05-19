output "vpc_id" {
    description = "ID of the VPC"
    value = aws_vpc.my_vpc.id
}


output "public_subnet_ids" {
    description = "list of public subnet IDs"
    value = [aws_subnet.public[*].id]
}


output "private_subnet_ids" {
    description = "list of private subnet IDs"
    value = [aws_subnet.private[*].id]
}


output "alb_dns_name" {
    description = "DNS name of the Application Load Balancer"
    value = aws_lb.app_lb.dns_name
}

output "amazon_linux_ami_id" {
  value = data.aws_ami.amazon_linux.id
}



# output "internet_gateway_id" {
#     description = "Internet gateway ID"
#     value = aws_internet_gateway.IGW.id
# }


# output "nat_gateway_id" {
#     description = "NAT gateway ID"
#     value = aws_nat_gateway.NAT.id
# }


# output "nat_gateway_eip" {
#     description = "Elastic IP attached to the NAT gateway"
#     value = aws_eip.NAT.public_ip
# }


# output "availaibility_zones" {
#     description = "Availability zones used for subnets"
#     value = var.AZ
# }


# output "public_route_table_id" {
#     description = "ID of the public route table"
#     value = aws_route_table.public.id
# }


# output "private_route_table_id" {
#     description = "ID of the private route table"
#     value = aws_route_table.private.id
# }

