#---CHANGE-LOG----------------------------------------------------------------
# Author: David Rahäuser (Fractiunate)
# Updated: <Date>
# Features: a,b,c
#---CHANGE-LOG----------------------------------------------------------------

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }

  }
  backend "local" {
  }

}
provider "aws" {
  region = "eu-central-1"
}
