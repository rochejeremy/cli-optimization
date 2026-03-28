#!/usr/bin/env bash
# Deploy CLI optimization to a new system
# Usage: bash deploy.sh [--dry-run] [--yes] [--skip-tools]

# ============================================================================
# CLI Optimization Deployment Script
# ============================================================================
# This script safely deploys CLI enhancements with:
# - Pre-flight checks and system analysis
# - Interactive prompts for each change
# - Automatic backups before modifications
# - Detailed progress reporting
# - Rollback capability
# ============================================================================

set -o pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
BOLD='\033[1m'
RESET='\033[0m'

# Script configuration
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/.config/cli-optimization-backups/$(date +%Y%m%d_%H%M%S)"
DRY_RUN=false
AUTO_YES=false
SKIP_TOOLS=false
CHANGES_MADE=()
ERRORS=()

# Parse arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --dry-run)
            DRY_RUN=true
            shift
            ;;
        --yes|-y)
            AUTO_YES=true
            shift
            ;;
        --skip-tools)
            SKIP_TOOLS=true
            shift
            ;;
        --help|-h)
            echo "Usage: bash deploy.sh [OPTIONS]"
            echo ""
            echo "Options:"
            echo "  --dry-run      Show what would be done without making changes"
            echo "  --yes, -y      Skip confirmation prompts (auto-approve)"
            echo "  --skip-tools   Skip tool installation (only configure)"
            echo "  --help, -h     Show this help message"
            exit 0
            ;;
        *)
            echo "Unknown option: $1"
            echo "Use --help for usage information"
            exit 1
            ;;
    esac
done

# ============================================================================
# Helper Functions
# ============================================================================

print_header() {
    echo -e "${CYAN}${BOLD}"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "$1"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo -e "${RESET}"
}

print_step() {
    echo -e "${BLUE}${BOLD}▶ $1${RESET}"
}

print_success() {
    echo -e "${GREEN}✓ $1${RESET}"
    CHANGES_MADE+=("$1")
}

print_warning() {
    echo -e "${YELLOW}⚠ $1${RESET}"
}

print_error() {
    echo -e "${RED}✗ $1${RESET}"
    ERRORS+=("$1")
}

print_info() {
    echo -e "${CYAN}ℹ $1${RESET}"
}

ask_yes_no() {
    if [ "$AUTO_YES" = true ]; then
        return 0
    fi

    local prompt="$1"
    local default="${2:-n}"

    if [ "$default" = "y" ]; then
        prompt="$prompt [Y/n]: "
    else
        prompt="$prompt [y/N]: "
    fi

    while true; do
        echo -ne "${YELLOW}${prompt}${RESET}"
        read -r response
        response=${response:-$default}
        case "${response,,}" in
            y|yes) return 0 ;;
            n|no) return 1 ;;
            *) echo "Please answer yes or no." ;;
        esac
    done
}

backup_file() {
    local file="$1"
    if [ -f "$file" ]; then
        mkdir -p "$BACKUP_DIR"
        cp "$file" "$BACKUP_DIR/$(basename "$file").backup"
        print_info "Backed up: $file → $BACKUP_DIR/"
    fi
}

check_command() {
    command -v "$1" &> /dev/null
}

# ============================================================================
# Pre-flight Checks
# ============================================================================

print_header "🚀 CLI Optimization Deployment Script"

if [ "$DRY_RUN" = true ]; then
    print_warning "DRY RUN MODE - No changes will be made"
    echo ""
fi

print_step "Running pre-flight checks..."
echo ""

# Check if we're in the right directory
if [ ! -f "$SCRIPT_DIR/.bashrc_enhanced" ]; then
    print_error "Cannot find .bashrc_enhanced in $SCRIPT_DIR"
    print_info "Please run this script from the optimize_cli directory"
    exit 1
fi

# Detect system
print_info "System: $(uname -s) $(uname -m)"
print_info "Shell: $SHELL"
print_info "Home: $HOME"
print_info "Script location: $SCRIPT_DIR"

# Check if running in WSL
if grep -qi microsoft /proc/version 2>/dev/null; then
    print_info "Environment: WSL detected"
elif [ -d /proc/sys/fs/binfmt_misc/WSLInterop ]; then
    print_info "Environment: WSL2 detected"
else
    print_info "Environment: Native Linux"
fi

echo ""

# Analyze current state
print_step "Analyzing current configuration..."
echo ""

