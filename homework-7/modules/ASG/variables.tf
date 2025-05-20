variable "vpc_id" {}


variable "private_subnet_ids" {
  type = list(string)
}


variable "alb_sg_id" {}


variable "target_group_arn" {}


variable "ami_id" {
  description = "Amazon Linux 2 AMI"
  default     = "ami-0c2b8ca1dad447f8a" # update with latest for your region
}