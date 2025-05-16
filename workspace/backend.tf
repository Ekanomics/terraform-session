terraform {
  backend "s3" {
    bucket         = "terraform-session-backend-bucket-erkin"
    key            = "terraform.tfstate"
    region         = "us-west-2"
    encrypt        = true
    workspace_key_prefix = "workspaces"
  }
}



# terraform workspace show -> will show current workspace

# terraform workspace help

# In S3 bucket:
# Syntax: workspace_key_prefix/workspace_name/key
# Example: workspace/workspaces_name/terraform.tfstate