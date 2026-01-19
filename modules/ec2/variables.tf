variable "aws_region" { type = string }
variable "vpc_tag" { type = string }
variable "subnet_tag" { type = string }
variable "sg_tag" { type = string }
variable "kms_key_alias" { type = string }
variable "keypair_name" { type = string }


variable "instances" {
type = map(object({
instance_type = string
tags = map(string)
}))
}