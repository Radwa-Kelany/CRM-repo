provider "aws" {
  region = "eu-north-1"
}

resource "aws_vpc" "example" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_key_pair" "t_key" {
  key_name   = "t-key"
  public_key = file ("~/.ssh/sshkey.pub")
}

resource "aws_instance" "web" {
  ami           = "ami-0c1ac8a41498c1a9c"
  instance_type = "t3.micro"
  key_name = data.aws_key_pair.t_key.key_name
  tags = {
    Name = "t-ec2-02"
  }
}