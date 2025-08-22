
# AWS EC2 Provisioning with Terraform (and Ansible Stretch Goal)

This project demonstrates the basics of **Infrastructure as Code (IaC)** using **Terraform** to provision an AWS EC2 instance.  
The stretch goal is to configure the provisioned server using **Ansible**.

---

## 📌 Project Overview
- **Provider**: AWS  
- **Resources Created**:
  - Key Pair (for SSH authentication)
  - Security Group (SSH, HTTP/HTTPS rules)
  - EC2 Instance (Amazon Linux 2023, `t2.micro`)  
- **Outputs**:
  - Public IP of the instance
  - Pre-built SSH command
  - Local `.pem` private key path  

---

## 📂 Project Structure
```

Projects/8.ansible/
│── providers.tf     # Defines required providers (AWS, TLS, Local)
│── variables.tf     # Input variables (region, project name, CIDR for SSH)
│── main.tf          # Core infrastructure definition (key pair, SG, EC2)
│── outputs.tf       # Useful output values after `apply`
│── .gitignore       # Excludes .terraform/, state files, secrets, keys

````

---

## ⚙️ Prerequisites
- Terraform installed locally (`terraform -version`)
- AWS CLI installed and configured (`aws configure`)
- An AWS account with programmatic access keys
- Git for version control

---

## 🚀 Usage

### 1. Initialize Terraform
```bash
terraform init
````

### 2. Validate and plan

```bash
terraform fmt
terraform validate
terraform plan -out=tfplan
```

### 3. Apply changes

```bash
terraform apply "tfplan"
```

After apply, Terraform will output:

* Public IP of your EC2
* SSH command (with key path)

---

## 🔑 Connecting via SSH

```bash
ssh -i ./.ssh/<project_name>.pem ec2-user@<PUBLIC_IP>
```

> Default user is `ec2-user` (Amazon Linux).
> Ensure your PEM file has proper permissions:
> `chmod 600 ./.ssh/<project_name>.pem`

---

## 🌐 Stretch Goal (Next Steps with Ansible)

* Extend Security Group to allow HTTP (80) and HTTPS (443).
* Add an **Ansible playbook** (`site.yml`) that:

  * Updates packages
  * Installs Nginx
  * Configures a custom index page

This will allow you to provision EC2 with Terraform and configure it automatically with Ansible.

---

## 🧹 Cleanup

When finished, destroy all resources to avoid charges:

```bash
terraform destroy
```

---

## ✅ Status

* [x] Terraform basics scaffolded
* [x] Providers, variables, outputs defined
* [x] EC2 instance creation tested
* [ ] Add Ansible playbook for configuration
* [ ] Extend README with Ansible usage

```


