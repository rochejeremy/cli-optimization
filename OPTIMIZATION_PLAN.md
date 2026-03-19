# CLI Optimization Plan - Phase 2

## Current Environment
- **System**: WSL2 Ubuntu on Windows (Jeremy-Desktop)
- **Kernel**: 6.6.87.2-microsoft-standard-WSL2
- **Shell**: bash
- **Terminal**: Windows Terminal (PowerShell as default)

## Current Configuration Analysis

### Windows Terminal Settings
✓ **Strengths:**
- Multiple profiles configured (WSL distros, SSH, Python, AI CLI tools)
- Custom keybindings for basic operations
- Acrylic transparency and visual customization
- Bell notifications configured for some profiles

❌ **Issues Identified:**
1. Default profile is PowerShell, not WSL Ubuntu
2. Limited keybindings (only 4 actions configured)
3. No custom color schemes defined
4. Inconsistent settings across profiles
5. Hardcoded IP address in SSH profile (Zissou)
6. Missing common actions (new tab, close tab, switch tabs, etc.)

### WSL/Linux Environment
- Using basic bash configuration
- History size: 1000 (default, could be larger)
- No modern CLI tools detected yet
- No shell enhancements (starship, oh-my-bash, etc.)

## Phase 2 Optimization Tasks

### 1. Windows Terminal Enhancements
- [ ] Add comprehensive keybindings for common operations
- [ ] Create custom color schemes
- [ ] Set Ubuntu WSL as default profile
- [ ] Add tab management shortcuts
- [ ] Configure better split pane navigation
- [ ] Add search and command palette enhancements

### 2. Shell Environment (Bash)
- [ ] Increase history size and add timestamps
- [ ] Install and configure modern CLI tools:
  - fzf (fuzzy finder)
  - starship (prompt)
  - bat (better cat)
  - exa/eza (better ls)
  - fd (better find)
  - ripgrep (better grep)
  - zoxide (smart cd)
  - tldr (simplified man pages)
- [ ] Create useful aliases and functions
- [ ] Improve bash completion
- [ ] Add directory navigation shortcuts

### 3. SSH Configuration
- [ ] Create/optimize ~/.ssh/config
- [ ] Add SSH key management
- [ ] Configure connection multiplexing
- [ ] Add useful SSH aliases

### 4. Git Optimization
- [ ] Configure git aliases
- [ ] Add git prompt integration
- [ ] Setup better git diff/merge tools

### 5. Productivity Tools
- [ ] Setup tmux or screen for session management
- [ ] Configure vim/nano shortcuts
- [ ] Add clipboard integration between WSL and Windows

## Implementation Priority
1. **High**: Shell enhancements, keybindings, modern CLI tools
2. **Medium**: SSH config, git optimization
3. **Low**: Visual themes, advanced terminal features

## Next Steps
Starting with high-priority items in Phase 2.
