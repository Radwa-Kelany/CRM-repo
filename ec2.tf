
resource "aws_key_pair" "t_key_east" {
  key_name   = "t-key_east"
  public_key = file("~/.ssh/sshkey.pub")
}

resource "aws_instance" "web_east" {
  ami           = var.instance_ami["us-east-1-amazon"]
  instance_type = var.instance_type
  key_name      = aws_key_pair.t_key_east.key_name
  tags = {
    Name = var.instance_tag[count.index]
  }
  count = 1
  provisioner "local-exec" {
    command    = "echo ${self.private_ip} >> private_ips.txt"
    on_failure = continue
  }
}

# resource "aws_key_pair" "t_key_west" {
#   provider = aws.west
#   key_name   = "t-key_west"
#   public_key = file ("~/.ssh/sshkey.pub")
# }

# resource "aws_instance" "web_west" {
#   provider = aws.west
#   ami           = "ami-020fbc00dbecba358"
#   instance_type = "t2.micro"
#   key_name = aws_key_pair.t_key_west.key_name
#   tags = {
#     Name = "t-ec2-02"
#   }
#   provisioner "local-exec" {
#     command = "echo ${self.private_ip} >> private_ips.txt"
#     on_failure = continue
#   }
# }

# resource "aws_instance" "myec2"{

#   ami           = "ami-00a929b66ed6e0de6"
#   instance_type = "t2.micro"
#   key_name = "terraform_key"
#   tags = {
#     Name = "terraform_ec2"
#   }
#   connection {
#     type     = "ssh"
#     user     = "ec2-user"
#     private_key = file ("~/downloads/terraform_key.pem")
#     host     = self.public_ip
#   }


#   provisioner "remote-exec" {
#     inline = [
#       "sudo yum update -y",
#       "sudo yum install nginx -y",
#       "sudo systemctl start nginx",
#       "sudo systemctl enable nginx"
#     ]
#   }
# }

# resource "aws_instance" "myec2"{

#   ami           = "ami-00a929b66ed6e0de6"
#   instance_type = "t2.micro"
#   key_name = "terraform_key"
#   tags = {
#     Name = "terraform_ec2_2"
#   }
#     user_data = <<-EOF
#               #!/bin/bash
#               yum update -y
#               yum install -y httpd
#               systemctl start httpd
#               systemctl enable httpd
#               echo "<h1>Hello World from $(hostname -f)</h1>" > /var/www/html/index.html
#               EOF

# }

# output "instance_DNS" {

#   value = aws_instance.myec2.public_dns

# }

