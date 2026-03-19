# Phase 2 Implementation: CLI Optimization

## Current State Assessment
✓ Homebrew installed
✓ nvm installed
✓ uv installed
✓ Basic bash aliases configured
❌ No modern CLI productivity tools
❌ Limited bash customization
❌ Suboptimal Windows Terminal keybindings
❌ Basic prompt with no git integration

## Phase 2 Tasks

### Task 1: Install Modern CLI Tools
```bash
# Essential productivity tools
brew install fzf           # Fuzzy finder
brew install starship      # Modern prompt
brew install bat           # Better cat with syntax highlighting
brew install eza           # Better ls (modern fork of exa)
brew install fd            # Better find
brew install ripgrep       # Better grep
brew install zoxide        # Smart cd with frecency
brew install tldr          # Simplified man pages
brew install git-delta     # Better git diff
```

### Task 2: Enhanced Bash Configuration
Create optimized ~/.bashrc additions with:
- Larger history (10000+ lines)
- History timestamps
- Ignore duplicates and space-prefixed commands
- Better navigation with zoxide
- FZF integration for history/file search
- Starship prompt
- Useful aliases and functions

### Task 3: Windows Terminal Optimized Config
Add essential keybindings:
- Tab management (Ctrl+T new, Ctrl+W close, Ctrl+Tab switch)
- Split panes (Alt+Shift+ arrows)
- Pane navigation (Alt+ arrows)
- Command palette (Ctrl+Shift+P)
- Settings UI (Ctrl+,)

### Task 4: Git Configuration
- Git aliases (gs, gd, gl, etc.)
- Delta as diff/merge tool
- Better git log formatting

### Task 5: SSH Configuration
- Optimize ~/.ssh/config
- Connection multiplexing
- Key management

## Implementation Order
1. Install CLI tools (5 min)
2. Configure bash (10 min)
3. Update Windows Terminal settings (5 min)
4. Configure git (5 min)
5. Setup SSH config (5 min)

Total time: ~30 minutes
