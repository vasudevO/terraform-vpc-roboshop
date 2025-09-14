terraform {
    required_providers {
        aws = {
        source  = "hashicorp/aws"
        version = "~> 6.0"
        }
    }

    backend "s3" {
       bucket = "roboshop-statefile-buckett"
       key    = "roboshop-project-dev/terraform.state"
       region = "us-east-1"

       }

}



provider "aws" {
    region = "us-east-1"
} 