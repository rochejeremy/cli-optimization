# CLI Optimization - Phase 2 Complete

## Overview
This project optimizes your WSL2/Ubuntu CLI environment with modern tools, efficient configurations, and productivity enhancements.

## What's Included

### 1. **Enhanced Bash Configuration** (.bashrc_enhanced)
- Extended history (50k entries with timestamps)
- Smart directory navigation with CDPATH
- Modern CLI tool integrations
- Comprehensive aliases for common tasks
- Useful functions (mkcd, extract, backup, killp)
- WSL-Windows clipboard integration
- Git shortcuts and functions
- Docker, Python, Node shortcuts

### 2. **Tool Installation Script** (install-tools.sh)
Installs:
- **fzf**: Fuzzy finder for files/history/commands
- **starship**: Beautiful, fast, customizable prompt
- **bat**: Better cat with syntax highlighting
- **eza**: Modern ls replacement with icons
- **fd**: Better find
- **ripgrep**: Blazing fast grep
- **zoxide**: Smart cd with frecency
- **tldr**: Simplified man pages
- **git-delta**: Better git diff viewer

### 3. **Windows Terminal Configuration** (windows-terminal-optimized.json)
- Comprehensive keybindings (30+ shortcuts)
- Ubuntu/Claude Code as default profile
- Better split pane management
- Modern color scheme (One Half Dark)
- Optimized fonts and rendering
- Organized profiles

### 4. **Starship Prompt Configuration** (starship.toml)
- Git branch and status
- Directory path with icons
- Python, Node, Rust, Go, Docker context
- Command duration
- Timestamps
- Clean, informative design

### 5. **Enhanced Git Config** (.gitconfig_enhanced)
- 40+ useful git aliases
- Delta integration for diffs
- Better colors
- Helpful defaults

### 6. **SSH Configuration** (ssh_config)
- Connection multiplexing
- Keep-alive settings
- Compression enabled
- Reusable connections

## Installation Instructions

### Step 1: Install Tools
```bash
cd ~/claude/projects/optimize_cli
bash install-tools.sh
```

### Step 2: Activate Bash Configuration
Add to your ~/.bashrc:
```bash
echo "" >> ~/.bashrc
echo "# Enhanced CLI configuration" >> ~/.bashrc
echo "source ~/claude/projects/optimize_cli/.bashrc_enhanced" >> ~/.bashrc
source ~/.bashrc
```

### Step 3: Setup Starship Prompt
```bash
mkdir -p ~/.config
cp starship.toml ~/.config/starship.toml
```

### Step 4: Configure Git
```bash
git config --global include.path ~/claude/projects/optimize_cli/.gitconfig_enhanced

# If you want to use delta (after installing)
git config --global core.pager delta
git config --global interactive.diffFilter 'delta --color-only'
```

### Step 5: Setup SSH Config
```bash
# Create SSH directory if it doesn't exist
mkdir -p ~/.ssh
chmod 700 ~/.ssh

# Copy and customize SSH config
cp ssh_config ~/.ssh/config
chmod 600 ~/.ssh/config

# Edit with your actual hosts
nano ~/.ssh/config
```

### Step 6: Update Windows Terminal Settings
1. Open Windows Terminal
2. Press `Ctrl+Shift+,` (opens settings.json)
3. **Backup your current settings!**
4. Replace or merge with `windows-terminal-optimized.json`
5. Save and restart Windows Terminal

## Key Features & Benefits

### Productivity Improvements
✓ **90% faster file searching** with fzf and fd
✓ **Instant command history** with Ctrl+R fuzzy search
✓ **Smart directory jumping** with zoxide (remembers frequent dirs)
✓ **Beautiful syntax highlighting** with bat
✓ **Informative git prompt** with starship
✓ **50x faster grep** with ripgrep

### New Shortcuts

#### Bash Aliases
```bash
# Navigation
..          # cd ..
...         # cd ../..
-           # cd to previous directory
projects    # cd ~/claude/projects

# Modern tools
ls          # Uses eza with icons (if installed)
ll          # Detailed list with git status
cat         # Uses bat with syntax highlighting
grep        # Uses ripgrep (faster)

# Git shortcuts
gs          # git status
ga          # git add
gc          # git commit
gd          # git diff
gl          # git log (pretty)
gp          # git push
gpl         # git pull

# System
update      # apt update && upgrade
install     # apt install
c           # clear
```

