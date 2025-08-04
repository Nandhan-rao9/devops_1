
# Ansible EC2 Configuration & Static Site Deployment

This project demonstrates how to use **Ansible** to automate the configuration of a remote AWS EC2 instance, install essential packages, and deploy a static website.  
You’ll learn real-world DevOps practices, see common errors, and master troubleshooting—all from your own EC2 “controller” server.

---

## 🚀 **What Does This Project Do?**

- Provisions and configures a remote EC2 instance (managed node) from a controller EC2 using Ansible
- Installs Linux packages and utilities
- Deploys a static website (as a `.tar.gz` archive) to your web server root
- Uses roles and playbooks for modular, maintainable automation
- Demonstrates best practices for SSH, inventory management, and GitHub collaboration

---

## 📦 **Project Structure**

```

7.ansible/
├── inventory.ini         # Ansible inventory (list of managed hosts)
├── setup.yml            # Main Ansible playbook
├── website.tar.gz       # Static website archive
├── my\_website/          # Static website content
└── roles/
├── base/            # Base server setup (yum update, utilities)
│   └── tasks/main.yml
├── app/             # Static site deployment
│   └── tasks/main.yml
├── nginx/           # (yet to complete) Nginx web server role
└── ssh/             # (yet to complete) SSH public key role

````

---

## 🛠️ **Setup Instructions**

### **1. Launch EC2 Instances**
- **Controller EC2**: Where you install/run Ansible
- **Managed EC2**: The remote server you will configure

### **2. SSH into Controller EC2**
```bash
ssh -i /path/to/controller-key.pem ec2-user@<controller-ec2-public-ip>
````

### **3. Install Prerequisites**

```bash
sudo yum install git -y
sudo amazon-linux-extras install ansible2 -y
```

### **4. Clone This Repo (or upload your code)**

```bash
git clone "https://github.com/Nandhan-rao9/devops_1"
cd 7.ansible
```

### **5. Upload Your PEM Key to Controller EC2**

From your local machine:

```bash
scp -i "/path/to/controller-key.pem" "/path/to/managed-key.pem" ec2-user@<controller-ec2-ip>:~/.ssh/2.pem
```

On controller EC2:

```bash
chmod 600 ~/.ssh/2.pem
```

### **6. Prepare Your Inventory**

Edit `inventory.ini`:

```
[web]
<managed-ec2-public-ip> ansible_user=ec2-user ansible_ssh_private_key_file=~/.ssh/2.pem
```

### **7. Package Your Website**

```bash
tar -czvf website.tar.gz my_website/
```

(Ensure `website.tar.gz` is in this folder.)

---

## 🚦 **Usage**

### **Test Connection**

```bash
ansible -i inventory.ini web -m ping
```

### **Run the Playbook**

```bash
ansible-playbook -i inventory.ini setup.yml
```

* By default, runs all roles. To run only a specific role:

  ```bash
  ansible-playbook -i inventory.ini setup.yml --tags "app"
  ```

---

## 🧩 **How It Works**

* **Base role**: Updates packages, installs essential utilities (e.g., git, htop).
* **App role**: Uploads `website.tar.gz` to the remote server and extracts it to the web root (`/usr/share/nginx/html` for Nginx, `/var/www/html` for Apache).
* **Inventory**: Defines remote EC2 IP, SSH user, and SSH key location.
* **Modular Roles**: Easily expand to add Nginx/Apache/SSH key automation as needed.

---

## ❗ **Common Errors & Troubleshooting**

| Issue                     | Error/Message                                          | Solution                                           |
| ------------------------- | ------------------------------------------------------ | -------------------------------------------------- |
| SSH key path problems     | "file not found" or "not recognized"                   | Use correct Linux path on controller EC2           |
| Git push rejected         | "failed to push... fetch first"                        | `git pull origin main --rebase`, resolve conflicts |
| Curl package conflict     | "curl-minimal... conflicts with curl"                  | Remove `curl` from utilities list                  |
| Firewalld not found       | "Could not find the requested service firewalld: host" | Remove/comment out firewalld task                  |
| Website tarball not found | "Could not find or access website.tar.gz"              | Create/upload `website.tar.gz` in this dir         |
| SSH public key missing    | "file not found: .pub" in SSH role                     | Remove SSH role or generate `.pub` keypair         |

---

## 📝 **What I Learnt**

* **Ansible basics**: playbooks, roles, tasks, modules, inventory, tags
* **SSH authentication and key management**
* **Linux server automation**
* **Static site packaging & deployment**
* **Git & GitHub collaboration for DevOps projects**

---

## 🏆 **Next Steps / To-Do**

* Add Nginx or Apache web server installation via a dedicated role
* Use variables for more flexible playbooks
* Implement Ansible Vault for secrets
* Expand to multi-server (multi-host) deployments

---

## 📚 **References**

* [Ansible Docs: Getting Started](https://docs.ansible.com/ansible/latest/getting_started/index.html)
* [AWS EC2 Guide](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/concepts.html)
* [GitHub: Personal Access Tokens](https://github.com/settings/tokens)

