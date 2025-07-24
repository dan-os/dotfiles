[![Project Banner](https://github.com/dan-os/dotfiles/blob/main/.github/banner.png?raw=true)](https://github.com/dan-os/dotfiles)

# dotfiles

these are my dotfiles. there are many others like them, but these ones is mine.

## Usage

### 1. Prerequisites:

Ensure the following are available prior to starting:

- `xcode tools` (macOS only)
- `curl` or `wget`
- `git`

### 2. Bootstrap

Execute the following to bootstrap the target machine, following prompts to configure the password manager (1pass):

```bash
# Bootstrap a new machine with one line
/bin/bash -c "$(curl -fsSL go.dan.sm/dotfiles)"
```

That's it! The machine should now be correctly provisioned.

Updates are applied by executing:

```bash
# Update dotfiles to the latest remote
chezmoi update
```

### Todos

- Manage versions with renovate
- Add a changelog
