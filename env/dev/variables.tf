variable "instance_type" {}
variable "vpc_tag" {}
variable "subnet_tag" {}
variable "subnet2_tag" {}
variable "sg_tag" {}
variable "keypair_name" {}
variable "kms_key_alias" {}
variable "tags" {
  type = map(string)
}
