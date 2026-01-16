module "ec2" {
  source = "../../modules/ec2"

  instance_type  = var.instance_type
  vpc_tag         = var.vpc_tag
  subnet_tag      = var.subnet_tag
  subnet2_tag    = var.subnet2_tag 
  sg_tag          = var.sg_tag
  keypair_name    = var.keypair_name
  kms_key_alias   = var.kms_key_alias
  tags            = var.tags
}
