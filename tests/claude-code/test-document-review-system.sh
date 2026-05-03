#!/usr/bin/env bash
# Workflow Test: Brief Spec System
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/../.." && pwd)"

echo "========================================"
echo " Brief Spec Workflow Test"
echo "========================================"

FAILED=0

check_contains() {
    local file="$1"
    local pattern="$2"
    local label="$3"
    if grep -Eiq "$pattern" "$ROOT_DIR/$file"; then
        echo "  [PASS] $label"
    else
        echo "  [FAIL] $label"
        FAILED=$((FAILED + 1))
    fi
}

check_absent() {
    local file="$1"
    local pattern="$2"
    local label="$3"
    if grep -Eiq "$pattern" "$ROOT_DIR/$file"; then
        echo "  [FAIL] $label"
        FAILED=$((FAILED + 1))
    else
        echo "  [PASS] $label"
    fi
}

check_contains "skills/brainstorming/SKILL.md" "brief spec" "Brainstorming produces a brief spec"
check_contains "skills/brainstorming/SKILL.md" "issue|human prompt" "Brainstorming starts from issues or prompts"
check_contains "skills/brainstorming/SKILL.md" "approval" "Brainstorming still requires human approval"
check_absent "skills/brainstorming/SKILL.md" "docs/superpowers|Spec written" "Brainstorming does not require stored artifacts"

if [ -e "$ROOT_DIR/skills/brainstorming/spec-document-reviewer-prompt.md" ]; then
    echo "  [FAIL] Spec document reviewer prompt should be removed"
    FAILED=$((FAILED + 1))
else
    echo "  [PASS] Spec document reviewer prompt removed"
fi

if [ $FAILED -eq 0 ]; then
    echo "STATUS: PASSED"
    exit 0
fi

echo "STATUS: FAILED ($FAILED failures)"
exit 1
