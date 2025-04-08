data "aws_ec2_instance_type" "example" {
  instance_type = "t3.micro"
}

output "instance" {
  value = data.aws_ec2_instance_type.example
}