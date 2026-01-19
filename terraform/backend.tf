terraform {
  backend "s3" {
    bucket = "infra3ec2-storage-state-file"   # your exact bucket name
    key    = "ec2/terraform.tfstate"          # state file path inside bucket
    region = "us-east-1"
  }
}

