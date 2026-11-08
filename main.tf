# ---------------------------------------------------------------
# TEST FILE ONLY - every credential below is FAKE / MOCK.
# Purpose: check that GitHub secret scanning and push protection
# flag hardcoded secrets in Terraform code.
# ---------------------------------------------------------------

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# BAD PRACTICE (intentional): hardcoded AWS credentials.
# These are the example keys from AWS documentation, not real.
provider "aws" {
  region     = "ap-south-1"
  access_key = "AKIAIOSFODNN7EXAMPLE"
  secret_key = "wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY"
}

# BAD PRACTICE (intentional): hardcoded database password.
variable "db_password" {
  type    = string
  default = "SuperSecretP@ssw0rd123!"
}

# BAD PRACTICE (intentional): fake GitHub token pattern.
variable "github_token" {
  type    = string
  default = "ghp_FAKEFAKEFAKEFAKEFAKEFAKEFAKEFAKE1234"
}

resource "aws_ecr_repository" "myapp" {
  name = "myapp-test"
}

resource "aws_db_instance" "demo" {
  identifier          = "techhealth-demo-db"
  engine              = "postgres"
  instance_class      = "db.t3.micro"
  allocated_storage   = 20
  username            = "admin"
  password            = var.db_password
  skip_final_snapshot = true
}
