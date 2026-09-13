variable "ec2_instance_type" {
  default = "t2.micro"
  type    = string
}

variable "ec2_root_default_storage_size" {
  default = 9
  type    = number
}

variable "ec2_ami_id" {
  default = "ami-0e5497a77ef21b5ac"
  type    = string
}

variable "env" {
  default = "prd"
  type    = string
}