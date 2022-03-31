# Terraform for Open Day in KAIT20
---
## How to use?
To properly run this terraform configuration you must provide VPC ID variable in your environment.
Simply type in your terminal:
```bash
export TF_VAR_vpc_id=<your VPC ID>
```
And you are good to go!

## Run Terraform
```bash
terraform validate
terraform plan
terraform apply
```
