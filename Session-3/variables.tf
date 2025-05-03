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

