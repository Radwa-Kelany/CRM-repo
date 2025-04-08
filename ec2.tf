
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