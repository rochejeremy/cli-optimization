#!/usr/bin/env bash
# Quick Setup Script for CLI Optimization
# Run with: bash quick-setup.sh

set -e

echo "========================================"
echo "  CLI Optimization - Quick Setup"
echo "========================================"
echo ""

# Project directory detection
PROJECT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Check if we're in the right directory
if [ ! -f "$PROJECT_DIR/bash/.bashrc_enhanced" ]; then
    echo "Error: Configuration files not found in $PROJECT_DIR/bash"
    exit 1
fi

echo "Step 1: Installing modern CLI tools..."
echo "This requires sudo access."
read -p "Install tools now? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    if [ -f "$PROJECT_DIR/bash/install-bash-tools.sh" ]; then
        bash "$PROJECT_DIR/bash/install-bash-tools.sh"
    elif [ -f "$PROJECT_DIR/install-tools.sh" ]; then
        bash "$PROJECT_DIR/install-tools.sh"
    else
        echo "Error: Installation script not found."
    fi
else
    echo "Skipping tool installation."
fi

echo ""
echo "Step 2: Activating enhanced bash configuration..."
if ! grep -q "bashrc_enhanced" ~/.bashrc; then
    echo "" >> ~/.bashrc
    echo "# Enhanced CLI configuration" >> ~/.bashrc
    echo "source $PROJECT_DIR/bash/.bashrc_enhanced" >> ~/.bashrc
    echo "✓ Added to ~/.bashrc"
else
    # Update the path if it changed
    sed -i "s|source .*/bashrc_enhanced|source $PROJECT_DIR/bash/.bashrc_enhanced|g" ~/.bashrc
    echo "✓ Already configured in ~/.bashrc (path updated if necessary)"
fi

echo ""
echo "Step 3: Setting up Starship prompt..."
mkdir -p ~/.config
if [ -f "$PROJECT_DIR/common/starship.toml" ]; then
    cp "$PROJECT_DIR/common/starship.toml" ~/.config/starship.toml
    echo "✓ Starship config installed"
else
    echo "✗ Starship config not found at $PROJECT_DIR/common/starship.toml"
fi

echo ""
echo "Step 4: Configuring Git..."
if [ -f "$PROJECT_DIR/common/gitconfig_enhanced" ]; then
    if ! git config --global --get include.path | grep -q "gitconfig_enhanced"; then
        git config --global include.path "$PROJECT_DIR/common/gitconfig_enhanced"
        echo "✓ Git configuration included"
    else
        echo "✓ Git configuration already included"
    fi
else
    echo "✗ Git config not found at $PROJECT_DIR/common/gitconfig_enhanced"
fi

echo ""
echo "Step 5: SSH configuration..."
mkdir -p ~/.ssh
chmod 700 ~/.ssh
if [ ! -f ~/.ssh/config ]; then
    if [ -f "$PROJECT_DIR/common/ssh_config" ]; then
        cp "$PROJECT_DIR/common/ssh_config" ~/.ssh/config
        chmod 600 ~/.ssh/config
        echo "✓ SSH config created"
    else
        echo "✗ SSH template not found at $PROJECT_DIR/common/ssh_config"
    fi
else
    echo "✓ SSH config already exists"
fi

echo ""
echo "Step 6: Installing AI assistant helpers..."
if [ -f "$PROJECT_DIR/create-ai-helpers.sh" ]; then
    bash "$PROJECT_DIR/create-ai-helpers.sh"
else
    echo "✓ AI helpers script not found (optional)"
fi

echo ""
echo "Step 7: Creating/Updating GEMINI.md for AI agents..."
GEMINI_MD="$PROJECT_DIR/GEMINI.md"
if [ ! -f "$GEMINI_MD" ]; then
    touch "$GEMINI_MD"
fi

# Use a temporary file to construct the context
cat > "$GEMINI_MD" << 'EOF'
# Project Environment & Tooling (Gemini CLI)

## Optimized CLI Tools
The following modern tools are installed and preferred in this environment:
- **Navigation**: `zoxide` (use `z`)
- **Search**: `ripgrep` (`rg`) and `fd`
- **Viewing**: `bat` (aliased to `cat`)
- **Listing**: `eza` (aliased to `ls`, `ll`, `lt`)
- **Fuzzy Finding**: `fzf` (integrated into history with Ctrl+R)
- **Prompt**: `starship` is active.
- **Diffs**: `git-delta` (active for git operations)
- **Multiplexer**: `tmux` (optimized for WSL)

## Conventions
- Use the provided git aliases (`gs`, `gd`, `gl`) for standard operations.
- Prefer `fd` over `find` and `rg` over `grep`.
- Reference `AGENTS.md` for more comprehensive environment details.
EOF
echo "✓ GEMINI.md created/updated"

echo ""
echo "Step 8: Setting up Tmux configuration..."
if [ -f "$PROJECT_DIR/common/tmux.conf" ]; then
    cp "$PROJECT_DIR/common/tmux.conf" ~/.tmux.conf
    # Ensure TPM is installed
    if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
        git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    fi
    echo "✓ Tmux config installed and TPM ready"
    echo "  (Note: Open tmux and press 'Prefix + I' to install plugins)"
else
    echo "✗ Tmux config not found at $PROJECT_DIR/common/tmux.conf"
fi

echo ""
echo "========================================"
echo "  Setup Complete! 🎉"
echo "========================================"
echo ""
echo "Next steps:"
echo "1. Restart your terminal or run: source ~/.bashrc"
echo "2. Test with: ll, gs, fzf (Ctrl+R for history search)"
echo "3. Try: latest-screenshot, ai-context"
echo "4. Update Windows Terminal settings (see README.md)"
echo "5. Customize SSH config: nano ~/.ssh/config"
echo ""
echo "For detailed documentation, see:"
echo "  $PROJECT_DIR/README.md"
echo "  $PROJECT_DIR/AGENTS.md (AI assistant context)"
echo "  $PROJECT_DIR/AI_ASSISTANT_SETUP.md (AI integration guide)"
echo ""
echo "Enjoy your optimized CLI! 🚀"
