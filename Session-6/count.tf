resource "aws_sqs_queue" "count_queue" {
    count   = length(var.names)
    name    = element(var.names, count.index)
}


variable "names" {
    type = list(string)
    description = "a list aws sqs names"
    default = [ "first", "second", "third" ]
}

# This block of code creates 3 aws sqs. The names are: first, second, third
# "ELEMENT" function is limited to a "LIST"
# Until Terraform 0.13, we used element

# Problem statement: What if i have a "MAP"

# Only to Auto Scaling group you cannot use and apply "MAP"