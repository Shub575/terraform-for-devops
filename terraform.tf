terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }

  backend "s3" {
    bucket         = "shub-state-terraform-bucket"
    key            = "terraform.tfstate"
    region         = "us-east-2"
    dynamodb_table = "shub-state-terraform-table"
  }
}
