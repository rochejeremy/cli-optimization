# Deploying CLI Optimization to Other WSL VMs

## Quick Deployment Methods

### Method 1: Git Clone (Recommended)

**First time setup:**
```bash
# On this VM - push to remote
cd ~/claude/projects/optimize_cli
git remote add origin https://github.com/yourusername/optimize_cli.git
git push -u origin main
```

**On new WSL VM:**
```bash
# Clone and deploy
git clone https://github.com/yourusername/optimize_cli.git ~/claude/projects/optimize_cli
cd ~/claude/projects/optimize_cli
bash deploy.sh
source ~/.bashrc
```

That's it! Everything installs automatically.

---

### Method 2: Manual Transfer (No Git)

**Copy to new VM using SCP:**
```bash
# From Windows or another machine
scp -r /path/to/optimize_cli user@target-vm:~/claude/projects/
```

**Or via shared folder/drive:**
```bash
# On new VM
cp -r /mnt/c/path/to/optimize_cli ~/claude/projects/
cd ~/claude/projects/optimize_cli
bash deploy.sh
source ~/.bashrc
```

---

### Method 3: Tarball Transfer

**Create tarball on current VM:**
```bash
cd ~/claude/projects
tar czf optimize_cli.tar.gz optimize_cli/
# Copy to shared location
cp optimize_cli.tar.gz /mnt/c/Users/roche/
```

**Extract on new VM:**
```bash
# Copy from shared location
mkdir -p ~/claude/projects
cd ~/claude/projects
tar xzf /mnt/c/Users/roche/optimize_cli.tar.gz
cd optimize_cli
bash deploy.sh
source ~/.bashrc
```

---

### Method 4: GitHub Gist (Quick Share)

**For quick sharing without full git:**
```bash
# Create a release archive
cd ~/claude/projects
tar czf optimize_cli.tar.gz optimize_cli/
# Upload to file sharing service or GitHub release
```

---

## What the deploy.sh Script Does

The automated deployment script:

1. ✅ Installs all CLI tools (fzf, starship, bat, eza, etc.)
2. ✅ Configures bash with enhanced settings
3. ✅ Sets up Starship prompt
4. ✅ Configures Git with aliases
5. ✅ Optionally sets up SSH config

**Safe to run multiple times** - it checks before overwriting existing configs.

---

## Manual Deployment (Step-by-Step)

If you prefer manual control:

```bash
# After copying files to ~/claude/projects/optimize_cli

# 1. Install tools
bash install-tools.sh

# 2. Add to bashrc
echo 'source ~/claude/projects/optimize_cli/.bashrc_enhanced' >> ~/.bashrc

# 3. Setup starship
mkdir -p ~/.config
cp starship.toml ~/.config/starship.toml

# 4. Setup git
git config --global include.path ~/claude/projects/optimize_cli/.gitconfig_enhanced

# 5. Reload shell
source ~/.bashrc
```

---

## Deploying to Multiple VMs at Once

**Using a loop:**
```bash
# Create list of VMs
VMS="vm1 vm2 vm3"

for vm in $VMS; do
    echo "Deploying to $vm..."
    ssh $vm "mkdir -p ~/claude/projects"
    scp -r ~/claude/projects/optimize_cli $vm:~/claude/projects/
    ssh $vm "cd ~/claude/projects/optimize_cli && bash deploy.sh"
done
```

**Using Ansible (advanced):**
Create `deploy-playbook.yml`:
```yaml
---
- hosts: wsl_vms
  tasks:
    - name: Copy optimize_cli
      copy:
        src: ~/claude/projects/optimize_cli
        dest: ~/claude/projects/

    - name: Run deployment
      shell: cd ~/claude/projects/optimize_cli && bash deploy.sh
```

---

## Syncing Updates

**Pull updates on all VMs:**
```bash
# If using git
cd ~/claude/projects/optimize_cli
git pull
source ~/.bashrc  # Reload if .bashrc_enhanced changed
```

**Or create an update script:**
```bash
#!/bin/bash
# update-cli.sh
cd ~/claude/projects/optimize_cli
git pull origin main
echo "✅ CLI optimizations updated! Run: source ~/.bashrc"
```

---

## Platform-Specific Notes

### WSL2 to WSL2 (Same Windows Host)
```bash
# Copy directly between WSL distros
# From WSL distro 1
tar czf /mnt/c/temp/optimize_cli.tar.gz ~/claude/projects/optimize_cli

# Switch to WSL distro 2
wsl -d Ubuntu-22.04  # or your distro name
cd ~/claude/projects
tar xzf /mnt/c/temp/optimize_cli.tar.gz
cd optimize_cli && bash deploy.sh
```

### Different Windows Machines
1. Use cloud storage (OneDrive, Dropbox, GitHub)
2. Or network share
3. Or USB drive

### Remote Linux Servers
```bash
# Standard SCP/SSH deployment
scp -r ~/claude/projects/optimize_cli user@server:~/
ssh user@server "cd ~/optimize_cli && bash deploy.sh"
```

---

## Verification Checklist

After deployment on new VM, verify:

```bash
# Check tools installed
which fzf starship bat eza fd rg zoxide tldr delta

# Check bash config loaded
grep "bashrc_enhanced" ~/.bashrc

# Check aliases work
ll  # Should use eza
gs  # Should be git status

# Check FZF
# Press Ctrl+R - should show fuzzy history search

# Check Starship
# Should see colored prompt with git info in git repos
```

---

## Troubleshooting

**Issue: Tools not found after deployment**
```bash
# Add to PATH
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
```

**Issue: Starship not showing**
```bash
# Re-run eval
echo 'eval "$(starship init bash)"' >> ~/.bashrc
source ~/.bashrc
```

**Issue: Permission denied on deploy.sh**
```bash
chmod +x deploy.sh
```

---

## Best Practices

1. **Use Git** - Easiest to maintain and update
2. **Version control** - Tag releases for stable deployments
3. **Test first** - Deploy to one VM, test, then roll out to others
4. **Document customizations** - Track any VM-specific changes
5. **Backup configs** - Before deploying, backup existing ~/.bashrc

---

## Quick Reference

| Method | Speed | Best For |
|--------|-------|----------|
| Git clone | ⚡⚡⚡ Fast | Ongoing updates, multiple VMs |
| SCP transfer | ⚡⚡ Medium | One-time setups, no git |
| Tarball | ⚡⚡ Medium | Offline transfers |
| Manual copy | ⚡ Slow | Custom installations |

**Fastest deployment:**
```bash
git clone <repo> ~/claude/projects/optimize_cli && \
cd ~/claude/projects/optimize_cli && \
bash deploy.sh && \
source ~/.bashrc
```

Done in < 5 minutes! 🚀
