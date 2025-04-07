provider "aws" {
  region = "eu-north-1"
}

resource "aws_vpc" "example" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_key_pair" "t-key" {
  key_name   = "t-key"
  public_key = file ("~/.ssh/sshkey.pub")
   }