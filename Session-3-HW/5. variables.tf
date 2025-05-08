variable "AZ" {
    description = "Availability Zones"
    type = list(string)                                   
    default = ["us-east-1a", "us-east-1b", "us-east-1c"]
}


variable "vpc_cidr" {
    description = "VPC CIDR, IP address range"
    type = string
    default = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
    description = "public subnets cidrs"
    type = list(string)
    default = ["10.0.0.0/24", "10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
    description = "private subnets cidrs"
    type = list(string)
    default = ["10.0.3.0/24", "10.0.4.0/24", "10.0.5.0/24"]
}

