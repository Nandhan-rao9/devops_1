# 🚀 Static Website Deployment on AWS EC2 with Nginx

A step-by-step project for deploying a static website to an AWS EC2 instance using **Nginx**, securely and efficiently, with Windows and open-source tools.

---

## 📄 Project Overview

- **Goal:** Deploy a static HTML/CSS website on AWS EC2, served by Nginx.
- **Skills Used:** AWS EC2, Linux, Nginx, SSH, SCP, file permissions, troubleshooting.

---

## 🛠️ Prerequisites

- AWS account with EC2 permissions
- [PuTTY](https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html) and/or OpenSSH on Windows
- Your EC2 `.pem` key file
- A folder with your website files (`index.html`, etc.)

---

## 1️⃣ Launch and Prepare Your EC2 Instance

1. **Launch EC2 (Amazon Linux) instance.**
2. **Download your private key** (`2.pem`) and save securely.
3. **Edit the Security Group:**
   - Add Inbound Rule for **SSH (22)**: Source = _Your IP_ (or `0.0.0.0/0` for test)
   - Add Inbound Rule for **HTTP (80)**: Source = `0.0.0.0/0`
   - (Optional) Add Inbound Rule for **HTTPS (443)**: Source = `0.0.0.0/0`

---

## 2️⃣ Connect to Your EC2 via SSH

- Open **PowerShell** or **Windows Terminal**.
- Restrict your `.pem` permissions:
  ```powershell
  icacls "C:\path\to\2.pem" /inheritance:r /grant:r "%username%:R"


* SSH into EC2:

  ```powershell
  ssh -i "C:\path\to\2.pem" ec2-user@your-ec2-public-dns
  ```

---

## 3️⃣ Install & Start Nginx

```bash
sudo yum update -y
sudo amazon-linux-extras install nginx1 -y
sudo systemctl start nginx
sudo systemctl enable nginx
```

* Visit `http://<your-ec2-public-ip>` — you should see the Nginx welcome page.

---

## 4️⃣ Fix Nginx Folder Permissions (First Time Only)

By default, only `root` can write to Nginx's web root. Give permission to `ec2-user`:

```bash
sudo chown -R ec2-user:ec2-user /usr/share/nginx/html/
```

---

## 5️⃣ Upload Your Site from Windows

### Using SCP in PowerShell

```powershell
scp -i "C:\path\to\2.pem" -r "C:\path\to\your-site\*" ec2-user@your-ec2-public-dns:/usr/share/nginx/html/
```

* `-i`: Path to your key
* `-r`: Recursively upload all files/folders
* Replace `C:\path\to\your-site\*` with your project path

### (Or) Using WinSCP (GUI):

1. Use [PuTTYgen](https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html) to convert `.pem` to `.ppk`.
2. In WinSCP:

   * Protocol: SFTP
   * Host name: `your-ec2-public-dns`
   * User: `ec2-user`
   * Key file: Your `.ppk`
3. Upload files to `/usr/share/nginx/html/`.

---

## 6️⃣ View Your Live Website

* Go to `http://<your-ec2-public-ip>` in your browser.
* You should see your site (not the default Nginx page)!

---

## 🧰 Troubleshooting

* **Permission denied** on upload?
  → SSH in and run:
  `sudo chown -R ec2-user:ec2-user /usr/share/nginx/html/`
* **Key error?**
  → Make sure `.pem` is restricted to your user.
* **Still see the Nginx default page?**
  → Make sure you uploaded your own `index.html` to `/usr/share/nginx/html/`.

---

## 🏆 What You Learned

* Secure AWS EC2 setup & web server config
* Linux file permissions and troubleshooting
* Cloud deployment from Windows (CLI and GUI)

---

## 📝 Example Commands (Quick Copy)

```bash
# Give ec2-user permission on Nginx web folder
sudo chown -R ec2-user:ec2-user /usr/share/nginx/html/

# Upload from Windows PowerShell
scp -i "C:\Users\YOU\path\2.pem" -r "C:\Users\YOU\your-site\*" ec2-user@your-ec2-public-dns:/usr/share/nginx/html/
```

---

## 💡 Next Steps

* Add a domain and SSL (Let’s Encrypt)
* Automate deployment with scripts or GitHub Actions
* Serve a React, Angular, or other static app

---

