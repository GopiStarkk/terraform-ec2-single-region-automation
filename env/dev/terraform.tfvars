instance_type = "t3.micro"

vpc_tag    = "dev-vpc"
subnet_tag = "dev-private-subnet"
sg_tag     = "dev-web-sg"

keypair_name  = "my-keypair"
kms_key_alias = "ebs-key-dev"

tags = {
  Env = "dev"
  App = "cx360"
}