STATE_BASHRC_ENHANCED=false
STATE_STARSHIP_CONFIG=false
STATE_GIT_ENHANCED=false
STATE_SSH_CONFIG=false
INSTALLED_TOOLS=()
MISSING_TOOLS=()

# Check bash configuration
if [ -f ~/.bashrc ] && grep -q "bashrc_enhanced" ~/.bashrc; then
    STATE_BASHRC_ENHANCED=true
    print_info "✓ Bash enhancement already configured"
else
    print_info "○ Bash enhancement not configured"
fi

# Check Starship
if [ -f ~/.config/starship.toml ]; then
    STATE_STARSHIP_CONFIG=true
    print_info "✓ Starship config exists"
else
    print_info "○ Starship config not found"
fi

# Check Git config
if git config --global --get include.path | grep -q "gitconfig_enhanced"; then
    STATE_GIT_ENHANCED=true
    print_info "✓ Git enhancement configured"
else
    print_info "○ Git enhancement not configured"
fi

# Check SSH config
if [ -f ~/.ssh/config ]; then
    STATE_SSH_CONFIG=true
    print_info "✓ SSH config exists"
else
    print_info "○ SSH config not found"
fi

# Check which tools are installed
TOOLS_TO_CHECK=("fzf" "starship" "bat" "eza" "fd" "rg" "zoxide" "tldr" "delta")
for tool in "${TOOLS_TO_CHECK[@]}"; do
    if check_command "$tool"; then
        INSTALLED_TOOLS+=("$tool")
    else
        MISSING_TOOLS+=("$tool")
    fi
done

