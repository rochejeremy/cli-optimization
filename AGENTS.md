# AI Agent Instructions for Roche's Environment

This file contains system information and preferences for AI assistants (Claude Code, Gemini CLI, etc.) working in this environment.

## System Overview

### Operating System
- **Host**: Windows 11 (Jeremy-Desktop)
- **WSL**: Ubuntu on WSL2
- **Kernel**: 6.6.87.2-microsoft-standard-WSL2
- **Shell**: bash (enhanced with custom configuration)
- **Terminal**: Windows Terminal

### Key Paths
```bash
# Linux/WSL paths
~/claude/projects/                    # Main project directory
~/claude/projects/optimize_cli/       # CLI optimization project
~/.local/bin/                         # Custom user scripts

# Windows paths (from WSL)
/mnt/c/Users/roche/                   # Windows user home
/mnt/c/Users/roche/OneDrive/Documents/ShareX/Screenshots/YYYY-MM/  # ShareX screenshots
/mnt/c/Users/roche/OneDrive/Documents/  # Documents
/mnt/c/Users/roche/OneDrive/Pictures/   # Pictures
/mnt/c/Users/roche/Documents/Python/    # Python projects
```

### Screenshot Location (ShareX)
**IMPORTANT**: When user mentions screenshots, check here first:
```bash
/mnt/c/Users/roche/OneDrive/Documents/ShareX/Screenshots/$(date +%Y-%m)/
```

Example for March 2026:
```bash
/mnt/c/Users/roche/OneDrive/Documents/ShareX/Screenshots/2026-03/
```

Helper commands available:
- `latest-screenshot` - Get path to most recent screenshot
- `list-screenshots` - List recent screenshots
- `screenshots` - Navigate to current month's folder

### Enhanced Bash Configuration
User has optimized bash environment loaded from:
```bash
~/claude/projects/optimize_cli/.bashrc_enhanced
```

## Available Tools & Aliases

### Modern CLI Tools (Installed)
- **fzf** - Fuzzy finder (Ctrl+R for history, Ctrl+T for files)
- **starship** - Beautiful prompt with git integration
- **bat** - Syntax-highlighted cat replacement
- **eza** - Modern ls with icons and git status
- **fd** - Fast find alternative
- **ripgrep (rg)** - Blazingly fast grep
- **zoxide (z)** - Smart cd that learns habits
- **tldr** - Simplified man pages
- **git-delta** - Beautiful git diffs

### Common Aliases
```bash
# Navigation
..              # cd ..
...             # cd ../..
-               # cd to previous directory
projects        # cd ~/claude/projects
screenshots     # cd to current month's ShareX folder

# File operations
ll              # eza -l (detailed list with icons)
la              # eza -la (all files)
lt              # eza -T (tree view)
cat             # bat --paging=never (syntax highlighted)

# Git shortcuts
gs              # git status -sb
ga              # git add
gc              # git commit -v
gd              # git diff
gl              # git log (pretty, last 20)
gp              # git push
gpl             # git pull

# System
c               # clear
h               # history
update          # apt update && upgrade
```

### Useful Functions
```bash
mkcd <dir>              # Create directory and cd into it
extract <file>          # Extract any archive format
backup <file>           # Create timestamped backup
gcl <url>               # Git clone and cd into repo
latest-screenshot       # Get path to most recent screenshot
list-screenshots [N]    # List N most recent screenshots
open-screenshot         # Open latest screenshot in Windows
```

## Development Environment

### Installed Package Managers
- **Homebrew** (`/home/linuxbrew/.linuxbrew/bin/brew`)
  - Note: Has Ruby permission issues, prefer apt when possible
- **nvm** - Node Version Manager (`~/.nvm/`)
- **uv** - Python package manager (`~/.local/bin/uv`)
- **pip3** - Python package installer

### Language Environments
- **Python**: System python3 + uv for package management
- **Node.js**: Managed via nvm
- **Go**: `/home/roche/go/bin` (if installed)

### Active Projects (as of 2026-03-19)
```bash
~/claude/projects/optimize_cli/              # CLI optimization (active)
~/claude/projects/prompt-alchemy-canvas-labs/ # Prompt engineering
~/claude/projects/aws-costs/                 # AWS cost analysis
~/claude/projects/keycloak-fun/              # Keycloak experiments
~/claude/projects/temporal-learning/         # Temporal workflows
```

## WSL-Windows Integration

### Clipboard
```bash
# Copy to Windows clipboard
echo "text" | clip.exe

# Paste from Windows clipboard
powershell.exe -command "Get-Clipboard"
```

### Open Windows Apps from WSL
```bash
explorer.exe .                # Open current directory in Explorer
notepad.exe file.txt          # Open in Notepad
code .                        # Open in VS Code (if installed)
```

### Path Conversion
```bash
wslpath -w ~/file.txt         # Convert to Windows path
wslpath -u "C:\file.txt"      # Convert to WSL path
```

## User Preferences

### Communication Style
- **Concise and direct** - Get to the point
- **No unnecessary emojis** - Use sparingly and only when helpful
- **Practical examples** - Show, don't just tell
- **Clear instructions** - Step-by-step when needed

### Coding Preferences
- **Security first** - Avoid vulnerabilities (XSS, injection, etc.)
- **Simple solutions** - Don't over-engineer
- **Readable code** - Clear variable names, minimal abstractions
- **No premature optimization** - Solve the problem first

### File Operations
- **Read before editing** - Always check existing code
- **Prefer editing** - Don't create unnecessary new files
- **No bloat** - Don't add comments/docs unless requested
- **Test changes** - Verify code works before completing

## Git Configuration

### Git Aliases (40+ available)
See full list: `git aliases`

Most used:
```bash
gs      # status
gl      # log (pretty)
gd      # diff
gc      # commit
gp      # push
gpl     # pull
```

