variable "instance_type" {
    description = "aws instance size or type"
    type = string                                   # could be: string, num, bool, list(string), map, tuple, set
    default = "t2.micro"
}


variable "env" {
    description = "environment"
    type = string
    default = "dev"
}

variable "ami" {
    description = "AMI ID"
    type = string
    default = "xyz"
}

variable "vpc_security_group_ids" {
    description = "security group id"
    type = list(string)
    default = [ "xyz" ] 
}

