resource "aws_subnet" "public" {
    count = length(var.AZ)
    vpc_id = aws_vpc.my_vpc.id
    cidr_block = cidrsubnet(var.vpc_cidr, )
}

