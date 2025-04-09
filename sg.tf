# resource "aws_security_group" "server_sg" {
#   name        = "server_sg"
#   description = "for private servers"
#   vpc_id      = aws_vpc.CRM_vpc.id

#   tags = {
#     Name = "server_sg"
#   }
# }
# resource "aws_security_group" "lb_sg" {
#   name        = "lb_sg"
#   description = "for lb"
#   vpc_id      = aws_vpc.CRM_vpc.id

#   tags = {
#     Name = "lb_sg"
#   }
# }



# resource "aws_vpc_security_group_ingress_rule" "from_lb" {
#   security_group_id            = aws_security_group.server_sg.id
#   from_port                    = 80
#   ip_protocol                  = "tcp"
#   to_port                      = 80
#   referenced_security_group_id = aws_security_group.lb_sg.id
# }

# resource "aws_vpc_security_group_ingress_rule" "from_internet" {
#   security_group_id = aws_security_group.lb_sg.id
#   cidr_ipv4         = "0.0.0.0/0"
#   from_port         = 80
#   ip_protocol       = "tcp"
#   to_port           = 80
# }

# resource "aws_vpc_security_group_egress_rule" "to_servers" {
#   security_group_id = aws_security_group.lb_sg.id

#   from_port                    = 80
#   ip_protocol                  = "tcp"
#   to_port                      = 80
#   referenced_security_group_id = aws_security_group.server_sg.id
# }

# # open to all temporarily until create NAT gateway
# resource "aws_vpc_security_group_egress_rule" "to_NAT" {
#   security_group_id            = aws_security_group.server_sg.id
#   cidr_ipv4                    = "0.0.0.0/0"
#   from_port                    = 80
#   ip_protocol                  = "tcp"
#   to_port                      = 80
# }


resource "aws_security_group" "lb_sg" {
  name        = "lb_sg"
  description = "for lb"
  # vpc_id      = aws_vpc.CRM_vpc.id

  tags = {
    Name = "lb_sg"
  }
  dynamic "ingress" {
    for_each = var.ingress_ports
    content {
     from_port= ingress.value
     to_port= ingress.value
     protocol= "tcp"
     cider_block= ["0.0.0.0/0"]
    }
  }

  dynamic "egress" {
    for_each = var.ingress_ports
    content {
     from_port= egress.value
     to_port= egress.value
     protocol= "tcp"
     cider_block= ["0.0.0.0/0"]
    }
  }
}
