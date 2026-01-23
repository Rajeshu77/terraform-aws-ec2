module "ec2_aws_1" {
  source = "./module/ec2"
  ami = var.ami_value
  instance_type = var.instance_type_value
  name = "my-sample-1"
}