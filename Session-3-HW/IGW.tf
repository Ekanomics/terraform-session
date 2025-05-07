resource "aws_internet_gateway" "IGW" {
    vpc_id = aws_vpc.my_vpc.id
    tags = {
      Name = "my-igw"
    }
}