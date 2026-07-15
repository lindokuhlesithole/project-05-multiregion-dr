terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "eu-central-1"
  alias  = "primary"
}

provider "aws" {
  region = "eu-west-1"
  alias  = "secondary"
}
