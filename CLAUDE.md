# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repo is

An Ansible playbook that provisions a personal macOS machine: Homebrew packages, dotfile symlinks, iTerm2 prefs, nvm, and SDKMAN. The target host is always `localhost` (see `inventory/local`).

## Common commands

```bash
# Full provisioning (also installs Homebrew + Ansible if missing)
./bootstrap.sh

# Re-run the playbook on an already-bootstrapped machine
ansible-playbook playbook.yml -i inventory/local

# Run only one role — every task is tagged with its role name
ansible-playbook playbook.yml -i inventory/local --tags homebrew
ansible-playbook playbook.yml -i inventory/local --tags iterm2
```

There are no tests, linters, or build steps. Validation is "re-run the playbook and check it's still idempotent."

## Architecture

- **`group_vars/all.yml`** is the single source of user-customizable input (package lists, paths, versions). New roles should read their inputs from here, not hard-code them.
- **Each role is a single `tasks/main.yml`** under `roles/<name>/`. There are no handlers, defaults, or vars files — keep it that way unless a role genuinely needs them.
- **Every task carries a `tags: <role-name>` tag.** This is what makes `--tags <role>` work; preserve it on new tasks.
- **Role order in `playbook.yml` matters.** `homebrew` runs first because later roles (e.g. `iterm2`, `nvm`) depend on packages it installs.
- **`requirements.yml`** lists Ansible Galaxy collections (currently `community.general`, used for `homebrew*` and `osx_defaults` modules). `bootstrap.sh` installs these before running the playbook.

## Conventions

- **Idempotency is non-negotiable.** Every task must be safe to re-run. Use `creates:`, `state: present`, `community.general.osx_defaults`, or explicit `stat` + `when:` guards rather than unconditional shell commands.
- **Machine-specific secrets stay out of the repo.** Pattern: the playbook prompts on first run and writes to a `*.local` file in `$HOME` that is gitignored on the user's machine (see `roles/dotfiles/tasks/main.yml` creating `~/.gitconfig.local`, which `dotfiles/.gitconfig` includes via `[include] path = ~/.gitconfig.local`).
- **iTerm2 prefs are owned by iTerm2, not Ansible.** The `iterm2` role only flips `LoadPrefsFromCustomFolder`/`PrefsCustomFolder` to point at `iterm2/` in the repo. iTerm2 itself reads and writes `iterm2/com.googlecode.iterm2.plist`. Don't add tasks that template or patch the plist — let the GUI write it and commit the diff.
- **Use Conventional Commits** (`feat:`, `fix:`, `docs:`, `chore:`, etc.) for commit messages. The older history is mixed; new commits should follow the convention.
- **Never commit directly to `main`.** `main` is protected — pushes are rejected. Always create a topic branch first (`git switch -c <name>`) and commit there, then push the branch and open a PR.
- **Always update `README.md`** when adding or removing packages in `group_vars/all.yml`. The "What gets installed" section must stay in sync.
