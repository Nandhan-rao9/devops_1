
# 🚀 GitHub Pages Deployment via CI/CD 

---

## 🗂️ Project Overview

This repo contains multiple mini-projects, with a focus on deploying my static site from
`Projects/4.github_pages_deployment/`
to **GitHub Pages** using GitHub Actions for continuous deployment.

---

## 🧑‍💻 Steps I Followed

### 1. **Repository Structure**

```plaintext
/Projects/
  1.server_performance_stats/
  3.nginx_log_analyser/
  4.github_pages_deployment/
    ├─ index.html
    └─ README.md
/.github/workflows/deploy.yml
/README.md
```

---

### 2. **Setting Up GitHub Actions**

* Created a workflow file at
  `.github/workflows/deploy.yml`
  in the **root** of the repository (not inside any project folder).
* Used [`peaceiris/actions-gh-pages`](https://github.com/peaceiris/actions-gh-pages) to deploy the contents of my static site folder.
* Configured the workflow to trigger only when files in `4.github_pages_deployment/` change.

> **Sample workflow snippet:**
>
> ```yaml
> on:
>   push:
>     branches: [main]
>     paths:
>       - 'Projects/4.github_pages_deployment/**'
> jobs:
>   deploy:
>     runs-on: ubuntu-latest
>     steps:
>       - uses: actions/checkout@v4
>       - uses: peaceiris/actions-gh-pages@v4
>         with:
>           publish_dir: ./Projects/4.github_pages_deployment
>           github_token: ${{ secrets.GITHUB_TOKEN }}
> ```

---

### 3. **GitHub Pages Configuration**

* Set **Pages Source** to `gh-pages` branch, folder `/ (root)` in repository settings.
* Now, every time I push changes to my deployment folder, my website updates automatically!

---

## 🛠️ Problems I Faced (And How I Solved Them)

| Issue                                | What Happened                                                 | Solution                                                                                 
| ------------------------------------ | ------------------------------------------------------------- | ---------------------------------------------------------------------------------------- 
| Workflow not running                 | Placed `.github/workflows` inside a project folder by mistake | Moved `.github/workflows` to the root of the repository                                  
| No `gh-pages` branch created         | Workflow didn’t create `gh-pages` branch                      | Fixed folder, permissions, and triggered a push to create the branch                     
| Permission denied (403)              | Workflow error: “Permission denied to github-actions\[bot]”   | Set workflow permissions to “Read and write” in repo settings                            
| README showing instead of index.html | GitHub Pages displayed README instead of my website           | Ensured valid `index.html` was present at the root of `gh-pages` branch, not just README 
| Delay/cache issues                   | Sometimes changes took a while to appear                      | Waited a minute and forced browser refresh                                               

---

## ✨ **Final Takeaways**

* Learned how to deploy a **specific folder** from a multi-project repo to GitHub Pages.
* Got comfortable with **GitHub Actions** and CI/CD automation.
* Solved real-life DevOps mistakes with file structure and permissions.
* Now my site updates itself every time I make a change—DevOps magic!

---

> **Deploying is so much more fun (and less scary) when it’s automated!**
>
> *Want to see it live? Check it out here:*
> [https://nandhan-rao9.github.io/devops\_1/](https://nandhan-rao9.github.io/devops_1/)