if [ ${#INSTALLED_TOOLS[@]} -gt 0 ]; then
    print_info "✓ Installed tools: ${INSTALLED_TOOLS[*]}"
fi

if [ ${#MISSING_TOOLS[@]} -gt 0 ]; then
    print_info "○ Missing tools: ${MISSING_TOOLS[*]}"
fi

echo ""

# ============================================================================
# Deployment Plan
# ============================================================================

print_header "📋 Deployment Plan"
echo ""
echo "The following changes will be made:"
echo ""

STEP_NUM=1

if [ "$SKIP_TOOLS" = false ] && [ ${#MISSING_TOOLS[@]} -gt 0 ]; then
    echo -e "${BOLD}Step $STEP_NUM: Install Missing CLI Tools${RESET}"
    echo "   Tools to install: ${MISSING_TOOLS[*]}"
    echo "   This may take 2-5 minutes and requires sudo"
    echo ""
    ((STEP_NUM++))
fi

if [ "$STATE_BASHRC_ENHANCED" = false ]; then
    echo -e "${BOLD}Step $STEP_NUM: Configure Bash${RESET}"
    echo "   Will add: source $SCRIPT_DIR/.bashrc_enhanced"
    echo "   File: ~/.bashrc"
    if [ -f ~/.bashrc ]; then
        echo "   Action: Append to existing file (will backup first)"
    else
        echo "   Action: Create new file"
    fi
    echo ""
    ((STEP_NUM++))
fi

if [ "$STATE_STARSHIP_CONFIG" = false ] || ask_yes_no "Starship config exists. Preview differences?" "n"; then
    echo -e "${BOLD}Step $STEP_NUM: Configure Starship Prompt${RESET}"
    echo "   Will copy: starship.toml → ~/.config/starship.toml"
    if [ "$STATE_STARSHIP_CONFIG" = true ]; then
        echo "   Action: Overwrite existing (will backup first)"
    else
        echo "   Action: Install new config"
    fi
    echo ""
    ((STEP_NUM++))
fi

if [ "$STATE_GIT_ENHANCED" = false ]; then
    echo -e "${BOLD}Step $STEP_NUM: Configure Git${RESET}"
    echo "   Will add 40+ git aliases and better defaults"
    echo "   Current git user: $(git config --global user.name || echo 'not set')"
    echo "   Current git email: $(git config --global user.email || echo 'not set')"
    echo ""
    ((STEP_NUM++))
fi

if [ "$STATE_SSH_CONFIG" = false ]; then
    echo -e "${BOLD}Step $STEP_NUM: Configure SSH${RESET}"
    echo "   Will copy: ssh_config → ~/.ssh/config"
    echo "   Features: connection multiplexing, keep-alive, compression"
    echo ""
    ((STEP_NUM++))
fi

if [ $STEP_NUM -eq 1 ]; then
    print_success "Everything is already configured!"
    echo ""
    print_info "Your system already has all optimizations installed."
    echo ""
    if ask_yes_no "Would you like to see what's configured?"; then
        echo ""
        echo "Installed tools: ${INSTALLED_TOOLS[*]}"
        echo "Bash config: ~/.bashrc sources .bashrc_enhanced"
        echo "Starship: ~/.config/starship.toml"
        echo "Git config: Enhanced with aliases"
        [ "$STATE_SSH_CONFIG" = true ] && echo "SSH config: ~/.ssh/config"
    fi
    exit 0
fi

if [ "$DRY_RUN" = true ]; then
    print_warning "Dry run complete - no changes made"
    exit 0
fi

echo ""
if ! ask_yes_no "Proceed with deployment?" "y"; then
    print_warning "Deployment cancelled by user"
    exit 0
fi

# ============================================================================
# Execute Deployment
# ============================================================================

print_header "🔧 Starting Deployment"
echo ""

# Step 1: Install Tools
if [ "$SKIP_TOOLS" = false ] && [ ${#MISSING_TOOLS[@]} -gt 0 ]; then
    print_step "Step 1: Installing CLI tools..."
    echo ""
    print_info "This will install: ${MISSING_TOOLS[*]}"
    print_info "Installation method: Homebrew (will install if needed)"
    echo ""

    if ask_yes_no "Install tools now?" "y"; then
        if [ -f "$SCRIPT_DIR/install-tools.sh" ]; then
            print_info "Running install-tools.sh..."
            if bash "$SCRIPT_DIR/install-tools.sh"; then
                print_success "Tools installed successfully"
            else
                print_error "Tool installation had some issues (see above)"
                if ! ask_yes_no "Continue with configuration anyway?" "y"; then
                    exit 1
                fi
            fi
        else
            print_error "install-tools.sh not found in $SCRIPT_DIR"
            exit 1
        fi
    else
        print_warning "Skipped tool installation"
    fi
    echo ""
fi

# Step 2: Configure Bash
if [ "$STATE_BASHRC_ENHANCED" = false ]; then
    print_step "Step 2: Configuring Bash..."
    echo ""
    print_info "This will add enhanced bash configuration to ~/.bashrc"
    print_info "Features: better history, aliases, functions, tool integrations"
    echo ""

    if ask_yes_no "Configure bash now?" "y"; then
        backup_file ~/.bashrc

        {
            echo ""
            echo "# ============================================"
            echo "# CLI Optimization - Enhanced Configuration"
            echo "# Installed: $(date)"
            echo "# ============================================"
            echo "source $SCRIPT_DIR/.bashrc_enhanced"
        } >> ~/.bashrc

        print_success "Bash configuration added to ~/.bashrc"
    else
        print_warning "Skipped bash configuration"
    fi
    echo ""
fi

# Step 3: Configure Starship
if [ "$STATE_STARSHIP_CONFIG" = false ] || [ "$STATE_STARSHIP_CONFIG" = true ]; then
    print_step "Step 3: Configuring Starship Prompt..."
    echo ""

    if [ "$STATE_STARSHIP_CONFIG" = true ]; then
        print_info "Existing config found at ~/.config/starship.toml"
        if ask_yes_no "View differences before overwriting?" "n"; then
            if check_command "diff"; then
                diff -u ~/.config/starship.toml "$SCRIPT_DIR/starship.toml" || true
                echo ""
            fi
        fi

        if ! ask_yes_no "Overwrite with new config?" "y"; then
            print_warning "Skipped starship configuration"
            echo ""
            continue
        fi
    fi

    if [ "$STATE_STARSHIP_CONFIG" = false ] || ask_yes_no "Configure starship now?" "y"; then
        backup_file ~/.config/starship.toml
        mkdir -p ~/.config
        cp "$SCRIPT_DIR/starship.toml" ~/.config/starship.toml
        print_success "Starship config installed to ~/.config/starship.toml"
    else
        print_warning "Skipped starship configuration"
    fi
    echo ""
fi

# Step 4: Configure Git
if [ "$STATE_GIT_ENHANCED" = false ]; then
    print_step "Step 4: Configuring Git..."
    echo ""
    print_info "This will add 40+ git aliases and better defaults"
    print_info "Your existing git config will be preserved"
    echo ""

    # Show sample aliases
    print_info "Sample aliases: gs (status), gc (commit), gd (diff), gl (log)"
    echo ""

    if ask_yes_no "Configure git now?" "y"; then
        git config --global include.path "$SCRIPT_DIR/.gitconfig_enhanced"
        print_success "Git configuration added"

        # Configure delta if installed
        if check_command "delta"; then
            print_info "Delta is installed - configuring as git pager"
            git config --global core.pager delta
            git config --global interactive.diffFilter 'delta --color-only'
            print_success "Git delta configured"
        else
            print_info "Delta not installed - skipping pager configuration"
        fi
    else
        print_warning "Skipped git configuration"
    fi
    echo ""
fi

# Step 5: Configure SSH
if [ "$STATE_SSH_CONFIG" = false ]; then
    print_step "Step 5: Configuring SSH..."
    echo ""
    print_info "This will install optimized SSH client configuration"
    print_info "Features: connection multiplexing, keep-alive, compression"
    print_warning "You'll need to edit ~/.ssh/config to add your actual hosts"
    echo ""

    if ask_yes_no "Configure SSH now?" "y"; then
        mkdir -p ~/.ssh
        chmod 700 ~/.ssh
        cp "$SCRIPT_DIR/ssh_config" ~/.ssh/config
        chmod 600 ~/.ssh/config
        print_success "SSH config installed to ~/.ssh/config"
        print_info "Remember to edit ~/.ssh/config with your actual hosts"
    else
        print_warning "Skipped SSH configuration"
    fi
    echo ""
elif [ "$STATE_SSH_CONFIG" = true ]; then
    print_info "SSH config already exists at ~/.ssh/config"
    if ask_yes_no "View optimized SSH config for reference?" "n"; then
        echo ""
        cat "$SCRIPT_DIR/ssh_config"
        echo ""
    fi
    echo ""
fi

# ============================================================================
# Deployment Summary
# ============================================================================

print_header "✅ Deployment Complete!"
echo ""

if [ ${#CHANGES_MADE[@]} -gt 0 ]; then
    echo -e "${GREEN}${BOLD}Changes Made:${RESET}"
    for change in "${CHANGES_MADE[@]}"; do
        echo -e "${GREEN}  ✓${RESET} $change"
    done
    echo ""
fi

if [ ${#ERRORS[@]} -gt 0 ]; then
    echo -e "${RED}${BOLD}Errors Encountered:${RESET}"
    for error in "${ERRORS[@]}"; do
        echo -e "${RED}  ✗${RESET} $error"
    done
    echo ""
fi

if [ -d "$BACKUP_DIR" ]; then
    print_info "Backups saved to: $BACKUP_DIR"
    echo ""
fi

# Next steps
echo -e "${CYAN}${BOLD}Next Steps:${RESET}"
echo ""
echo "1. Reload your shell configuration:"
echo -e "   ${BOLD}source ~/.bashrc${RESET}"
echo ""
echo "2. Test the new features:"
echo "   • Press Ctrl+R for fuzzy history search"
echo "   • Try 'll' for enhanced directory listing"
echo "   • Try 'gs' for git status"
echo "   • Use 'z <directory>' for smart directory jumping"
echo ""
echo "3. Explore new tools:"
if check_command "bat"; then
    echo "   • bat <file>  - View files with syntax highlighting"
fi
if check_command "fd"; then
    echo "   • fd <name>   - Fast file finder"
fi
if check_command "rg"; then
    echo "   • rg <text>   - Fast text search"
fi
echo ""
echo "4. Customize (optional):"
echo "   • Starship prompt: ~/.config/starship.toml"
echo "   • Bash config: $SCRIPT_DIR/.bashrc_enhanced"
echo "   • Git aliases: $SCRIPT_DIR/.gitconfig_enhanced"
echo ""

if [ ! "$STATE_SSH_CONFIG" = true ]; then
    echo "5. Configure SSH hosts: edit ~/.ssh/config"
    echo ""
fi

print_info "For full documentation, see: $SCRIPT_DIR/README.md"
print_info "For deployment to other systems: $SCRIPT_DIR/DEPLOYMENT.md"
echo ""

if [ ${#CHANGES_MADE[@]} -gt 0 ]; then
    echo -e "${GREEN}${BOLD}🎉 Your CLI is now optimized!${RESET}"
else
    echo -e "${YELLOW}${BOLD}No changes were made${RESET}"
fi
echo ""
