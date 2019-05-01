# Lab 1: Infrastructure and Prerequisites

Duration: 20 minutes

This lab will establish the underlying infrastructure for our PTFE setup. For more information on these requirements, please see the [Preflight Requirements](https://www.terraform.io/docs/enterprise/private/preflight-installer.html) and the [AWS Reference Architecture](https://www.terraform.io/docs/enterprise/private/aws-setup-guide.html).

Prerequisites:
- An AWS Account
- Terraform locally installed
- A Replicated Installer License
- A HashiCorp BitBucket Server Account

- Task 1: Clone the GitHub repo with the AWS Production External Services infrastructure
- Task 2: Update your local variables
- Task 3: Apply and note your instance information

## Task 1: Clone the GitHub repo

### Step 1.1.1

The GitHub repo we'll be working from is located at https://github.com/tr0njavolta/private-terraform-enterprise. Open your terminal and run the following command:

```shell
git clone https://github.com/tr0njavolta/private-terraform-enterprise
```

### Step 1.1.2

Navigate to the `aws` folder and examine the `main.tf` file. Examine the deployment structure in the `aws/network` and `aws/pes` folders.

## Task 2: Update your variables

### Step 1.2.1

Once you've familiarized yourself with the deployment structure and the resources we'll be creating, edit the `terraform.tfvars.example` file with your own variables.

```shell
vim terraform.tfvars.example
```

Below is an example of the variable file. The instructor will provide you with `aws_region` & `aws_instance_ami` values.

```hcl
aws_region = "us-east-2"
namespace = "res-ptfe"
aws_instance_type = "m5.large"
public_key = "ssh-rsa AAAA... rachel@hashicorp.com"
owner = "rachel"
ttl = "-1"
ssh_key_root = "res-ptfe"
aws_instance_ami = "ami-055bccc85303a099d"
```

## Task 3: Init & Apply

### Step 1.3.1

Once your variables are set, initialize Terraform in the `aws` directory.

```shell
$ cd .../aws/
$ terraform init

Initializing provider plugins...
...

Terraform has been successfully initialized!
```

### Step 1.3.2

Apply your configuration and note the output you've received.

```shell
terraform apply
```

If you've received any errors, go back to your variables and ensure you've given the correct information.