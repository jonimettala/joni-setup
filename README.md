# joni-setup

Ansible playbook for setting up a Mac. Run `bootstrap.sh` on a new machine — it installs Homebrew and Ansible, then runs the playbook.

## Usage

```bash
# Clone the repo
git clone https://github.com/YOUR_USERNAME/joni-setup.git ~/work/repos/joni-setup
cd ~/work/repos/joni-setup

# Run bootstrap (installs Homebrew + Ansible + runs the playbook)
./bootstrap.sh
```

## Structure

```
.
├── bootstrap.sh          # Entry point for a new machine
├── playbook.yml          # Main playbook
├── requirements.yml      # Ansible Galaxy collections
├── inventory/local       # localhost inventory
├── group_vars/all.yml    # All variables (packages, settings)
├── dotfiles/             # Personal config files (symlinked to home directory)
│   ├── .zshrc
│   ├── .gitconfig
│   └── .gitignore_global
└── roles/
    ├── homebrew/         # Brew formulae and casks
    ├── dotfiles/         # Symlinks for dotfiles
    ├── nvm/              # Node Version Manager
    └── sdkman/           # SDKMAN (Java/Kotlin etc.)
```

## Customization

Add/remove packages in `group_vars/all.yml`:

```yaml
homebrew_formulae:
  - gh
  - nvm
  - ...

homebrew_casks:
  - 1password-cli
  - ...
```

## Running individual roles

```bash
ansible-playbook playbook.yml -i inventory/local --tags homebrew
ansible-playbook playbook.yml -i inventory/local --tags dotfiles
ansible-playbook playbook.yml -i inventory/local --tags nvm
ansible-playbook playbook.yml -i inventory/local --tags sdkman
```
