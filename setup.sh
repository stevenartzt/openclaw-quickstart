#!/bin/bash
#
# OpenClaw Quickstart - One-command setup for WSL, Linux, and VPS
# https://github.com/stevenartzt/openclaw-quickstart
#
# Usage:
#   curl -fsSL https://raw.githubusercontent.com/stevenartzt/openclaw-quickstart/main/setup.sh | bash
#   OR
#   git clone https://github.com/stevenartzt/openclaw-quickstart.git && cd openclaw-quickstart && ./setup.sh
#

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Logging
log() { echo -e "${GREEN}[OPENCLAW]${NC} $1"; }
warn() { echo -e "${YELLOW}[WARNING]${NC} $1"; }
error() { echo -e "${RED}[ERROR]${NC} $1"; exit 1; }
info() { echo -e "${BLUE}[INFO]${NC} $1"; }

# Banner
echo ""
echo -e "${BLUE}"
echo "   ___                    ____ _"
echo "  / _ \ _ __   ___ _ __  / ___| | __ ___      __"
echo " | | | | '_ \ / _ \ '_ \| |   | |/ _\` \ \ /\ / /"
echo " | |_| | |_) |  __/ | | | |___| | (_| |\ V  V /"
echo "  \___/| .__/ \___|_| |_|\____|_|\__,_| \_/\_/"
echo "       |_|"
echo -e "${NC}"
echo "  Quickstart Setup - WSL / Linux / VPS"
echo ""

# Detect OS
detect_os() {
    if grep -qi microsoft /proc/version 2>/dev/null; then
        echo "wsl"
    elif [[ -f /etc/debian_version ]]; then
        echo "debian"
    elif [[ -f /etc/redhat-release ]]; then
        echo "redhat"
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        echo "macos"
    else
        echo "linux"
    fi
}

OS=$(detect_os)
log "Detected OS: $OS"

# Check if running as root
if [[ $EUID -eq 0 ]]; then
    warn "Running as root. Consider running as a regular user."
fi

# Install dependencies based on OS
install_deps() {
    log "Installing dependencies..."
    
    case $OS in
        wsl|debian)
            sudo apt-get update -qq
            sudo apt-get install -y -qq curl git build-essential
            ;;
        redhat)
            sudo yum install -y curl git gcc-c++ make
            ;;
        macos)
            if ! command -v brew &> /dev/null; then
                /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
            fi
            brew install git node
            ;;
        *)
            warn "Unknown OS, assuming dependencies are installed"
            ;;
    esac
}

# Install Node.js 22 via nvm
install_node() {
    # Always use nvm for user-local node (avoids permission issues)
    export NVM_DIR="$HOME/.nvm"
    
    # Install nvm if not present
    if [[ ! -d "$NVM_DIR" ]]; then
        log "Installing nvm..."
        curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
    fi
    
    # Load nvm
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    
    # Check if node 22 is already installed via nvm
    if nvm ls 22 &> /dev/null; then
        nvm use 22
        log "Node.js $(node -v) already installed via nvm ✓"
        return
    fi
    
    log "Installing Node.js 22..."
    
    # Install Node 22
    nvm install 22
    nvm use 22
    nvm alias default 22
    
    log "Node.js $(node -v) installed ✓"
}

# Install OpenClaw
install_openclaw() {
    log "Installing OpenClaw..."
    
    # Ensure nvm is loaded
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    
    # Check if we're using nvm (user-local) or system node
    if [[ -d "$NVM_DIR" ]] && command -v nvm &> /dev/null; then
        # Using nvm - can install globally without sudo
        npm install -g openclaw
    else
        # Using system node - need sudo for global install
        sudo npm install -g openclaw
    fi
    
    log "OpenClaw installed ✓"
}

# Run OpenClaw setup
setup_openclaw() {
    log "Running OpenClaw setup wizard..."
    
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    
    openclaw setup
}

# Create workspace
create_workspace() {
    log "Creating workspace..."
    
    mkdir -p ~/.openclaw/workspace
    
    # Create basic SOUL.md
    if [[ ! -f ~/.openclaw/workspace/SOUL.md ]]; then
        cat > ~/.openclaw/workspace/SOUL.md << 'SOUL'
# SOUL.md - Your Agent's Personality

I'm your personal AI assistant running on OpenClaw.

## Core Traits
- Helpful and direct
- Technical when needed, conversational otherwise
- Focused on getting things done

## Capabilities
- Execute shell commands
- Search the web
- Manage files
- Connect to Discord, Telegram, WhatsApp, and more

---
*Customize this file to shape your agent's personality.*
SOUL
        log "Created SOUL.md"
    fi
    
    # Initialize git repo
    if [[ ! -d ~/.openclaw/workspace/.git ]]; then
        cd ~/.openclaw/workspace
        git init -q
        git add -A
        git commit -m "Initial workspace setup" -q 2>/dev/null || true
        log "Initialized workspace git repo"
    fi
}