### Git Workflow
- Create new commits (don't amend unless requested)
- Never skip hooks (--no-verify)
- Stage specific files (avoid `git add -A`)
- Include co-author: `Co-Authored-By: Claude Sonnet 4.5 <noreply@anthropic.com>`

## SSH Configuration

### Known Hosts
```bash
gammadrum           # SSH host (configured)
zissou              # AWS host: 18.119.115.3
zissou-oc-1         # Same as above
```

### SSH Config Location
```bash
~/.ssh/config       # Main SSH configuration
```

## Windows Terminal Profiles

### Default Profile
**Ubuntu WSL** via "Claude Code" profile

### Available Profiles
- **Claude Code** - Ubuntu WSL at ~/claude/projects/
- **Ubuntu** - Standard Ubuntu WSL
- **PowerShell** - PowerShell Core
- **Kali Linux** - Kali WSL distribution
- **Debian** - Debian WSL distribution
- **Python** - Direct Python 3.12 REPL
- **Gemini** - Ubuntu WSL as gemini user
- **Gemini CLI** - Direct gemini CLI tool
- **SSH hosts** - Pre-configured SSH connections

### Keybindings (30+ available)
See: `~/claude/projects/optimize_cli/QUICK_REFERENCE.md`

Most useful:
- `Ctrl+T` - New tab
- `Ctrl+W` - Close tab
- `Alt+Shift+-` - Split horizontal
- `Alt+Arrow` - Navigate panes
- `Ctrl+R` - Search history (with fzf)

## Working with Screenshots

### When User Says "Check my screenshot" or "latest screenshot"
```bash
# 1. Get the path
SCREENSHOT=$(latest-screenshot)

# 2. Read the image (if you have image capabilities)
# Use your Read/View tool with the path

# 3. List recent if needed
list-screenshots 5
```

### Example Workflow
```bash
# User: "What's in my latest screenshot?"
# Agent:
1. Run: latest-screenshot
2. Get path: /mnt/c/Users/roche/OneDrive/Documents/ShareX/Screenshots/2026-03/screenshot_20260319_123456.png
3. Use Read tool to view the image
4. Analyze and respond
```

## Troubleshooting

### Path Issues
- Use absolute paths when possible
- WSL home: `/home/roche/`
- Windows home: `/mnt/c/Users/roche/`

### Permission Issues
- Use `chmod +x` for scripts
- Avoid `sudo` when possible
- If sudo needed, ask user first

### Tool Not Found
```bash
# Check if tool exists
which <tool>

# Check if in PATH
echo $PATH

# Reload bash config
source ~/.bashrc
```

## Best Practices for AI Agents

### 1. **Check Enhanced Config First**
User has custom aliases and functions. Check:
```bash
grep "alias <command>" ~/.bashrc ~/.bashrc_enhanced
```

### 2. **Use Optimized Tools**
- Use `eza` instead of `ls` (if available)
- Use `bat` instead of `cat` (if available)
- Use `rg` instead of `grep` (if available)
- Use `fd` instead of `find` (if available)

### 3. **Screenshots Are Important**
Always check ShareX folder when user mentions screenshots.

### 4. **WSL Path Awareness**
Be aware of WSL ↔ Windows path differences:
- WSL: `/home/roche/file.txt`
- Windows: `C:\Users\roche\file.txt`
- WSL view of Windows: `/mnt/c/Users/roche/file.txt`

### 5. **Git Shortcuts**
User has 40+ git aliases. Use them:
- `gs` not `git status`
- `gd` not `git diff`
- `gl` not `git log`

### 6. **Documentation Locations**
- CLI optimization docs: `~/claude/projects/optimize_cli/README.md`
- Quick reference: `~/claude/projects/optimize_cli/QUICK_REFERENCE.md`
- This file: `~/claude/projects/optimize_cli/AGENTS.md`

## Quick Reference Commands

```bash
# Navigate to projects
projects

# Get latest screenshot
latest-screenshot

# List recent screenshots
list-screenshots 10

# Open latest screenshot
open-screenshot

# View file with syntax highlighting
bat filename

# Fuzzy search history
Ctrl+R

# Fuzzy file search
Ctrl+T

# Git status
gs

# Pretty git log
gl

# List all available aliases
alias

# List all git aliases
git aliases

# Show enhanced bash config
cat ~/.bashrc_enhanced

# Reload bash config
source ~/.bashrc
```

## Emergency Info

### If Things Break
1. Check if config is loaded: `grep bashrc_enhanced ~/.bashrc`
2. Reload config: `source ~/.bashrc`
3. Check tool availability: `which fzf starship bat eza`
4. View error logs: Recent command errors appear in shell
5. Restore original bashrc: Comment out source line

### Contact/Support
- GitHub issues: https://github.com/anthropics/claude-code/issues
- Project location: `~/claude/projects/optimize_cli/`
- Documentation: `~/claude/projects/optimize_cli/README.md`

---

## Version Info
- **Created**: 2026-03-19
- **Last Updated**: 2026-03-19
- **Optimization Phase**: 2 (Complete)
- **CLI Version**: Enhanced with modern tools

## Notes for AI Assistants

1. **Always check this file** when starting a new conversation
2. **Use the screenshot helpers** when user mentions images
3. **Leverage installed tools** - User has optimized environment
4. **Respect preferences** - Concise, direct, practical
5. **Check git aliases** before suggesting long git commands
6. **WSL integration** - User can access Windows files and apps
7. **Don't reinstall** what's already configured

---

**This file should be referenced by all AI assistants working in this environment.**

To view this file anytime:
```bash
cat ~/claude/projects/optimize_cli/AGENTS.md
```

Or:
```bash
projects
cat optimize_cli/AGENTS.md
```
