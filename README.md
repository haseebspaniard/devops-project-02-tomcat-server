# 🚀 DevOps Project 01 — Ubuntu Application Server with Apache Tomcat

![Tomcat Running](screenshots/08-tomcat-browser.png)

## 📋 Project Overview

**Scenario:** Our company is preparing a new Ubuntu application server to host a Java-based internal web application. The development team requires Java runtime installation, Apache Tomcat setup, proper service configuration, and application deployment readiness before tonight's maintenance window.

**Role:** DevOps Engineer

**Constraint:** Do not reboot the server manually. A scheduled infrastructure reboot is planned tonight.

**Expected Final State After Reboot:**
- ✅ Tomcat service starts automatically
- ✅ Application portal is accessible
- ✅ Service remains persistent after reboot

---

## 🛠️ Tech Stack

| Tool | Version |
|------|---------|
| OS | Ubuntu (VirtualBox) |
| Java | OpenJDK 17 |
| Apache Tomcat | 10.1.55 |
| Service Manager | systemd |
| Firewall | UFW |

---

## 📁 Project Structure
```
devops-project-01-tomcat-server/
├── README.md
├── tomcat.service          # systemd service unit file
├── setup.sh                # full setup script
└── screenshots/
├── 01-server-info.png
├── 02-java-installed.png
├── 03-tomcat-downloaded.png
├── 04-permissions-set.png
├── 05-service-file.png
├── 06-tomcat-running.png
├── 07-firewall-configured.png
├── 08-tomcat-browser.png
└── 09-enabled-verified.png
---
```
## 📝 Step-by-Step What I Did

### Step 1 — Verified Server Information
Checked Ubuntu version, hostname, IP address, and running services to understand the baseline state of the server.

### Step 2 — Installed Java (OpenJDK 17)
Apache Tomcat requires a Java runtime. Installed OpenJDK 17 LTS — the production standard for enterprise Java applications.

### Step 3 — Created a Dedicated Tomcat Service User
Created a system user `tomcat` with no login shell. This follows the **principle of least privilege** — if Tomcat is ever compromised, the attacker cannot use it to log into the server.

### Step 4 — Downloaded and Installed Tomcat
Downloaded Apache Tomcat 10.1.55 directly from the official Apache mirror. Extracted and moved it to `/opt/tomcat/`. Created a symlink `/opt/tomcat/latest` pointing to the installation — this makes future upgrades easy without changing service configuration.

### Step 5 — Configured Permissions
Assigned ownership of all Tomcat files to the `tomcat` user. Made startup/shutdown scripts executable. This ensures Tomcat can only be managed by its own dedicated user.

### Step 6 — Created systemd Service File
Wrote a custom `tomcat.service` unit file at `/etc/systemd/system/tomcat.service`. This is what registers Tomcat with systemd so it can be managed like any other Linux service — and crucially, start automatically on boot.

### Step 7 — Enabled and Started the Service
- `systemctl daemon-reload` — tells systemd about the new service file
- `systemctl enable tomcat` — registers it to start on every boot
- `systemctl start tomcat` — starts it immediately without a reboot

### Step 8 — Configured the Firewall
Opened port 8080 through UFW (Ubuntu's firewall) to allow web traffic to reach Tomcat.

### Step 9 — Verified Application Access
Confirmed the Tomcat welcome page loads at `http://localhost:8080`. Confirmed `systemctl is-enabled tomcat` returns `enabled` — proving it will survive tonight's scheduled reboot.

---

## 🔑 Key Learnings

- **systemd** is how Linux manages services — `enable` = survive reboot, `start` = run now
- **Principle of least privilege** — dedicated service users with no login shell
- **Symlinks** make version management clean in production (`/opt/tomcat/latest`)
- **`systemctl is-enabled`** is how you verify persistence — not just `status`
- **UFW** must be configured or the firewall will block traffic even if the app is running

---

## 📸 Screenshots

| Step | Screenshot |
|------|-----------|
| Server Info | ![](screenshots/01-server-info.png) |
| Java Installed | ![](screenshots/02-java-installed.png) |
| Tomcat Downloaded | ![](screenshots/03-tomcat-downloaded.png) |
| Permissions Set | ![](screenshots/04-permissions-set.png) |
| Service File | ![](screenshots/05-service-file.png) |
| Tomcat Running | ![](screenshots/06-tomcat-running.png) |
| Firewall Configured | ![](screenshots/07-firewall-configured.png) |
| Browser Verified | ![](screenshots/08-tomcat-browser.png) |
| Persistence Verified | ![](screenshots/09-enabled-verified.png) |

---

## 🔗 Connect With Me

- 💼 LinkedIn: [linkedin.com/in/abdulhaseebas](https://www.linkedin.com/in/abdulhaseebas)
- ✍️ Medium: [medium.com/@haseebabdul480](https://medium.com/@haseebabdul480)
- 🐙 GitHub: [github.com/haseebspaniard](https://github.com/haseebspaniard)

---

*Part of my public Cloud & DevOps learning journey. Teaching CS for 3.5 years → now building in the cloud.*

