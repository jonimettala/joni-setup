# joni-setup

Ansible playbook Mac-koneen setuppaamiseen. Aja `bootstrap.sh` uudella koneella — se asentaa Homebrew:n ja Ansible:n, ja ajaa playbookin.

## Käyttö

```bash
# Kloonaa repo
git clone https://github.com/YOUR_USERNAME/joni-setup.git ~/work/repos/joni-setup
cd ~/work/repos/joni-setup

# Aja bootstrap (asentaa Homebrew + Ansible + ajaa playbookin)
./bootstrap.sh
```

## Rakenne

```
.
├── bootstrap.sh          # Aloituspiste uudella koneella
├── playbook.yml          # Pääplaybook
├── requirements.yml      # Ansible Galaxy -kokoelmat
├── inventory/local       # localhost-inventaario
├── group_vars/all.yml    # Kaikki muuttujat (paketit, asetukset)
├── dotfiles/             # Omat konfiguraatiotiedostot (symlinkataan kotihakemistoon)
│   ├── .zshrc
│   ├── .gitconfig
│   └── .gitignore_global
└── roles/
    ├── homebrew/         # Brew formulat ja caskit
    ├── dotfiles/         # Symlinkit dotfilesille
    ├── nvm/              # Node Version Manager
    └── sdkman/           # SDKMAN (Java/Kotlin jne.)
```

## Muokkaus

Lisää/poista paketteja `group_vars/all.yml`:ssä:

```yaml
homebrew_formulae:
  - gh
  - nvm
  - ...

homebrew_casks:
  - 1password-cli
  - ...
```

## Yksittäisten roolien ajo

```bash
ansible-playbook playbook.yml -i inventory/local --tags homebrew
ansible-playbook playbook.yml -i inventory/local --tags dotfiles
ansible-playbook playbook.yml -i inventory/local --tags nvm
ansible-playbook playbook.yml -i inventory/local --tags sdkman
```
