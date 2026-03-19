#!/usr/bin/env bash
# Quick Setup Script for CLI Optimization
# Run with: bash quick-setup.sh

set -e

echo "========================================"
echo "  CLI Optimization - Quick Setup"
echo "========================================"
echo ""

PROJECT_DIR="$HOME/claude/projects/optimize_cli"

# Check if we're in the right directory
if [ ! -f "$PROJECT_DIR/.bashrc_enhanced" ]; then
    echo "Error: Configuration files not found in $PROJECT_DIR"
    exit 1
fi

echo "Step 1: Installing modern CLI tools..."
echo "This requires sudo access."
read -p "Install tools now? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    bash "$PROJECT_DIR/install-tools.sh"
else
    echo "Skipping tool installation. You can run it later with:"
    echo "  bash $PROJECT_DIR/install-tools.sh"
fi

echo ""
echo "Step 2: Activating enhanced bash configuration..."
if ! grep -q "bashrc_enhanced" ~/.bashrc; then
    echo "" >> ~/.bashrc
    echo "# Enhanced CLI configuration" >> ~/.bashrc
    echo "source $PROJECT_DIR/.bashrc_enhanced" >> ~/.bashrc
    echo "✓ Added to ~/.bashrc"
else
    echo "✓ Already configured in ~/.bashrc"
fi

echo ""
echo "Step 3: Setting up Starship prompt..."
mkdir -p ~/.config
if [ ! -f ~/.config/starship.toml ] || [ "$PROJECT_DIR/starship.toml" -nt ~/.config/starship.toml ]; then
    cp "$PROJECT_DIR/starship.toml" ~/.config/starship.toml
    echo "✓ Starship config installed"
else
    echo "✓ Starship config already exists"
fi

echo ""
echo "Step 4: Configuring Git..."
if ! git config --global --get include.path | grep -q "gitconfig_enhanced"; then
    git config --global include.path "$PROJECT_DIR/.gitconfig_enhanced"
    echo "✓ Git configuration included"
else
    echo "✓ Git configuration already included"
fi

echo ""
echo "Step 5: SSH configuration..."
mkdir -p ~/.ssh
chmod 700 ~/.ssh
if [ ! -f ~/.ssh/config ]; then
    cp "$PROJECT_DIR/ssh_config" ~/.ssh/config
    chmod 600 ~/.ssh/config
    echo "✓ SSH config created (remember to customize with your hosts!)"
    echo "  Edit with: nano ~/.ssh/config"
else
    echo "✓ SSH config already exists"
    echo "  You can view the template at: $PROJECT_DIR/ssh_config"
fi

echo ""
echo "Step 6: Installing AI assistant helpers..."
if [ -f "$PROJECT_DIR/create-ai-helpers.sh" ]; then
    bash "$PROJECT_DIR/create-ai-helpers.sh"
else
    echo "✓ AI helpers script not found (optional)"
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
