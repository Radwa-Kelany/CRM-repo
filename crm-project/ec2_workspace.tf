resource "aws_instance" "web_east" {
  ami           = "ami-00a929b66ed6e0de6"
  instance_type = lookup(var.type, terraform.workspace)
  tags = {
    Name = lookup(var.tag, terraform.workspace)
  }
}


variable "type" {
  type = map(any)
  default = {
    default = "t2.micro"
    prod    = "t2.micro"
    dev     = "t2.medium"
  }
}
variable "tag" {
  type = map(any)
  default = {
    default = "default"
    prod    = "prod"
    dev     = "dev"
  }
}
