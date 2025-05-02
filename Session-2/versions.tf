terraform {
  required_version = "~> 1.11.0"    // Terraform Version 
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.96.0"
    }
  }
}

// ~> = Lazy Constraints (means range inside 1.11, can be from 1.11.0 - 1.11.9 and etc.)

// Semantic Versioning = 1.11.4
// 1 = Major (Upgrade) = Breaking Changes
// 11 = Minor (Update) = Features get added
// 4 = Patch (Patch) = Fix bugs, vulnerabilities

