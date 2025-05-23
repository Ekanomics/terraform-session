resource "aws_subnet" "public" {
    count = length(var.AZ)
    vpc_id = aws_vpc.my_vpc.id
    cidr_block = var.public_subnet_cidrs[count.index]
    availability_zone = var.AZ[count.index]

    tags = {
        Name = "public_subnet_${count.index}"
    }
}


resource "aws_subnet" "private" {
    count = length(var.AZ)
    vpc_id = aws_vpc.my_vpc.id
    cidr_block = var.private_subnet_cidrs[count.index]
    availability_zone = var.AZ[count.index]

    tags = {
        Name = "private_subnet_${count.index}"
    }
}