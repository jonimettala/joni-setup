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

## What gets installed

**Homebrew formulae**
- `bash` — latest Bash shell
- `gh` — GitHub CLI
- `nvm` — Node Version Manager (also sets up `~/.nvm` and installs latest stable Node)
- `pymupdf` — PDF library for Python
- `awscli` — AWS Command Line Interface

**Homebrew casks**
- `1password-cli` — 1Password CLI
- `claude-code` — Claude Code
- `copilot-cli` — GitHub Copilot CLI
- `iterm2` — iTerm2 terminal
- `raycast` — Raycast launcher

**Dotfiles** (symlinked to `~/`)
- `.zshrc`
- `.gitconfig`
- `.gitignore_global`

**Other**
- [SDKMAN](https://sdkman.io) — installed only; install Java versions manually with `sdk install java`

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
