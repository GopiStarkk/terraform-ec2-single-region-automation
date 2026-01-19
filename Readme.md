# Terraform EC2 Single Region Automation (Production Ready)

This project provisions **multiple EC2 instances** in a **single AWS region** using **existing infrastructure** (VPC, Subnet, Security Group, KMS, Keypair).

It follows security best practices and is fully **idempotent**.

---

## ✅ Features

* Multi-EC2 support using `for_each`
* Uses **existing**:

  * VPC
  * Subnet
  * Security Group
  * KMS Key
  * Key Pair
* Creates:

  * Root EBS volume (100 GB, encrypted)
  * Extra EBS volume (150 GB, encrypted)
* Single network interface per instance (secure design)
* Tag-based discovery
* Modular structure
* CI/CD ready

---

## 📁 Folder Structure

```
terraform-ec2-single-region-automation/
│
├── env/dev/
│   ├── main.tf
│   ├── provider.tf
│   ├── variables.tf
│   └── terraform.tfvars
│
├── modules/ec2/
│   ├── main.tf
│   ├── variables.tf
│   └── outputs.tf
│
└── .github/workflows/terraform.yml
```

---

## ⚙ Prerequisites

* Terraform >= 1.5
* AWS CLI configured
* Existing AWS resources with tags:

  * VPC → `Name`
  * Subnet → `Name`
  * Security Group → `Name`
  * KMS alias → `alias/<name>`
  * Key pair

---

## 🚀 How to Run

```bash
cd env/dev
terraform init
terraform plan
terraform apply
```

---

## 🧩 Adding New EC2 Instance

Edit `terraform.tfvars`:

```hcl
instances = {
  app1 = { ... }
  app2 = { ... }
  app3 = { ... }
}
```

Terraform will only create the new instance.

---

## 🔐 Security Design

* No secondary network interfaces
* Encrypted EBS using KMS
* Existing network controls
* No hardcoded secrets
* IAM roles supported

---

## ♻ Idempotency

* Same config → no changes
* Changed instance type → updates only that instance
* New instance → creates only new one
* Removed instance → destroys only that instance

---

## 📌 Region

Single region deployment (example: `us-east-1`)

---

## 👨‍💻 Author

Saradha

---
