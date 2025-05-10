# resource "aws_sqs_queue" "for_each_queue" {
#     for_each = var.for_each_names
#     name    = each.value
# }


# variable "for_each_names" {
#     type = map
#     description = "a map of sqs names"
#     default = {
#         first = "first-for-each-sqs"
#         second = "second-for-each-sqs"
#         third = "third-for-each-sqs"
#     }
# }


# for_each meta argument orks with both a "MAP" and a "LIST"


resource "aws_sqs_queue" "for_each_queue" {
    for_each = toset( local.queue_names )
    name    = each.key
}
# FOR EXPRESSION
locals {
  queue_names = [ for i in range(1, 4) : "queue-${i}"]
}