# Install Public.com skill
install_public_skill() {
    log "Installing Public.com trading skill..."
    
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    
    # Create skills directory
    mkdir -p ~/.openclaw/workspace/skills
    
    # Clone or update the skill
    if [[ -d ~/.openclaw/workspace/skills/claw-skill-public-dot-com ]]; then
        cd ~/.openclaw/workspace/skills/claw-skill-public-dot-com
        git pull -q
    else
        git clone -q https://github.com/publicdotcom/claw-skill-public-dot-com.git ~/.openclaw/workspace/skills/claw-skill-public-dot-com 2>/dev/null || \
        warn "Could not clone Public.com skill - you can add it manually later"
    fi
    
    # Install Python dependencies if present
    if [[ -f ~/.openclaw/workspace/skills/claw-skill-public-dot-com/requirements.txt ]]; then
        pip3 install -q -r ~/.openclaw/workspace/skills/claw-skill-public-dot-com/requirements.txt 2>/dev/null || true
    fi
    
    # Install publicdotcom-py SDK
    pip3 install -q publicdotcom-py 2>/dev/null || true
    
    log "Public.com skill installed ✓"
}

# Setup systemd service (Linux/VPS)
setup_service() {
    if [[ $OS == "macos" ]]; then
        info "macOS detected - use the OpenClaw app for background running"
        return
    fi
    
    read -p "Set up OpenClaw as a background service? (y/n) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        return
    fi
    
    log "Setting up systemd service..."
    
    # Enable lingering for user services
    sudo loginctl enable-linger $USER 2>/dev/null || true
    
    # Create user service directory
    mkdir -p ~/.config/systemd/user
    
    # Get node path
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    NODE_PATH=$(which node)
    OPENCLAW_PATH=$(which openclaw)
    
    # Create service file
    cat > ~/.config/systemd/user/openclaw.service << EOF
[Unit]
Description=OpenClaw Gateway
After=network.target

[Service]
Type=simple
ExecStart=$NODE_PATH $OPENCLAW_PATH gateway
Restart=always
RestartSec=10
Environment=PATH=$PATH
Environment=NVM_DIR=$HOME/.nvm

[Install]
WantedBy=default.target
EOF
    
    # Enable and start
    systemctl --user daemon-reload
    systemctl --user enable openclaw
    systemctl --user start openclaw
    
    log "Service installed and started ✓"
    info "Check status: systemctl --user status openclaw"
}

# Print completion message
complete_setup() {
    echo ""
    echo -e "${GREEN}═══════════════════════════════════════════════════════════${NC}"
    echo -e "${GREEN}  OpenClaw Setup Complete! 🎉${NC}"
    echo -e "${GREEN}═══════════════════════════════════════════════════════════${NC}"
    echo ""
    echo "  Quick commands:"
    echo "    openclaw gateway     - Start the gateway"
    echo "    openclaw health      - Check status"
    echo "    openclaw channels login discord  - Connect Discord"
    echo ""
    echo "  Configuration:"
    echo "    ~/.openclaw/openclaw.json  - Main config"
    echo "    ~/.openclaw/workspace/     - Your workspace"
    echo ""
    echo "  Documentation:"
    echo "    https://docs.openclaw.ai"
    echo ""
    
    if [[ -n "$PUBLIC_SKILL_INSTALLED" ]]; then
        echo "  Public.com Trading:"
        echo "    Set PUBLIC_COM_SECRET in ~/.openclaw/.env"
        echo "    Set PUBLIC_COM_ACCOUNT_ID for default account"
        echo ""
    fi
    
    echo -e "${YELLOW}  Next step: Run 'openclaw gateway' to start!${NC}"
    echo ""
}

# Main
main() {
    install_deps
    install_node
    install_openclaw
    create_workspace
    
    read -p "Install Public.com trading skill? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        install_public_skill
        PUBLIC_SKILL_INSTALLED=1
    fi
    
    setup_openclaw
    setup_service
    complete_setup
}

main "$@"
