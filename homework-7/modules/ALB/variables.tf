variable "vpc_cidr" {
    description = "VPC CIDR"
    type = string
    default = "10.0.0.0/16"
}


variable "public_subnet_cidrs" {
    description = "public subnet cidrs"
    type = list(string)
    default = ["10.0.0.0/24", "10.0.1.0/24", "10.0.2.0/24"]  
}


variable "private_subnet_cidrs" {
    description = "private subnet cidrs"
    type = list(string)
    default = [ "10.0.3.0/24", "10.0.4.0/24", "10.0.5.0/24" ]  
}


variable "AZ" {
    description = "Availability Zones"
    type = list(string)                                   
    default = ["us-west-2a", "us-west-2b", "us-west-2c"]
}


variable "vpc_id" {}

variable "public_subnet_ids" {
  type = list(string)
}