# CLI Optimization - Quick Reference Card

## 🚀 Getting Started
```bash
cd ~/claude/projects/optimize_cli
bash quick-setup.sh              # One-command setup
source ~/.bashrc                 # Reload configuration
```

## ⌨️ Windows Terminal Shortcuts

### Tabs
| Shortcut | Action |
|----------|--------|
| `Ctrl+T` | New tab |
| `Ctrl+W` | Close tab |
| `Ctrl+Tab` | Next tab |
| `Ctrl+Shift+Tab` | Previous tab |
| `Ctrl+1-5` | Jump to tab 1-5 |

### Panes
| Shortcut | Action |
|----------|--------|
| `Alt+Shift+-` | Split horizontal |
| `Alt+Shift++` | Split vertical |
| `Alt+Shift+D` | Duplicate pane |
| `Alt+Arrow` | Navigate panes |
| `Alt+Shift+Arrow` | Resize panes |
| `Ctrl+Shift+W` | Close pane |

### Other
| Shortcut | Action |
|----------|--------|
| `Ctrl+Shift+F` | Find |
| `Ctrl+Shift+P` | Command palette |
| `Ctrl+,` | Settings |
| `F11` | Fullscreen |
| `Ctrl++/-` | Zoom in/out |

## 🪟 Tmux Shortcuts (Multiplexer)
*Prefix is `Ctrl+a`*

| Shortcut | Action |
|----------|--------|
| `Prefix + r` | Reload config |
| `Prefix + \|` | Split horizontal |
| `Prefix + -` | Split vertical |
| `Prefix + h/j/k/l` | Navigate panes (Vim keys) |
| `Shift + Left/Right` | Switch windows |
| `Prefix + [` | Enter Copy Mode (Vim keys) |
| `Prefix + I` | Install TPM plugins |
| `Prefix + d` | Detach session |
| `tmux attach` | Re-attach to last session |

## 🔍 FZF (Fuzzy Finder)
| Shortcut | Action |
|----------|--------|
| `Ctrl+R` | Search command history |
| `Ctrl+T` | Search files |
| `Alt+C` | Search directories |

## 📁 Navigation Aliases
| Alias | Command | Description |
|-------|---------|-------------|
| `..` | `cd ..` | Up one dir |
| `...` | `cd ../..` | Up two dirs |
| `....` | `cd ../../..` | Up three dirs |
| `-` | `cd -` | Previous dir |
| `projects` | `cd ~/claude/projects` | Quick jump |

## 📋 File Operations
| Alias | Command | Description |
|-------|---------|-------------|
| `ll` | `eza -l` | Detailed list with icons |
| `la` | `eza -la` | List all with details |
| `lt` | `eza -T` | Tree view |
| `cat` | `bat` | View with syntax highlighting |
| `fd` | `fd` | Fast find |
| `rg` | `ripgrep` | Fast search in files |

## 🔧 Useful Functions
| Function | Usage | Description |
|----------|-------|-------------|
| `mkcd` | `mkcd dirname` | Create dir and cd |
| `extract` | `extract file.zip` | Extract any archive |
| `backup` | `backup file.txt` | Timestamped backup |
| `killp` | `killp processname` | Kill by name |
| `gcl` | `gcl repo-url` | Clone and cd |

## 🌳 Git Aliases
| Alias | Git Command | Description |
|-------|-------------|-------------|
| `gs` | `git status -sb` | Short status |
| `ga` | `git add` | Add files |
| `gaa` | `git add --all` | Add all |
| `gc` | `git commit -v` | Commit with diff |
| `gcm` | `git commit -m` | Commit with message |
| `gd` | `git diff` | Show diff |
| `gds` | `git diff --staged` | Staged diff |
| `gl` | `git log` (pretty) | Last 20 commits |
| `gll` | `git log` (detailed) | Detailed log |
| `gp` | `git push` | Push |
| `gpl` | `git pull` | Pull |
| `gco` | `git checkout` | Checkout |
| `gcob` | `git checkout -b` | New branch |
| `gb` | `git branch` | List branches |
| `gst` | `git stash` | Stash changes |
| `gsta` | `git stash apply` | Apply stash |

