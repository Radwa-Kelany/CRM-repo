variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "instance_tag" {
  type    = list(any)
  default = ["web", "app", "database"]
}

variable "instance_ami" {
  type = map(any)
  default = {
    us-east-1-amazon = "ami-00a929b66ed6e0de6"
  }
}


# variable "test_var" {
#   type = number
# }


variable "instance_env" {
  default = ["dev","prod","test","staging"]
}
/* 

set is array with no repeating
List is array with repeating
Map is object, key value pair

although terraform.tfvars override variables.tf, but you must declare variables 
first in variables.tf file even it has no value 
?????????
*/
