#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")/../.." && pwd)"

fail() {
  echo "[FAIL] $1" >&2
  exit 1
}

assert_file_absent() {
  local file="$1"
  if [ -e "$ROOT_DIR/$file" ]; then
    fail "$file should not exist in the derived PR workflow"
  fi
}

assert_no_match() {
  local pattern="$1"
  shift
  local matches
  matches=$(grep -En "$pattern" "$@" 2>/dev/null || true)
  if [ -n "$matches" ]; then
    echo "$matches" >&2
    fail "forbidden pattern found: $pattern"
  fi
}

assert_match() {
  local pattern="$1"
  local file="$2"
  if ! grep -Eiq "$pattern" "$ROOT_DIR/$file"; then
    fail "$file should mention pattern: $pattern"
  fi
}

workflow_files=(
  "$ROOT_DIR/README.md"
  "$ROOT_DIR/skills/brainstorming/SKILL.md"
  "$ROOT_DIR/skills/writing-plans/SKILL.md"
  "$ROOT_DIR/skills/subagent-driven-development/SKILL.md"
  "$ROOT_DIR/skills/executing-plans/SKILL.md"
  "$ROOT_DIR/skills/finishing-a-development-branch/SKILL.md"
)

assert_file_absent "skills/using-git-worktrees/SKILL.md"

assert_no_match "using-git-worktrees|git worktree|docs/superpowers/specs|docs/superpowers/plans|Spec written and committed|Plan complete and saved" "${workflow_files[@]}"

assert_match "brief spec|short conversational spec" "skills/brainstorming/SKILL.md"
assert_match "issue|human prompt" "skills/brainstorming/SKILL.md"
assert_match "temporary.*plan|in-chat.*plan|conversation.*plan" "skills/writing-plans/SKILL.md"
assert_match "one commit per task|commit each task" "skills/subagent-driven-development/SKILL.md"
assert_match "review before task commit|commit.*after.*review" "skills/subagent-driven-development/SKILL.md"
assert_match "current workspace|own workspace" "skills/subagent-driven-development/SKILL.md"
assert_match "pull request|PR" "skills/finishing-a-development-branch/SKILL.md"
assert_match "approved" "skills/finishing-a-development-branch/SKILL.md"

echo "[PASS] Derived PR workflow content checks passed"
