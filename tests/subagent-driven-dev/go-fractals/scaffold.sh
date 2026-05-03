#!/usr/bin/env bash
# Scaffold the Go Fractals test project
# Usage: ./scaffold.sh /path/to/target/directory

set -e

TARGET_DIR="${1:?Usage: $0 <target-directory>}"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# Create target directory
mkdir -p "$TARGET_DIR"
cd "$TARGET_DIR"

# Initialize git repo
git init

# Create .claude settings to allow reads/writes in this directory
mkdir -p .claude
cat > .claude/settings.local.json << 'SETTINGS'
{
  "permissions": {
    "allow": [
      "Read(**)",
      "Edit(**)",
      "Write(**)",
      "Bash(go:*)",
      "Bash(mkdir:*)",
      "Bash(git:*)"
    ]
  }
}
SETTINGS

# Create initial commit
git add .
git commit -m "Initial project setup"

echo "Scaffolded Go Fractals project at: $TARGET_DIR"
echo ""
echo "To run the test:"
echo "  tests/subagent-driven-dev/run-test.sh go-fractals --plugin-dir /path/to/superpowers"
