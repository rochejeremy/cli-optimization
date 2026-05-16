#!/usr/bin/env bash
# CLI Optimization Tools Installation Script
# Run with: bash install-tools.sh

echo "Installing modern CLI tools..."

# Update package list
sudo apt update

# Install from apt
echo "Installing: fzf, ripgrep, fd-find, bat..."
sudo apt install -y fzf ripgrep fd-find bat

# Create bat symlink (Ubuntu packages it as batcat)
mkdir -p ~/.local/bin
ln -sf /usr/bin/batcat ~/.local/bin/bat 2>/dev/null

# Install eza (modern ls replacement)
echo "Installing eza..."
sudo mkdir -p /etc/apt/keyrings
wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
sudo apt update
sudo apt install -y eza

# Install starship prompt
echo "Installing starship..."
curl -sS https://starship.rs/install.sh | sh -s -- -y

# Install zoxide (smart cd)
echo "Installing zoxide..."
curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash

# Install tldr
echo "Installing tldr..."
sudo apt install -y tldr

# Install git-delta
echo "Installing git-delta..."
wget https://github.com/dandavison/delta/releases/download/0.17.0/git-delta_0.17.0_amd64.deb
sudo dpkg -i git-delta_0.17.0_amd64.deb
rm git-delta_0.17.0_amd64.deb

echo ""
echo "✓ Installation complete!"
echo "Run: source ~/.bashrc"
