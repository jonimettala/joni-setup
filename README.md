# joni-setup

Ansible playbook for setting up a Mac. Run `bootstrap.sh` on a new machine — it installs Homebrew and Ansible, then runs the playbook.

## First-time setup on a new Mac

```bash
git clone git@github.com:jonimettala/joni-setup.git ~/dev/repos/joni-setup
cd ~/dev/repos/joni-setup
./bootstrap.sh
```

`bootstrap.sh` installs Homebrew and Ansible if they're missing, then runs the playbook.

## Updating an existing machine

After editing `group_vars/all.yml` (e.g. adding a new cask), re-run the playbook to apply the changes:

```bash
cd ~/dev/repos/joni-setup

# Run the full playbook
ansible-playbook playbook.yml -i inventory/local

# Or run only a specific part (homebrew, dotfiles, nvm, sdkman)
ansible-playbook playbook.yml -i inventory/local --tags homebrew
```

Re-running is always safe — it only installs what's missing and skips everything already in place.

You can also re-run `./bootstrap.sh` instead. It skips Homebrew and Ansible if they're already installed and then runs the playbook.

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
- `.gitconfig` — shared git settings; machine-specific user name and email are stored in `~/.gitconfig.local` (created on first run, not tracked in the repo)
- `.gitignore_global`

**Other**
- [SDKMAN](https://sdkman.io) — installed only; install Java versions manually with `sdk install java`

## Customization

Edit `group_vars/all.yml` to add or remove packages:

- **`homebrew_formulae`** — command-line tools (e.g. `gh`, `awscli`)
- **`homebrew_casks`** — GUI apps (e.g. `iterm2`, `raycast`)

```yaml
homebrew_formulae:
  - gh
  - nvm
  - ...

homebrew_casks:
  - 1password-cli
  - ...
```

After saving, re-run the playbook as described in [Updating an existing machine](#updating-an-existing-machine).
