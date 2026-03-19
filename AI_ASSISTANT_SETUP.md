# Using Your Optimized CLI with AI Assistants

## Overview

The `AGENTS.md` file contains comprehensive instructions for **any AI assistant** (Claude Code, Gemini CLI, ChatGPT, etc.) to understand your environment and work effectively.

## For Claude Code (Anthropic)

### Auto-Loading
Claude Code automatically loads context from:
- **Memory**: `~/.claude/projects/<project>/memory/MEMORY.md`
- **Project context**: Files in your working directory

My memory already includes your ShareX screenshot location.

### Manual Reference
If I seem to forget something, you can say:
```
"Check AGENTS.md for my environment setup"
"What's in my memory?"
```

## For Gemini CLI (Google)

### Option 1: Include in Every Prompt
Add to your Gemini CLI config to auto-load context:

```bash
# Edit your gemini CLI wrapper or config
nano ~/.config/gemini/config

# Add this line to prepend context:
context_file="$HOME/claude/projects/optimize_cli/AGENTS.md"
```

### Option 2: Manual Loading
When starting a conversation:
```bash
gemini "$(cat ~/claude/projects/optimize_cli/AGENTS.md)

---

Now help me with: [your question]"
```

### Option 3: Create Gemini Wrapper
```bash
cat > ~/.local/bin/gemini-enhanced << 'EOF'
#!/usr/bin/env bash
# Enhanced Gemini CLI with auto-loaded context

CONTEXT_FILE="$HOME/claude/projects/optimize_cli/AGENTS.md"
PROMPT="$*"

if [ -f "$CONTEXT_FILE" ]; then
    FULL_PROMPT="[SYSTEM CONTEXT - Read this first]
$(cat $CONTEXT_FILE)

[USER REQUEST]
$PROMPT"
else
    FULL_PROMPT="$PROMPT"
fi

# Call actual gemini CLI
gemini "$FULL_PROMPT"
EOF

chmod +x ~/.local/bin/gemini-enhanced
```

Then use: `gemini-enhanced "your question"`

## For ChatGPT / Web Interfaces

### Copy-Paste Context
When starting a new conversation:

1. Copy AGENTS.md content:
```bash
cat ~/claude/projects/optimize_cli/AGENTS.md | clip
```

2. Paste into ChatGPT and say:
```
Read this system context first, then help me with: [your request]
```

### Custom Instructions
In ChatGPT settings → Custom Instructions:
```
# Environment
- WSL2 Ubuntu on Windows
- Enhanced bash with fzf, starship, eza, bat, ripgrep, zoxide
- ShareX screenshots: /mnt/c/Users/roche/OneDrive/Documents/ShareX/Screenshots/YYYY-MM/
- Projects: ~/claude/projects/

# Preferences
- Concise and direct responses
- Use my enhanced CLI aliases (ll, gs, gd, etc.)
- Check ShareX folder for screenshots
- Practical examples over theory

Full context: ~/claude/projects/optimize_cli/AGENTS.md
```

## For GitHub Copilot / IDE Assistants

### VS Code
Add to workspace settings (`.vscode/settings.json`):
```json
{
  "github.copilot.advanced": {
    "contextFiles": [
      "${workspaceFolder}/../optimize_cli/AGENTS.md"
    ]
  }
}
```

### Cursor / Windsurf
Add to `.cursorrules` or similar:
```
Include context from: ~/claude/projects/optimize_cli/AGENTS.md
```

## For Custom AI Scripts

### Loading Context Programmatically

**Python**:
```python
import os
from pathlib import Path

def load_agent_context():
    context_file = Path.home() / "claude/projects/optimize_cli/AGENTS.md"
    if context_file.exists():
        return context_file.read_text()
    return ""

# Use with OpenAI, Anthropic, or Google APIs
system_context = load_agent_context()
```

**Node.js**:
```javascript
const fs = require('fs');
const os = require('os');
const path = require('path');

function loadAgentContext() {
  const contextPath = path.join(
    os.homedir(),
    'claude/projects/optimize_cli/AGENTS.md'
  );
  return fs.readFileSync(contextPath, 'utf8');
}

// Use with API calls
const systemContext = loadAgentContext();
```

**Bash**:
```bash
#!/usr/bin/env bash
# Load context for any AI API call

CONTEXT_FILE="$HOME/claude/projects/optimize_cli/AGENTS.md"
CONTEXT=$(cat "$CONTEXT_FILE")

# Use in API calls
curl -X POST https://api.example.com/chat \
  -H "Content-Type: application/json" \
  -d "{
    \"system\": \"$CONTEXT\",
    \"prompt\": \"$1\"
  }"
```

## Screenshot Integration Examples

### For Claude Code
```bash
# Get latest screenshot path
latest-screenshot

# In conversation:
"Here's my latest screenshot: $(latest-screenshot)"
```

I'll automatically read and analyze it.

### For Gemini CLI
```bash
# If gemini supports images
gemini "What's in this screenshot?" --image "$(latest-screenshot)"

# Or include path in text
gemini "Analyze the screenshot at: $(latest-screenshot)"
```

