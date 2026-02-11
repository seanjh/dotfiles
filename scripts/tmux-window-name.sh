#!/bin/bash
# Rename tmux window based on whether the focused pane is running Claude Code

PANE_PID=$1

if [ -z "$PANE_PID" ]; then
    exit 0
fi

# Get full command line - claude runs as node with claude in the path
CMD=$(ps -o args= -p "$PANE_PID" 2>/dev/null | head -1)

# Also check child processes (claude spawns node)
CHILD_CMD=$(pgrep -P "$PANE_PID" 2>/dev/null | xargs -I{} ps -o args= -p {} 2>/dev/null | head -1)

if echo "$CMD $CHILD_CMD" | grep -qi "claude"; then
    tmux rename-window "claude"
else
    # Re-enable automatic rename for non-claude panes
    tmux set-window-option automatic-rename on
fi
