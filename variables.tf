terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    tags = {
      Project     = "Internship Program"
      Environment = "Dev"
      Owner       = "Silvio Depetri"
      CostCenter  = ""
    }
  }
}

# provider "aws" {
#   region = "us-east-2"
#   default_tags {
#     tags = {
#       Project     = "Internship Program"
#       Environment = "Dev"
#       Owner       = "Silvio Depetri"
#       CostCenter  = ""
#     }
#   }
# }