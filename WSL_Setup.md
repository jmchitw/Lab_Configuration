Absolutely, James. Here's a two-part package: a Markdown doc to document your Git Bash cleanup and WSL Git setup, followed by a companion WSL shell script to configure Git identity and SSH keys inside your Linux environment. Both are modular, auditable, and ready for version control.

---

## 📘 Part 1: Git Bash Cleanup & WSL Git Setup

```markdown
# Git Bash Cleanup & WSL Git Setup

## Purpose
This document outlines the steps to uninstall Git Bash from Windows and configure Git and SSH inside WSL for a streamlined, Linux-native development workflow.

---

## 🧹 Git Bash Cleanup

### 1. Uninstall Git Bash
Run the following PowerShell script as Administrator:

```powershell
& "C:\Program Files\Git\unins000.exe" /VERYSILENT
```

### 2. Remove Git Bash from PATH
Clean up system environment variables:

```powershell
$envPath = [Environment]::GetEnvironmentVariable("Path", "Machine")
$updatedPath = ($envPath -split ";") | Where-Object { $_ -notmatch "Git\\bin|Git\\cmd" } | Join-String -Separator ";"
[Environment]::SetEnvironmentVariable("Path", $updatedPath, "Machine")
```

### 3. Remove Git Bash Shortcuts
Delete desktop and Start Menu links:

```powershell
Remove-Item "$env:USERPROFILE\Desktop\Git Bash.lnk" -Force
Remove-Item "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Git\Git Bash.lnk" -Force
```

---

## 🛠️ WSL Git & SSH Setup

### 1. Confirm Git Installation
```bash
git --version
```

### 2. Configure Git Identity
```bash
git config --global user.name "James"
git config --global user.email "your.email@example.com"
```

### 3. Generate SSH Key (if needed)
```bash
ssh-keygen -t ed25519 -C "your.email@example.com"
```

### 4. Add SSH Key to GitHub
```bash
cat ~/.ssh/id_ed25519.pub
```
Copy the output and add it to your GitHub account under **Settings → SSH and GPG keys**.

### 5. Test SSH Connection
```bash
ssh -T git@github.com
```

---

## 🔐 Optional: Sync Git Config from Windows
Copy `.gitconfig` from Windows to WSL:

```bash
cp /mnt/c/Users/James/.gitconfig ~/.gitconfig
```

---

## ✅ Outcome
Git Bash removed. WSL is now your primary Git and SSH environment, with full support for Linux-native tooling, scripting, and X11 workflows.
```

---

## 🧩 Part 2: WSL Shell Script – Git Identity & SSH Setup

```bash
#!/bin/bash
# WSL Git Identity & SSH Setup Script
# Author: James & Copilot

echo "🔧 Configuring Git identity..."
git config --global user.name "James"
git config --global user.email "your.email@example.com"

echo "🔍 Checking for existing SSH key..."
if [ ! -f ~/.ssh/id_ed25519 ]; then
    echo "🔐 Generating new SSH key..."
    ssh-keygen -t ed25519 -C "your.email@example.com" -f ~/.ssh/id_ed25519 -N ""
else
    echo "✅ SSH key already exists."
fi

echo "📋 Your public key:"
cat ~/.ssh/id_ed25519.pub

echo "🧪 Testing GitHub SSH connection..."
ssh -T git@github.com || echo "⚠️ SSH test failed. Make sure your key is added to GitHub."

echo "✅ Git and SSH setup complete."
```

---

Let me know if you'd like to wrap this into a versioned repo with README, or integrate it into your provisioning workflow for lab automation. I can even help you build a Markdown-to-PDF export pipeline for your documentation.
