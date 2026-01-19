data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }
}


# -----------------
# Existing VPC
# -----------------
data "aws_vpc" "selected" {
  filter {
    name   = "tag:Name"
    values = [var.vpc_tag]
  }
}

# -----------------
# Existing Subnet
# -----------------
data "aws_subnet" "selected" {
  filter {
    name   = "tag:Name"
    values = [var.subnet_tag]
  }

  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.selected.id]
  }
}

# -----------------
# Existing Security Group
# -----------------
data "aws_security_group" "selected" {
  filter {
    name   = "tag:Name"
    values = [var.sg_tag]
  }

  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.selected.id]
  }
}

data "aws_kms_key" "selected" {
key_id = "alias/${var.kms_key_alias}"
}

# -----------------
# EC2 Instances (single ENI only)
# -----------------


resource "aws_instance" "this" {
for_each = var.instances


ami = data.aws_ami.amazon_linux.id
instance_type = each.value.instance_type


subnet_id = data.aws_subnet.selected.id
vpc_security_group_ids = [data.aws_security_group.selected.id]
key_name = var.keypair_name


# Root volume – 100 GB
root_block_device {
volume_size = 100
volume_type = "gp3"
encrypted = true
kms_key_id = data.aws_kms_key.selected.arn
}


tags = merge(each.value.tags, {
Name = each.key
})
}


# -----------------
# Extra EBS Volume – 150 GB
# -----------------


resource "aws_ebs_volume" "extra" {
for_each = aws_instance.this


availability_zone = each.value.availability_zone
size = 150
type = "gp3"
encrypted = true
kms_key_id = data.aws_kms_key.selected.arn


tags = {
Name = "${each.key}-data-volume"
}
}


resource "aws_volume_attachment" "extra_attach" {
for_each = aws_instance.this


device_name = "/dev/xvdf"
volume_id = aws_ebs_volume.extra[each.key].id
instance_id = each.value.id
}