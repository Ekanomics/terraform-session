variable "AZ" {
    description = "Availability Zones"
    type = list(string)                                   
    default = ["us-west-2a", "us-west-2b", "us-west-2c"]
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





variable "env" {
    description = "Environment: dev, qa, stage, prod"
    type = string
    default = "dev"
}

