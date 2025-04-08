
resource "aws_key_pair" "t_key" {
  key_name   = "t-key"
  public_key = file ("~/.ssh/sshkey.pub")
}

resource "aws_instance" "web" {
  ami           = "ami-0c1ac8a41498c1a9c"
  instance_type = "t3.micro"
  key_name = aws_key_pair.t_key.key_name
  tags = {
    Name = "t-ec2-02"
  }
  provisioner "local-exec" {
    command = "echo ${self.private_ip} >> private_ips.txt"
    on_failure = continue
  }
}

resource "aws_instance" "web-2" {
  ami           = "ami-0c1ac8a41498c1a9c"
  instance_type = "t3.micro"
  key_name = aws_key_pair.t_key.key_name
  tags = {
    Name = "t-ec2-022"
  }
  connection {
    type     = "ssh"
    user     = "ec2-user"
    private_key = file ("~/.ssh/sshkey.pub")
    host     = self.public_ip
    agent       = true  # This enables SSH agent forwarding
    timeout     = "2m"
  }


  provisioner "remote-exec" {
    inline = [
      "sudo yum update -y",
      "sudo yum install nginx -y",
      "sudo systemctl start nginx",
      "sudo systemctl enable nginx"
    ]
  }
}