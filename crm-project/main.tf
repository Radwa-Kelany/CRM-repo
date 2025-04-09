module "sg_module" {
  source = "../modules"
}

# resource "aws_instance" "web" {
#   ami="ami-00a929b66ed6e0de6"
#   instance_type = "t2.micro"
#   vpc_security_group_ids = [module.sg_module.sg_id]
# }


