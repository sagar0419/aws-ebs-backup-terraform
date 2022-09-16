# Terraform Script to implement AWS backup plan. To automate backup of EBS.

## Following AWS resources will be created.
- Backup Plan.
- AWS KMS Key.
- AWS Backup Vault.
- AWS IAM Role.
- AWS IAM Policy.

### Details about repo.
- This is a repo contains the code to implement auto backup of ebs.
- To access the AWS you can add your access and secret key in terraform.tfvars file. Or the other way around is you can create the env variable with the name `"TF_VAR_AWS_ACCESS_KEY"` and `"TF_VAR_AWS_SECRET_KEY"` and this automation script will automatically fetch the variables during execution. 
- All the variables are defined in vars.tf if you want to pass your variable add them in terraform.tfvars file. 
- You need to chnage the bucket name and the region name in "main.tf" file according to your need. If you want to keep your remote file local comment below given code in main.tf.

``` hcl
terraform {
  backend "s3" {
    bucket = "terraform-backup-sagar"
    region = "us-west-2"
    key    = "backup.tfstate"
  }
}
```

## Terraform 

To create infra run the below mention command

```sh
    - terraform fmt
    - terraform init
    - terraform plan
    - terraform apply    
```

## Cleaning up.

You can destroy this cluster entirely by running:

```sh
terraform plan -destroy
terraform destroy  
```
