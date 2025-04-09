variable "instance_type" {
  type= string
  default = "t2.micro"
}

variable "instance_tag" {
  type    = list(any)
  default = ["prod","dev","test"]
}

variable "instance_ami" {
  type = map(any)
  default = {
     us-east-1 = "ami-00a929b66ed6e0de6"
  }
}




/* 

set is array with no repeating
List is array with repeating
Map is object, key value pair

although terraform.tfvars override variables.tf, but you must declare variables 
first in variables.tf file even it has no value 
?????????
*/