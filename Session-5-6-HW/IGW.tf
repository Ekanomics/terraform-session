resource "aws_internet_gateway" "IGW" {
    vpc_id = aws_vpc.my_vpc.id

    tags = {
      Name = "my-igw"
    }
}



resource "aws_eip" "NAT" {
  tags = {
    Name = "NAT-EIP"
  }
}
# Creating elastic IP(EIP) in VPC. Attached to NAT Gateway, so it can send/receive traffic. Cannot launch NAT Gateway without Elastic IP


resource "aws_nat_gateway" "NAT" {
  allocation_id = aws_eip.NAT.id                  # allows private subnets access internet via NAT
  subnet_id     = aws_subnet.public[0].id         # Must be public subnet:

# Privaate subnets have no direct route to the internet (no IGW attached).
# The NAT Gateway acts as a middleman: private resources route their outbound internet traffic to the NAT Gateway.
# The NAT Gateway must live in a public subnet, where it has: a public IP (Elastic IP) and access to the IGW
# This way, the NAT can forward requests to the Internet and relay responses back to the private resources.


  tags = {
    Name = "NAT gateway"
  }
  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.IGW]
}