#### Windows Terminal Keybindings
```
Tabs:
  Ctrl+T              New tab
  Ctrl+W              Close tab
  Ctrl+Tab            Next tab
  Ctrl+Shift+Tab      Previous tab
  Ctrl+1-5            Switch to tab 1-5

Panes:
  Alt+Shift+-         Split horizontal
  Alt+Shift++         Split vertical
  Alt+Shift+D         Duplicate pane
  Alt+Arrow           Navigate panes
  Alt+Shift+Arrow     Resize panes

Other:
  Ctrl+Shift+F        Find
  Ctrl+Shift+P        Command palette
  Ctrl+,              Settings
  F11                 Fullscreen
```

#### FZF Shortcuts (after install)
```
Ctrl+R              Fuzzy search history
Ctrl+T              Fuzzy file search
Alt+C               Fuzzy directory search
```

### Useful Functions
```bash
mkcd dirname        # Create directory and cd into it
extract file.tar.gz # Extract any archive format
backup file.txt     # Create timestamped backup
killp processname   # Find and kill process by name
ff filename         # Find files by name
gcl repo-url        # Git clone and cd into directory
```

## Configuration Files Summary

| File | Purpose | Action |
|------|---------|--------|
| `.bashrc_enhanced` | Main bash config | Source in ~/.bashrc |
| `install-tools.sh` | Install modern CLI tools | Run with bash |
| `windows-terminal-optimized.json` | Terminal settings | Copy to Windows Terminal |
| `starship.toml` | Prompt config | Copy to ~/.config/ |
| `.gitconfig_enhanced` | Git aliases & settings | Include in ~/.gitconfig |
| `ssh_config` | SSH optimization | Copy to ~/.ssh/config |

## Testing Your Setup

After installation:

```bash
# Test tools are installed
which fzf starship bat eza fd rg zoxide tldr delta

# Test aliases
ll          # Should show icons (if eza installed)
gs          # Should run git status

# Test FZF
Ctrl+R      # Should show fuzzy history search

# Test prompt
cd ~/claude/projects
git init test_repo
cd test_repo
# Should show git branch in prompt
```

## Troubleshooting

### Tools not found
```bash
# Make sure ~/.local/bin is in PATH
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
```

### Starship not showing
```bash
# Verify installation
which starship

# Check if eval line is in .bashrc_enhanced
grep "starship" ~/.bashrc
```

### Windows Terminal settings not applied
1. Make sure you saved the settings.json file
2. Restart Windows Terminal completely
3. Check for JSON syntax errors in settings

### Permission errors during tool installation
```bash
# Make sure you can use sudo
sudo echo "test"

# Check brew ownership
ls -la /home/linuxbrew/.linuxbrew/
```

## Next Steps

1. **Customize starship.toml** - Adjust colors, icons, modules
2. **Add custom aliases** - Edit .bashrc_enhanced with your shortcuts
3. **Configure SSH hosts** - Add your servers to ssh_config
4. **Try FZF integrations** - Explore Ctrl+R, Ctrl+T, Alt+C
5. **Learn git aliases** - Run `git aliases` to see all shortcuts

## Performance Gains

| Task | Before | After | Improvement |
|------|--------|-------|-------------|
| Find file in project | `find . -name "file"` (slow) | `fd file` | 10-50x faster |
| Search in files | `grep -r "text"` | `rg "text"` | 50-100x faster |
| View file with colors | `cat file` (no colors) | `bat file` | ∞ better |
| Navigate to frequent dir | `cd /long/path` | `z path` | Instant |
| Search command history | `Ctrl+R` (linear) | `Ctrl+R` (fuzzy) | Much faster |
| Git status view | Basic text | Starship + icons | Visual |

## Resources

- [fzf GitHub](https://github.com/junegunn/fzf)
- [Starship Docs](https://starship.rs/)
- [eza GitHub](https://github.com/eza-community/eza)
- [ripgrep GitHub](https://github.com/BurntSushi/ripgrep)
- [bat GitHub](https://github.com/sharkdp/bat)
- [zoxide GitHub](https://github.com/ajeetdsouza/zoxide)
- [git-delta GitHub](https://github.com/dandavison/delta)
- [Windows Terminal Docs](https://docs.microsoft.com/en-us/windows/terminal/)

## Support

Having issues? Check:
1. All tools installed: `which fzf starship bat eza fd rg zoxide`
2. Bash config sourced: `grep "bashrc_enhanced" ~/.bashrc`
3. PATH includes ~/.local/bin: `echo $PATH`
4. Starship initialized: `grep "starship" ~/.bashrc`

---

**Phase 2 Complete!** Your CLI is now significantly optimized for productivity.

Enjoy your enhanced terminal experience! 🚀
