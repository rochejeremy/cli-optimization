# Deploy Script Guide

## Overview

The `deploy.sh` script is a **robust, interactive deployment tool** that safely installs CLI optimizations with:

✅ **Pre-flight checks** - Analyzes your system before making changes
✅ **Interactive prompts** - Asks permission before each change
✅ **Automatic backups** - Saves existing configs before modifying
✅ **Detailed feedback** - Shows exactly what's happening
✅ **Dry-run mode** - Preview changes without applying them
✅ **Error handling** - Gracefully handles issues
✅ **Summary report** - Shows what was changed and next steps

---

## Quick Start

### Basic Usage (Interactive)
```bash
cd ~/claude/projects/optimize_cli
bash deploy.sh
```

This will:
1. Analyze your current system
2. Show what will be changed
3. Ask for confirmation before each step
4. Create backups of existing configs
5. Install and configure everything
6. Provide a summary and next steps

---

## Command Options

### Dry Run (Preview Only)
```bash
bash deploy.sh --dry-run
```
- Shows exactly what would be changed
- Makes **no modifications** to your system
- Perfect for reviewing before actual deployment
- Safe to run anytime

### Auto-Approve Mode
```bash
bash deploy.sh --yes
# or
bash deploy.sh -y
```
- Skips all confirmation prompts
- Automatically proceeds with recommended actions
- Useful for scripted deployments
- Still shows all output and creates backups

### Skip Tool Installation
```bash
bash deploy.sh --skip-tools
```
- Only configures dotfiles (bash, git, starship, SSH)
- Skips installing CLI tools (fzf, bat, eza, etc.)
- Useful if tools are already installed
- Faster for config-only updates

### Combined Options
```bash
# Preview config changes without installing tools
bash deploy.sh --dry-run --skip-tools

# Auto-deploy configs only
bash deploy.sh --yes --skip-tools
```

### Help
```bash
bash deploy.sh --help
```

---

## What the Script Checks

### 1. System Detection
- OS type (Linux/WSL/WSL2)
- Architecture (x86_64/arm64)
- Current shell
- Script location
- Home directory

### 2. Current Configuration Status
- ✓ Bash enhancement (is .bashrc_enhanced sourced?)
- ✓ Starship config (does ~/.config/starship.toml exist?)
- ✓ Git enhancements (is gitconfig_enhanced included?)
- ✓ SSH config (does ~/.ssh/config exist?)

### 3. Installed Tools
Checks for:
- `fzf` - Fuzzy finder
- `starship` - Prompt
- `bat` - Better cat
- `eza` - Better ls
- `fd` - Better find
- `rg` - Ripgrep
- `zoxide` - Smart cd
- `tldr` - Quick help
- `delta` - Git diff viewer

---

## Deployment Steps

The script performs up to 5 steps:

### Step 1: Install CLI Tools
**What it does:**
- Installs missing tools via Homebrew
- Only installs what's not already present
- May take 2-5 minutes
- Requires sudo access

**Prompts:**
- Shows which tools will be installed
- Asks for confirmation before proceeding
- Can be skipped with `--skip-tools`

### Step 2: Configure Bash
**What it does:**
- Adds `source ~/.bashrc_enhanced` to your ~/.bashrc
- Backs up existing ~/.bashrc first
- Adds timestamp comment

**Skips if:**
- Already configured (detects existing source line)

### Step 3: Configure Starship
**What it does:**
- Copies starship.toml to ~/.config/starship.toml
- Backs up existing config if present
- Optionally shows diff if config exists

**Prompts:**
- If config exists, asks to view differences
- Asks for confirmation before overwriting

### Step 4: Configure Git
**What it does:**
- Adds `include.path` to global git config
- Installs 40+ git aliases
- Configures delta pager (if installed)
- Preserves existing git settings

**Shows:**
- Current git user.name
- Current git user.email
- Sample of aliases being added

### Step 5: Configure SSH
**What it does:**
- Copies ssh_config to ~/.ssh/config
- Creates ~/.ssh directory if needed
- Sets proper permissions (700/600)

**Prompts:**
- If SSH config exists, shows reference but doesn't overwrite
- Reminds you to add actual hosts

---

## Safety Features

### Automatic Backups
All existing files are backed up before modification to:
```
~/.config/cli-optimization-backups/YYYYMMDD_HHMMSS/
```

Example:
```
~/.config/cli-optimization-backups/20260328_143022/
├── bashrc.backup
├── starship.toml.backup
└── config.backup
```

### Non-Destructive
- Never overwrites without asking (unless `--yes` used)
- Always shows what will change before changing it
- Creates backups automatically
- Skips steps that are already configured

### Error Handling
- Continues on non-critical errors
- Asks if you want to proceed after errors
- Shows summary of all errors at the end
- Sets proper exit codes

---

## Example Output