### For ChatGPT (via API)
```bash
SCREENSHOT=$(latest-screenshot)
# Upload via API with base64 encoding
base64 "$SCREENSHOT" | curl ...
```

## Quick Helper Scripts

### Universal AI Context Loader
```bash
cat > ~/.local/bin/ai-context << 'EOF'
#!/usr/bin/env bash
# Load AI agent context for any assistant

cat "$HOME/claude/projects/optimize_cli/AGENTS.md"
EOF

chmod +x ~/.local/bin/ai-context
```

Usage:
```bash
# Copy to clipboard
ai-context | clip

# Include in prompt
gemini "$(ai-context) Now help me with: [question]"
```

### Screenshot Sender
```bash
cat > ~/.local/bin/send-screenshot << 'EOF'
#!/usr/bin/env bash
# Get latest screenshot info for AI assistants

SCREENSHOT=$(latest-screenshot)
if [ -n "$SCREENSHOT" ]; then
    echo "Latest screenshot: $SCREENSHOT"
    echo "Taken: $(stat -c %y "$SCREENSHOT" | cut -d'.' -f1)"
    echo "Size: $(du -h "$SCREENSHOT" | cut -f1)"

    # Copy path to clipboard
    echo -n "$SCREENSHOT" | clip
    echo "Path copied to clipboard!"
else
    echo "No screenshots found in current month"
fi
EOF

chmod +x ~/.local/bin/send-screenshot
```

## Updating AGENTS.md

When your environment changes:

1. **Edit the file**:
```bash
nano ~/claude/projects/optimize_cli/AGENTS.md
```

2. **Add new tools/paths**:
```bash
echo "## New Tool
- Installation: ...
- Usage: ...
" >> ~/claude/projects/optimize_cli/AGENTS.md
```

3. **Version control** (optional):
```bash
cd ~/claude/projects/optimize_cli
git init
git add AGENTS.md
git commit -m "Update agent context"
```

## Testing Context Loading

### Verify File Exists
```bash
test -f ~/claude/projects/optimize_cli/AGENTS.md && echo "✓ AGENTS.md found" || echo "✗ AGENTS.md missing"
```

### Check Size
```bash
wc -l ~/claude/projects/optimize_cli/AGENTS.md
# Should show ~400+ lines
```

### Preview Content
```bash
head -30 ~/claude/projects/optimize_cli/AGENTS.md
```

## Best Practices

### 1. Keep It Updated
When you install new tools or change paths, update AGENTS.md:
```bash
nano ~/claude/projects/optimize_cli/AGENTS.md
```

### 2. Use for All AI Interactions
Start conversations with context loading to get better results.

### 3. Combine with Screenshots
```bash
# Get screenshot and context
ai-context | clip
send-screenshot
# Now paste both into your AI assistant
```

### 4. Create AI-Specific Versions
For different assistants, create variants:
```bash
cp AGENTS.md AGENTS_GEMINI.md
cp AGENTS.md AGENTS_CHATGPT.md
# Customize each for specific assistant capabilities
```

### 5. Automate Common Patterns
Create wrapper scripts for common AI + context tasks.

## Troubleshooting

### Context Not Loading
```bash
# Check file permissions
ls -l ~/claude/projects/optimize_cli/AGENTS.md

# Verify content
cat ~/claude/projects/optimize_cli/AGENTS.md | head
```

### Path Issues
```bash
# Use absolute path
cat /home/roche/claude/projects/optimize_cli/AGENTS.md
```

### Screenshots Not Found
```bash
# Check current month folder exists
ls /mnt/c/Users/roche/OneDrive/Documents/ShareX/Screenshots/$(date +%Y-%m)/

# List all screenshot folders
ls /mnt/c/Users/roche/OneDrive/Documents/ShareX/Screenshots/
```

## Examples

### Complete Gemini Workflow
```bash
# 1. Start with context
ai-context | clip

# 2. Get screenshot if needed
send-screenshot

# 3. Start gemini with context
gemini "$(ai-context)

Screenshot: $(latest-screenshot)

Question: What errors do you see in this screenshot?"
```

### Complete ChatGPT Workflow
```bash
# 1. Copy context
ai-context | clip

# 2. Copy screenshot path
latest-screenshot | clip

# 3. Paste both in ChatGPT:
# [Context]
# [Screenshot path]
# [Your question]
```

## Summary

✓ **AGENTS.md** - Universal context for all AI assistants
✓ **Auto-loaded in Claude Code** - Via my memory system
✓ **Manual load for others** - Use wrappers or copy-paste
✓ **Screenshot helpers** - Integrated with all tools
✓ **Keep updated** - Edit as your environment changes

---

**Key Files**:
- `~/claude/projects/optimize_cli/AGENTS.md` - Main context file
- `~/.claude/.../memory/MEMORY.md` - Claude Code specific memory
- `~/.local/bin/ai-context` - Quick context loader
- `~/.local/bin/send-screenshot` - Screenshot helper

**Quick Commands**:
```bash
ai-context              # Load context
send-screenshot         # Get screenshot info
latest-screenshot       # Get screenshot path
```
