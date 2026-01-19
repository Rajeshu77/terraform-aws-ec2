terraform {
  backend "s3" {
    bucket = "infra3ec2-storage-state-file"
    key    = "ec2/terraform.tfstate"
    region = "us-east-1"
  }
}

