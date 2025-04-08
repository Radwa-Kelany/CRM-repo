resource "aws_security_group" "server_sg" {
  name        = "server_sg"
  description = "for private servers"
  vpc_id      = aws_vpc.CRM_vpc.id

  tags = {
    Name = "server_sg"
  }
}
resource "aws_security_group" "lb_sg" {
  name        = "lb_sg"
  description = "for lb"
  vpc_id      = aws_vpc.CRM_vpc.id

  tags = {
    Name = "lb_sg"
  }
}



resource "aws_vpc_security_group_ingress_rule" "from_lb" {
  security_group_id = aws_security_group.server_sg.id
  from_port   = 80
  ip_protocol = "http"
  to_port     = 80
  referenced_security_group_id = aws_security_group.lb_sg.id
}

resource "aws_vpc_security_group_ingress_rule" "from_internet" {
  security_group_id = aws_security_group.lb_sg.id
  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 80
  ip_protocol = "http"
  to_port     = 80
}