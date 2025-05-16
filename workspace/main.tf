resource "aws_sqs_queue" "main" {
    name = "${terraform.workspace}-sqs" 
}


# How to reference to workspace -            terraform.workspace
# terraform.workspace = current workspace name

# terraform workspace new dev -> this command creates new workspace with the name "dev"

# Each workspace will have its own terraform.tfstate file