aws_region = "us-east-1"


vpc_tag = "dev-vpc"
subnet_tag = "dev-private-subnet"
sg_tag = "dev-web-sg"
kms_key_alias = "ebs-key-dev"
keypair_name = "my-keypair"


instances = {
app1 = {
instance_type = "t3.micro"
tags = {
Env = "dev"
App = "cx360"
}
}


app2 = {
instance_type = "t3.small"
tags = {
Env = "dev"
App = "cx360"
}
}
}