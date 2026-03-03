#!/bin/bash

# Provision a Vast.ai instance with VSCode

set -e

ROOT="/workspace"
REPO="env-vast-ai-setup"
cd $ROOT

echo "Starting machine provisioning..."

# Update system packages
apt-get update
apt-get upgrade -y

# Install Python and pip
apt-get install -y python3.12 python3-pip

# Install VSCode tunnel
curl -Lk 'https://code.visualstudio.com/sha/download?build=stable&os=cli-alpine-x64' --output $ROOT/vscode_cli.tar.gz
tar -xf $ROOT/vscode_cli.tar.gz
rm $ROOT/vscode_cli.tar.gz

# Install GitHub CLI
apt-get install -y gh
gh auth login

# Configure github stuff
git config --global user.email "kellmanmr@gmail.com"
git config --global user.name "Michael Kellman"

# Verify installations
echo "Verifying installations..."
nvidia-smi
code --version

# Install uv and python dependencies
pip install uv
uv venv --no-project --python 3.12
source $ROOT/.venv/bin/activate
uv pip install -r $ROOT/$REPO/uv/requirements.txt

# Clone the working repositories
git clone https://github.com/kellman/deepul.git
unzip -qq $ROOT/deepul/homeworks/hw1/data/hw1_data.zip -d $ROOT/deepul/homeworks/hw1/data/
pip install $ROOT/deepul

echo "Provisioning complete!"