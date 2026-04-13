#!/usr/bin/env bash
set -euo pipefail

# Bootstrap: install Homebrew + Ansible, then run the playbook.
# Usage: ./bootstrap.sh

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Install Homebrew if not present
if ! command -v brew &>/dev/null; then
  echo "==> Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  # Add brew to PATH for Apple Silicon Macs
  if [[ -f /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi
fi

echo "==> Homebrew $(brew --version | head -1)"

# Install Ansible via brew if not present
if ! command -v ansible &>/dev/null; then
  echo "==> Installing Ansible..."
  brew install ansible
fi

echo "==> Ansible $(ansible --version | head -1)"

# Install required Ansible collections
echo "==> Installing Ansible Galaxy collections..."
ansible-galaxy collection install -r "$REPO_DIR/requirements.yml"

# Run the playbook
echo "==> Running playbook..."
ansible-playbook "$REPO_DIR/playbook.yml" -i "$REPO_DIR/inventory/local" "$@"
