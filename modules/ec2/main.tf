# -----------------------
# Data sources
# -----------------------

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }
}

data "aws_vpc" "selected" {
  filter {
    name   = "tag:Name"
    values = [var.vpc_tag]
  }
}

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

data "aws_subnet" "selected_2" {
  filter {
    name   = "tag:Name"
    values = [var.subnet2_tag]
  }

  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.selected.id]
  }
}


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

# -----------------------
# EC2 Instance
# -----------------------

resource "aws_network_interface" "secondary" {
  subnet_id       = data.aws_subnet.selected_2.id
  security_groups = [data.aws_security_group.selected.id]

  tags = {
    Name = "automation-secondary-eni"
  }
}


resource "aws_instance" "this" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = var.instance_type

  # Primary subnet
  subnet_id = data.aws_subnet.selected.id

  vpc_security_group_ids = [data.aws_security_group.selected.id]
  key_name               = var.keypair_name

  # Secondary subnet via ENI
  network_interface {
    network_interface_id = aws_network_interface.secondary.id
    device_index         = 1
  }

  root_block_device {
    volume_size = 100
    volume_type = "gp3"
    encrypted   = true
    kms_key_id  = data.aws_kms_key.selected.arn
  }

  tags = merge(var.tags, {
    Name = "automation-ec2"
  })
}


# -----------------------
# Additional EBS Volume
# -----------------------

resource "aws_ebs_volume" "extra" {
  availability_zone = aws_instance.this.availability_zone
  size              = 100
  type              = "gp3"
  encrypted         = true
  kms_key_id        = data.aws_kms_key.selected.arn

  tags = {
    Name = "automation-extra-volume"
  }
}

resource "aws_volume_attachment" "extra_attach" {
  device_name = "/dev/xvdf"
  volume_id   = aws_ebs_volume.extra.id
  instance_id = aws_instance.this.id
}
