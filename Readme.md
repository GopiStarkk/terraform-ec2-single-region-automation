# Terraform EC2 Single Region Automation (us-east-1)

This project provisions an EC2 instance in North Virginia using Terraform while reusing existing AWS infrastructure.

## Features

- Single region (us-east-1)
- Existing VPC, Subnet, SG, Keypair, KMS
- Idempotent
- Modular design
- CI/CD ready

## Usage

```bash
cd envs/dev
terraform init
terraform apply
