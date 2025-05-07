variable "instance_type" {
    description = "aws instance size or type"
    type = string                                   # could be: string, num, bool, list(string), map, tuple, set
    default = "t2.micro"
}


variable "env" {
    description = "Environment"
    type = string
    default = "dev"
}

variable "ingress_ports" {
    description = "a list of ingress ports"
    type = list(number)
    default = [ 22, 80, 443, 3306 ]
}

variable "ingress_cidr" {
    description = "a list of ingress ports"
    type = list(string)
    default = [ "10.0.0.0/16", "0.0.0.0/0", "0.0.0.0/0", "10.0.0.0/16" ]
}
