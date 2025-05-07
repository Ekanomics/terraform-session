variable "AZ" {
    description = "Availability Zones"
    type = string                                   
    default = ["us-east-1a", "us-east-1b", "us-east-1c"]
}


variable "vpc_cidr" {
    description = "VPC CIDR, IP address range"
    type = string
    default = "10.0.0.0/16"
}
