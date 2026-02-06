#!/bin/bash

# --- CHAD-KING AUTOMATION ENGINE ---
# Philosophy: Logic > Optics. O(1) Deployment.
# Optimized for HP Envy x360 (8GB RAM / Ryzen 7000)

echo "👑 Initializing Chad-King Architecture..."

# 1. HARDWARE HONESTY: Install System Packages
echo "🏎️  Deploying System Manifest..."
sudo pacman -S --needed --noconfirm $(grep -v '^#' packages.txt)

# 2. SPATIAL CERTAINTY: Symlink Configs with GNU Stow
echo "🔗 Mapping Configuration HUD..."
# Ensures .config directory exists before stowing
mkdir -p ~/.config
stow .config

# 3. EXODIA CORE: Deploy Systemd Mounts
echo "⚙️  Configuring Unraid Automounts..."
if [ -d "systemd" ]; then
    sudo cp systemd/mnt-unraid.mount /etc/systemd/system/
    sudo cp systemd/mnt-unraid.automount /etc/systemd/system/
    sudo systemctl daemon-reload
    sudo systemctl enable --now mnt-unraid.automount
fi

# 4. THE BUILD: Initialize Python Virtual Environment
echo "🐍 Setting up Python Logic..."
if [ ! -d "$HOME/.venv" ]; then
    python -m venv "$HOME/.venv"
fi
source "$HOME/.venv/bin/activate"
pip install --upgrade pip
pip install -r requirements.txt

# 5. API KEY HYGIENE
echo "🔑 Verifying Inference Credentials..."
if [ ! -f "$HOME/.env" ]; then
    touch "$HOME/.env"
    echo "⚠️  Created ~/.env. Add your GEMINI_API_KEY and ANTHROPIC_API_KEY here."
fi

# Ensure keys are exported to the environment
grep -q "source $HOME/.env" ~/.zshrc || echo "source $HOME/.env" >> ~/.zshrc

echo "✅ Deployment Complete. System Map Restored."
