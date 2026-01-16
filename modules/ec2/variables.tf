variable "instance_type" {
  type    = string
  default = "t3.micro"
}
variable "vpc_tag" {}
variable "subnet_tag" {}
variable "sg_tag" {}
variable "keypair_name" {}
variable "kms_key_alias" {}
variable "tags" {
  type = map(string)
}