### Clean Installation
```
🚀 CLI Optimization Deployment Script
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

▶ Running pre-flight checks...

ℹ System: Linux x86_64
ℹ Shell: /bin/bash
ℹ Home: /home/user
ℹ Script location: /home/user/optimize_cli
ℹ Environment: WSL2 detected

▶ Analyzing current configuration...

ℹ ○ Bash enhancement not configured
ℹ ○ Starship config not found
ℹ ○ Git enhancement not configured
ℹ ○ SSH config not found
ℹ ○ Missing tools: fzf starship bat eza fd rg zoxide tldr delta

📋 Deployment Plan
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

The following changes will be made:

Step 1: Install Missing CLI Tools
   Tools to install: fzf starship bat eza fd rg zoxide tldr delta
   This may take 2-5 minutes and requires sudo

Step 2: Configure Bash
   Will add: source /home/user/optimize_cli/.bashrc_enhanced
   File: ~/.bashrc
   Action: Append to existing file (will backup first)

... [continues]

Proceed with deployment? [Y/n]: y
```

### Already Configured
```
📋 Deployment Plan
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

✓ Everything is already configured!

ℹ Your system already has all optimizations installed.

Would you like to see what's configured? [y/N]:
```

---

## Troubleshooting

### Script won't run
```bash
# Make sure it's executable
chmod +x deploy.sh

# Or run with bash explicitly
bash deploy.sh
```

### Can't find files
```bash
# Make sure you're in the right directory
cd ~/claude/projects/optimize_cli
ls -la  # Should see .bashrc_enhanced, starship.toml, etc.

# Run with full path
bash /full/path/to/optimize_cli/deploy.sh
```

### Permission denied during install
```bash
# Make sure you have sudo access
sudo echo "test"

# Check Homebrew permissions
ls -la /home/linuxbrew/.linuxbrew/
```

### Tools not installing
```bash
# Check if Homebrew is working
brew doctor

# Try installing manually
brew install fzf starship bat eza fd ripgrep zoxide tldr git-delta
```

### Changes not taking effect
```bash
# Reload shell after deployment
source ~/.bashrc

# Or start a new shell
exec bash
```

### Want to undo changes
```bash
# Restore from backups
ls ~/.config/cli-optimization-backups/
# Find the backup directory from your deployment
cp ~/.config/cli-optimization-backups/20260328_*/bashrc.backup ~/.bashrc

# Remove source line manually
nano ~/.bashrc
# Delete the lines added by the script
```

---

## Advanced Usage

### Remote Deployment
```bash
# Deploy to remote machine via SSH
ssh user@remote "git clone <repo-url> ~/optimize_cli"
ssh user@remote "cd ~/optimize_cli && bash deploy.sh --yes"
```

### Scripted Multi-VM Deployment
```bash
#!/bin/bash
VMS="vm1 vm2 vm3"
for vm in $VMS; do
    echo "Deploying to $vm..."
    ssh $vm "git clone <repo-url> ~/optimize_cli 2>/dev/null || true"
    ssh $vm "cd ~/optimize_cli && git pull && bash deploy.sh --yes"
done
```

### Custom Installation
```bash
# Install only specific components by editing the script
# Or run steps manually from the script
```

---

## Testing Deployment

### Use Dry-Run First
```bash
# Always test first
bash deploy.sh --dry-run

# Review the output, then deploy for real
bash deploy.sh
```

### Verify Installation
```bash
# Check tools
which fzf starship bat eza fd rg zoxide tldr delta

# Check configs
grep "bashrc_enhanced" ~/.bashrc
ls -la ~/.config/starship.toml
git config --global --get include.path

# Test functionality
ll        # Should use eza
gs        # Should be git status
Ctrl+R    # Should show fzf fuzzy history
```

---

## Performance

- **Pre-flight checks**: < 1 second
- **Analysis**: < 1 second
- **Config changes**: < 1 second (instant)
- **Tool installation**: 2-5 minutes (only if tools missing)
- **Total (config only)**: ~5 seconds with prompts
- **Total (full install)**: ~3-5 minutes

---

## Exit Codes

- `0` - Success (or already configured)
- `1` - Error (missing files, failed operations)
- User cancelled - `0` (clean exit)

---

## Comparison: Old vs New Script

| Feature | Old Script | New Script |
|---------|-----------|------------|
| Pre-flight checks | ❌ None | ✅ System detection & analysis |
| User prompts | ❌ None | ✅ Interactive confirmation |
| Backups | ❌ None | ✅ Automatic before changes |
| Dry-run mode | ❌ No | ✅ Full preview mode |
| Progress feedback | ⚠️ Basic | ✅ Detailed with colors |
| Error handling | ⚠️ Exit on error | ✅ Continue with summary |
| Summary report | ⚠️ Basic | ✅ Comprehensive |
| Options | ❌ None | ✅ Multiple flags |
| Color output | ❌ No | ✅ Full color support |
| Context awareness | ❌ No | ✅ Detects existing configs |

---

## Questions?

Run with `--help` for options:
```bash
bash deploy.sh --help
```

For full documentation:
- Main README: `README.md`
- Deployment guide: `DEPLOYMENT.md`
- Quick reference: `QUICK_REFERENCE.md`