## 💻 System Aliases
| Alias | Command | Description |
|-------|---------|-------------|
| `c` | `clear` | Clear screen |
| `h` | `history` | Show history |
| `update` | `apt update && upgrade` | Update system |
| `install` | `apt install` | Install package |
| `disk` | `df -h` | Disk usage |
| `mem` | `free -h` | Memory usage |
| `myip` | `curl ifconfig.me` | Show public IP |

## 🐋 Docker Shortcuts
| Alias | Command | Description |
|-------|---------|-------------|
| `d` | `docker` | Docker command |
| `dc` | `docker-compose` | Docker Compose |
| `dps` | `docker ps` | List containers |
| `di` | `docker images` | List images |
| `dex` | `docker exec -it` | Execute in container |
| `dlog` | `docker logs -f` | Follow logs |

## 🐍 Python Shortcuts
| Alias | Command | Description |
|-------|---------|-------------|
| `venv` | `python3 -m venv venv` | Create venv |
| `activate` | `source venv/bin/activate` | Activate venv |

## 📦 Node/npm Shortcuts
| Alias | Command | Description |
|-------|---------|-------------|
| `ni` | `npm install` | Install deps |
| `nid` | `npm install --save-dev` | Install dev deps |
| `nrs` | `npm run start` | Start |
| `nrt` | `npm run test` | Test |
| `nrb` | `npm run build` | Build |

## 🪟 WSL Integration
| Alias | Description |
|-------|-------------|
| `pbcopy` | Copy to Windows clipboard |
| `pbpaste` | Paste from Windows clipboard |
| `explorer` | Open Windows Explorer here |
| `open` | Open with Windows default app |

## 🎨 Starship Prompt Info
Your prompt shows:
- 👤 Username@hostname
- 📁 Current directory
- 🌿 Git branch (if in repo)
- ✓/✗ Git status indicators
- 🐍 Python version (if in venv)
- 📦 Node version (if in node project)
- 🐳 Docker context (if active)

## 🔥 Pro Tips

1. **Use `z` instead of `cd`** - It learns your habits
   ```bash
   z projects    # Jump to frequent directories
   zi            # Interactive directory picker
   ```

2. **Search history with Ctrl+R** - Fuzzy find past commands
   ```bash
   Ctrl+R        # Type partial command
   ```

3. **Preview files before opening**
   ```bash
   Ctrl+T        # Shows bat preview
   ```

4. **Pipe to bat for colored output**
   ```bash
   git diff | bat
   ```

5. **Use ripgrep for code search**
   ```bash
   rg "TODO"     # Fast recursive search
   rg -i "error" # Case insensitive
   ```

6. **Quick backup before editing**
   ```bash
   backup important.txt
   nano important.txt
   ```

7. **Git log with graph**
   ```bash
   gll           # Beautiful log with branches
   ```

8. **Extract any archive**
   ```bash
   extract file.tar.gz
   extract file.zip
   extract file.7z
   ```

## 📚 Learning More

- Type `tldr command` for quick examples
- Check `~/.bashrc_enhanced` for all aliases
- Run `git aliases` to see all git shortcuts
- See full docs: `~/claude/projects/optimize_cli/README.md`

## 🆘 Troubleshooting

**Tools not working?**
```bash
source ~/.bashrc              # Reload config
which fzf starship bat        # Check installations
echo $PATH                    # Verify PATH
```

**FZF not showing?**
```bash
sudo apt install fzf
source ~/.bashrc
```

**Starship not showing?**
```bash
which starship
eval "$(starship init bash)"
```

---

**Print this page or keep it handy while you learn!** 📄

Most useful shortcuts:
- `Ctrl+R` (history search)
- `Ctrl+T` (file search)
- `ll` (beautiful ls)
- `gs` (git status)
- `Alt+Shift+-` (split pane)
