module "ec2" {
source = "../../modules/ec2"


aws_region = var.aws_region
vpc_tag = var.vpc_tag
subnet_tag = var.subnet_tag
sg_tag = var.sg_tag
kms_key_alias = var.kms_key_alias
keypair_name = var.keypair_name
instances = var.instances
}