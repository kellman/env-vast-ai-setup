#!/bin/bash

# Provision a Vast.ai instance with VSCode

set -e

echo "Starting machine provisioning..."

# Update system packages
apt-get update
apt-get upgrade -y

# Install Python and pip
apt-get install -y python3 python3-pip

# Install VSCode tunnel
curl -Lk 'https://code.visualstudio.com/sha/download?build=stable&os=cli-alpine-x64' --output vscode_cli.tar.gz
tar -xf vscode_cli.tar.gz
rm vscode_cli.tar.gz

# Install GitHub CLI
apt-get install -y gh

# Login to GitHub CLI
gh auth login

# Configure github stuff
git config --global user.email "kellmanmr@gmail.com"
git config --global user.name "Michael Kellman"

# Verify installations
echo "Verifying installations..."
nvidia-smi
python3 -c "import torch; print(f'PyTorch version: {torch.__version__}')"
code --version

# Clone the working repositories
git clone https://github.com/kellman/deepul.git

echo "Provisioning complete!"