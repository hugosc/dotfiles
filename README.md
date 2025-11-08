# Dotfiles Repository

This repository contains configuration files (dotfiles) for various applications, managed using **GNU Stow**.

## What is Stow?

GNU Stow is a symlink farm manager that helps organize and deploy dotfiles efficiently. Instead of manually copying configuration files to your home directory, stow creates symbolic links from a central repository to their target locations.

### Why Use Stow?

- **Version Control**: Keep all configurations in one git repository
- **Easy Deployment**: Deploy or remove configurations with single commands
- **Non-Destructive**: If a file already exists, stow warns you instead of overwriting
- **Selective Installation**: Install only the configurations you need
- **Simple Cleanup**: Remove configurations cleanly by unstowing

## Installation

### On macOS
```bash
brew install stow
```

### On Linux (Ubuntu/Debian)
```bash
sudo apt-get install stow
```

### On Linux (Fedora/RHEL)
```bash
sudo dnf install stow
```

## Directory Structure

This repository uses a package-based structure where each subdirectory represents a configuration package:

```
dotfiles/
├── btop/              # btop (system monitor) config
├── kitty/             # Kitty terminal config
├── shell/             # Shell configuration (.zshrc, etc.)
├── scripts/           # Custom scripts
├── git/               # Git configuration
├── gh/                # GitHub CLI config
├── spicetify/         # Spotify customization
├── vesktop/           # Vesktop (Discord client) config
└── ...
```

Each package contains the relative path structure that mirrors your `$HOME` directory:

```
kitty/
└── .config/
    └── kitty/
        ├── kitty.conf
        ├── current-theme.conf
        └── themes/
```

## Basic Usage

### Install a Package

To create symlinks for a specific package:

```bash
cd ~/dotfiles
stow kitty
```

This creates symlinks in your home directory:
- `~/.config/kitty/` → symlink to `dotfiles/kitty/.config/kitty/`

### Install Multiple Packages

```bash
stow kitty shell scripts git
```

### Install All Packages

```bash
stow */
```

### Remove a Package

To delete the symlinks for a package:

```bash
stow -D kitty
```

### Reinstall (Delete and Recreate)

```bash
stow -R kitty
```

## Advanced Usage

### Adopt Existing Configurations

If you have existing configs in your home directory that you want to move into the repository:

1. Move the file to the appropriate package directory while preserving the path structure
2. From the dotfiles directory, run: `stow -R package-name`

### Conflict Resolution

If stow detects conflicts (e.g., a file already exists at the target location):

```bash
# Check what stow would do without making changes
stow --simulate kitty

# Adopt an existing file (replace with symlink)
stow --adopt kitty
```

### Verbose Output

See detailed information about what stow is doing:

```bash
stow -v kitty    # Verbose
stow -vv kitty   # Very verbose
```

## Available Packages

- **btop** - System monitor configuration
- **config-wal** - Colorscheme management
- **fastfetch** - System information display
- **fum** - File manager configuration
- **gh** - GitHub CLI configuration
- **git** - Git global configuration
- **kitty** - Terminal emulator configuration
- **lazygit** - Git TUI configuration
- **ncspot** - Spotify TUI configuration
- **picom** - Window compositor configuration
- **scripts** - Custom shell scripts
- **shell** - Shell configuration (zsh, aliases, etc.)
- **spicetify** - Spotify appearance customization
- **vesktop** - Discord client configuration

## Quick Start

1. Clone this repository:
```bash
git clone <repo-url> ~/dotfiles
cd ~/dotfiles
```

2. Install stow if not already installed

3. Deploy packages:
```bash
# Install essential packages
stow shell git scripts

# Or install specific packages
stow kitty lazygit
```

4. Verify symlinks were created:
```bash
ls -la ~/.config/
```

## Tips and Tricks

### View All Symlinks Created by Stow
```bash
ls -la ~/.config/ | grep "^l"
```

### Check Stow Status
```bash
cd ~/dotfiles
stow --no-folding kitty  # See individual files instead of directories
```

### Ignore Files in Packages
Create a `.stowignore` file in the dotfiles directory to exclude patterns:
```
.git
*.swp
.DS_Store
```

## Troubleshooting

### "Conflict detected"
This means stow found an existing file/directory at the target location. Either:
- Delete the existing file: `rm ~/.config/kitty/kitty.conf`
- Use `--adopt` to replace it with a symlink: `stow --adopt kitty`
- Manually review and resolve conflicts

### Symlinks not created
- Ensure you're running stow from the dotfiles directory: `cd ~/dotfiles`
- Check file permissions: `ls -la`
- Use verbose mode: `stow -vv package-name`

### Can't find stow
Make sure it's installed and in your PATH: `which stow`

## Best Practices

1. **Backup First**: Before deploying new packages, backup existing configs
2. **Test Before Mass Deploy**: Test individual packages first
3. **Keep Secrets Out**: Don't commit sensitive data (API keys, passwords)
4. **Use .gitignore**: Exclude user-specific or sensitive files
5. **Document Changes**: Update this README when adding new packages

## Further Reading

- [GNU Stow Documentation](https://www.gnu.org/software/stow/manual/)
- [Stow GitHub Repository](https://github.com/aspiers/stow)
- [Dotfiles Best Practices](https://dotfiles.github.io/)
