#!/usr/bin/env bash
# Create AI Assistant Helper Scripts

echo "Creating AI assistant helper scripts..."

mkdir -p ~/.local/bin

# ============================================================
# AI Context Loader
# ============================================================
cat > ~/.local/bin/ai-context << 'EOF'
#!/usr/bin/env bash
# Load AI agent context for any assistant

CONTEXT_FILE="$HOME/claude/projects/optimize_cli/AGENTS.md"

if [ ! -f "$CONTEXT_FILE" ]; then
    echo "Error: AGENTS.md not found at $CONTEXT_FILE"
    exit 1
fi

cat "$CONTEXT_FILE"
EOF

chmod +x ~/.local/bin/ai-context

# ============================================================
# Screenshot Sender
# ============================================================
cat > ~/.local/bin/send-screenshot << 'EOF'
#!/usr/bin/env bash
# Get latest screenshot info for AI assistants

SCREENSHOT=$(latest-screenshot 2>/dev/null)

if [ -n "$SCREENSHOT" ]; then
    echo "Latest screenshot: $SCREENSHOT"
    echo "Taken: $(stat -c %y "$SCREENSHOT" 2>/dev/null | cut -d'.' -f1)"
    echo "Size: $(du -h "$SCREENSHOT" 2>/dev/null | cut -f1)"
    echo ""

    # Copy path to clipboard
    echo -n "$SCREENSHOT" | clip.exe 2>/dev/null
    echo "✓ Path copied to clipboard!"
    echo ""
    echo "Use in AI conversation:"
    echo "  \"Check this screenshot: $SCREENSHOT\""
else
    echo "No screenshots found in current month"
    echo "Location: /mnt/c/Users/roche/OneDrive/Documents/ShareX/Screenshots/$(date +%Y-%m)/"
fi
EOF

chmod +x ~/.local/bin/send-screenshot

# ============================================================
# Enhanced Gemini CLI Wrapper (if gemini is installed)
# ============================================================
cat > ~/.local/bin/gemini-enhanced << 'EOF'
#!/usr/bin/env bash
# Enhanced Gemini CLI with auto-loaded context

CONTEXT_FILE="$HOME/claude/projects/optimize_cli/AGENTS.md"
PROMPT="$*"

if [ -z "$PROMPT" ]; then
    echo "Usage: gemini-enhanced <prompt>"
    echo ""
    echo "This wrapper loads your environment context automatically."
    echo "Use regular 'gemini' command if you don't want context."
    exit 1
fi

if [ -f "$CONTEXT_FILE" ]; then
    FULL_PROMPT="[SYSTEM CONTEXT - Read this first]
$(cat "$CONTEXT_FILE")

---

[USER REQUEST]
$PROMPT"
else
    echo "Warning: AGENTS.md not found, proceeding without context"
    FULL_PROMPT="$PROMPT"
fi

# Check if gemini command exists
if command -v gemini &> /dev/null; then
    gemini "$FULL_PROMPT"
else
    echo "Error: 'gemini' command not found"
    echo "Install gemini CLI first, or check if it's in your PATH"
    exit 1
fi
EOF

chmod +x ~/.local/bin/gemini-enhanced

# ============================================================
# Quick Screenshot Share
# ============================================================
cat > ~/.local/bin/screenshot-for-ai << 'EOF'
#!/usr/bin/env bash
# Prepare latest screenshot for AI analysis

SCREENSHOT=$(latest-screenshot 2>/dev/null)

if [ -z "$SCREENSHOT" ]; then
    echo "No screenshot found. Take one with ShareX first."
    exit 1
fi

echo "Latest Screenshot Info:"
echo "======================="
echo "Path: $SCREENSHOT"
echo "Time: $(stat -c %y "$SCREENSHOT" 2>/dev/null | cut -d'.' -f1)"
echo "Size: $(stat -c %s "$SCREENSHOT" 2>/dev/null | numfmt --to=iec-i --suffix=B)"
echo ""

# Copy path
echo -n "$SCREENSHOT" | clip.exe 2>/dev/null

echo "✓ Path copied to clipboard"
echo ""
echo "Ready to share with AI:"
echo "  Claude Code: Just mention 'latest screenshot'"
echo "  Other AIs: Paste path from clipboard"
EOF

chmod +x ~/.local/bin/screenshot-for-ai

echo ""
echo "✓ AI helper scripts created!"
echo ""
echo "Available commands:"
echo "  ai-context           - Load environment context"
echo "  send-screenshot      - Get latest screenshot info"
echo "  screenshot-for-ai    - Prepare screenshot for sharing"
echo "  gemini-enhanced      - Gemini with auto-loaded context"
echo ""
echo "Usage examples:"
echo "  ai-context | clip                    # Copy context to clipboard"
echo "  send-screenshot                      # Get screenshot path"
echo "  screenshot-for-ai                    # Prepare for AI sharing"
echo "  gemini-enhanced 'your question'      # Use Gemini with context"
echo ""
