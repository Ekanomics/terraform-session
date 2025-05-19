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

variable "instance_type" {
    description = "instance type"
    type = string
    default = "t2.micro"
}


variable "domain_name" {
    description = "domain name"
    type = string
    default = "rundevous.com"
}

variable "owner" {
    description = "Owner of the project"
    type = string
    default = "erkin"
}

variable "managed_by" {
    description = "Managed by"
    type = string
    default = "terraform"
}

variable "provider_name" {
    description = "provider name"
    type = string
    default = "aws"
}


variable "hosted_zone_id" {
    description = "The ID of the Route 53 hosted zone"
    type =string
    default = "Z00463341WOWJM6XVVSDP"
}

