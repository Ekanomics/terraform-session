resource "aws_route_table" "public" {
    vpc_id = aws_vpc.my_vpc.id

    route {
        cidr_block = "10.0.0.0/16"
        gateway_id = "local"
    }

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.IGW.id
    }

    tags = {
        Name = "public_rt"
    }
}



resource "aws_route_table" "private" {
    vpc_id = aws_vpc.my_vpc.id

    route {
        cidr_block = "10.0.0.0/16"
        gateway_id = "local"
    }

    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.NAT.id
    }

    tags = {
        Name = "private-rt"
    }
}





# _______________________________________________________ #
# Route Table Associations

resource "aws_route_table_association" "public_association" {
    count          = length(var.AZ)
    subnet_id      = aws_subnet.public[count.index].id
    route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private_association" {
    count          = length(var.AZ)
    subnet_id      = aws_subnet.private[count.index].id
    route_table_id = aws_route_table.private.id
}



